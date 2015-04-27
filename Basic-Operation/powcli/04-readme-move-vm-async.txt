$count=3

.\create-vm-general-purpose-profile-sequential.ps1 -num $count
.\start-vm-general-purpose-profile-sequential.ps1 -num $count
.\move-vm-general-purpose-profile-async.ps1 -num $count

<wait>
.\remove-vm.ps1 -num $count

