require 'open3'

class Heartbleeder
  def self.check(host)
    output = Open3.popen2e('./bin/heartbleeder', host) { |stdin, stdout_and_stderr| stdout_and_stderr.read.chomp }

    # Strip any timestamp from STDERR
    output.gsub(/\d\d\d\/\d\d\/\d\d\s+\d\d:\d\d:\d\d/, '')
  end
end
