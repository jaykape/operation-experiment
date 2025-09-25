#!/usr/bin/perl
use strict;
use warnings;

my %service_count;


open(my $fh, "-|", "journalctl -n 1000 --no-pager") or die "Could not read journalctl: $!\n";

while (my $line = <$fh>) {
    if ($line =~ /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+\+\d{2}:\d{2}\s+\S+\s+([^:]+):/) {
        $service_count{$1}++;
    }
}

close($fh);

print "System log summary by service (last 1000 lines):\n";
print "-----------------------------------------------\n";
foreach my $service (sort { $service_count{$b} <=> $service_count{$a} } keys %service_count) {
    printf "%-25s %d\n", $service, $service_count{$service};
}
