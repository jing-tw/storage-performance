# usage:
# ./testcase-09-async.ps1
#connect-viserver -server 192.168.1.200 -user root -password 1111111

# ============= Run 1 =============
<#
Host 3	VirtualStor	12 * 32GB Win7 VM	Boot VM	"Evaluate boot storm case
1. time for this job
2. host CPU usage and cvm CPU usage
- host 1
- host 2"
#>

$vm_pattern='192.168.1.103*'
#run 1
$run_index=3
# start-vm -vm $vm_prefix_name$_ -runasync
start-vm -vm $vm_pattern -runasync


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
.\Use-Culture.ps1 en-US {get-task} | export-csv "report-boot-storm-Run-$($run_index)-general-purpose-profile-async-$($dateinfo).csv"
Write-Host "done!"

# stop-vm -vm $vm_pattern -runasync  -Confirm:$false
