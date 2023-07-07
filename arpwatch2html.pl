#!/usr/bin/perl

use strict;
use warnings;
use File::Spec::Functions qw(rel2abs);
use POSIX qw(strftime);

my $arpwatch_output_file = "arpwatch_output.txt";
my $html_output_file = "arpwatch_output.html";

# Get the input file path from user
print "Enter the path to the input file: ";
my $input_file = <STDIN>;
chomp $input_file;

# Get the absolute path of the input file
my $abs_input_file = rel2abs($input_file);

# Read the existing MAC addresses from arpwatch_output.txt
my %existing_mac_addresses;
open(my $existing_fh, '<', $arpwatch_output_file) or die "Cannot open $arpwatch_output_file: $!";
while (my $line = <$existing_fh>) {
    chomp($line);
    my ($mac) = split(/\t/, $line);
    $existing_mac_addresses{$mac} = 1;
}
close($existing_fh);

# Append new MAC addresses to arpwatch_output.txt
open(my $append_fh, '>>', $arpwatch_output_file) or die "Cannot open $arpwatch_output_file for appending: $!";
open(my $input_fh, '<', $abs_input_file) or die "Cannot open $abs_input_file: $!";
while (my $line = <$input_fh>) {
    chomp($line);
    my ($mac) = split(/\t/, $line);
    if (!exists $existing_mac_addresses{$mac}) {
        print $append_fh "$line\n";
    }
}
close($input_fh);
close($append_fh);

# Clear the screen
system("clear");

my $sync_message = "ARP watch output has been synchronized";
my $html_file_path = rel2abs($html_output_file);
my $html_message = "The HTML output file can be found at $html_file_path";

my $line_length = length($sync_message);
if (length($html_message) > $line_length) {
    $line_length = length($html_message);
}

my $line = "+" . "-" x ($line_length + 2) . "+";

my $current_time = strftime("%d.%m.%Y / %H:%M:%S", localtime);

# Set text color to green (00ff00)
my $color_green = "\e[32m";
my $color_reset = "\e[0m";

print "$line\n";
print "$current_time\n";
print "${color_green}$sync_message${color_reset}\n";
print "$line\n\n";

# Start the arpwatch_gen_table.pl script
system("perl arpwatch_gen_table.pl");

print "\n$line\n";
print "$current_time\n";
print "${color_green}$html_message${color_reset}\n";
print "$line\n\n";
