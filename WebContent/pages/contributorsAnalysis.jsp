<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, java.text.DecimalFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Contributors Analysis</title>

<!-- CSS -->
	<link rel="stylesheet" href="./library/assets/bootstrap/bootstrap4-alpha3.min.css">

<!-- Scripts -->
		<script src="./library/assets/jquery/jquery-3.1.0.min.js"></script>
		<script src="./library/assets/tether/tether.min.js"></script>
		<script src="./library/assets/bootstrap/bootstrap4-alpha3.min.js"></script>
		<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
		
		
<!-- Page Style -->
		<style>
			body {
				background-color: #fafafa;
				font-size: 16px;
				line-height: 1.5;
			}
			
			h1,h2,h3,h4,h5,h6 {
				font-weight: 400;	
			}
			
			#revenue-tag {
				font-weight: inherit !important;
				border-radius: 0px !important;
			}
			
			//card rappresenta l'intestazione al di sopra dell'immagine
			.card {
				border: 0rem;
				border-radius: 0rem;
			}
			
			.card-header {
				background-color: #37474F;
				border-radius: 0 !important;
				color:	white;
				margin-bottom: 0;
				padding:	1rem;
			}
			
			.card-block {
				border: 1px solid #cccccc;	
			}
			
			.shadow {
				box-shadow: 0 6px 10px 0 rgba(0, 0, 0, 0.14),
										0 1px 18px 0 rgba(0, 0, 0, 0.12),
										0 3px 5px -1px rgba(0, 0, 0, 0.2);
			}
			#chartContainer, #products-revenue-pie-chart, #orders-spline-chart {
				height: 500px;
				width: 100%;
			}					
		</style>
		
</head>
<body>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<%!
//metodo che crea una stringa contenente gli elementi dell'array 
public static String getArrayString(String[] items){
    String result = "[";
    for(int i = 0; i < items.length; i++) {
        result += items[i];
        if(i < items.length - 1) {
            result += ", ";
        }
    }
    result += "]";
    return result;
}
%>
<%!
public static String getColor(double x) {
	String color="black";

	if(x < 0) {
		color="red";
	}else {
		if(x > 0)
		color="#347C17";
	}

	return color;
}
%>
<%!
public static String generateFreccia(double x) {
	String freccia="";

	if(x < 0) {
		freccia="&#9660";
	}else {
		if(x>0)
		freccia="&#9650";
	}

	return freccia;
}
%>
<%!
public static int getCount(String[] array, int indice1, int indice2) {
	int count = 0;

	for(int i=indice1; i<indice2; i++){
		count+= Integer.parseInt(array[i]);
	}
	return count;
}
%>
<%!
public static String getData(){
	Calendar data = Calendar.getInstance();
	String anno = String.valueOf(data.get(Calendar.YEAR));
	String mese = String.valueOf(data.get(Calendar.MONTH)+1);
	String giorno = String.valueOf(data.get(Calendar.DAY_OF_MONTH));
	String dataString = giorno + "-" + mese + "-" + anno;
	return dataString;
}
%>
<%!
public static String getPercentuale(int parziale, int totale){
	DecimalFormat df2 = new DecimalFormat("##.##");
	
	double percentuale = 0.0;
	percentuale = (parziale*100)/totale;
	return df2.format(percentuale);
}
%>
<%
HttpSession s = request.getSession();

//numero totale di repository
int totalCountRepo = 0;
if( request.getAttribute("totalCountRepo") != null){
	totalCountRepo = (Integer) request.getAttribute("totalCountRepo");
}

//Array di String contenente i valori della distribuzione
String[] valueContributors = new String[8];
valueContributors[0] = "110";
valueContributors[1] = "63";
valueContributors[2] = "48";
valueContributors[3] = "39";
valueContributors[4] = "34";
valueContributors[5] = "31";
valueContributors[6] = "25";
valueContributors[7] = "26";

