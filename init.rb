#!/usr/bin/env ruby
require 'digest'
require 'yaml'
#==============// INIT VARS //===========================================#
uname = %x(uname -a).to_s.downcase.chomp
$dir = __dir__
require "#{$dir}/classes.rb" #custom class declarations
f1 = "#{$dir}/master.zsh"
f3 = "#{$dir}/dirs.zsh"
f4 = "#{$dir}/env/last.zsh"
$run_file_path = __FILE__
$user = "ANON"
$host = "UNKN"
%x(git config --global user.email "peter@never.lan")
%x(git config --global user.name "Peter Pan")
%x(git config --global push.default simple) # squelch push alert
%x(git submodule update --init --recursive) # get all submodule data
#==============// Select OS //===========================================#
if uname.to_s.downcase.match(/microsoft/)
	uname = "MICROSOFT"
	f2 = './env/micro.zsh'
	$host = %x(hostname -s).to_s.chomp
	$user = %x(whoami).to_s.chomp
elsif uname.to_s.downcase.match(/darwin/)
	uname = "DARWIN"
	f2 = './env/mac.zsh'
	$host = %x(hostname -s).to_s.chomp
	$user = %x(whoami).to_s.chomp
elsif uname.to_s.downcase.match(/bsd/)
	uname = "BSD"
	f2 = './env/bsd.zsh'
	$host = %x(hostname -s).to_s.chomp
	$user = %x(whoami).to_s.chomp
elsif uname.to_s.downcase.match(/linux/)
	uname = "LINUX"
	f2 = './env/linux.zsh'
	$host = %x(hostname -s).to_s.split(/\s/).first.chomp
	$user = %x(whoami).to_s.split(/\s/).first.chomp
elsif uname.to_s.downcase.match(/mingw64/)
	uname = "MINGW64"
	$dir = $dir.gsub(/ /, '\ ') # fix windows homepath with spaces...
	f1 = "./master.zsh"
	f2 = './env/linux.zsh'
	f3 = "./dirs.zsh"
	f4 = "./env/last.zsh"
	$host = %x(hostname).to_s.split(/\s/).first.chomp
	$user = %x(whoami).to_s.split(/\s/).first.chomp
else
	puts "Node is not mac, linux, mingw64, or bsd - aborting."
	return nil
	exit
end
puts "Assuming host is #{uname};"
#==============// Pre-stage environment //===============================#
if File.exists?("../.ssh/id_rsa.pub")
	ssh = %x(cat ../.ssh/id_rsa.pub).chomp.split(/\s+/m)
	skey = ssh[0] + " " + ssh[1]
else
	puts "Please generate an ssh key using 'ssh-keygen -b 4048 -t rsa'"
	return nil
	exit
end
#==============// Hash builds (shit's gettin messy y'all) //=============#
if File.exists?("./db3.yaml")
    pctree = YAML.load_file("./db3.yaml")
    pctree ? nil : (pctree = {}) # Return empty hash if the load file fails...
else
    pctree = {}
end
user5 = Digest::MD5.hexdigest($user)
host5 = Digest::MD5.hexdigest($host)
if pctree.has_key? host5 # check if the host exists
    h = pctree[host5]
	c_host = h.color
	if h.users.has_key? user5
		c_user = h.users[user5].color
	else
		h.users[user5] = User.new
	    h.users[user5].name = "#{$user[0, 2].upcase}\@#{$host[0, 4].upcase}"
		h.users[user5].color = '255'
		c_user = h.users[user5].color
	end
	h.users[user5].ssh_key = skey
	s_user = h.users[user5].ssh_key
else
	pctree[host5] = Host.new # create new host if not
    h = pctree[host5]
	h.color = '255'
	c_host = h.color
	h.users = {}
    h.users[user5] = User.new
    h.users[user5].name = "#{$user[0, 2].upcase}\@#{$host[0, 4].upcase}"
	h.users[user5].color = '255'
	c_user = h.users[user5].color
	h.users[user5].ssh_key = skey
	s_user = h.users[user5].ssh_key
end
File.open("./db3.yaml", 'w') do |out|   # To file
   YAML.dump(pctree, out)
end
#==============// Generate $PATH //======================================#
pa = []
pa << %x([ -d "$HOME/bin" ] && echo "$HOME/bin").to_s.chomp
pa << %x([ -d "/usr/local/sbin" ] && echo "/usr/local/sbin").to_s.chomp
pa << %x([ -d "/usr/local/bin" ] && echo "/usr/local/bin").to_s.chomp
pa << %x([ -d "/usr/sbin" ] && echo "/usr/sbin").to_s.chomp
pa << %x([ -d "/usr/bin" ] && echo "/usr/bin").to_s.chomp
pa << %x([ -d "/sbin" ] && echo "/sbin").to_s.chomp
pa << %x([ -d "/bin" ] && echo "/bin").to_s.chomp
pa << %x([ -d "/usr/games" ] && echo "/usr/games").to_s.chomp
pa.reject! { |e| e.empty? }
exdr = pa.join(':')
pt = "export PATH=\"#{exdr}:$PATH\"\n"
#==============// Create .zshrc //=======================================#
sp = "export PROMPT=\"\033[38;5;#{c_user}m%n\e[0m@\033[38;5;#{c_host}m%m\e[0m %~ \n%# \"\n"
if uname=="MINGW64" # workaround for git bash, zsh not available
	sh = %x(which bash).to_s.chomp
elsif
	sh = %x(which zsh).to_s.chomp
end
if not File.exists?("./zshrc")
	File.open("./zshrc", 'w') {|f| f.write("...")}
end

File.open("./zshrc", 'r+') do |file|
	l1 = []
	l2 = []
	l3 = []
	l4 = []
	File.open(f1, 'r+') do |f1| # Open master.zsh
		l1 = f1.each_line.to_a
		l1[0] = "\#!#{sh}\n"
		l1[1] = pt
		l1[2] = sp
		f1.rewind
	end
	File.open(f2, 'r+') do |f2| # Open OS template.zsh
		l2 = f2.each_line.to_a
		f2.rewind
	end
	File.open(f3, 'r+') do |f3| # Open dirs.zsh
		l3 = f3.each_line.to_a
		l3.push("\n")
		f3.rewind
	end
	File.open(f4, 'r+') do |f4| # Open last.zsh
		l4 = f4.each_line.to_a
		f4.rewind
	end
	lines = l1.concat(l2).concat(l3).concat(l4) # workaround for 2.3 versions
	file.write(lines.join)
end
File.open("./configs/authk.txt", 'r+') do |file|
	pctree.each do |k1, v1|
        pctree[k1].users.each do |k2, v2|
			u_ssh = v2.ssh_key.to_s
			u_nme = v2.name.to_s
			line = u_ssh + " " + u_nme + "\n"
			file.write(line)
		end
	end
end

%x(cp -Rf ./bin/ ../bin/)
%x(cp -Rf ./configs/tmux.txt ../.tmux.conf)
%x(cp -Rf ./configs/nanorc.txt ../.nanorc)
%x(cp -Rf ./configs/authk.txt ../.ssh/authorized_keys)
%x(cp -Rf ./configs/config.txt ../.ssh/config)
%x(mv -f ./zshrc ../.zshrc)
%x(rm -rf ../.nano)
%x(cp -Rf ./submodules/nano ../.nano)
