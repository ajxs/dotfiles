#!/usr/bin/env perl

use strict;
use warnings;
use File::Temp qw/ tempfile tempdir /;
use Getopt::Long;

# Creates a screenshot and saves it to a temporary directory.
#  Automatically copies the filename to the clipboard.

my $region = 0;
my $quality = 100;

GetOptions('quality=i' => \$quality,
	'region' => \$region);

my $SCREENSHOT_UTILITY="/usr/bin/scrot";
my $CLIPBOARD_UTILITY="xclip -sel clip";

my ($fh, $screenshot_filename) = tempfile("screenshot_XXXX",
	TMPDIR => 1,
	SUFFIX => ".png") or die "Unable to open tempfile! Exiting.";

my @screenshot_cmd = ($SCREENSHOT_UTILITY);
push @screenshot_cmd, "-q $quality";
push @screenshot_cmd, "-s" if $region;
push @screenshot_cmd, $screenshot_filename;

system @screenshot_cmd or die "Unable to execute screenshot! Exiting.";

open my $clipboard_stream, "|-", $CLIPBOARD_UTILITY 
	or die "Unable to open clipboard stream! Exiting.";
print $clipboard_stream "$screenshot_filename"