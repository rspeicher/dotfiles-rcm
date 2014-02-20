module ApplescriptHelpers
  # Run an AppleScript command
  def osascript(cmd, pretend = false)
    puts cmd unless @quiet
    %x{osascript -e "#{cmd.gsub('"', '\\"').gsub('$', '\\$')}"}.strip unless pretend
  end

  # Get the POSIX path from an HFS path
  def posix_path(hfs, pretend = false)
    osascript %{POSIX path of "#{hfs}"}, pretend
  end

  # Send a specific command to the iTunes application
  def itunes(command, pretend = false)
    osascript %{tell application "iTunes" to #{command}}, pretend
  end
end
