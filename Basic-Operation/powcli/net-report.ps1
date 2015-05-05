$esxtopInterval = 3
 
$first = $true
$report = @()
for($i = 0; $i -lt 100;$i++){
  $stats = Get-EsxTop -CounterName NetPort | where{$_.ClientName -eq 'vmnic0'}
  if(!$first){
	# create a data row
	$row = "" | Select ClientName, NumOfSendPackets, NumOfSendBytes, NumOfRecvPackets, NumOfRecvBytes
	$row.ClientName=$stats[0].ClientName
	$row.numOfSendPackets=$stats[0].numOfSendPackets-$numOfSendPackets
	$row.numOfSendBytes=($stats[0].numOfSendBytes-$numOfSendBytes)/1000000   #MB bytes
	$row.numOfRecvPackets=$stats[0].numOfRecvPackets-$numOfRecvPackets
	$row.numOfRecvBytes=($stats[0].numOfRecvBytes-$numOfRecvBytes)/1000000
	
	$report +=$row
	$report | ft -AutoSize
  }
  else{
    $first = $false
  }
 
  $numOfSendPackets=$stats[0].NumOfSendPackets
  $numOfSendBytes=$stats[0].numOfSendBytes
  $numOfRecvPackets=$stats[0].numOfRecvPackets
  $numOfRecvBytes=$stats[0].numOfRecvBytes
  
  sleep $esxtopInterval
}
 
$report | ft -AutoSize
$dateinfo=(Get-Date).ToString("y.m.d.h.m.s")
$report | Export-Csv "$($dateinfo)-network-traffic.csv" -NoTypeInformation -UseCulture