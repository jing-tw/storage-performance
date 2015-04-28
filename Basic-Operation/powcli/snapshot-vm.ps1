# Usage 
#    .\snapshot-vm.ps1 -vm_prefix_name $vm_prefix_name -num $count
#

param (
	[int]$num=1,
	[string] $vm_prefix_name='vm_prefix_name'
)

1..$num | foreach {
	new-snapshot -vm $vm_prefix_name$_ -name "$($vm_prefix_name)-$($date)" -memory:$true -RunAsync
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
.\Use-Culture.ps1 en-US {get-task} | export-csv "$($vm_prefix_name)_report-snapshot-vm-general-purpose-profile-async-$($dateinfo).csv"
Write-Host "done!"


