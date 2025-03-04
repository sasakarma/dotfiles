if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

$repoPath = ".\nvim" 
$neovimConfigPath = "$env:LOCALAPPDATA\nvim"

# シンボリックリンクを作成
if (-not (Test-Path $neovimConfigPath)) {
  New-Item -ItemType Directory -Path $neovimConfigPath
}

if (-not (Test-Path "$neovimConfigPath")) {
  echo "$repoPath -> $neovimConfigPath"
  New-Item -ItemType SymbolicLink -Path "$neovimConfigPath" -Target "$repoPath"
} else {
  echo "$neovimConfigPath already exists!"
}
