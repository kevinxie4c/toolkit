#!/usr/bin/env perl
use File::Find;

$fn = shift @ARGV;
push @PATH, split ':', $ENV{CMAKE_PREFIX_PATH};
push @PATH, split ':', $ENV{CMAKE_INSTALL_PREFIX};

@PATH = map { ("$_/share", "$_/lib/cmake/", "$_/lib64/cmake/") } @PATH;

find(sub {
	print "$File::Find::name\n" if /$fn-config(.*)\.cmake/i or /${fn}Config(.*)\.cmake/i;
    }, @PATH);
