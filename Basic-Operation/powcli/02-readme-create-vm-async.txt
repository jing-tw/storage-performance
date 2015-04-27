$count=3

.\create-vm-general-purpose-profile-async.ps1 -num $count

<wait>

.\start-vm-general-purpose-profile-async.ps1 -num $count

<wait>

.\remove-vm.ps1 -num $count

