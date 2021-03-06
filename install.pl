#!/usr/bin/perl
use warnings;
use strict;

use FindBin qw($Bin);

my @tasks = ();

sub add_task {
    my $app     = shift;
    my $message = shift;

    push @tasks, "$app: $message";
}

sub link_file {
    my $source = shift;
    my $dest   = shift;
    my $copy   = shift || 0;

    if ($copy) {
	if ($copy eq 'rsync') {
	    system ('rsync', '-aq', $source, $dest);
	} else {
	    if (-e $dest) {
		system ('mv', $dest, "$dest-backup-".time());
	    }
	    system ('cp', '-R', $source, $dest);
	}
    } else {
	if (not -l $dest) {
	    if (-e $dest) {
		system ('mv', $dest, "$dest-backup-".time());
	    }
	    system ('ln', '-sf', $source, $dest);
	}
    }
}

sub install_tmux {
    link_file("$Bin/tmux/.tmux.conf", "$ENV{HOME}/.tmux.conf");
}

sub install_byobu {
    link_file("$Bin/byobu/", "$ENV{HOME}/.byobu");
    if (not -e "$ENV{HOME}/.gcalclirc") {
	add_task('byobu', "Configure $ENV{HOME}/.gcalclirc");
    }
}

sub install_emacs {
    if (not -d "$ENV{HOME}/.emacs.d") {
	mkdir "$ENV{HOME}/.emacs.d";
    }
    link_file("$Bin/emacs/", "$ENV{HOME}/.emacs.d/conf");
    link_file("$ENV{HOME}/.emacs.d/conf/init.el", "$ENV{HOME}/.emacs.d/init.el");
}

sub install_i3 {
    my $hostname = `hostname -s`;
    chomp $hostname;

    my $i3status = "$Bin/i3/i3status.conf";
    if (-r "$Bin/i3/$hostname-i3status.conf") {
	$i3status = "$Bin/i3/$hostname-i3status.conf";
    }
    
    link_file($i3status, "$ENV{HOME}/.i3status.conf");

    link_file("$Bin/i3/config/", "$ENV{HOME}/.i3");
    
    # combine host-head, default, host-foot

    my $head = "$Bin/i3/default-head";
    if (-r "$Bin/i3/$hostname-head") {
	$head = "$Bin/i3/$hostname-head";
    }

    my $middle = "$Bin/i3/default-middle";
    
    my $foot = "$Bin/i3/default-foot";
    if (-r "$Bin/i3/$hostname-foot") {
	$foot = "$Bin/i3/$hostname-foot";
    }

    my $cmd = ("cat $head $middle $foot > $ENV{HOME}/.i3/config");
    #print STDERR "$cmd\n";
    system $cmd;
}

sub install_dropbox {
    if (not -d "$ENV{HOME}/.dropbox-dist") {
	system "cd ~ && wget -O - \"https://www.dropbox.com/download?plat=lnx.x86_64\" | tar xzf -";
    }

    # get dropbox.py tool
    if (not -d "$ENV{HOME}/bin") {
	mkdir "$ENV{HOME}/bin";
    }
    system "wget -O ~/bin/dropbox.py 'https://www.dropbox.com/download?dl=packages/dropbox.py'";
    system "chmod +x ~/bin/dropbox.py";
	
}

sub install_ssh {
    if (not -d "$ENV{HOME}/.ssh") {
	mkdir "$ENV{HOME}/.ssh";
	system ('chmod', '700', "$ENV{HOME}/.ssh");
    }
    if (not -d "$ENV{HOME}/.ssh/control") {
	mkdir "$ENV{HOME}/.ssh/control";
    }
    
    link_file ("$Bin/ssh/config", "$ENV{HOME}/.ssh/config");

    if (not -e "$ENV{HOME}/.ssh/id_dsa"
	and not -e "$ENV{HOME}/.ssh/id_rsa"
	) {
	add_task('ssh', 'Create or restore ssh keys');
    }
}

sub install_gnupg {
    if (not -d "$ENV{HOME}/.gnupg") {
	add_task('gnupg', 'Copy or restore gpg keys');
    }
}

sub install_xfce4 {
    if (not -e "$ENV{HOME}/.config") {
	mkdir "$ENV{HOME}/.config";
    }
    if (not -e "$ENV{HOME}/.config/xfce4") {
	mkdir "$ENV{HOME}/.config/xfce4";
    }

    link_file ("$Bin/xfce4/terminal/", "$ENV{HOME}/.config/xfce4/terminal");
}

sub install_conkeror {
    link_file ("$Bin/conkeror/conkerorrc", "$ENV{HOME}/.conkerorrc");

    if (not -x "/usr/sbin/conkeror") {
	add_task('conkeror', 'Install conkeror: ~aura -A conkeror-git~');
    }
}

my %dispatch_table = (
    tmux    => \&install_tmux,
    byobu   => \&install_byobu,
    ssh     => \&install_ssh,
    gnupg   => \&install_gnupg,
    dropbox => \&install_dropbox,
    i3      => \&install_i3,
    xfce4   => \&install_xfce4,
    emacs   => \&install_emacs,
    conkeror => \&install_conkeror,
    );


my @apps = @ARGV;
if (not @apps) {
    @apps = sort keys %dispatch_table;
}

## install apps
foreach my $app (@apps) {
    if (defined $dispatch_table{$app}) {
	&{ $dispatch_table{$app} };
    } else {
	warn "Unknown app: $app\n";
    }
}

## print tasks
foreach my $task (@tasks) {
    print "- [ ] $task\n";
}
