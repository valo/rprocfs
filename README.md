rprocfs
=======

A simple ruby lib for reading process details from the proc filesystem.

Install
-------

Install the gem using rubygems and you are ready to go:

```bash
gem install rprocfs
```

Usage
-----

```ruby
require 'rubygems' # This is not needed for ruby > 1.8
require 'rprocfs'
  
puts "User time of the current process: #{RProcFS.utime($$)}"
puts "Current data memory size of the current process: #{RProcFS.data($$)}"
```
  
Example
-------

Let's say you want to run a process and measure its user + system time. Here is how to do that:

```ruby
require 'rubygems'
require 'rprocfs'

pid = fork do
  Kernel.exec ARGV.join(" ")
end

time = 0
begin
  # Sums the utime, stime, cutime and cstime of the process
  # utime - user time of the process
  # stime - system time of the process
  # cutime - the user time of the children of the process
  # cstime - the system time of the children of the process
  time = [:utime, :stime, :cutime, :cstime].map { |f| RProcFS.send f, pid }.inject(0) { |x,y| x + y }
  sleep 0.01
end until(Process.waitpid(pid, Process::WNOHANG))

puts "Time: %0.3f" % time
```

Docs
----

Currently the lib is not very well documented. More information you can get from "man proc". Currently the lib parses /proc/{pid}/stat and /proc/{pid}/statm. The names of the API is the same as the names in the manpage.

Portability
-----------

Currently this is tested only on ubuntu 9.04 system. It should work on most linux systems. Please file an issue if you find any problem.

Copyright
---------

Copyright (c) 2009 Valentin Mihov. See LICENSE for details.
