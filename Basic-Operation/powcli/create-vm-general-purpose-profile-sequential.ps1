# Usage 
# . ./create-vm-general-purpose-profile-sequential.ps1 -num 10
# 
# remove vm
# . ./remove-vm.ps1 -num 10

param (
	[int]$num=1
)

$esxi_host_ip='192.168.1.101'
$vm_name='20150427v'
$vCPU=2
$vRAM=4096
$vDISK=60

$global:creation_start_time = Get-Date
1..$num | foreach {
	$date=Get-Date
	
	new-vm -vmhost $esxi_host_ip -name $vm_name$_ -datastore VIRTUALSTOR  -NumCpu $vCPU -MemoryMB $vRAM -diskGB $vDISK -DiskStorageFormat Thick
	
	$print_vm_name="$vm_name$_"
	$runtime = $(Get-Date) - $date
	$print_out_string="new-vm $print_vm_name Run-Time $runtime"
	$print_out_string
	Write-Host $print_out_string
}
$global:total_runtime = $(Get-Date) - $global:creation_start_time
$print_out_string="Total time elapsed: $global:total_runtime"
$print_out_string
Write-Host $print_out_string