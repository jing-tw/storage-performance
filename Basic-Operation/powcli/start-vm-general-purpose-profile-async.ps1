# Usage 
# . ./start-vm-general-purpose-profile-async.ps1 -vm_prefix_name '20150427v' -num 10
# 
# report
# .\Use-Culture.ps1 en-US {get-task} | export-csv test.csv
#
# remove vm
# . ./remove-vm.ps1 -num 10

param (
	[int]$num=1,
	[string] $vm_prefix_name='vm_prefix_name'
)


1..$num | foreach {
	start-vm -vm $vm_prefix_name$_ -runasync
}


# wait for all VMs to finish the task.  
# FIXME: algorithm => wait, if there is any task is running.
$out=0
while($out -ne 1){
      $out=1
      Get-Task | % {
		if($_.State -eq "Running"){
			write-host "id=$_.Id"
			write-host "Running"
			$out=0
		}
	  }
	  Start-Sleep -Seconds 5
	  write-host "wait"
}

# report
$dateinfo=(Get-Date).ToString("m.d.h.m.s")
.\Use-Culture.ps1 en-US {get-task} | export-csv "$($vm_prefix_name)_report-start-vm-general-purpose-profile-async-$($dateinfo).csv"
Write-Host "done!"



