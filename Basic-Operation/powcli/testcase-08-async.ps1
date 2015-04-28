# usage:
# ./testcase-08-async.ps1
#connect-viserver -server 192.168.1.200 -user root -password 1111111

# host 1 run 1
$count=4
$esxi_host_ip='192.168.1.101'
$run_index=1
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
.\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -tempalte_img "win7-test-01" -vm_prefix_name $vm_prefix_name -num $count

#remove-vm -vm '192*' -DeletePermanently
# 

# host 1 run 2
$count=4
$esxi_host_ip='192.168.1.101'
$run_index=2
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
.\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -tempalte_img "win7-test-01" -vm_prefix_name $vm_prefix_name -num $count

# host 1 run 3
$count=4
$esxi_host_ip='192.168.1.101'
$run_index=3
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
.\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -tempalte_img "win7-test-01" -vm_prefix_name $vm_prefix_name -num $count

# host 2 run 1
$count=4
$esxi_host_ip='192.168.1.102'
$run_index=1
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
.\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -tempalte_img "win7-test-01" -vm_prefix_name $vm_prefix_name -num $count

# host 2 run 2
$count=4
$esxi_host_ip='192.168.1.102'
$run_index=2
$vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
.\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -tempalte_img "win7-test-01" -vm_prefix_name $vm_prefix_name -num $count

# host 2 run 3
# $count=4
# $esxi_host_ip='192.168.1.102'
# $run_index=3
# $vm_prefix_name="$($esxi_host_ip)-run-$($run_index)-20150427v"
# .\clone-vm-async.ps1 -esxi_host_ip $esxi_host_ip -tempalte_img "win7-test-01" -vm_prefix_name $vm_prefix_name -num $count