//Array di String per i range delle star
String[] arrayRangeStar = new String[8];
arrayRangeStar[0] = "307346--6578";
arrayRangeStar[1] = "6578--3834";
arrayRangeStar[2] = "3834--2772";
arrayRangeStar[3] = "2772--2143";
arrayRangeStar[4] = "2143--1753";
arrayRangeStar[5] = "1753--1479";
arrayRangeStar[6] = "1479--1272";
arrayRangeStar[7] = "1272--1112";

String[] arrayJavaScript = new String[8];
arrayJavaScript[0] = "714";
arrayJavaScript[1] = "569";
arrayJavaScript[2] = "536";
arrayJavaScript[3] = "555";
arrayJavaScript[4] = "497";
arrayJavaScript[5] = "561";
arrayJavaScript[6] = "489";
arrayJavaScript[7] = "474";

String[] arrayJava = new String[8];
arrayJava[0] = "221";
arrayJava[1] = "248";
arrayJava[2] = "234";
arrayJava[3] = "290";
arrayJava[4] = "274";
arrayJava[5] = "265";
arrayJava[6] = "263";
arrayJava[7] = "250";

String[] arrayPython = new String[8];
arrayPython[0] = "222";
arrayPython[1] = "291";
arrayPython[2] = "287";
arrayPython[3] = "280";
arrayPython[4] = "293";
arrayPython[5] = "270";
arrayPython[6] = "279";
arrayPython[7] = "294";

String[] arrayGo = new String[8];
arrayGo[0] = "147";
arrayGo[1] = "158";
arrayGo[2] = "166";
arrayGo[3] = "151";
arrayGo[4] = "158";
arrayGo[5] = "136";
arrayGo[6] = "158";
arrayGo[7] = "138";

String[] arrayCSharp = new String[8];
arrayCSharp[0] = "27";
arrayCSharp[1] = "49";
arrayCSharp[2] = "68";
arrayCSharp[3] = "53";
arrayCSharp[4] = "67";
arrayCSharp[5] = "59";
arrayCSharp[6] = "70";
arrayCSharp[7] = "64";

String[] arrayC = new String[8];
arrayC[0] = "66";
arrayC[1] = "89";
arrayC[2] = "105";
arrayC[3] = "84";
arrayC[4] = "91";
arrayC[5] = "90";
arrayC[6] = "96";
arrayC[7] = "98";

String[] arraySwift = new String[8];
arraySwift[0] = "50";
arraySwift[1] = "64";
arraySwift[2] = "85";
arraySwift[3] = "84";
arraySwift[4] = "75";
arraySwift[5] = "74";
arraySwift[6] = "68";
arraySwift[7] = "87";
%>

<!-- valore da passare a javascript -->
<input type="hidden" id="arrayLenght" value="<%=arrayRangeStar.length%>">

<%for(int i=0; i<arrayRangeStar.length; i++){ %>
<input type="hidden" id="arrayRangeStar<%=i%>" value=<%=arrayRangeStar[i]%>>
<input type="hidden" id="valueContributors<%=i%>" value=<%=valueContributors[i]%>>
<input type="hidden" id="arrayJavaScript<%=i%>" value=<%=arrayJavaScript[i]%>>
<input type="hidden" id="arrayJava<%=i%>" value=<%=arrayJava[i]%>>
<input type="hidden" id="arrayPython<%=i%>" value=<%=arrayPython[i]%>>
<input type="hidden" id="arrayGo<%=i%>" value=<%=arrayGo[i]%>>
<input type="hidden" id="arrayCSharp<%=i%>" value=<%=arrayCSharp[i]%>>
<input type="hidden" id="arrayC<%=i%>" value=<%=arrayC[i]%>>
<input type="hidden" id="arraySwift<%=i%>" value=<%=arraySwift[i]%>>
<%} %>

