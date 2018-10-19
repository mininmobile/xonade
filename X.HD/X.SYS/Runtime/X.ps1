# copyleft xonade, licensed under MIT
# x lang compiler

param (
	[hashtable] $xenv,
	[string] $xpath
)

Set-Alias -Name Parse-Command -Value .\X.HD\X.SYS\Runtime\Command.ps1

$xfile = Get-Content $xpath
$xlines = $xfile.Split("`n")

for ($xi = 0; $xi -lt $xlines.Count; $xi++) {
	$line = $xlines[$xi]
	$xc = Parse-Command $line

	switch ($xc) {
		"print" { Write-Host $xc[1]; break }
		"label" { $xenv.Labels[$xc[1]] = $xi; break }
		"null" { break }

		default {
			throw "Invalid token $($xc[0]), line $($xi + 1)"
		}
	}
}
