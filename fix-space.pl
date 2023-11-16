#!/usr/bin/env perl
use File::Find;
use strict;
use warnings;

my $n = 8; # spaces per tab
my $tab_to_space = 1;
my $spaces = ' ' x $n;

sub process {
    my ($fin, $fout) = @_;
    while (<$fin>) {
        s/[ \t]+$//;
        if (s/^(\s+)//) {
            my $s = $1;
            $s =~ s/\t/$spaces/g;
            print $fout "$s$_";
        } else {
            print $fout $_;
        }
    }
}

sub process_plain {
    my $f = shift @_;
    if (-e "$f.bak") {
        warn "$f.bak already exists. Skip.";
        return;;
    }
    rename $f, "$f.bak";
    open my $fin, '<', "$f.bak";
    open my $fout, '>', $f;
    process($fin, $fout);
    unlink "$f.bak";
}

if (@ARGV) {
    for my $f (@ARGV) {
        if (-T $f) {
            process_plain($f);
        } elsif (-d $f) {
            my @list;
            find(sub {
                    push @list, $File::Find::name if -T $File::Find::name;
                }, $f);
            process_plain($_) for @list;
        }
    }
} else {
    process(\*STDIN, \*STDOUT);
}