<br>
<center><h2>Analisi dei contributors delle repository più popolari</h2>
<br><br>
<div id="introduzione" style="margin-left: 30px; margin-bottom: 50px">
<font>
I <b>contributors</b> sono gli utenti di Github che effettuano PUSH a una repository, partecipando al suo sviluppo.<br><br>
L'analisi dei contributors è stata effettuata su un dataset di 20731 repository aventi numero di Star maggiore di 500.<br>
Ricordiamo che il numero di star è indice di popolarità della repository su Github.<br><br>
Successivamente, il dataset è stato suddiviso in <b>8 range</b> in base al numero di Stars.<br>
Per ciascun range, è stato ottenuto il <b>numero medio di contributors</b> delle repository appartenenti a tale range di Star. <br>
Inoltre, per ciascun range di Star, è stato fornito il numero di contributors delle repository che utilizzano un preciso linguaggio di programmazione.<br><br>

Nel seguente grafico sono riportati i risultati delle analisi aggiornati alla data <b>10-12-19</b>:

</font>
</div>
</center>

<br>
<div class="container">

	<!-- Grafico delle star -->
	<div class="row m-b-1">
					<div class="col-xs-12">
						<div class="card shadow">
							<h4 class="card-header">Distribuzione dei contributors in base al numero di star delle repository</h4>
							<div class="card-block">
							
							<div id="chartContainer"></div>
							</div>
						</div>
					</div>
	</div>
	<!-- <div style="margin-left: 50px; margin-right: -10px" id="observablehq-64da7f7f"></div> -->
</div>

