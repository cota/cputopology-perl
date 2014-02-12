#!/usr/bin/perl
#
# example.pl
#
# Run "foo" in separate cores, but make sure these cores are in the same socket.
# If that's not possible, run threads in the same socket, using multithreading.
# If that's not possible either, just run on all available hardware threads.

use warnings;
use strict;
use CpuTopology;

sub taskset_list {
    my ($n_threads) = @_;
    my $n_cores_per_socket = CpuTopology::n_cores_per_socket;
    my $n_threads_per_core = CpuTopology::n_threads_per_core;

    my @cpu_list = ();
    if ($n_threads <= $n_threads_per_core) {
	@cpu_list = CpuTopology::threads_in_socket(0, 1);
    } elsif ($n_threads <= $n_threads_per_core * $n_cores_per_socket) {
	@cpu_list = CpuTopology::threads_in_socket(0, $n_threads_per_core);
    } else {
	@cpu_list = CpuTopology::cpus();
	$n_threads = @cpu_list;  # make sure the slice below is in range
    }
    return @cpu_list[0..$n_threads-1];
}

sub my_run {
    my ($program, $n_threads) = @_;

    my $taskset_cmd = "taskset -c ".join(",", taskset_list($n_threads));
    my $cmd = "$taskset_cmd $program";
    printf "%2d threads: %s\n", $n_threads, $cmd;
    # system($cmd) == 0
    #    or die "system '$cmd' failed: $?";
}

my $program = 'foo';
my @n_threads = (1,2,4,8,16,32);
foreach (@n_threads) {
    my_run($program, $_);
}
