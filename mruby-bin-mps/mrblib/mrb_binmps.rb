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
  end
end