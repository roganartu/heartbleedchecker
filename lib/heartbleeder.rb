class Heartbleeder
  def self.check(host)
    IO.popen(['./bin/heartbleeder', host]) { |io| io.read.chomp }
  end
end
