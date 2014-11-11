#!/bin/env perl
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
	    system ('cp', '-R', $source, $dest);
	}
    } else {
	system ('ln', '-sf', $source, $dest);
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

sub install_i3 {
    link_file("$Bin/i3/i3status.conf", "$ENV{HOME}/.i3status.conf");

    if (not -d "$ENV{HOME}/.i3") {
	mkdir "$ENV{HOME}/.i3";
    }

    link_file("$Bin/i3/config", "$ENV{HOME}/.i3");
    
    # combine host-head, default, host-foot
    my $hostname = `hostname -s`;

    my $head = "$Bin/i3/config/default-head";
    if (-e "$Bin/i3/config/$hostname-head") {
	$head = "$Bin/i3/config/$hostname-head";
    }

    my $middle = "$Bin/i3/config/default-middle";
    
    my $foot = "$Bin/i3/config/default-foot";
    if (-e "$Bin/i3/config/$hostname-foot") {
	$foot = "$Bin/i3/config/$hostname-head";
    }

    system ("cat $head $middle $foot > $ENV{HOME}/.i3/config");
}

sub install_dropbox {
    if (not -d "$ENV{HOME}/.dropbox-dist") {
	system "cd ~ && wget -O - \"https://www.dropbox.com/download?plat=lnx.x86_64\" | tar xzf -";
    }
}

sub install_ssh {
    if (not -d "$ENV{HOME}/.ssh") {
	mkdir "$ENV{HOME}/.ssh";
	system ('chmod', '700', "$ENV{HOME}/.ssh");
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

my %dispatch_table = (
    tmux    => \&install_tmux,
    byobu   => \&install_byobu,
    ssh     => \&install_ssh,
    gnupg   => \&install_gnupg,
    dropbox => \&install_dropbox,
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
