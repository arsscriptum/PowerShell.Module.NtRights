
<#
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>

#===============================================================================
# ChannelProperties
#===============================================================================

class ChannelProperties
{
    #ChannelProperties
    [string]$Channel = 'GIT'
    [ConsoleColor]$TitleColor = (Get-RandomColor)
    [ConsoleColor]$MessageColor = 'DarkGray'
    [ConsoleColor]$ErrorColor = 'DarkRed'
    [ConsoleColor]$SuccessColor = 'DarkGreen'
    [ConsoleColor]$ErrorDescriptionColor = 'DarkYellow'
}
$Script:ChannelProps = [ChannelProperties]::new()


function Write-ChannelMessage{                
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Message        
    )

    Write-Host "[$($Script:ChannelProps.Channel)] " -f $($Script:ChannelProps.TitleColor) -NoNewLine
    Write-Host "$Message" -f $($Script:ChannelProps.MessageColor)
}


function Write-ChannelResult{                               
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Message,
        [switch]$Warning
    )

    if($Warning -eq $False){
        Write-Host "[$($Script:ChannelProps.Channel)] " -f $($Script:ChannelProps.TitleColor) -NoNewLine
        Write-Host "[ OK ] " -f $($Script:ChannelProps.SuccessColor) -NoNewLine
    }else{
        Write-Host "[WARN] " -f $($Script:ChannelProps.ErrorColor) -NoNewLine
    }
    
    Write-Host "$Message" -f $($Script:ChannelProps.MessageColor)
}



function Write-ChannelError{                              
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true)]
        [System.Management.Automation.ErrorRecord]$Record
    )
    $formatstring = "{0}`n{1}"
    $fields = $Record.FullyQualifiedErrorId,$Record.Exception.ToString()
    $ExceptMsg=($formatstring -f $fields)
    Write-Host "[$($Script:ChannelProps.Channel)] " -f $($Script:ChannelProps.TitleColor) -NoNewLine
    Write-Host "[ERROR] " -f $($Script:ChannelProps.ErrorColor) -NoNewLine
    Write-Host "$ExceptMsg`n`n" -ForegroundColor DarkYellow
}
