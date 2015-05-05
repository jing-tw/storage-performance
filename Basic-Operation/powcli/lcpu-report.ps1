$esxtopInterval = 2
$conversion = 100 / (1e6 * $esxtopInterval)


$stats=Get-EsxTop -CounterName PCPU
$NumOfLCPUs=$stats[0].NumOfLCPUs
echo NumOfLCPUs=$NumOfLCPUs

$first = $true
$report = @()

# create array with $NumOfLCPUs elements
$run_array = @()
for($j=0; $j -lt $NumOfLCPUs; $j++){
	$run_array +=0;
}

for($i = 0; $i -lt 100;$i++){

  $stats = Get-EsxTop -CounterName LCPU
  if(!$first){
    $row = "" | Select LCPUID,UsedTimeInUsec
	
	$avg=0.0
	for($j=0; $j -lt $NumOfLCPUs; $j++){
			$avg= $avg + ($stats[$j].UsedTimeInUsec - $run_array[$j]) 
			$LCPUID = $stats[$j].LCPUID
			echo $LCPUID $avg
			
			
	}
	$row.UsedTimeInUsec=$avg / $NumOfLCPUs * $conversion
	
	
    #$row.LCPUID = $stats[0].LCPUID
    #$row.UsedTimeInUsec = ($stats[0].UsedTimeInUsec - $run) * $conversion

    $report += $row
	
	$report | ft -AutoSize
  }
  else{
    $first = $false
  }
  #$run = $stats[0].UsedTimeInUsec
  for($j=0; $j -lt $NumOfLCPUs; $j++){
	$run_array[$j]=$stats[$j].UsedTimeInUsec
  }
 
 
 
  sleep $esxtopInterval
}
 
// report

$report | ft -AutoSize
$dateinfo=(Get-Date).ToString("y.m.d.h.m.s")
$report | Export-Csv "$($dateinfo)-cpu-report.csv" -NoTypeInformation -UseCulture