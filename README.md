cputopology-perl
================
This is a tiny Perl module to read [CPU topology information from sysfs.](https://www.kernel.org/doc/Documentation/cputopology.txt)

Interpreting this topology is useful when you want to control on which
hardware threads you want your software threads to run, e.g. when running
latency-sensitive code.

Example
-------
See example.pl.

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
