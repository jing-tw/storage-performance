connect-viserver -server 192.168.1.200 -user root -password 1111111

$count=3
$vm_prefix_name='20150427v'

.\create-vm-general-purpose-profile-sequential.ps1 -vm_prefix_name $vm_prefix_name -num $count
.\start-vm-general-purpose-profile-sequential.ps1 -num $count
.\remove-vm.ps1 -num $count

