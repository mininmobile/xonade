<> copyleft xonade, licensed under MIT
<> xonade console

clear

print "Xonade Console\n"

:x.console.prompt
	var x.input < "> "

	eval $x.input
goto x.console.prompt
