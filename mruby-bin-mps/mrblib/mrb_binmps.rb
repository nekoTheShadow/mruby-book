module MPS
  module SystemInfo 
    def self.loadavg
      la1, la5, la15, _, _ = *File.read("/proc/loadavg").split(' ')
      [la1, la5, la15]
    end
  end

  class ProcInfo
    class NoProcessFound < StandardError
    end

    def self.all
      entries = []
      Dir.entries("/proc").select{|e| e =~ /^[0-9]+$/}.each do |pid|
        begin
          entries << ProcInfo.new(pid)
        rescue => NoProcessFound
          # pass
        end
      end
      entries
    end

    def oneline
      "%6s %6s %-12s %-12s %-12s %-s" % [pid, ppid, vm_size, resident_set_size, state, cmdline_or_comm.join(" ")]
    end

    def initialize(pid)
      begin
        @pid = pid
        @cmdline = File.open("/proc/#{@pid}/cmdline").read.split("\0")
        @status = File.open("/proc/#{@pid}/status")
                      .read
                      .split("\n")
                      .map{|l| l.split(":").map(&:strip)}
                      .inject({}){|ha, (k, v)| ha[k] = v; ha}
        @comm = File.open("/proc/#{@pid}/comm").read.chomp
      rescue Errno::ENOENT
        raise NoProcessFound, "Cannot get proper infomation from PID = #{pid}"
      end
    end

    attr_reader :pid, :cmdline, :status, :comm

    def [](key)
      status[key]
    end

    def cmdline_or_comm 
      cmdline.empty? ? ["#{comm}"] : cmdline
    end

    def ppid
      self["PPid"]
    end

    def state()
      self["State"]
    end

    def vm_size()
      self["VmSize"] || "-"
    end

    def resident_set_size()
      self["VmRSS"] || "-"
    end

    def show_stat
      puts <<-STAT
Stat of process id = #{pid}
===================================
Command Line = #{cmdline_or_comm.join(' ')}
State        = #{state}
VSZ          = #{vm_size}
RSS          = #{resident_set_size}
      STAT
    end
  end
end

def __main__(_)
  case ARGV.size
  when 1
    if ARGV[0] == "--all"
      puts "%6s %6s %-12s %-12s %-12s %-s" % %w(PID PPID VSZ RSS STATE CMDLINE)
      MPS::ProcInfo.all.each do |pinfo|
        puts pinfo.oneline
      end
      exit
    elsif ARGV[0] == "--loadavg"
      puts "Loadavg: 1m=%s, 5m=%s, 15m=%s" % MPS::SystemInfo.loadavg
      exit
    end
  when 2
    if ARGV[0] == "-p"
      pid = ARGV[1].to_i
      pinfo = MPS::ProcInfo.new(pid)
      pinfo.show_stat
      exit
    end
  else
    # PASS
  end
  usage_and_exit
end

def usage_and_exit
  puts "Usage #{$0} [-p PID | --all | --loadavg]"
  exit 1
end