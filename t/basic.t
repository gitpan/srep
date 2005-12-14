#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 2;

# Adjust current dir, if needed;
chdir("t") if -d "t";

# Common code.
require "common.pl";

# Control data.
my $data = do { local($/); scalar(<DATA>) };

# Split: ORIG -- REPL -- NEW.
my ($orig_data, $repl, $new_data) = split("=====\n", $data);

# Create test dir, if needed;
mkdir("try") unless -d "try";

# Create replacement instructions.
open(T1, ">try/basic.dat");
print T1 ($repl);
close(T1);

# Create test file.
open(T1, ">try/d1.txt");
print T1 ($orig_data);
close(T1);

# Execute srep.
our @ARGV = qw(--data=try/basic.dat --recursive --exclude=basic.dat try);
eval {
     require "../script/srep";
};
ok(!$@, $@);

# Verify new contents of test file.
open(T1, "try/d1.txt");
$data = do { local($/); scalar(<T1>) };
close(T1);
ok($data eq $new_data);

# Clean up a bit.
unlink("try/basic.dat");
unlink("try/d1.txt");
rmdir("try");

__DATA__
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
The quickbrown fox jumps over the lazy dog 01234567879.
The quick brown fox jumps over the lazy dog 0123456789.
The quick brown fox jumps over the lazy dog 0123456789.
=====
w quick fast
W The Ze
s 879 89
<< Intro\n
>> Extro\n
=====
Intro
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze quickbrown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Ze fast brown fox jumps over the lazy dog 0123456789.
Extro
