$count=3

.\create-vm-general-purpose-profile-sequential.ps1 -num $count
.\start-vm-general-purpose-profile-sequential.ps1 -num $count
.\remove-vm.ps1 -num $count

