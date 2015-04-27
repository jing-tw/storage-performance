# Usage 
# . ./remove-vm.ps1 -num 10 

param (
	[int]$num=1
)

$vm_name='20150427v'

1..$num | foreach {
	stop-vm -vm $vm_name$_ -confirm:$false
	remove-vm -vm $vm_name$_ -DeletePermanently -confirm:$false
}
