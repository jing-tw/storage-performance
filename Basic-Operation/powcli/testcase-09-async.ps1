# usage:
# ./testcase-09-async.ps1
#connect-viserver -server 192.168.1.200 -user root -password 1111111

# ============= Run 1 =============
# Host 2 -> 3	VirtualStor	4 * 30GB Win7 VM	Migration VM
$count=4
$esxi_host_ip='192.168.1.101'
$esxi_host_ip_destination='192.168.1.103'
$run_index=1
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count

# Host 3	VirtualStor	4 * 30GB Win7 VM	Boot VM
.\start-vm-general-purpose-profile-async.ps1 -vm_prefix_name $vm_prefix_name -num $count

# Host 3	VirtualStor	4 * 30GB Win7 VM	Snapshot VM
.\snapshot-vm.ps1 -vm_prefix_name $vm_prefix_name -num $count

# Host 3 -> Host 1	VirtualStor	4 * 32GB Win7 VM	vMotion
$esxi_host_ip_destination='192.168.1.101'
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count

# Host 1 -> Host 3	VirtualStor	4 * 32GB Win7 VM	vMotion
$esxi_host_ip_destination='192.168.1.103'
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count



# ============= Run 2 =============
# Host 2 -> 3	VirtualStor	4 * 30GB Win7 VM	Migration VM
$count=4
$esxi_host_ip='192.168.1.101'
$esxi_host_ip_destination='192.168.1.103'
$run_index=2
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count

# Host 3	VirtualStor	4 * 30GB Win7 VM	Boot VM
.\start-vm-general-purpose-profile-async.ps1 -vm_prefix_name $vm_prefix_name -num $count

# Host 3	VirtualStor	4 * 30GB Win7 VM	Snapshot VM
.\snapshot-vm.ps1 -vm_prefix_name $vm_prefix_name -num $count

# Host 3 -> Host 1	VirtualStor	4 * 32GB Win7 VM	vMotion
$esxi_host_ip_destination='192.168.1.101'
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count

# Host 1 -> Host 3	VirtualStor	4 * 32GB Win7 VM	vMotion
$esxi_host_ip_destination='192.168.1.103'
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count



# ============= Run 3 =============
# Host 2 -> 3	VirtualStor	4 * 30GB Win7 VM	Migration VM
$count=4
$esxi_host_ip='192.168.1.101'
$esxi_host_ip_destination='192.168.1.103'
$run_index=3
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count

# Host 3	VirtualStor	4 * 30GB Win7 VM	Boot VM
.\start-vm-general-purpose-profile-async.ps1 -vm_prefix_name $vm_prefix_name -num $count

# Host 3	VirtualStor	4 * 30GB Win7 VM	Snapshot VM
.\snapshot-vm.ps1 -vm_prefix_name $vm_prefix_name -num $count

# Host 3 -> Host 1	VirtualStor	4 * 32GB Win7 VM	vMotion
$esxi_host_ip_destination='192.168.1.101'
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count

# Host 1 -> Host 3	VirtualStor	4 * 32GB Win7 VM	vMotion
$esxi_host_ip_destination='192.168.1.103'
.\move-vm-general-purpose-profile-async.ps1 -esxi_host_ip_destination $esxi_host_ip_destination -vm_prefix_name $vm_prefix_name -num $count
