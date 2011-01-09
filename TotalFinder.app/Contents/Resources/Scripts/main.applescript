tell application "Finder"
	delay 1 -- this delay is important to prevent random "Connection is Invalid -609" AppleScript errors 
	try
		«event BATFinit»
	on error msg number num
		display dialog "
Unable to launch TotalFinder.
		
" & msg & " ( " & (num as text) & ")" & " 

TotalFinder.app is expected to be located in \"/Applications\" folder
		
Please check output in Console.app.

You may also visit 
http://getsatisfaction.com/binaryage 
to get support on this issue." with icon 0
	end try
end tell