# Usage 
# . ./start-vm-general-purpose-profile-async.ps1 -num 10
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

1..$num | foreach {
	start-vm -vm $vm_name$_ -runasync
}


