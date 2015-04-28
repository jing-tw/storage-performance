# Usage 
# . ./create-vm-general-purpose-profile-sequential.ps1 -num 10
# 
# remove vm
# . ./remove-vm.ps1  $esxi_host_ip '192.168.1.101' -vm_prefix_name '20150427v' -num 10

param (
	[int]$num=1,
	[string] $esxi_host_ip='192.168.1.101',
	[string] $vm_prefix_name='vm_prefix_name'
	
)

$vCPU=2
$vRAM=4096
$vDISK=60

$global:creation_start_time = Get-Date
$sum=0
1..$num | foreach {
	$date=Get-Date
	
	new-vm -vmhost $esxi_host_ip -name $vm_prefix_name$_ -datastore VIRTUALSTOR  -NumCpu $vCPU -MemoryMB $vRAM -diskGB $vDISK -DiskStorageFormat Thick
	
	$print_vm_name="$vm_prefix_name$_"
	$runtime = $(Get-Date) - $date
	$sum=$sum+$runtime
	
	$print_out_string="$_ new-vm $print_vm_name Run-Time $runtime"
	$print_out_string
	Write-Host $print_out_string
}
$global:total_runtime = $(Get-Date) - $global:creation_start_time
$print_out_string="Total time elapsed: $global:total_runtime, avg=$sum/$num"
$print_out_string
Write-Host $print_out_string