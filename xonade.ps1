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

	Write-Host "Creating Xonade Enviroment...";				New-Item "X.HD\X.SYS\Runtime\Env.ps1" | Out-Null
	Write-Host "Creating Xonade Command Parser...";			New-Item "X.HD\X.SYS\Runtime\Command.ps1" | Out-Null
	Write-Host "Creating Xonade Script Parser...";			New-Item "X.HD\X.SYS\Runtime\X.ps1" | Out-Null

	Write-Host "Creating Xonade Console...";				New-Item "X.HD\X.SYS\Console\Console.x" | Out-Null
	#endregion

	#region write file content
	Write-Host "Writing file data..."
	Write-Host "Writing Xonade Configuration File...";		Set-Content "X.HD\X.y" "{}"

	Write-Host "Writing Example Plugin...";					Set-Content "X.HD\X.BIN\Plugins\Example.x" "print `"Hello, World!`""

	Write-Host "Writing Xonade Accounts Managing BiP...";	Set-Content "X.HD\X.SYS\Plugins\Accounts.x" "> copyleft xonade, licensed under MIT`n> account manager for xonade"

	Write-Host "Writing Xonade Enviroment...";				Set-Content "X.HD\X.SYS\Runtime\Env.ps1" "# copyleft xonade, licensed under MIT`n# enviroment for xonade runtime`n`n@{`n`t`"Variables`"`t= @{};`n`t`"Labels`"`t= @{};`n}"
	Write-Host "Writing Xonade Command Parser...";			Set-Content "X.HD\X.SYS\Runtime\Command.ps1" "# copyleft xonade, licensed under MIT`n# command interpreter`n`nparam (`n`t[string] `$command`n)`n`n# remove undentation`n`$c = `$command -replace `"^[ |\t]+`", `"`"`n`n# remove comments`n`$c = `$c -replace `">.*`", `"`"`n`n# labels`n`$c = `$c -replace `"^:`", `"label `"`n`n# empty command`nif (`$c.Length -eq 0) { `$c = `"null`" }`n`n# lowercase`nif (`$c.Contains(`"```"`")) {`n`t`$strings = `$c.Split(`"```"`")`n`tfor (`$i = 0; `$i -lt `$strings.Count; `$i++) { if (((`$i) % 2) -eq 0) { `$strings[`$i] = `$strings[`$i].ToLower() } }`n`t`$c = ([string]::Join(`"```"`", `$strings))`n}`n`n# split`n`$c = `$c + `" `" -split `" (?=(?:[^```"]|```"[^```"]*```")*`$)`"`n`n# return formatted command`n`$c"
	Write-Host "Writing Xonade Script Parser...";			Set-Content "X.HD\X.SYS\Runtime\X.ps1" "# copyleft xonade, licensed under MIT`n# x lang compiler"

	Write-Host "Writing Xonade Console...";					Set-Content "X.HD\X.SYS\Console\Console.x" "> copyleft xonade, licensed under MIT`n> xonade console"
	#endregion
}

# procure enviroment
Write-Host "Starting Enviroment..."; $xenv = .\X.HD\X.SYS\Runtime\Env.ps1;

# launch console
Write-Host "Starting Console..."; .\X.HD\X.SYS\Runtime\X.ps1 $xenv .\X.HD\X.SYS\Console\Console.x
