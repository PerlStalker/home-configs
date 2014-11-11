#!/bin/env perl
use warnings;
use strict;

use FindBin qw($Bin);

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
    print "Please configure $ENV{HOME}/.gcalclirc\n");
}

sub install_i3 {
    link_file("$Bin/i3/i3status.conf", "$ENV{HOME}/.i3status.conf");

    # combine host-pre, default, host-post
    my $hostname = `hostname`;
}

my %dispatch_table = (
    tmux  => \&install_tmux,
    byobu => \&install_byobu
    );


my @apps = @ARGV;
if (not @apps) {
    @apps = sort keys %dispatch_table;
}

foreach my $app (@apps) {
    if (defined $dispatch_table{$app}) {
	&{ $dispatch_table{$app} };
    } else {
	warn "Unknown app: $app\n";
    }
}
