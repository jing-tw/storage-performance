# usage:
# ./testcase-08-async.ps1
#connect-viserver -server 192.168.1.200 -user root -password 1111111


# host 3 run 1
$count=4
$esxi_host_ip='192.168.1.103'
$run_index=1
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150501v"

$vm_datastore='datastore-103'
.\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -clone_source_vm 'clone-source2' -vm_datastore $vm_datastore -vm_prefix_name $vm_prefix_name -num $count


# host 3 run 2
$count=4
$esxi_host_ip='192.168.1.103'
$run_index=2
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150501v"
.\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -clone_source_vm 'clone-source2' -vm_datastore $vm_datastore -vm_prefix_name $vm_prefix_name -num $count


# host 3 run 3
$count=4
$esxi_host_ip='192.168.1.103'
$run_index=3
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150501v"
.\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -clone_source_vm 'clone-source2' -vm_datastore $vm_datastore -vm_prefix_name $vm_prefix_name -num $count
