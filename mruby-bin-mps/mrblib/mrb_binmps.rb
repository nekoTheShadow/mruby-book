module MPS
  class ProcInfo
    class NoProcessFound < StandardError
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
      rescue Errno::ENOENT
        raise NoProcessFound, "Cannot get proper infomation from PID = #{pid}"
      end
    end

    attr_reader :pid, :cmdline, :status

    def [](key)
      status[key]
    end

    def ppid
      self["PPid"]
    end

    def state()
      self["State"]
    end

    def vm_size()
      self["VmSize"]
    end

    def resident_set_size()
      self["VmRSS"]
    end

    def show_stat
      puts <<-STAT
Stat of process id = #{pid}
===================================
Command Line = #{cmdline.join(' ')}
State        = #{state}
VSZ          = #{vm_size}
RSS          = #{resident_set_size}
      STAT
    end
  end
end

def __main__(_)
  case ARGV.size
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
  puts "Usage #{$0} -p PID"
  exit 1
end