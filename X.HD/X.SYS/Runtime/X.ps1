# copyleft xonade, licensed under MIT
# x lang compiler

param (
	[string] $xpath
)

Set-Alias -Name Parse-Command -Value .\X.HD\X.SYS\Runtime\Command.ps1

$xenv = @{
	"Variables"	= @{};
	"Labels"	= @{};
}

$xfile = Get-Content $xpath
$xlines = $xfile.Split("`n")

$xi = 0;

function Format-String([string] $string) {
	$s = $string -replace "\\n", "`n"
	$s = $s -replace "\\t", "`t"
	$s = $s -replace "^`"|`"$", ""

	return $s
}

#function Format-Variables([string] $command) {
#	$c = $command
#
#	foreach ($var in $xenv.Variables) {
#		$c = $c -replace "`$$($var)", $var
#	}
#
#	return $c
#}

function Parse-Line([string[]] $_xc) {
	[System.Collections.ArrayList]$xc = $_xc

	switch ($xc) {
		"print" {
			$xc.RemoveAt(0)

			switch ($xc[0]) {
				"-n" { $xc.RemoveAt(0); Write-Host (Format-String $xc) -n }

				default { Write-Host (Format-String $xc) }
			}
		break }

		"pause" { [Console]::ReadKey() | Out-Null; break }
		"clear" { Clear-Host; break }

		"label" { $Script:xenv.Labels[$xc[1]] = $xi; break }
		"goto" { $Script:xi = $xenv.Labels[$xc[1]] - 1; break }

		"softeval" {
			try {
				$xc.Remove("softeval")
				Parse-Line $xc
			} catch [Exception] {
				Write-Error $_.Exception.ToString()
			}
		break }

		"var" {
			switch ($xc[2]) {
				"=" { $Script:xenv.Variables[$xc[1]] = $xc[3] }
				"<" {
					if ($xc[3]) { Write-Host (Format-String $xc[3]) -n }
					$Script:xenv.Variables[$xc[1]] = [Console]::ReadLine()
				}

				default {
					throw "(Variable Assignment) Invalid token $($xc[2]), line $($xi + 1)"
				}
			}
		break }

		"function" { break }

		"null" { break }

		default {
			throw "Invalid token $($xc[0]), line $($xi + 1)"
		}
	}
}

for ($xi = 0; $xi -lt $xlines.Count; $xi++) {
	$line = $xlines[$xi]
	$xc = Parse-Command $line

	#Write-Host ([string]::Join(" ", $xc))

	Parse-Line $xc
}
