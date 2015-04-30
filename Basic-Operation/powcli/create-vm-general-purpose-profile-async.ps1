# Usage 
# . ./create-vm-general-purpose-profile-async.ps1 -esxi_host_ip '192.168.1.101' -vm_prefix_name '20150427v' -num 10
# 
# report
# .\Use-Culture.ps1 en-US {get-task} | export-csv test.csv
#
# remove vm
# . ./remove-vm.ps1 $esxi_host_ip '192.168.1.101' -vm_prefix_name '20150427v' -num 10

param (
	[int]$num=1,
	[string] $esxi_host_ip='192.168.1.101',
	[string] $vm_prefix_name='vm_prefix_name'
)
Write-Host "start"

$vCPU=2
$vRAM=4096
$vDISK=60

$hash_task=@{}

1..$num | foreach {
	$hash_task[(new-vm -vmhost $esxi_host_ip -name $vm_prefix_name$_ -datastore VIRTUALSTOR  -NumCpu $vCPU -MemoryMB $vRAM -diskGB $vDISK -DiskStorageFormat Thick -runasync).id]="$vm_prefix_name$_"
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
	  Start-Sleep -Seconds 2
	  write-host "wait"
}

# report
.\Use-Culture.ps1 en-US {get-task} | export-csv "$($vm_prefix_name)_report-create-vm-general-purpose-profile-async-$($dateinfo).csv"
Write-Host "done!"
