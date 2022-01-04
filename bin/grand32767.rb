#!/usr/bin/env ruby

srand(Time.now.to_i + Process.pid + 93) # seed the rand

def rgen()
	r = rand(2887453441..2887485696)
	if r < 2887483392 || r > 2887485695 && r < 2887458816 || r > 2887459071
		return r
	else
		rgen()
	end
end

ip = rgen()

puts [ip].pack('N').unpack('CCCC').join('.')
