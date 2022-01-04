#!/usr/bin/env ruby

srand(Time.now.to_i + Process.pid + 93) # seed the rand
puts "172.27.32.#{rand(255)}"
