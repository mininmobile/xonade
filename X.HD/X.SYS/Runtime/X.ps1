# copyleft xonade, licensed under MIT
# x lang compiler

param (
	[hashtable] $xenv,
	[string] $xpath
)

Set-Alias -Name Parse-Command -Value .\X.HD\X.SYS\Runtime\Command.ps1

function Format-String([string] $string) {
	$s = $string -replace "\\n", "`n"
	$s = $s -replace "\\t", "`t"
	$s = $s -replace "^`"|`"$", ""

	return $s
}

$xfile = Get-Content $xpath
$xlines = $xfile.Split("`n")

for ($xi = 0; $xi -lt $xlines.Count; $xi++) {
	$line = $xlines[$xi]
	$xc = Parse-Command $line

	#Write-Host ([string]::Join(" ", $xc))

	switch ($xc) {
		"print" { Write-Host (Format-String $xc[1]); break }
		"pause" { [Console]::ReadKey() | Out-Null; break }
		"clear" { Clear-Host; break }

		"label" { $Script:xenv.Labels[$xc[1]] = $xi; break }
		"goto" { $Script:xi = $xenv.Labels[$xc[1]] - 1; break }

		"function" { break }
		"var" { break }

		"null" { break }

		default {
			throw "Invalid token $($xc[0]), line $($xi + 1)"
		}
	}
}