<br><br>
<center>
<br>
<div>
	<table style="border-collapse: collapse; border: 1px solid black; width: 80%">
		<tr style="width: 100%">
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><b>Range di Star</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><b>Media dei contributors</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center>Contributors delle repository che utilizzano <b>Javascript</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center>Contributors delle repository che utilizzano <b>Java</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center>Contributors delle repository che utilizzano <b>Python</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center>Contributors delle repository che utilizzano <b>Go</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center>Contributors delle repository che utilizzano <b>C#</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center>Contributors delle repository che utilizzano <b>C</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center>Contributors delle repository che utilizzano <b>Swift</b></center>
			</td>
		</tr>
		<%for(int i=0; i<arrayRangeStar.length; i++){ %>
		<tr>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=arrayRangeStar[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=valueContributors[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=arrayJavaScript[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=arrayJava[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=arrayPython[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=arrayGo[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=arrayCSharp[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=arrayC[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="10%">
				<center><%=arraySwift[i]%></center>
			</td>
		</tr>
		<%} %>
	</table>
<br>
<br>
</div>

<div id="considerazioni" style="margin-left: 30px; margin-bottom: 50px">
<font>

</font>
</div>
</center>

</body>
<script type="module">
import {Runtime, Inspector} from "https://cdn.jsdelivr.net/npm/@observablehq/runtime@4/dist/runtime.js";
import define from "https://api.observablehq.com/@antonio96/grouped-bar-chart.js?v=3";
const inspect = Inspector.into("#observablehq-64da7f7f");
(new Runtime).module(define, name => (name === "chart") && inspect());
</script>

<script>
		
		window.onload = function () {
			
			var arrayRangeStar = []
			var valueContributors = [];
			var arrayJavaScript = [];
			var arrayJava = [];
			var arrayPython = [];
			var arrayGo = [];
			var arrayCSharp = [];
			var arrayC = [];
			var arraySwift = [];
			var arrayLenght = $("#arrayLenght").val();
			
			for(var i=0; i<arrayLenght; i++){
				arrayRangeStar[i] = $("#arrayRangeStar"+i).val();
				valueContributors[i] = $("#valueContributors"+i).val();
				arrayJavaScript[i] = $("#arrayJavaScript"+i).val();
				arrayJava[i] = $("#arrayJava"+i).val();
				arrayPython[i] = $("#arrayPython"+i).val();
				arrayGo[i] = $("#arrayGo"+i).val();
				arrayCSharp[i] = $("#arrayCSharp"+i).val();
				arrayC[i] = $("#arrayC"+i).val();
				arraySwift[i] = $("#arraySwift"+i).val();
			}
			
		var chart1 = new CanvasJS.Chart("chartContainer", {
			animationEnabled: true,
			axisX: {
				labelFontSize: 14,
				title: "Range del numero delle Star",
			},
			axisY: {
				labelFontSize: 14,
				title: "Numero di contributors",
			},
			legend: {
				cursor:"pointer",
				itemclick : toggleDataSeries
			},
			toolTip: {
				shared: true,
				content: toolTipFormatter
			},
			data: [{
				type: "column",
				showInLegend: true,
				name: "Media dei contributors",
				color: "#98abc5",
				dataPoints: [
					{ label: arrayRangeStar[0], y: parseInt(valueContributors[0]) },
					{ label: arrayRangeStar[1], y: parseInt(valueContributors[1]) },
					{ label: arrayRangeStar[2], y: parseInt(valueContributors[2]) },
					{ label: arrayRangeStar[3], y: parseInt(valueContributors[3]) },
					{ label: arrayRangeStar[4], y: parseInt(valueContributors[4]) },
					{ label: arrayRangeStar[5], y: parseInt(valueContributors[5]) },
					{ label: arrayRangeStar[6], y: parseInt(valueContributors[6]) },
					{ label: arrayRangeStar[7], y: parseInt(valueContributors[7]) },
				]
			},
			{
				type: "column",
				showInLegend: true,
				name: "Contributors Javascript",
				color: "#8a89a6",
				dataPoints: [
					{ label: arrayRangeStar[0], y: parseInt(arrayJavaScript[0]) },
					{ label: arrayRangeStar[1], y: parseInt(arrayJavaScript[1]) },
					{ label: arrayRangeStar[2], y: parseInt(arrayJavaScript[2]) },
					{ label: arrayRangeStar[3], y: parseInt(arrayJavaScript[3]) },
					{ label: arrayRangeStar[4], y: parseInt(arrayJavaScript[4]) },
					{ label: arrayRangeStar[5], y: parseInt(arrayJavaScript[5]) },
					{ label: arrayRangeStar[6], y: parseInt(arrayJavaScript[6]) },
					{ label: arrayRangeStar[7], y: parseInt(arrayJavaScript[7]) },
				]
			},
			{
				type: "column",
				showInLegend: true,
				name: "Contributors Java",
				color: "#7b6888",
				dataPoints: [
					{ label: arrayRangeStar[0], y: parseInt(arrayJava[0]) },
					{ label: arrayRangeStar[1], y: parseInt(arrayJava[1]) },
					{ label: arrayRangeStar[2], y: parseInt(arrayJava[2]) },
					{ label: arrayRangeStar[3], y: parseInt(arrayJava[3]) },
					{ label: arrayRangeStar[4], y: parseInt(arrayJava[4]) },
					{ label: arrayRangeStar[5], y: parseInt(arrayJava[5]) },
					{ label: arrayRangeStar[6], y: parseInt(arrayJava[6]) },
					{ label: arrayRangeStar[7], y: parseInt(arrayJava[7]) },
				]
			},
			{
				type: "column",
				showInLegend: true,
				name: "Contributors Python",
				color: "#6b486b",
				dataPoints: [
					{ label: arrayRangeStar[0], y: parseInt(arrayPython[0]) },
					{ label: arrayRangeStar[1], y: parseInt(arrayPython[1]) },
					{ label: arrayRangeStar[2], y: parseInt(arrayPython[2]) },
					{ label: arrayRangeStar[3], y: parseInt(arrayPython[3]) },
					{ label: arrayRangeStar[4], y: parseInt(arrayPython[4]) },
					{ label: arrayRangeStar[5], y: parseInt(arrayPython[5]) },
					{ label: arrayRangeStar[6], y: parseInt(arrayPython[6]) },
					{ label: arrayRangeStar[7], y: parseInt(arrayPython[7]) },
				]
			},
			{
				type: "column",
				showInLegend: true,
				name: "Contributors Go",
				color: "#a05d56",
				dataPoints: [
					{ label: arrayRangeStar[0], y: parseInt(arrayGo[0]) },
					{ label: arrayRangeStar[1], y: parseInt(arrayGo[1]) },
					{ label: arrayRangeStar[2], y: parseInt(arrayGo[2]) },
					{ label: arrayRangeStar[3], y: parseInt(arrayGo[3]) },
					{ label: arrayRangeStar[4], y: parseInt(arrayGo[4]) },
					{ label: arrayRangeStar[5], y: parseInt(arrayGo[5]) },
					{ label: arrayRangeStar[6], y: parseInt(arrayGo[6]) },
					{ label: arrayRangeStar[7], y: parseInt(arrayGo[7]) },
				]
			},
			{
				type: "column",
				showInLegend: true,
				name: "Contributors C#",
				color: "#d0743c",
				dataPoints: [
					{ label: arrayRangeStar[0], y: parseInt(arrayCSharp[0]) },
					{ label: arrayRangeStar[1], y: parseInt(arrayCSharp[1]) },
					{ label: arrayRangeStar[2], y: parseInt(arrayCSharp[2]) },
					{ label: arrayRangeStar[3], y: parseInt(arrayCSharp[3]) },
					{ label: arrayRangeStar[4], y: parseInt(arrayCSharp[4]) },
					{ label: arrayRangeStar[5], y: parseInt(arrayCSharp[5]) },
					{ label: arrayRangeStar[6], y: parseInt(arrayCSharp[6]) },
					{ label: arrayRangeStar[7], y: parseInt(arrayCSharp[7]) },
				]
			},
			{
				type: "column",
				showInLegend: true,
				name: "Contributors C",
				color: "#ff8c00",
				dataPoints: [
					{ label: arrayRangeStar[0], y: parseInt(arrayC[0]) },
					{ label: arrayRangeStar[1], y: parseInt(arrayC[1]) },
					{ label: arrayRangeStar[2], y: parseInt(arrayC[2]) },
					{ label: arrayRangeStar[3], y: parseInt(arrayC[3]) },
					{ label: arrayRangeStar[4], y: parseInt(arrayC[4]) },
					{ label: arrayRangeStar[5], y: parseInt(arrayC[5]) },
					{ label: arrayRangeStar[6], y: parseInt(arrayC[6]) },
					{ label: arrayRangeStar[7], y: parseInt(arrayC[7]) },
				]
			},
			{
				type: "column",
				showInLegend: true,
				name: "Contributors Swift",
				color: "red",
				dataPoints: [
					{ label: arrayRangeStar[0], y: parseInt(arraySwift[0]) },
					{ label: arrayRangeStar[1], y: parseInt(arraySwift[1]) },
					{ label: arrayRangeStar[2], y: parseInt(arraySwift[2]) },
					{ label: arrayRangeStar[3], y: parseInt(arraySwift[3]) },
					{ label: arrayRangeStar[4], y: parseInt(arraySwift[4]) },
					{ label: arrayRangeStar[5], y: parseInt(arraySwift[5]) },
					{ label: arrayRangeStar[6], y: parseInt(arraySwift[6]) },
					{ label: arrayRangeStar[7], y: parseInt(arraySwift[7]) },
				]
			},
			
			]
		});
		chart1.render();
		
		function toolTipFormatter(e) {
			var str = "";
			var total = 0 ;
			var str2 ;
			for (var i = 0; i < e.entries.length; i++){
				var str1 = "<span style= \"color:"+e.entries[i].dataSeries.color + "\">" + e.entries[i].dataSeries.name + "</span>: <strong>"+  e.entries[i].dataPoint.y + "</strong> <br/>" ;
				total = e.entries[i].dataPoint.y + total;
				str = str.concat(str1);
			}
			str2 = "<strong>" + e.entries[0].dataPoint.label + "</strong> <br/>";
			return (str2.concat(str));
		}
		
		function toggleDataSeries(e) {
			if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
				e.dataSeries.visible = false;
			}
			else {
				e.dataSeries.visible = true;
			}
			chart1.render();
		}
		
		}
</script>



</html>