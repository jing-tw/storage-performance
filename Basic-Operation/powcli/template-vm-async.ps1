# Usage 
#  async
#    .\clone-vm.ps1 -esxi_host_ip $esxi_host_ip -tempalte_img="win7-test-01" 

#
# Batch
#  (a) clone 30 vm
#      (async) .\clone-vm.ps1 -esxi_host_ip $esxi_host_ip -tempalte_img "win7-test-01" -vm_prefix_name '20150427v' -num $count
#
# remove vm
# . ./remove-vm.ps1 -num 10

param (
	[int]$num=1,
	[string] $target_vm=$null,
	[string] $esxi_host_ip='192.168.1.101',
	[string] $tempalte_img="win7-test-01",
	[string] $vm_prefix_name='vm_prefix_name'
)

$vCPU=2
$vRAM=4096
$vDISK=60


$global:creation_start_time = Get-Date
1..$num | foreach {
	$date=Get-Date
	new-vm -vmhost $esxi_host_ip -name $vm_prefix_name$_ -datastore VIRTUALSTOR  -Template $tempalte_img -RunAsync:$true

	
	$global:total_runtime = $(Get-Date) - $global:creation_start_time
    # Write-Host "Snapshot Time: $global:total_runtime"
	
	$print_vm_name="$vm_prefix_name$_"
	$runtime = $(Get-Date) - $date
	$print_out_string="clone new-vm $print_vm_name Run-Time $runtime"
	$print_out_string
	Write-Host $print_out_string
}

$global:total_runtime = $(Get-Date) - $global:creation_start_time
$print_out_string="Total time elapsed: $global:total_runtime"
$print_out_string
Write-Host $print_out_string



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
	  Start-Sleep -Seconds 10
	  write-host "wait"
}

# report
.\Use-Culture.ps1 en-US {get-task} | export-csv "$($vm_prefix_name)_report-clone-from-template-general-purpose-profile-async.csv"
Write-Host "done!"