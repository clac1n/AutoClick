Start-Sleep-Seconds 3
$signature @"
[DllImport("user32.dll")]
public static extern bool SetCursorPos(int x, int y);

[DllImport("user32.dll")]
public static extern void mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);

Add-type -MemberDefinition $signature -Namespace "User32" -Name "MouseClicker"

$MOUSEEVENT_LEFTDOWN = 0x02
$MOUSEEVENT_LEFTUP = 0x04

function MoveAndClick([int] $x, [int] $y) {
	[User32.MouseClicker]::SetCursorPos($x, $y)
	[User32.MouseClicker]:: mouse_event($MOUSEEVENT_LEFTDOWN, 0, 0, 0, 0)
	[User32.MouseClicker]::mouse_event($MOUSEEVENT_LEFTUP, 0, 0, 0, 0)
	Start-Sleep-Seconds 7
}
$global:totalExecutionTime = 54000
$startTime = Get-Date

$coordinates = @(
	@{ X = 24; Y = 96}
	@{ X = 243; Y = 214}
	@{ X = 635; Y = 436}
	@{ X = 588; Y = 486}
	@{ X = 1242; Y = 857}
	@{ X = 1098; Y = 601}
	@{ X = 1065; Y = 619}
	@{ X = 24; Y = 96}
	@{ X = 968; Y = 595}
)
while ($true) {
	$elapsedTime = (Get-Date) - $startTime
	if ($elapsedTime.TotalSeconds -gt $global:totalExecutionTime) { 
		break
	}
	for ($i=0; $i -lt $coordinates.Length; $i++) {
		$coord=$coordinates[$i]
		MoveAndClick $coord.X $coord.Y
	}
}

Write-Host "Turning off"