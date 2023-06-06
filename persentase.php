<?php 

include "koneksi.php";

$sql = "SELECT * FROM persentase_total_kpi";
$result = mysqli_query($link, $sql);
$no = 1;

$ontime = ""; 
$late = ""; 
$perOntime = ""; 
$perLate = ""; 

while($data = mysqli_fetch_array($result)) {
	$ontime = $data["ontime"];
	$late = $data["late"];
	$perOntime = $data["persentase_ontime"];
	$perLate = $data["persentase_late"];
}


?>

<!doctype html>
<html>
	<head>
	  <meta charset="UTF-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <script src="https://cdn.tailwindcss.com"></script>
	</head>
	<body>
	  <header>
	  	<nav class="flex justify-between items-center py-3 md:px-20 px-5 border-b fixed top-0 w-full">
	  		<div>
	  			<p class="text-xl font-semibold font-serif">KPI</p>
	  		</div>
	  		<div class="flex gap-x-4">
	  			<span>
	  				<a href="index.php" class="hover:underline">Data KPI</a>
	  			</span>
	  			<span>
	  				<a href="persentase.php" class="hover:underline">Persentase</a>
	  			</span>
	  		</div>
	  	</nav>
	  </header>
	  <main class="min-h-screen flex flex-col gap-y-28 justify-center p-36">
	  	<section class="flex justify-center">
	  		<div class="md:w-1/2">
	  			<canvas id="circleChart" width="500"></canvas>
	  		</div>
	  	</section>
	  	<section>
	  		<table>
	  			<tr>
	  				<td>Total Ontime</td>
	  				<td>&nbsp; : &nbsp;</td>
	  				<td><?= $ontime ?></td>
	  				<td class="text-indigo-500">&nbsp; <?= $perOntime ?>%</td>
	  			</tr>
	  			<tr>
	  				<td>Total Late</td>
	  				<td>&nbsp; : &nbsp;</td>
	  				<td><?= $late ?></td>
	  				<td class="text-indigo-500">&nbsp; <?= $perLate ?>%</td>
	  			</tr>
	  		</table>
	  	</section>
	  </main>
	  <script type="text/javascript" src="assets/js/chartjs/Chart.js"></script>
	  <script>
		var ctx = document.getElementById("circleChart").getContext('2d');
		var myPieChart = new Chart(ctx,{
			  type: 'doughnut',
			  data: {
			    datasets: [
			      {
			        data: [
			        	<?= $perOntime ?>, <?= $perLate ?>],
			        backgroundColor: [
			          'rgb(255, 99, 132)',
			          'rgb(255, 159, 64)',
			          'rgb(255, 205, 86)',
			          'rgb(75, 192, 192)',
			          'rgb(54, 162, 235)',
			        ],
			      },
			    ],
			    labels: ['Ontime', 'Late'],
			  },
			  options: {
			    plugins: {
			      datalabels: {
			        formatter: (value) => {
			          return value + '%';
			        },
			      },
			    },
			  },
			});

	</script>
	</body>
</html>