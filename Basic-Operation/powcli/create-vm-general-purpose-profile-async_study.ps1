# Usage 
# . ./create-vm-general-purpose-profile-async.ps1 -vm_prefix_name '20150427v' -num 10
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

$vCPU=2
$vRAM=4096
$vDISK=60

$hash_task=@{}

1..$num | foreach {
	$hash_task[(new-vm -vmhost $esxi_host_ip -name $vm_prefix_name$_ -datastore VIRTUALSTOR  -NumCpu $vCPU -MemoryMB $vRAM -diskGB $vDISK -DiskStorageFormat Thick -runasync).id]="$vm_prefix_name$_"
}

# wait for all VMs to finish the task.
$runningTasks = $hash_task.Count
while($runningTasks -gt 0){
  Get-Task | % {
    write-host "id=$($_.Id)"
	write-host "hash_task=$($hash_task)"
	write-host "State=$($_.State)"
	
	if($_.State -eq "Success"){
		write-host "Success"
	}
	if($hash_task.ContainsKey($_.Id)){
		write-host "-----> id match"
	}
	
	
	
    if($hash_task.ContainsKey($_.Id) -and $_.State -eq "Success"){
      $hash_task.Remove($_.Id)
      $runningTasks--
	  write-host "id match 111"
    }
    elseif($hash_task.ContainsKey($_.Id) -and $_.State -eq "Error"){
      $hash_task.Remove($_.Id)
      $runningTasks--
	   write-host "error"
    }
	 write-host "no id match 333"
  }
  Start-Sleep -Seconds 2
  write-host "runningTasks=$runningTasks"
}



# report
#.\Use-Culture.ps1 en-US {get-task} | export-csv "$($vm_prefix_name})_report-create-vm-general-purpose-profile-async.csv"
#Write-Host "done!"