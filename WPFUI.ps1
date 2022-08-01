Add-Type –assemblyName PresentationFramework
 
$Runspace = [runspacefactory]::CreateRunspace()
$Runspace.ApartmentState = "STA"
$Runspace.ThreadOptions = "ReuseThread"
$Runspace.Open()
 
$code = {
 
#Build the GUI
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="PowerShell Runspace Demo" Height="283" Width="782" WindowStartupLocation = "CenterScreen">
    <Grid Margin="0,0,0,-1">
        <Button x:Name="Ping1" Content="Ping" HorizontalAlignment="Left" Margin="119,146,0,0" VerticalAlignment="Top" Width="93" Height="31"/>
        <Button x:Name="Ping2" Content="Ping" HorizontalAlignment="Left" Margin="255,146,0,0" VerticalAlignment="Top" Width="93" Height="31"/>
        <Button x:Name="Ping3" Content="Ping" HorizontalAlignment="Left" Margin="387,146,0,0" VerticalAlignment="Top" Width="93" Height="31"/>
        <Button x:Name="Ping4" Content="Ping" HorizontalAlignment="Left" Margin="524,146,0,0" VerticalAlignment="Top" Width="93" Height="31"/>
        <Button x:Name="Ping5" Content="Ping" HorizontalAlignment="Left" Margin="656,146,0,0" VerticalAlignment="Top" Width="93" Height="31"/>
        <TextBox x:Name="ComputerName1" HorizontalAlignment="Left" Height="23" Margin="105,79,0,0" TextWrapping="Wrap" Text="SERVER-01" VerticalAlignment="Top" Width="120"/>
        <TextBox x:Name="ComputerName2" HorizontalAlignment="Left" Height="23" Margin="243,79,0,0" TextWrapping="Wrap" Text="SERVER-02" VerticalAlignment="Top" Width="120"/>
        <TextBox x:Name="ComputerName3" HorizontalAlignment="Left" Height="23" Margin="374,79,0,0" TextWrapping="Wrap" Text="SERVER-03" VerticalAlignment="Top" Width="120"/>
        <TextBox x:Name="ComputerName4" HorizontalAlignment="Left" Height="23" Margin="509,79,0,0" TextWrapping="Wrap" Text="SERVER-04" VerticalAlignment="Top" Width="120"/>
        <TextBox x:Name="ComputerName5" HorizontalAlignment="Left" Height="23" Margin="640,79,0,0" TextWrapping="Wrap" Text="SERVER-05" VerticalAlignment="Top" Width="120"/>
        <ComboBox x:Name="Count1" HorizontalAlignment="Left" Margin="137,107,0,0" VerticalAlignment="Top" Width="56" Height="34">
            <ComboBoxItem Content="1"/>
            <ComboBoxItem Content="2"/>
            <ComboBoxItem Content="3"/>
            <ComboBoxItem Content="4"/>
            <ComboBoxItem Content="5"/>
            <ComboBoxItem Content="6"/>
            <ComboBoxItem Content="7"/>
            <ComboBoxItem Content="8"/>
        </ComboBox>
        <ComboBox x:Name="Count2" HorizontalAlignment="Left" Margin="274,107,0,0" VerticalAlignment="Top" Width="56" Height="34">
            <ComboBoxItem Content="1"/>
            <ComboBoxItem Content="2"/>
            <ComboBoxItem Content="3"/>
            <ComboBoxItem Content="4"/>
            <ComboBoxItem Content="5"/>
            <ComboBoxItem Content="6"/>
            <ComboBoxItem Content="7"/>
            <ComboBoxItem Content="8"/>
        </ComboBox>
        <ComboBox x:Name="Count3" HorizontalAlignment="Left" Margin="403,107,0,0" VerticalAlignment="Top" Width="56" Height="34">
            <ComboBoxItem Content="1"/>
            <ComboBoxItem Content="2"/>
            <ComboBoxItem Content="3"/>
            <ComboBoxItem Content="4"/>
            <ComboBoxItem Content="5"/>
            <ComboBoxItem Content="6"/>
            <ComboBoxItem Content="7"/>
            <ComboBoxItem Content="8"/>
        </ComboBox>
        <ComboBox x:Name="Count4" HorizontalAlignment="Left" Margin="540,107,0,0" VerticalAlignment="Top" Width="56" Height="34">
            <ComboBoxItem Content="1"/>
            <ComboBoxItem Content="2"/>
            <ComboBoxItem Content="3"/>
            <ComboBoxItem Content="4"/>
            <ComboBoxItem Content="5"/>
            <ComboBoxItem Content="6"/>
            <ComboBoxItem Content="7"/>
            <ComboBoxItem Content="8"/>
        </ComboBox>
        <ComboBox x:Name="Count5" HorizontalAlignment="Left" Margin="669,107,0,0" VerticalAlignment="Top" Width="56" Height="34">
            <ComboBoxItem Content="1"/>
            <ComboBoxItem Content="2"/>
            <ComboBoxItem Content="3"/>
            <ComboBoxItem Content="4"/>
            <ComboBoxItem Content="5"/>
            <ComboBoxItem Content="6"/>
            <ComboBoxItem Content="7"/>
            <ComboBoxItem Content="8"/>
        </ComboBox>
        <TextBox x:Name="Result1" HorizontalAlignment="Left" Height="56" Margin="128,182,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="75" FontSize="18"/>
        <TextBox x:Name="Result2" HorizontalAlignment="Left" Height="56" Margin="264,182,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="75" FontSize="18"/>
        <TextBox x:Name="Result3" HorizontalAlignment="Left" Height="56" Margin="397,182,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="75" FontSize="18"/>
        <TextBox x:Name="Result4" HorizontalAlignment="Left" Height="56" Margin="535,182,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="75" FontSize="18"/>
        <TextBox x:Name="Result5" HorizontalAlignment="Left" Height="56" Margin="669,182,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="75" FontSize="18"/>
        <Label Content="ComputerName:" HorizontalAlignment="Left" Margin="3,75,0,0" VerticalAlignment="Top" Height="26" Width="97"/>
        <Label Content="Count:" HorizontalAlignment="Left" Margin="3,107,0,0" VerticalAlignment="Top" Height="26" Width="94"/>
        <Label Content="Avg Latency (ms):" HorizontalAlignment="Left" Margin="0,182,0,0" VerticalAlignment="Top" Height="26" Width="111"/>
        <Label Content="Runspace Demo: Test-Connection" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top" Width="338" FontSize="20" FontWeight="Bold"/>
        <Button x:Name="Pingall" Content="Ping all" HorizontalAlignment="Left" Margin="656,14,0,0" VerticalAlignment="Top" Width="89" Height="37" FontWeight="Bold"/>
    </Grid>
</Window>
"@
 
$syncHash = [hashtable]::Synchronized(@{})
$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$syncHash.Window=[Windows.Markup.XamlReader]::Load( $reader )
 
function RunspacePing {
    param($syncHash,$Count,$ComputerName,$TargetBox)
    if ($Count -eq $null)
        {NullCount; break}
    
    $syncHash.Host = $host
    $Runspace = [runspacefactory]::CreateRunspace()
    $Runspace.ApartmentState = "STA"
    $Runspace.ThreadOptions = "ReuseThread"
    $Runspace.Open()
    $Runspace.SessionStateProxy.SetVariable("syncHash",$syncHash) 
    $Runspace.SessionStateProxy.SetVariable("count",$count)
    $Runspace.SessionStateProxy.SetVariable("ComputerName",$ComputerName)
    $Runspace.SessionStateProxy.SetVariable("TargetBox",$TargetBox)
    
    $code = {
        $syncHash.Window.Dispatcher.invoke(
        [action]{ $syncHash.$TargetBox.Clear() })

        $Con = Test-Connection -ComputerName $ComputerName -Count $count
        $average = [math]::Round(($con.ResponseTime | measure -Average).Average)
        
        $syncHash.Window.Dispatcher.invoke(
        [action]{ $syncHash.$TargetBox.Text = $average }
        )
    }
    $PSinstance = [powershell]::Create().AddScript($Code)
    $PSinstance.Runspace = $Runspace
    $job = $PSinstance.BeginInvoke()
}
 
function NullCount {
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
[Microsoft.VisualBasic.Interaction]::MsgBox("Please select a ping count first",'OKOnly,Information',"Ping")
}
 
# XAML objects
# ComputerNames
$syncHash.ComputerName1 = $syncHash.Window.FindName("ComputerName1")
$syncHash.ComputerName2 = $syncHash.Window.FindName("ComputerName2")
$syncHash.ComputerName3 = $syncHash.Window.FindName("ComputerName3")
$syncHash.ComputerName4 = $syncHash.Window.FindName("ComputerName4")
$syncHash.ComputerName5 = $syncHash.Window.FindName("ComputerName5")
# Count
$syncHash.Count1 = $syncHash.Window.FindName("Count1")
$syncHash.Count2 = $syncHash.Window.FindName("Count2")
$syncHash.Count3 = $syncHash.Window.FindName("Count3")
$syncHash.Count4 = $syncHash.Window.FindName("Count4")
$syncHash.Count5 = $syncHash.Window.FindName("Count5")
# Ping buttons
$syncHash.Ping1 = $syncHash.Window.FindName("Ping1")
$syncHash.Ping2 = $syncHash.Window.FindName("Ping2")
$syncHash.Ping3 = $syncHash.Window.FindName("Ping3")
$syncHash.Ping4 = $syncHash.Window.FindName("Ping4")
$syncHash.Ping5 = $syncHash.Window.FindName("Ping5")
$syncHash.Pingall = $syncHash.Window.FindName("Pingall")
# Result boxes
$syncHash.Result1 = $syncHash.Window.FindName("Result1")
$syncHash.Result2 = $syncHash.Window.FindName("Result2")
$syncHash.Result3 = $syncHash.Window.FindName("Result3")
$syncHash.Result4 = $syncHash.Window.FindName("Result4")
$syncHash.Result5 = $syncHash.Window.FindName("Result5")
 
# Click Actions
$syncHash.Ping1.Add_Click(
    {
        RunspacePing -syncHash $syncHash -count $syncHash.Count1.SelectedItem.Content -ComputerName $syncHash.ComputerName1.Text -TargetBox "Result1"
    })
 
$syncHash.Ping2.Add_Click(
    {
        RunspacePing -syncHash $syncHash -count $syncHash.Count2.SelectedItem.Content -ComputerName $syncHash.ComputerName2.Text -TargetBox "Result2"
    })
 
$syncHash.Ping3.Add_Click(
    {
        RunspacePing -syncHash $syncHash -count $syncHash.Count3.SelectedItem.Content -ComputerName $syncHash.ComputerName3.Text -TargetBox "Result3"
    })
 
$syncHash.Ping4.Add_Click(
    {
        RunspacePing -syncHash $syncHash -count $syncHash.Count4.SelectedItem.Content -ComputerName $syncHash.ComputerName4.Text -TargetBox "Result4"
    })
 
$syncHash.Ping5.Add_Click(
    {
        RunspacePing -syncHash $syncHash -count $syncHash.Count5.SelectedItem.Content -ComputerName $syncHash.ComputerName5.Text -TargetBox "Result5"
    })
 
$syncHash.Pingall.Add_Click(
    {
        if ($syncHash.count1.SelectedItem.Content -eq $null -or $syncHash.count2.SelectedItem.Content -eq $null -or $syncHash.count3.SelectedItem.Content -eq $null -or $syncHash.count4.SelectedItem.Content -eq $null -or $syncHash.count5.SelectedItem.Content -eq $null)
            {NullCount; break}
        RunspacePing -syncHash $syncHash -count $syncHash.Count1.SelectedItem.Content -ComputerName $syncHash.ComputerName1.Text -TargetBox "Result1"
        RunspacePing -syncHash $syncHash -count $syncHash.Count2.SelectedItem.Content -ComputerName $syncHash.ComputerName2.Text -TargetBox "Result2"
        RunspacePing -syncHash $syncHash -count $syncHash.Count3.SelectedItem.Content -ComputerName $syncHash.ComputerName3.Text -TargetBox "Result3"
        RunspacePing -syncHash $syncHash -count $syncHash.Count4.SelectedItem.Content -ComputerName $syncHash.ComputerName4.Text -TargetBox "Result4"
        RunspacePing -syncHash $syncHash -count $syncHash.Count5.SelectedItem.Content -ComputerName $syncHash.ComputerName5.Text -TargetBox "Result5"
    })
 
$syncHash.Window.ShowDialog()
$Runspace.Close()
$Runspace.Dispose()
 
}
 
$PSinstance1 = [powershell]::Create().AddScript($Code)
$PSinstance1.Runspace = $Runspace
$job = $PSinstance1.BeginInvoke()