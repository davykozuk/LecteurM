
Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Title="MainWindow" Height="98.879" Width="203.7" >
    <Grid>
        <Button Content="BIB" HorizontalAlignment="Center" Margin="0" VerticalAlignment="Center" Width="75" Name="BBib"/>
    </Grid>
</Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#

function FBib(){
$Username="admin"
$Password="davy"
$Path="\\NAS-DAVY\Jeux"
New-SmbMapping -RemotePath $Path -LocalPath Y: -UserName $Username -Password $Password  -Persistent $true
stop-process -processname explorer
}


#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }



$BBib.Add_Click({FBib $this $_})



[void]$Window.ShowDialog()