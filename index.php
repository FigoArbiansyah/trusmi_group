<?php 

include "koneksi.php";

$sql = "SELECT * FROM grafik_kpi";
$result = mysqli_query($link, $sql);
$no = 1; 

$datas = [];

while($kpi = mysqli_fetch_array($result)) {
	array_push($datas, $kpi["kpi"]);
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
	  <main class="min-h-screen flex flex-col gap-y-36 justify-center p-36">
	  	<section class="flex justify-center">
	  		<div class="md:w-1/2">
	  			<canvas id="myChart" width="500">Crt</canvas>
	  		</div>
	  	</section>

		<table border="1" class="border w-full" cellpadding="10">
	  		<tr class="border">
	  			<th class="border">No</th>
	  			<th class="border">Karyawan</th>
	  			<th class="border">Sales Target</th>
	  			<th class="border">Sales Aktual</th>
	  			<th class="border">Sales Pencapaian</th>
	  			<th class="border">Sales Aktual Bobot</th>
	  			<th class="border">Report Target</th>
	  			<th class="border">Report Aktual</th>
	  			<th class="border">Report Pencapaian</th>
	  			<th class="border">Report Aktual Bobot</th>
	  			<th class="border">KPI</th>
	  		</tr>
	  		<?php 
	  		$data_kpi = mysqli_query($link, "SELECT * FROM grafik_kpi");
	  		while($item = mysqli_fetch_array($data_kpi)) { ?>
	  		<tr class="border">
	  			<td class="border"><?= $no++ ?></td>
	  			<td class="border"><?= $item["nama_karyawan"] ?></td>
	  			<td class="border text-center"><?= $item["sales_target"] ?></td>
	  			<td class="border text-center"><?= $item["sales_actual"] ?></td>
	  			<td class="border text-center"><?= $item["sales_pencapaian"] ?>%</td>
	  			<td class="border text-center"><?= round($item["sales_actual_bobot"]) ?>%</td>
	  			<td class="border text-center"><?= $item["report_target"] ?></td>
	  			<td class="border text-center"><?= $item["report_actual"] ?></td>
	  			<td class="border text-center"><?= $item["report_pencapaian"] ?>%</td>
	  			<td class="border text-center"><?= round($item["report_actual_bobot"]) ?>%</td>
	  			<td class="border text-center"><?= round($item["kpi"]) ?>%</td>
	  		</tr>
	  		<?php } ?>
	  	</table>
	  </main>
	  <script type="text/javascript" src="assets/js/chartjs/Chart.js"></script>
	  <script>
		var ctx = document.getElementById("myChart").getContext('2d');
		var myChart = new Chart(ctx, {
			type: 'bar',
			data: {
				labels: ["Budi", "Adi", "Rara", "Doni"],
				datasets: [{
					label: 'KPI%',
					data: [
						<?php echo $datas[0] ?>, <?php echo $datas[1] ?>, <?php echo $datas[2] ?>, <?php echo $datas[3] ?>],
					backgroundColor: [
					'rgba(255, 99, 132, 0.2)',
					'rgba(54, 162, 235, 0.2)',
					],
					borderColor: [
					'rgba(255,99,132,1)',
					'rgba(54, 162, 235, 1)',
					],
					borderWidth: 1
				}]
			},
			options: {
				scales: {
					yAxes: [{
						ticks: {
							beginAtZero:true
						}
					}]
				}
			}
		});
	</script>
	</body>
</html>