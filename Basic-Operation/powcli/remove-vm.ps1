# Usage 
# . ./remove-vm.ps1 -num 10 -vm_prefix_name '20150427v'

param (
	[int]$num=1,
	[string] $vm_name='vm_prefix_name'
)

1..$num | foreach {
	stop-vm -vm $vm_name$_ -confirm:$false
	remove-vm -vm $vm_name$_ -DeletePermanently -confirm:$false
}
