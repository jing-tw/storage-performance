# Usage 
# step 1: 
#    .\create-vm-general-purpose-profile-sequential.ps1 -num 1
#
# step 2: 
#  async
#    .\snapshot-vm.ps1 -num 1 -async:$true
#  sync
# 	.\snapshot-vm.ps1 -num 1
#
# Batch
#  (a) snapshot target vm in 30 times
#      (async) .\snapshot-vm.ps1 -num 30 -target_vm v1 -async:$true
#      (sync) .\snapshot-vm.ps1 -target_vm v1 -num $count
#  (b) snapshot 30 vm
#      (async) .\snapshot-vm.ps1 -async:$true -num $count
#      (sync) .\snapshot-vm.ps1 -num $count 
#
# remove vm
# . ./remove-vm.ps1 -num 10

param (
	[int]$num=1,
	[bool] $async=$false,
	[string] $target_vm=$null
)

$esxi_host_ip='192.168.1.101'
$vm_name='v'
$esxi_host_ip_destination='192.168.1.102'

Write-Host "Snapshot async=$async"
Write-Host "Start Time: $(Get-Date)"

$global:creation_start_time = Get-Date
1..$num | foreach {
	$date=Get-Date
	#$print_vm_name
	
	if($target_vm){
		# for target vm
		new-snapshot -vm $target_vm -name "$($target_vm)-$($date)" -memory:$true -RunAsync:$async
		$print_vm_name=$target_vm
	}else{
		# v1, v2, ... v$num
		new-snapshot -vm $vm_name$_ -name "$($vm_name)-$($date)" -memory:$true -RunAsync:$async
		$print_vm_name="$vm_name$_"
	}
	
	$runtime = $(Get-Date) - $date
	$print_out_string="snapshot $print_vm_name Run-Time $runtime"
	$print_out_string
	Write-Host $print_out_string
}
$global:total_runtime = $(Get-Date) - $global:creation_start_time
$print_out_string="snapshot Total time elapsed: $global:total_runtime"
$print_out_string
Write-Host $print_out_string