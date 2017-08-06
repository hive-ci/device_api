require 'syslog'

module DeviceAPI
  class SysLog
    attr_accessor :syslog

    def log(priority, message)
      if @syslog && @syslog.opened?
        @syslog = Syslog.reopen('device-api-gem', Syslog::LOG_PID, Syslog::LOG_DAEMON)
      else
        @syslog = Syslog.open('device-api-gem', Syslog::LOG_PID, Syslog::LOG_DAEMON)
      end

      @syslog.log(priority, message)
      @syslog.close
    end

    def fatal(message)
      log(Syslog::LOG_CRIT, message)
    end

    def error(message)
      log(Syslog::LOG_ERR, message)
    end

    def warn(message)
      log(Syslog::LOG_WARNING, message)
    end

    def info(message)
      log(Syslog::LOG_INFO, message)
    end

    def debug(message)
      log(Syslog::LOG_DEBUG, message)
    end
  end
end
