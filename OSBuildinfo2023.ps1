$computerName = "PCName"
$cimSession = New-CimSession -ComputerName $computerName

if ($cimSession) {
    $os = Get-CimInstance -CimSession $cimSession -ClassName Win32_OperatingSystem

    if ($os) {
        $osVersion = $os.Version
        $osBuildNumber = $os.BuildNumber
        $osInstallDate = $os.InstallDate

        Write-Host "OS version of $computerName is $osVersion"
        Write-Host "OS build number of $computerName is $osBuildNumber"
        Write-Host "OS installed on $osInstallDate"

        $hotfixes = Get-CimInstance -CimSession $cimSession -ClassName Win32_QuickFixEngineering

        if ($hotfixes) {
            $hotfixes = $hotfixes | Where-Object { $_.InstalledOn.Year -eq 2023 }

            if ($hotfixes) {
                Write-Host "Installed hotfixes on $computerName in 2023"
                $hotfixes | Select-Object -Property HotFixID, InstalledOn
            } else {
                Write-Host "No hotfixes installed on $computerName in 2023"
            }
        } else {
            Write-Host "No hotfixes installed on $computerName"
        }
    } else {
        Write-Host "Failed to retrieve OS information for $computerName"
    }

    Remove-CimSession -CimSession $cimSession
} else {
    Write-Host "Failed to establish CIM session to $computerName"
}
