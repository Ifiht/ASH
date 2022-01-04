#############################
#	CUSTOM ZSH FUNCTIONS	#
# 			V0.1			#
#############################
function EXT_COLOR () { 
	echo -ne "\033[38;5;$1m"; 
}
callback() {
	COMPLETED=$(( COMPLETED + 1 ))
	print $@
}