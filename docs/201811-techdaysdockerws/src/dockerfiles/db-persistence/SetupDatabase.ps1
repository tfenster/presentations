$volPath = "$env:volPath"
$myPassword = ([System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)).Replace('"','""').Replace('''',''''''))

if ($restartingInstance) {

    # Nothing to do

} elseif ($volPath -ne "") {
    # database volume path is provided, check if the database is already there or not

    if ((Get-Item -path $volPath).GetFileSystemInfos().Count -eq 0) {
        # folder is empty, try to move the existing database to the db volume path
        Write-Host "Move database to volume"

        [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null

        [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Common") | Out-Null

        $dummy = new-object Microsoft.SqlServer.Management.SMO.Server

        $sqlcmd = "ALTER LOGIN sa with password='$myPassword',CHECK_POLICY = OFF;ALTER LOGIN sa ENABLE;"
        & sqlcmd -S "$databaseServer\$databaseInstance" -Q $sqlcmd

        $sqlConn = new-object Microsoft.SqlServer.Management.Common.ServerConnection
        $sqlConn.ServerInstance = "localhost"
        $sqlConn.LoginSecure = $false
        $sqlConn.Login = "sa"
        $sqlConn.Password = $myPassword

        $toCopy = @()

        $smo = new-object Microsoft.SqlServer.Management.SMO.Server($sqlConn)
        $smo.Databases | ForEach-Object {
            if ($_.Name -ne 'master' -and $_.Name -ne 'model' -and $_.Name -ne 'msdb' -and $_.Name -ne 'tempdb') {
                $dbPath = Join-Path -Path $volPath -ChildPath $_.Name
                mkdir $dbPath | Out-Null
                $_.FileGroups | ForEach-Object {
                    $_.Files | ForEach-Object {
                        $destination = (Join-Path -Path $dbPath -ChildPath ($_.Name + '.' +  $_.FileName.SubString($_.FileName.LastIndexOf('.') + 1)))
                        $toCopy += ,@($_.FileName, $destination)
                        $_.FileName = $destination
                    } 
                }
                $_.LogFiles | ForEach-Object {
                    $destination = (Join-Path -Path $dbPath -ChildPath ($_.Name + '.' +  $_.FileName.SubString($_.FileName.LastIndexOf('.') + 1)))
                    $toCopy += ,@($_.FileName, $destination)
                    $_.FileName = $destination
                }

                $_.Alter()
                $_.SetOffline()

                $toCopy | ForEach-Object {
                    Move-Item -Path $_[0] -Destination $_[1]
                }
                $_.SetOnline()
            }
        }
        $smo.ConnectionContext.Disconnect()
    } else {
        # folder is not empty, attach the database
        Write-Host "Attach database $databaseName"

        $sqlcmd = "DROP DATABASE IF EXISTS $databaseName"
        & sqlcmd -S "$databaseServer\$databaseInstance" -Q $sqlcmd

        $files = Get-ChildItem $volPath -File
        $joinedFiles = $files -join "'), (FILENAME = '$volPath\"
        $sqlcmd = "CREATE DATABASE $databaseName ON (FILENAME = '$volPath\$joinedFiles') FOR ATTACH;"
        & sqlcmd -S "$databaseServer\$databaseInstance" -Q $sqlcmd
    }
} else {
    # invoke default
    . (Join-Path $runPath $MyInvocation.MyCommand.Name)
}