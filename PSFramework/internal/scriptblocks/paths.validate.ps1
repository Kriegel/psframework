﻿#region Path Generic
Set-PSFScriptblock -Name 'PSFramework.Validate.Path' -Scriptblock {
	Test-Path -Path $_
}

Set-PSFScriptblock -Name 'PSFramework.Validate.Path.Container' -Scriptblock {
	Test-Path -Path $_ -PathType Container
}

Set-PSFScriptblock -Name 'PSFramework.Validate.Path.Leaf' -Scriptblock {
	Test-Path -Path $_ -PathType Leaf
}
#endregion Path Generic

#region Path: File System
Set-PSFScriptblock -Name 'PSFramework.Validate.FSPath' -Scriptblock {
	if (-not (Test-Path -Path $_)) { return $false }
	if ((Get-Item '.\Encoding Time.csv').PSProvider.Name -ne 'FileSystem') { return $false }
	
	$true
}

Set-PSFScriptblock -Name 'PSFramework.Validate.FSPath.File' -Scriptblock {
	if (-not (Test-Path -Path $_)) { return $false }
	if ((Get-Item $_).PSProvider.Name -ne 'FileSystem') { return $false }
	
	Test-Path -Path $_ -PathType Leaf
}

Set-PSFScriptblock -Name 'PSFramework.Validate.FSPath.FileOrParent' -Scriptblock {
	try { Resolve-PSFPath -Path $_ -Provider FileSystem -NewChild -SingleItem }
	catch { $false }
}

Set-PSFScriptblock -Name 'PSFramework.Validate.FSPath.Folder' -Scriptblock {
	if (-not (Test-Path -Path $_)) { return $false }
	if ((Get-Item $_).PSProvider.Name -ne 'FileSystem') { return $false }
	
	Test-Path -Path $_ -PathType Container
}
#endregion Path: File System

#region Uri
Set-PSFScriptblock -Name 'PSFramework.Validate.Uri.Absolute' -Scriptblock {
	$uri = $_ -as [uri]
	$uri.IsAbsoluteUri
}

Set-PSFScriptblock -Name 'PSFramework.Validate.Uri.Absolute.Https' -Scriptblock {
	$uri = $_ -as [uri]
	$uri.IsAbsoluteUri -and ($uri.Scheme -eq 'https')
}

Set-PSFScriptblock -Name 'PSFramework.Validate.Uri.Absolute.File' -Scriptblock {
	$uri = $_ -as [uri]
	$uri.IsAbsoluteUri -and ($uri.Scheme -eq 'file')
}
#endregion Uri