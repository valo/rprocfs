module Stat
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    STAT_FIELDS = [:pid, :comm, :state, :ppid, :pgrp, :session, :tty_nr, :tpgid, :flags,
     :minflt, :cminflt, :majflt, :cmajflt, :utime, :stime, :cutime, :cstime, :priority,
     :nice, :num_threads, :itrealvalue, :starttime, :vsize, :rss, :rsslim, :startcode,
     :endcode, :startstack, :kstkesp, :kstkeip, :signal, :blocked, :sigignore,
     :sigcatch, :wchan, :nswap, :cnswap, :exit_signal, :processor, :rt_priority,
     :policy, :delayacct_blkio_ticks, :guest_time, :cguest_time]

    STAT_FIELDS_FORMAT = {:pid => :to_i,
      :comm => lambda { |value| value[1..-2] },
      :state => :to_s,
      :ppid => :to_i,
      :pgrp => :to_i,
      :session => :to_i,
      :tty_nr => :to_i,
      :tpgid => :to_i,
      :flags => :to_i,
      :minflt => :to_i,
      :cminflt => :to_i,
      :majflt => :to_i,
      :cmajflt => :to_i,
      :utime => lambda { |value| value.to_f / RProcFS::CLOCKS_PER_SEC },
      :stime => lambda { |value| value.to_f / RProcFS::CLOCKS_PER_SEC },
      :cutime => :to_i,
      :cstime => :to_i,
      :priority => :to_i,
      :nice => :to_i,
      :num_threads => :to_i,
      :itrealvalue => :to_i,
      :starttime => :to_i,
      :vsize => :to_i,
      :rss => :to_i,
      :rsslim => :to_i,
      :startcode => :to_i,
      :endcode => :to_i,
      :startstack => :to_i,
      :kstkesp => :to_i,
      :kstkeip => :to_i,
      :signal => :to_i,
      :blocked => :to_i,
      :sigignore => :to_i,
      :sigcatch => :to_i,
      :wchan => :to_i,
      :nswap => :to_i,
      :cnswap => :to_i,
      :exit_signal => :to_i,
      :processor => :to_i,
      :rt_priority => :to_i,
      :policy => :to_i,
      :delayacct_blkio_ticks => :to_i,
      :guest_time => :to_i,
      :cguest_time => :to_i}

    def stat_parse(pid)
      stat = File.read("/proc/#{pid}/stat").chomp.split(" ")

      result = {}

      STAT_FIELDS.zip(stat) do |field, value|
        case STAT_FIELDS_FORMAT[field]
          when Symbol
            result[field] = value.send(STAT_FIELDS_FORMAT[field])
          when Proc
            result[field] = STAT_FIELDS_FORMAT[field].call(value)
        end
       end
       
       result
    end

    STAT_FIELDS.each do |field|
      define_method field do |pid|
        stat_parse(pid)[field]
      end
    end
  end
end