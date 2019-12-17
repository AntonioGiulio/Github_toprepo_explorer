<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, java.text.DecimalFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Gender distribution</title>

<!-- CSS -->
	<link rel="stylesheet" href="./library/assets/bootstrap/bootstrap4-alpha3.min.css">

<!-- Scripts -->
		<script src="./library/assets/jquery/jquery-3.1.0.min.js"></script>
		<script src="./library/assets/tether/tether.min.js"></script>
		<script src="./library/assets/bootstrap/bootstrap4-alpha3.min.js"></script>
		<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
		
		

</head>
<body>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>

<%!
public static String getPercentuale(int parziale){
	DecimalFormat df2 = new DecimalFormat("#.#");
	
	double percentuale = 0.0;
	percentuale = (parziale*100)/22500;
	return df2.format(percentuale);
}
%>
<%
HttpSession s = request.getSession();

//numero totale di repository
int totalCountUser = 0;
int countFemale = 0;
String percFemale = getPercentuale(countFemale);
int countMale = 0;
String percMale = getPercentuale(countMale);

if( request.getAttribute("totalCountUser") != null){
	totalCountUser = (Integer) request.getAttribute("totalCountUser");
}
if( request.getAttribute("countFemale") != null){
	countFemale = (Integer) request.getAttribute("countFemale");
}
if( request.getAttribute("countMale") != null){
	countMale = (Integer) request.getAttribute("countMale");
}

DecimalFormat df2 = new DecimalFormat("#.#");
%>

<!-- valore da passare a javascript -->
<input type="hidden" id="totalCountUser" value="<%=totalCountUser%>">
<input type="hidden" id="countFemale" value="<%=countFemale%>">
<input type="hidden" id="percFemale" value="<%=percFemale%>">
<input type="hidden" id="countMale" value="<%=countMale%>">
<input type="hidden" id="percMale" value="<%=percMale%>">


<br>
<center><h2>Suddivisione degli utenti in base al sesso</h2>
<br><br>
<div id="introduzione" style="margin-left: 30px; margin-bottom: 50px">
<font>
Per ottenere una suddivisione degli utenti in base al <b>genere</b> sono stati analizzati i contributors delle repository più popolari di Github.<br>
Tuttavia, non essendo possibile ottenere esplicitamente il sesso di ciascun contributor, sono stati analizzati i relativi <b>nomi</b>,
facendo uso delle API esterne di <b>Genderize</b> e <b>GenderAPI</b>.


</font>
</div>
</center>

<br><br>
<div class="container">
	<!-- Grafico di confronto -->
	<div class="row m-b-1">
					<div class="col-xs-12">
						<div class="card shadow">
							<div class="card-block">
								<div id="chartContainer" style="height: 370px; width: 100%;"></div>
							</div>
						</div>
					</div>
	</div>

</div>
<center>
<br>
<div>
	<table style="width: 80%">
		<tr style="width: 100%">
			
		</tr>
	</table>
<br>
<br>
</div>

<div id="considerazioni" style="margin-left: 30px; margin-bottom: 50px">
<font>
<h3>Considerazioni</h3><br><br>
Il numero di donne che hanno contribuito allo sviluppo delle repository più popolari è di <b><%=countFemale%></b> su un totale di 22500 contributors, ovvero il <%=getPercentuale(countFemale)%>%.
</font>
</div>
</center>

</body>



<script>
window.onload = function () {
	
	var totalCountUser = $("#totalCountUser").val();
	var countFemale = $("#countFemale").val();
	var countMale = $("#countMale").val();

var chart = new CanvasJS.Chart("chartContainer", {
	exportEnabled: true,
	animationEnabled: true,
	legend:{
		cursor: "pointer",
		itemclick: explodePie
	},
	data: [{
		type: "pie",
		showInLegend: true,
		toolTipContent: "{name}: <strong>{y}</strong>",
		indexLabel: "{name} - {y}",
		dataPoints: [
			{ y: parseInt(countMale), name: "Uomini" },
			{ y: parseInt(countFemale), name: "Donne", exploded: true },
		]
	}]
});
chart.render();
}

function explodePie (e) {
	if(typeof (e.dataSeries.dataPoints[e.dataPointIndex].exploded) === "undefined" || !e.dataSeries.dataPoints[e.dataPointIndex].exploded) {
		e.dataSeries.dataPoints[e.dataPointIndex].exploded = true;
	} else {
		e.dataSeries.dataPoints[e.dataPointIndex].exploded = false;
	}
	e.chart.render();

}
</script>

</html>