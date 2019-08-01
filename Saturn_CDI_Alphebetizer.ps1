Write-Host "Saturn Rhea/Phoebe CDI Alphabetizer v.0.6"
Start-Sleep -s 1
Write-Host "by yggdra-omega"
Start-Sleep -s 1
Write-Host "=========================================="
Start-Sleep -s 1
Write-Host ""

$path = Read-Host -Prompt 'Input drive letter for SD card (with semicolon)'

$title = "Drive Letter"
$message = "Is " + $path + " the correct drive letter?"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "Deletes all the files in the folder."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "Retains all the files in the folder."

$maybe = New-Object System.Management.Automation.Host.ChoiceDescription "&Maybe", `
    "Pauses for 60 seconds and then asks again about deleting the files."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $maybe)

$result = $host.ui.PromptForChoice($title, $message, $options, 1) 

switch ($result)
    {
        0 {
             Write-Host "You selected Yes."
             Start-Sleep -s 1
             Write-Host "Moving on..."
             Start-Sleep -s 1
             Break
          }
        1 {
             Write-Host "You selected No."
             $path = Read-Host -Prompt 'Input drive letter for SD card (with semicolon)'
             $title = "Drive Letter"
             $message = "Is " + $path + " the correct drive letter?"

             $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
                 "Deletes all the files in the folder."

             $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
                 "Retains all the files in the folder."

             $maybe = New-Object System.Management.Automation.Host.ChoiceDescription "&Maybe", `
                 "Pauses for 60 seconds and then asks again about deleting the files."

             $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no, $maybe)

             $result = $host.ui.PromptForChoice($title, $message, $options, 1) 

             switch ($result)
                 {
                     0 {
                          Write-Host "You selected Yes."
                          Start-Sleep -s 1
                          Write-Host "Moving on..."
                          Start-Sleep -s 1
                          Break
                       }
                     1 {
                          Write-Host "You selected No."
                          Start-Sleep -s 1
                          Write-Host "Start over."
                          Start-Sleep -s 1
                          Write-Host "3"
                          Start-Sleep -s 1
                          Write-Host "2"
                          Start-Sleep -s 1
                          Write-Host "1"
                          Start-Sleep -s 1
                          Exit
             
                       }
                 }

          }
    }

if ( -Not (Test-Path $path.trim() ))
{
 Clear-Host
 Start-Sleep -s 2
 Write-Host "...wait a sec..."
 Start-Sleep -s 2
 Write-Host "The path you entered does not exist."
 Start-Sleep -s 2
 Write-Host "Maybe you forgot the semicolon?"
 Start-Sleep -s 2
 Write-Host "???????"
 Write-Host $path "ain't no drive I ever heard of."
 Write-Host "???????"
 Start-Sleep -s 2
 Write-Host "Start the script again."
 Start-Sleep -s 2
 Read-Host "Press ENTER to exit"
 Exit
}

cd $path
$tmpDir = $path + '\tmp'
$counter = 1;
$foldercounter = 1;
$foldersize = 1;
$GameListTxt = $path + '\FullGameListing.txt';


Read-Host "Close all Windows Explorer windows accessing the SD card..."
Clear-Host
Read-Host "Did you close them all?"
Clear-Host
Read-Host "Are you SURE??? This will potentially lock up your PC"
Clear-Host
Read-Host "Alright then...press ENTER to proceed..."
Write-Host "5"
Start-Sleep -s 1
Write-Host "4"
Start-Sleep -s 1
Write-Host "3"
Start-Sleep -s 1
Write-Host "2"
Start-Sleep -s 1
Write-Host "1"
Start-Sleep -s 1
Write-Host "GO!"
Start-Sleep -s 1


if ( -Not (Test-Path $tmpDir.trim() ))
{
 New-Item -Path $tmpDir -ItemType Directory
}

Get-ChildItem $path -Recurse -Include *.cdi | Move-Item -Destination $tmpDir
Get-ChildItem -recurse | Where {$_.PSIsContainer -and `
@(Get-ChildItem -Lit $_.Fullname -r | Where {!$_.PSIsContainer}).Length -eq 0} |
Remove-Item -recurse

if (Test-Path $GameListTxt.trim() )
{
 Remove-Item -Path $GameListTxt
 }

Write-Host "All unique files have been moved to the tmp directory"
Write-Host "You may take this time to clean up any errors/duplicates."
Read-Host "Be sure to close all Windows Explorer windows accessing the SD card..."
Clear-Host
Read-Host "Did you close them all?"
Clear-Host
Read-Host "Are you SURE??? This will potentially lock up your PC"
Clear-Host
Read-Host "Alright then...press ENTER to proceed..."
Write-Host "5"
Start-Sleep -s 1
Write-Host "4"
Start-Sleep -s 1
Write-Host "3"
Start-Sleep -s 1
Write-Host "2"
Start-Sleep -s 1
Write-Host "1"
Start-Sleep -s 1
Write-Host "GO!"
Start-Sleep -s 1

Write-Host "Creating folders..."
dir $tmpDir -Recurse -include *.cdi |
sort @{e={$_.basename}} |
%{
      # set folder name with zero filling for sorting
      $foldername = ("$path\{0:00}" -f $foldercounter)
     
      # if folder doesn't exist create
      if(!(Test-Path -Path $foldername))
      {
            $folderpath = md $foldername
      }
     
      # Check to see if file name
      if(($counter % $foldersize) -eq 0)
      {
            move $_.fullname $folderpath
            $foldercounter++
      }
      # if file doesn't
      elseif(($counter % $foldersize) -ne 0)
      {
            move $_.fullname $folderpath
      }
     
      # Increment counter
      $counter++
      Write-Host $foldername
}

Get-ChildItem -recurse | Where {$_.PSIsContainer -and `
@(Get-ChildItem -Lit $_.Fullname -r | Where {!$_.PSIsContainer}).Length -eq 0} |
Remove-Item -recurse

if ( -Not (Test-Path $GameListTxt.trim() ))
{
 New-Item -Path $GameListTxt -ItemType file
}
Get-ChildItem -include *.cdi -Recurse -name | Out-File $GameListTxt
Write-Host "Done!"
Write-Host "See new directory listing in" $GameListTxt
Read-Host "Press ENTER to exit..."
