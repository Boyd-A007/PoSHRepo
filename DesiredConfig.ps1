Configuration BANDWorkstation
{
   # A Configuration block can have zero or more Node blocks
   Node "localhost"
   {
      # Next, specify one or more resource blocks

      # WindowsFeature is one of the built-in resources you can use in a Node block
      # This example ensures the Web Server (IIS) role is installed
      #WindowsFeature MediaPlayer
      #{
      #    Ensure = "" # To uninstall the role, set Ensure to "Absent"
      #    Name = "WindowsMediaPlayer"  
      #}

      # File is a built-in resource you can use to manage files and directories
      # This example ensures files from the source directory are present in the destination directory
      File BANDWorkstation
      {
         Ensure = "Present"  # You can also set Ensure to "Absent"
         Type = "Directory“ # Default is “File”
         Recurse = $true
         SourcePath = $Payload # This is a path that has web files
         DestinationPath = "C:\bac" # The path where we want to ensure the web files are present
         #DependsOn = "[WindowsFeature]MyRoleExample"  # This ensures that MyRoleExample completes successfully before this block runs
      }
   }
} 
