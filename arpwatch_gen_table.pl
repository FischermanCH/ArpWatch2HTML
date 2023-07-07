#!/usr/bin/perl

use strict;
use warnings;
use Time::Local;

# Open the arpwatch file
open(my $fh, '<', 'arpwatch_output.txt') or die "Failed to open file: $!";

# Initialize column widths
my @column_widths = (15, 14, 14, 20, 9);

# Read the file line by line and calculate column widths
my @table_data;
while (my $line = <$fh>) {
    chomp($line);
    my @columns = split(/\s+/, $line);
    # Check if hostname column is missing and replace it with "unknown"
    if (@columns < 5) {
        splice(@columns, -1, 0, 'unknown');
    }
    push @table_data, \@columns;
    for my $i (0 .. $#columns) {
        $column_widths[$i] = length($columns[$i]) if length($columns[$i]) > $column_widths[$i];
    }
}

# Sort the table data based on the IP Address column
@table_data = sort { compare_ip_addresses($a->[1], $b->[1]) } @table_data;

# Move the file pointer back to the beginning
seek($fh, 0, 0);

# Open the HTML file for writing
open(my $html_fh, '>', 'arp_watch_result.html') or die "Failed to open file: $!";

# Start writing the HTML content
print $html_fh <<EOF;
<!DOCTYPE html>
<html>
<head>
<style>
body {
  background-color: black;
  color: #00ff00;
}

table {
  border-collapse: collapse;
  border: 1px dotted #00ff00;
}

th, td {
  border: 1px dotted #00ff00;
  padding: 5px;
}

th {
  text-align: left;
}

.unknown {
  color: red;
}
</style>
</head>
<body>

<table>
<tr>
EOF

# Print table header to HTML file
print_html_row($html_fh, 'th', 'MAC Address', 'IP Address', 'Timestamp', 'Hostname', 'Interface');

# Print table rows to HTML file
foreach my $row (@table_data) {
    $row->[1] = fill_ip_zeros($row->[1]);
    $row->[2] = convert_timestamp($row->[2]);
    print_html_row($html_fh, 'td', @$row);
}

# Close the HTML table and body
print $html_fh <<EOF;
</table>

</body>
</html>
EOF

# Close the file handles
close($fh);
close($html_fh);

# Print an HTML table row
sub print_html_row {
    my ($fh, $tag, @columns) = @_;
    print $fh "<tr>\n";
    foreach my $i (0 .. $#columns) {
        my $column = $columns[$i];
        my $class = $column eq 'unknown' ? 'unknown' : '';
        if ($i == 1) {
            my $url = "http://" . remove_leading_zeros($column);
            print $fh "<$tag class='$class'><a href='$url' target='_blank'>$column</a></$tag>\n";
        } else {
            print $fh "<$tag class='$class'>$column</$tag>\n";
        }
    }
    print $fh "</tr>\n";
}

# Compare two IP addresses
sub compare_ip_addresses {
    my ($ip1, $ip2) = @_;
    my @octets1 = split(/\./, $ip1);
    my @octets2 = split(/\./, $ip2);

    for my $i (0 .. 3) {
        my $result = ($octets1[$i] // 0) <=> ($octets2[$i] // 0);
        return $result if $result != 0;
    }

    return 0; # IP addresses are equal
}

# Fill missing octets in an IP address with zeros
sub fill_ip_zeros {
    my ($ip) = @_;
    my @octets = split(/\./, $ip);
    foreach my $i (0 .. 3) {
        $octets[$i] = sprintf("%03d", $octets[$i] // 0) if defined $octets[$i];
    }
    return join('.', @octets);
}

# Remove leading zeros from an IP address octet
sub remove_leading_zeros {
    my ($ip) = @_;
    my @octets = split(/\./, $ip);
    foreach my $i (0 .. 3) {
        $octets[$i] =~ s/^0+// if defined $octets[$i];
    }
    return join('.', @octets);
}

# Convert timestamp to date format
sub convert_timestamp {
    my ($timestamp) = @_;
    my ($sec, $min, $hour, $day, $month, $year) = (localtime($timestamp))[0..5];
    $year += 1900;
    $month += 1;
    my $date = sprintf("%02d:%02d:%04d / %02d:%02d:%02d", $day, $month, $year, $hour, $min, $sec);
    return $date;
}
