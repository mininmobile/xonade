Clear-Host

Write-Host "  __  __                     _      "
Write-Host "  \ \/ /___  _ __   __ _  __| | ___ "
Write-Host "   \  // _ \| '_ \ / _`` |/ _`` |/ _ \"
Write-Host "   /  \ (_) | | | | (_| | (_| |  __/"
Write-Host "  /_/\_\___/|_| |_|\__,_|\__,_|\___|"
Write-Host "                                    "
Write-Host ""
Write-Host "Initializing..."
Write-Host ""

# notes for future development:
# X syntax:
#	<>				comment
#	foobar:			label
#	goto foobar		jump to label
#	command args	run command with args
# things:

if (!(Test-Path "X.HD")) {
	Write-Host "X.HD: HARDDRIVE MISSING`n" -f ([ConsoleColor]::Red)

	$x = ""; while ($x.ToLower() -ne "y" -and $x.ToLower() -ne "n") { $Script:x = Read-Host "Install Xonade? [Y/N]" }
	if ($x -eq "n") { exit }

	# init

	#region file structure
	Write-Host "Creating file structure..."
	Write-Host "Creating Xonade Harddrive Container...";		New-Item "X.HD" -ItemType Directory | Out-Null
	Write-Host "Creating Xonade Data Folder...";				New-Item "X.HD\X.DAT" -ItemType Directory | Out-Null
	Write-Host "Creating Xonade Binaries Folder...";			New-Item "X.HD\X.BIN" -ItemType Directory | Out-Null
	Write-Host "Creating Xonade System Folder...";				New-Item "X.HD\X.SYS" -ItemType Directory | Out-Null

	Write-Host "Creating User Folder...";						New-Item "X.HD\X.DAT\User" -ItemType Directory | Out-Null
	Write-Host "Creating Xonade Root Folder...";				New-Item "X.HD\X.DAT\Root" -ItemType Directory | Out-Null

	Write-Host "Creating Xonade Plugin Folder...";				New-Item "X.HD\X.BIN\Plugins" -ItemType Directory | Out-Null
	Write-Host "Creating Xonade Application Folder...";			New-Item "X.HD\X.BIN\Apps" -ItemType Directory | Out-Null

	Write-Host "Creating Xonade Built-in Plugins Folder...";	New-Item "X.HD\X.SYS\Plugins" -ItemType Directory | Out-Null
	Write-Host "Creating Xonade Runtime Folder...";				New-Item "X.HD\X.SYS\Runtime" -ItemType Directory | Out-Null
	Write-Host "Creating Xonade ConsoleFolder...";				New-Item "X.HD\X.SYS\Console" -ItemType Directory | Out-Null
	#endregion

	#region default files
	Write-Host "Creating files..."
	Write-Host "Creating Xonade Configuration File...";		New-Item "X.HD\X.y" | Out-Null

	Write-Host "Creating Example Plugin...";				New-Item "X.HD\X.BIN\Plugins\Example.x" | Out-Null
	
	Write-Host "Creating Xonade Accounts Managing BiP...";	New-Item "X.HD\X.SYS\Plugins\Accounts.x" | Out-Null

	Write-Host "Creating Xonade Command Parser...";			New-Item "X.HD\X.SYS\Runtime\Command.ps1" | Out-Null
	Write-Host "Creating Xonade Script Parser...";			New-Item "X.HD\X.SYS\Runtime\X.ps1" | Out-Null

	Write-Host "Creating Xonade Console...";				New-Item "X.HD\X.SYS\Console\Console.x" | Out-Null
	#endregion

	#region write file content
	Write-Host "Writing file data..."
	Write-Host "Writing Xonade Configuration File...";		Set-Content "X.HD\X.y" "{}"

	Write-Host "Writing Example Plugin...";					Set-Content "X.HD\X.BIN\Plugins\Example.x" "print `"Hello, World!`""

	Write-Host "Writing Xonade Accounts Managing BiP...";	Set-Content "X.HD\X.SYS\Plugins\Accounts.x" "<> copyleft xonade, licensed under MIT`n<> account manager for xonade"

	Write-Host "Writing Xonade Command Parser...";			Set-Content "X.HD\X.SYS\Runtime\Command.ps1" "# copyleft xonade, licensed under MIT`n# command interpreter`n`nparam (`n`t[string] `$command`n)`n`n# remove undentation`n`$c = `$command -replace `"^[ |\t]+`", `"`"`n`n# remove comments`n`$c = `$c -replace `"<>.*`", `"`"`n`n# labels`n`$c = `$c -replace `"^:`", `"label `"`n`n# empty command`nif (`$c.Length -eq 0) { `$c = `"null`" }`n`n# lowercase`nif (`$c.Contains(`"```"`")) {`n`t`$strings = `$c.Split(`"```"`")`n`tfor (`$i = 0; `$i -lt `$strings.Count; `$i++) { if (((`$i) % 2) -eq 0) { `$strings[`$i] = `$strings[`$i].ToLower() } }`n`t`$c = ([string]::Join(`"```"`", `$strings))`n}`n`n# split`n`$c = `$c + `" `" -split `" (?=(?:[^```"]|```"[^```"]*```")*`$)`"`n`n# return formatted command`n`$c"
	Write-Host "Writing Xonade Script Parser...";			Set-Content "X.HD\X.SYS\Runtime\X.ps1" "# copyleft xonade, licensed under MIT`n# x lang compiler`n`nparam (`n	[string] `$xpath`n)`n`nSet-Alias -Name Parse-Command -Value .\X.HD\X.SYS\Runtime\Command.ps1`n`n`$xenv = @{`n	`"Variables`"	= @{};`n	`"Labels`"	= @{};`n}`n`n`$xfile = Get-Content `$xpath`n`$xlines = `$xfile.Split(`"``n`")`n`n`$xi = 0;`n`nfunction Format-String([string] `$string) {`n	`$s = `$string -replace `"\\n`", `"``n`"`n	`$s = `$s -replace `"\\t`", `"``t`"`n	`$s = `$s -replace `"^```"|```"`$`", `"`"`n`n	return `$s`n}`n`n#function Format-Variables([string] `$command) {`n#	`$c = `$command`n#`n#	foreach (`$var in `$xenv.Variables) {`n#		`$c = `$c -replace `"```$`$(`$var)`", `$var`n#	}`n#`n#	return `$c`n#}`n`nfunction Parse-Line([string[]] `$_xc) {`n	[System.Collections.ArrayList]`$xc = `$_xc`n`n	switch (`$xc) {`n		`"print`" {`n			`$xc.RemoveAt(0)`n`n			switch (`$xc[0]) {`n				`"-n`" { `$xc.RemoveAt(0); Write-Host (Format-String `$xc) -n }`n`n				default { Write-Host (Format-String `$xc) }`n			}`n		break }`n`n		`"pause`" { [Console]::ReadKey() | Out-Null; break }`n		`"clear`" { Clear-Host; break }`n`n		`"label`" { `$Script:xenv.Labels[`$xc[1]] = `$xi; break }`n		`"goto`" { `$Script:xi = `$xenv.Labels[`$xc[1]] - 1; break }`n`n		`"softeval`" {`n			try {`n				`$xc.Remove(`"softeval`")`n				Parse-Line `$xc`n			} catch [Exception] {`n				Write-Error `$_.Exception.ToString()`n			}`n		break }`n`n		`"var`" {`n			switch (`$xc[2]) {`n				`"=`" { `$Script:xenv.Variables[`$xc[1]] = `$xc[3] }`n				`"<`" {`n					if (`$xc[3]) { Write-Host (Format-String `$xc[3]) -n }`n					`$Script:xenv.Variables[`$xc[1]] = [Console]::ReadLine()`n				}`n`n				default {`n					throw `"(Variable Assignment) Invalid token `$(`$xc[2]), line `$(`$xi + 1)`"`n				}`n			}`n		break }`n`n		`"function`" { break }`n`n		`"null`" { break }`n`n		default {`n			throw `"Invalid token `$(`$xc[0]), line `$(`$xi + 1)`"`n		}`n	}`n}`n`nfor (`$xi = 0; `$xi -lt `$xlines.Count; `$xi++) {`n	`$line = `$xlines[`$xi]`n	`$xc = Parse-Command `$line`n`n	#Write-Host ([string]::Join(`" `", `$xc))`n`n	Parse-Line `$xc`n}"

	Write-Host "Writing Xonade Console...";					Set-Content "X.HD\X.SYS\Console\Console.x" "<> copyleft xonade, licensed under MIT`n<> xonade console`n`nclear`n`nprint Xonade Console\n`n`n:x.console.prompt`n	var x.input < `"> `"`n`n	softeval print poo my pants`ngoto x.console.prompt`n"
	#endregion
}

# procure enviroment
Write-Host "Starting Enviroment...";

# launch console
Write-Host "Starting Console..."; .\X.HD\X.SYS\Runtime\X.ps1 .\X.HD\X.SYS\Console\Console.x
