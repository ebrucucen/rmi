#
# ApplyVersionToAssemblies.ps1
#

function Convert-DateString ([String]$Date, [String[]]$Format)
{
   $result = New-Object DateTime
 
   $convertible = [DateTime]::TryParseExact(
      $Date,
      $Format,
      [System.Globalization.CultureInfo]::InvariantCulture,
      [System.Globalization.DateTimeStyles]::None,
      [ref]$result)
 
   if ($convertible) { $result }
}
function ApplyVersion(){
param(
[Parameter(Mandatory=$True, Position=1)]
[string]$sourcesDirectory,
[Parameter(Mandatory=$True, Position=2)]
[string]$buildNumber,
[Parameter(Mandatory=$True, Position=3)]
[string]$MajorMinor
)

$buildDate= [regex]::Matches($buildNumber, "\d+")[0].value
$revisionNumber=  [regex]::Matches($buildNumber, "\d+")[1].value

$startdate=[datetime] ($buildDate.substring(0,4) + "/01/01 00:00:00")
$enddate= convert-datestring -date $buildDate -Format "yyyyMMdd"
$elapsedDays=(NEW-TIMESPAN –Start $StartDate –End $EndDate).Days
$versionRegex= "\d+\.\d+\.\d+\.d+"
#$versionData= [regex]::Matches($buildNumber, $versionRegex)
$versionData= $MajorMinor + "." + $elapsedDays + "." + $revisionNumber

Write-Verbose -Verbose "buildNumber:$buildNumber"
Write-Verbose -Verbose "versionRegex:$versionRegex"
Write-Verbose -Verbose "versionData.Count:$($versionData.Count)"
Write-Verbose -Verbose "versionData:$($versionData.Tostring())"


Writ
$files= gci $sourcesDirectory -Recurse -Include "*Properties*" |?{$_.PSIscontainer}| foreach {
	gci -Path $_.FullName -Recurse -include AssemblyInfo.*}
if($files)
{
	Write-Verbose -Verbose "Will apply $newVersion to $($files.Count) files"
	foreach($file in $files){
		$fileContent= Get-Content ($file)
		attrib $file -r
		$fileContent -replace $versionRegex, $versionData | Out-File $file
		Write-Verbose -Verbose "$file.FullName - version applied" 
	}
}
else{
	Write-Warning -Verbose "Found no files."
}
}
Apply-Version $sourcesDirectory $buildNumber
