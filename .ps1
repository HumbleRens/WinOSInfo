$computerName = "Computer"
$os = Get-WmiObject -ComputerName $computerName -Class Win32_OperatingSystem

if ($os) {
    $osVersion = $os.Version
    $osBuildNumber = $os.BuildNumber
    $osInstallDate = $os.InstallDate

    Write-Host "OS version of $computerName is $osVersion"
    Write-Host "OS build number of $computerName is $osBuildNumber"
    Write-Host "OS installed on $osInstallDate"

    $hotfixes = Get-HotFix -ComputerName $computerName

    if ($hotfixes) {
        Write-Host "Installed hotfixes on $computerName in 2023:"
        $hotfixes | Where-Object { $_.InstalledOn.Year -eq 2023 } | Select-Object -Property HotFixID, InstalledOn
    } else {
        Write-Host "No hotfixes installed on $computerName in 2023"
    }
} else {
    Write-Host "Failed to retrieve OS information for $computerName"
}
