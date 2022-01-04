#Microsoft.PowerShell_profile.ps1
Import-Module oh-my-posh
Remove-Module PSReadline
oh-my-posh --init --shell pwsh --config ~/stelbent.minimal.omp.json | Invoke-Expression
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
function l {
    dir | fw
}
function ll {
    Get-ChildItem -Attributes Hidden,!Hidden
}