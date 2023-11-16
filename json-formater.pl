#!/usr/bin/env perl
use JSON;

$json = JSON->new;
$/ = undef;
print $json->pretty->encode($json->decode(<>));
