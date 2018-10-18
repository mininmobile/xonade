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
	New-Item "X.HD" -ItemType Directory | Out-Null
	New-Item "X.HD\X.DAT" -ItemType Directory | Out-Null
	New-Item "X.HD\X.BIN" -ItemType Directory | Out-Null
	New-Item "X.HD\X.SYS" -ItemType Directory | Out-Null

	New-Item "X.HD\X.DAT\User" -ItemType Directory | Out-Null
	New-Item "X.HD\X.DAT\Root" -ItemType Directory | Out-Null

	New-Item "X.HD\X.BIN\Plugins" -ItemType Directory | Out-Null
	New-Item "X.HD\X.BIN\Apps" -ItemType Directory | Out-Null
	
	New-Item "X.HD\X.SYS\Plugins" -ItemType Directory | Out-Null
	New-Item "X.HD\X.SYS\Runtime" -ItemType Directory | Out-Null
	New-Item "X.HD\X.SYS\Console" -ItemType Directory | Out-Null
	#endregion

	#region default files
	Write-Host "Creating files..."
	New-Item "X.HD\X.y" | Out-Null

	New-Item "X.HD\X.BIN\Plugins\Example.x" | Out-Null

	New-Item "X.HD\X.SYS\Plugins\Accounts.x" | Out-Null

	New-Item "X.HD\X.SYS\Runtime\Env.ps1" | Out-Null
	New-Item "X.HD\X.SYS\Runtime\Command.ps1" | Out-Null
	New-Item "X.HD\X.SYS\Runtime\X.ps1" | Out-Null
	New-Item "X.HD\X.SYS\Runtime\Y.ps1" | Out-Null

	New-Item "X.HD\X.SYS\Console\Console.x" | Out-Null
	#endregion
}

# launch console
