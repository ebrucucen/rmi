#
# ApplyVersionToAssemblies.ps1
#

[CmdletBinding()]
param(
[Parameter(Mandatory=$True, Position=1)]
[string]$sourcesDirectory,
[Parameter(Mandatory=$True, Position=2)]
[string]$buildNumber)

$versionRegex= "\d+\.\d+"
$versionData= [regex]::Matches($buildNumber, $versionRegex)
Write-Verbose -Verbose "buildNumber:$buildNumber"
Write-Verbose -Verbose "versionRegex:$versionRegex"
Write-Verbose -Verbose "versionData.Count:$($versionData.Count)"
Write-Verbose -Verbose "versionData:$($versionData.Tostring())"


switch ($versionData.Count)
{
	0
	{
		Write-Error "Could not find version number in $buildNumber"
	}
	1{}
	default
	{
		Write-Warning "found more than intance of data in buildnumber"
		Write-Warning "will assume first instance is version"
	}
}
$newVersion= $versionData[0]
Write-Verbose -Verbose "Version:$newVersion"

$files= gci $sourcesDirectory -Recurse -Include "*Properties*" |?{$_.PSIscontainer}| foreach {
	gci -Path $_.FullName -Recurse -include AssemblyInfo.*}
if($files)
{
	Write-Verbose -Verbose "Will apply $newVersion to $($files.Count) files"
	foreach($file in $files){
		$fileContent= Get-Content ($file)
		attrib $file -r
		$fileContent -replace $versionRegex, $newVersion | Out-File $file
		Write-Verbose -Verbose "$file.FullName - version applied" 
	}
}
else{
	Write-Warning -Verbose "Found no files."
}
