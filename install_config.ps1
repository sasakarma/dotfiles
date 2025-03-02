if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

$repoPath = ".\" 
$neovimConfigPath = "$env:LOCALAPPDATA\nvim"

# シンボリックリンクを作成
if (-not (Test-Path $neovimConfigPath)) {
  New-Item -ItemType Directory -Path $neovimConfigPath
}

if (-not (Test-Path "$neovimConfigPath\init.lua")) {
  echo "$repoPath\init.lua -> $neovimConfigPath\init.lua"
  New-Item -ItemType SymbolicLink -Path "$neovimConfigPath\init.lua" -Target "$repoPath\init.lua"
} else {
  echo "$neovimConfigPath\init.lua already exists!"
}
