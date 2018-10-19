# copyleft xonade, licensed under MIT
# command interpreter

param (
	[string] $command
)

# remove undentation
$c = $command -replace "^[ |\t]+", ""

# remove comments
$c = $c -replace "#.*", ""

# labels
$c = $c -replace "^:", "label "

# empty command
if ($c.Length -eq 0) { $c = "null" }

# lowercase
if ($c.Contains("`"")) {
	$strings = $c.Split("`"")
	for ($i = 0; $i -lt $strings.Count; $i++) { if ((($i) % 2) -eq 0) { $strings[$i] = $strings[$i].ToLower() } }
	$c = ([string]::Join("`"", $strings))
}

# return formatted command
$c
