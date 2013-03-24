set lastErrMsg to "Unable to inject TotalFinder"
set lastErrCode to -1
set failed to yes
set nextDelay to 1

tell application "Finder"
	set startTime to current date

	-- under some conditions like system startup the system may be busy delivering apple events
	-- in this case we may get random "Connection is Invalid -609" AppleScript errors
	-- solution: we try it multiple times
	repeat
		-- increase the delay between individual trials
		log "delay " & (nextDelay as text) & "..."
		delay nextDelay
		set nextDelay to nextDelay + 1
		
		-- try injection
		try
			«event BATFinit»
			set failed to no
			exit repeat
		on error msg number code
			log "error: " & msg & "(" & (code as text) & ")"
			set lastErrMsg to msg
			set lastErrCode to code
		end try
		
		-- make sure we don't repeat this forever, two minutes should be enough
		if (current date) - startTime is greater than (2 * 60) then exit repeat
		
	end repeat
	
	if failed is yes then
		display dialog "
Unable to launch TotalFinder.
		
" & lastErrMsg & " (" & (lastErrCode as text) & ")" & " 

Please email support@binaryage.com to get support on this issue." with icon 0 giving up after 30
	end if
	
end tell