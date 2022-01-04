#!/usr/bin/env ruby

class Host
    attr_accessor :users, :color
    def initialize( u=Hash.new, c=String.new, i=String.new )
        @users = u
        @color = c
    end
end

class User
	attr_accessor :name, :ssh_key, :color
    def initialize( n=String.new, s=String.new, c=String.new )
        @name = n
        @ssh_key = s
        @color = c
    end
end

#pctree = YAML.load_file("db.yaml")
#open('../.ssh/authk', 'a') do |f|
#	pctree.each do | k, v |
#		puts k
#		pctree[k].each do |x|
#			puts x
#		end
#	end
#	f.puts a + " " + b
#end
