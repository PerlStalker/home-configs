#!/usr/bin/env perl
use warnings;
use strict;

my $type = shift @ARGV || '';
$type = lc $type;

update_package_list();
install_common();

if    ($type eq 'desktop') { install_desktop(); }
elsif ($type eq 'server')  { install_server();  }

my %conf = (
    'common' => {
	base => $ENV{HOME}.'/.emacs.d/conf/common',
	vc   => $ENV{HOME}.'/src/vc',
	package_list => [ qw(gnutls-bin) ]
    },
    'desktop' => {
	base => $ENV{HOME}.'/.emacs.d/conf/desktop',
	vc   => $ENV{HOME}.'/src/vc',
	package_list => [ qw(ditaa plantuml msmtp mplayer gnutls-bin wl-beta
                             texlive-latex-extra texlive-fonts-recommended
                             conkeror conkeror-https-everywhere conkeror-adblock-plus-element-hiding-helper
                             ) ]
    },
    'server' => {
	base => $ENV{HOME}.'/.emacs.d/conf/server',
	vc   => $ENV{HOME}.'/src/vc',
	package_list => [ qw() ]
    },
    );

my $base = $ENV{HOME}.'/.emacs.d/conf/desktop';
my $vc   = $ENV{HOME}.'/src/vc';
my @package_list = qw(ditaa plantuml msmtp mplayer gnutls-bin);

sub install_common {
    install_packages(@{ $conf{'common'}{package_list) });
}

sub install_desktop {
    install_packages(@{ $conf{'desktop'}{package_list) });
    install_pianobar();
}

sub install_server {
    install_packages(@{ $conf{'server'}{package_list) });
}

sub update_package_list {
    my_system ("sudo", "aptitude", "update");
}

sub install_packages {
    my @packages = @_;
    if (@_) {
	my_system ("sudo", "aptitude", '-y', '-q', 'install', @packages);
    }
}

sub install_pianobar {
    install_packages(qw( libmad0-dev libjson0-dev libfaad-dev libao-dev ));

    chdir $vc;
    if (-d 'pianobar') {
	system ('git', 'pull',);
    }
    else {
	system ('git', 'clone', 'https://github.com/PromyLOPh/pianobar.git');
    }
    chdir 'pianobar';
    my_system ('make');
    chdir $base;
}

sub install_elim {
    my @packages = qw(libpurple-dev libpurple autoconf intltool mercurial);
}

sub my_system {
    my @command = @_;
    print "@command\n";
    system @command;
}
