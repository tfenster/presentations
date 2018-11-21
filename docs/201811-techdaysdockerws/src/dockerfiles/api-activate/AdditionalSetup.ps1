. C:\Run\Prompt.ps1
New-NAVServerUser -WindowsAccount (whoami) NAV
New-NAVServerUserPermissionSet -WindowsAccount (whoami) -PermissionSetId SUPER NAV
Write-Host "initialize API Services"
Invoke-NAVCodeunit -CodeunitId 5465 -ServerInstance NAV -CompanyName (Get-NAVCompany NAV).CompanyName