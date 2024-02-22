#!/usr/bin/env perl

$fn = shift @ARGV;
@PATH = split ':', `pkg-config --variable pc_path pkg-config`;
push @PATH, split ':', $ENV{PKG_CONFIG_PATH};
for (@PATH) {
    chomp;
    print "$_\n" if -e "$_/$fn";
}
