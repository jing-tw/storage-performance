# Usage 
# step 1: 
#    .\create-vm-general-purpose-profile-sequential.ps1 
#
# step 2: 
#  async
#    .\clone-vm.ps1 -tempalte_img="win7-test-01" -async:$true
#  sync
# 	.\clone-vm.ps1 -tempalte_img="win7-test-01"
#
# Batch
#  (a) clone 30 vm
#      (async) .\clone-vm.ps1 -tempalte_img "win7-test-01" -async:$true -num $count
#      xxxx (sync) .\clone-vm.ps1 -tempalte_img "win7-test-01" -num $count
#
# remove vm
# . ./remove-vm.ps1 -num 10

param (
	[int]$num=1,
	[bool] $async=$false,
	[string] $target_vm=$null,
	[string] $tempalte_img="win7-test-01"
)

$esxi_host_ip='192.168.1.101'
$vm_name='v'
$vCPU=2
$vRAM=4096
$vDISK=60


$global:creation_start_time = Get-Date
1..$num | foreach {
	$date=Get-Date
	
	# v1, v2, ... v$num
	# new-vm -vmhost $esxi_host_ip -name $vm_name$_ -datastore VIRTUALSTOR  -NumCpu $vCPU -MemoryMB $vRAM -diskGB $vDISK -DiskStorageFormat Thick -Template "win7-test-01"
	
	new-vm -vmhost $esxi_host_ip -name $vm_name$_ -datastore VIRTUALSTOR  -Template "win7-test-01" -RunAsync:$async

	
	$global:total_runtime = $(Get-Date) - $global:creation_start_time
    # Write-Host "Snapshot Time: $global:total_runtime"
	
	$print_vm_name="$vm_name$_"
	$runtime = $(Get-Date) - $date
	$print_out_string="clone new-vm $print_vm_name Run-Time $runtime"
	$print_out_string
	Write-Host $print_out_string
}

$global:total_runtime = $(Get-Date) - $global:creation_start_time
$print_out_string="Total time elapsed: $global:total_runtime"
$print_out_string
Write-Host $print_out_string