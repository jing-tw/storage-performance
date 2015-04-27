# Usage 
# . ./create-vm-general-purpose-profile-async.ps1 -num 10
# 
# report
# .\Use-Culture.ps1 en-US {get-task} | export-csv test.csv
#
# remove vm
# . ./remove-vm.ps1 -num 10

param (
	[int]$num=1
)

$esxi_host_ip='192.168.1.101'
$vm_name='v'
$vCPU=2
$vRAM=4096
$vDISK=60


1..$num | foreach {
	new-vm -vmhost $esxi_host_ip -name $vm_name$_ -datastore VIRTUALSTOR  -NumCpu $vCPU -MemoryMB $vRAM -diskGB $vDISK -DiskStorageFormat Thick -runasync
}


