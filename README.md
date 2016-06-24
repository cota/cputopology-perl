cputopology-perl
================
This is a tiny Perl module to read [CPU topology information from sysfs.](https://www.kernel.org/doc/Documentation/cputopology.txt)

Interpreting this topology is useful when you want to control on which
hardware threads you want your software threads to run, e.g. when running
latency-sensitive code.

Example
-------
Inspect `list.pl` to see how the perl module can be used.
The script has use of its own, when paired with `taskset(1)`. For example,
on a machine with 4 sockets and 8 2-way cores per socket, i.e. a total
of 64 threads:

    $ ./list.pl --policy=scatter 16
    0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
, i.e. four threads per socket.

    $ ./list.pl --policy=compact 16
    0,4,8,12,16,20,24,28,1,5,9,13,17,21,25,29
, i.e. eight threads per socket, using two sockets.

    $ ./list.pl --policy=compact-smt 16
    0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60
, i.e. all threads in the same socket, leveraging SMT.

Limitations
-----------
* Only the topology (socket->core->thread) is read; all other information
  (e.g. cache sizes) is ignored. There exist other (more complex) packages
  for this.

Dependencies
------------
* Linux, with sysfs mounted on /sys

License
-------
Public domain via CC0 -- see LICENSE.

Contact
-------
  Emilio G. Cota <cota@braap.org>
