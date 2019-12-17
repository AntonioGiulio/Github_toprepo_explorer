<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, java.text.DecimalFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Star distribution</title>

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
			
			#starDistribution-chart, #products-revenue-pie-chart, #orders-spline-chart {
				height: 300px;
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
	DecimalFormat df2 = new DecimalFormat("#.#");
	
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
String[] arrayRepo = new String[20];
if( request.getAttribute("arrayRepo") != null ){
	arrayRepo = (String[]) request.getAttribute("arrayRepo");
}

//Array di String per i range delle star
String[] arrayRange = new String[20];
int indice1 = 500;
int indice2 = 0;
for(int i=0; i<19; i++){
	indice2 = indice1 + 500;
	arrayRange[i] = String.valueOf(indice1) + "-" + String.valueOf(indice2);
	indice1 = indice2;
}
arrayRange[arrayRange.length-1] = "10000-30000";

DecimalFormat df2 = new DecimalFormat("#.#");

String[] arrayRepo2017 =  new String[20];
arrayRepo2017[0] = "14954";
arrayRepo2017[1] = "5217";
arrayRepo2017[2] = "2825";
arrayRepo2017[3] = "1800";
arrayRepo2017[4] = "1073";
arrayRepo2017[5] = "0";
arrayRepo2017[6] = "608";
arrayRepo2017[7] = "480";
arrayRepo2017[8] = "380";
arrayRepo2017[9] = "275";
arrayRepo2017[10] = "226";
arrayRepo2017[11] = "187";
arrayRepo2017[12] = "397";
arrayRepo2017[13] = "38";
arrayRepo2017[14] = "44";
arrayRepo2017[15] = "44";
arrayRepo2017[16] = "98";
arrayRepo2017[17] = "84";
arrayRepo2017[18] = "68";
arrayRepo2017[19] = "779";

%>


<!-- valore da passare a javascript -->
<input type="hidden" id="arrayLenght" value="<%=arrayRepo.length%>">

<%for(int i=0; i<arrayRepo.length; i++){ %>
<input type="hidden" id="arrayRepo<%=i%>" value=<%=arrayRepo[i]%>>
<input type="hidden" id="arrayRepo2017<%=i%>" value=<%=arrayRepo2017[i]%>>
<%} %>

<br>
<center><h2>Distribuzione delle repository in base al numero di Star</h2>
<br><br>
<div id="introduzione" style="margin-left: 30px; margin-bottom: 50px">
<font>
Il numero di Star di una repository può essere considerato un indice di gradimento del pubblico (simile ai like di Facebook).<br>
È stata osservata la distribuzione delle repository in base al numero di Star, stabilendo dei range di 500 unità alla volta.<br>
Nel seguente grafico sono riportati i risultati delle analisi aggiornati alla data odierna <b><%=getData()%></b>:

</font>
</div>
</center>

<br>
<div class="container">

	<!-- Grafico attuale -->
	<div class="row m-b-1">
					<div class="col-xs-12">
						<div class="card shadow">
							<h4 class="card-header">Numero attuale delle repository <span class="tag tag-success" id="revenue-tag"> <%=totalCountRepo%></span></h4>
							<div class="card-block">
								<div id="starDistribution-chart"></div>
							</div>
						</div>
					</div>
	</div>
</div>
<br><br>
<div class="container">
	<!-- Grafico di confronto -->
	<div class="row m-b-1">
					<div class="col-xs-12">
						<div class="card shadow">
							<h4 class="card-header">Distribuzione attuale vs distribuzione 2017</h4>
							<div class="card-block">
								<div id="chartContainer" style="height: 370px; width: 100%;"></div>
							</div>
						</div>
					</div>
	</div>

</div>
	
<br>
<center>
<div>
	Di seguito osserviamo come la distribuzione delle repository in base al numero di star su Github sia cambiata dal 2017 ad oggi.
</div>
<br>
<div>
	<table style="border-collapse: collapse; border: 1px solid black; width: 80%">
		<tr style="width: 100%">
			<td style="border-collapse: collapse; border: 1px solid black;"width="25%">
				<center><b>Range di star</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Numero di repository attuali</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;">
				<center><b>Numero di repository nel 2017</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Differenza in percentuale</b></center>
			</td>
		</tr>
		<%for(int i=0; i<arrayRepo.length; i++){ %>
		<tr>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=arrayRange[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=arrayRepo[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<%
				String value = "";
				if(arrayRepo2017[i].equals("0")){ 
					value="Dato non disponibile";
				}else{
					value=arrayRepo2017[i];
				}
				%>
				<center><%=value%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<% double valore = 0.0;
					if( Double.parseDouble(arrayRepo[i]) == 0 ||  Double.parseDouble(arrayRepo2017[i]) == 0){
						valore = 0.0;
					}else{
						valore = (( Double.parseDouble(arrayRepo[i]) / Double.parseDouble(arrayRepo2017[i]) )*100)-100;
					}
					
				   String color = getColor(valore);
				   String freccia = generateFreccia(valore);
				   String valoreString = df2.format( valore );
				%>
				<center><font color="<%=color%>">  <%=freccia%> <%=valoreString%> %  </font></center>
			</td>
		</tr>
		<%} %>
	</table>
<br>
<br>
</div>

<div id="considerazioni" style="margin-left: 30px; margin-bottom: 50px">
<font>
<h3>Considerazioni</h3><br><br>
Dalle analisi effettuate è possibile osservare che:<br><br>
-nel 2017 le repository aventi numero di star compreso nel range 500-1000 era di <b><%=arrayRepo2017[0]%></b>. 
<br>Oggi le repository con numero di star compreso tra 500 e 1000 sono <b><%=arrayRepo[0]%></b>.
<br>
<br>
-nel 2017 <b><%=getCount(arrayRepo2017, 0, 8)%></b> su un totale di <b><%=getCount(arrayRepo2017, 0, arrayRepo2017.length)%></b> repository avevano meno di 5,000 star (circa <%=getPercentuale(getCount(arrayRepo2017, 0, 8), getCount(arrayRepo2017, 0, 20))%>%).<br>
Attualmente <b><%=getCount(arrayRepo, 0, 8)%></b> su un totale di <b><%=getCount(arrayRepo, 0, arrayRepo.length)%></b> repository hanno meno di 5,000 star (circa il <%=getPercentuale(getCount(arrayRepo, 0, 8), getCount(arrayRepo, 0, 20))%>%).<br>
<br>
<br>
-nel 2017 solo <b><%=getCount(arrayRepo2017, 19, 20)%></b> repository avevano più di 10,000 star (circa il <%=getPercentuale(getCount(arrayRepo2017, 19, 20), getCount(arrayRepo2017, 0, 20))%>%).<br>
Oggi le repository con numero di star superiore a 10,000 sono <b><%=getCount(arrayRepo, 19, 20)%></b> (circa il <%=getPercentuale(getCount(arrayRepo, 19, 20), getCount(arrayRepo, 0, 20))%>%).
<br><br>
<b>N.B.</b> I dati sono aggiornati alla data odierna <%=getData()%>

</font>
</div>
</center>

</body>



<script type="text/javascript">
				window.onload = function () {
					
				var arrayRepo = []
				var arrayRepo2017 = []
				var arrayLenght = $("#arrayLenght").val();
				
				for(var i=0; i<arrayLenght; i++){
					arrayRepo[i] = $("#arrayRepo"+i).val();
					arrayRepo2017[i] = $("#arrayRepo2017"+i).val();
				}
				
				
				//funzione che filtra l'array arrayRepo, ritornando un'array contenente le sottostringhe contenute tra le due quote ""
				function extractAllText(str){
					  const re = /"(.*?)"/g;
					  const result = [];
					  let current;
					  while (current = re.exec(str)) {
					    result.push(current.pop());
					  }
					  return result.length > 0
					    ? result
					    : [str];
				}
				
				
				
				var chart = new CanvasJS.Chart("starDistribution-chart", {
					animationEnabled: true,
					exportEnabled: true,
					theme: "light2", // "light1", "light2", "dark1", "dark2"
					axisX: {
						labelFontSize: 12,
						title: "Range del numero delle star",
					},
					axisY: {
						labelFontSize: 12,
						title: "Numero di repository",
					},
					data: [{
						type: "column", //change type to bar, line, area, pie, etc
						//indexLabel: "{y}", //Shows y value on all Data Points
						indexLabelFontColor: "#5A5757",
						indexLabelPlacement: "outside",
						dataPoints: [
							{ label: "500-1000", y: parseInt(arrayRepo[0]) },
							{ label: "1000-1500", y: parseInt(arrayRepo[1]) },
							{ label: "1500-2000", y: parseInt(arrayRepo[2]) },
							{ label: "2000-2500", y: parseInt(arrayRepo[3]) },
							{ label: "2500-3000", y: parseInt(arrayRepo[4]) },
							{ label: "3000-3500", y: parseInt(arrayRepo[5]) },
							{ label: "3500-4000", y: parseInt(arrayRepo[6]) },
							{ label: "4000-4500", y: parseInt(arrayRepo[7]) },
							{ label: "4500-5000", y: parseInt(arrayRepo[8]) },
							{ label: "5000-5500", y: parseInt(arrayRepo[9]) },
							{ label: "5500-6000", y: parseInt(arrayRepo[10]) },
							{ label: "6000-6500", y: parseInt(arrayRepo[11]) },
							{ label: "6500-7000", y: parseInt(arrayRepo[12])},
							{ label: "7000-7500", y: parseInt(arrayRepo[13])},
							{ label: "7500-8000", y: parseInt(arrayRepo[14])},
							{ label: "8000-8500", y: parseInt(arrayRepo[15])},
							{ label: "8500-9000", y: parseInt(arrayRepo[16])},
							{ label: "9000-9500", y: parseInt(arrayRepo[17])},
							{ label: "9500-10000", y: parseInt(arrayRepo[18])},
							{ label: "10000-300000", y: parseInt(arrayRepo[19])},
						]
					}]
				});
				chart.render();
				
				var chart1 = new CanvasJS.Chart("chartContainer", {
					animationEnabled: true,
					axisX: {
						labelFontSize: 12,
						title: "Range del numero delle star",
					},
					axisY: {
						labelFontSize: 12,
						title: "Numero di repository",
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
						name: "Numero di repository attuale",
						color: "green",
						dataPoints: [
							{ label: "500-1000", y: parseInt(arrayRepo[0]) },
							{ label: "1000-1500", y: parseInt(arrayRepo[1]) },
							{ label: "1500-2000", y: parseInt(arrayRepo[2]) },
							{ label: "2000-2500", y: parseInt(arrayRepo[3]) },
							{ label: "2500-3000", y: parseInt(arrayRepo[4]) },
							{ label: "3000-3500", y: parseInt(arrayRepo[5]) },
							{ label: "3500-4000", y: parseInt(arrayRepo[6]) },
							{ label: "4000-4500", y: parseInt(arrayRepo[7]) },
							{ label: "4500-5000", y: parseInt(arrayRepo[8]) },
							{ label: "5000-5500", y: parseInt(arrayRepo[9]) },
							{ label: "5500-6000", y: parseInt(arrayRepo[10]) },
							{ label: "6000-6500", y: parseInt(arrayRepo[11]) },
							{ label: "6500-7000", y: parseInt(arrayRepo[12])},
							{ label: "7000-7500", y: parseInt(arrayRepo[13])},
							{ label: "7500-8000", y: parseInt(arrayRepo[14])},
							{ label: "8000-8500", y: parseInt(arrayRepo[15])},
							{ label: "8500-9000", y: parseInt(arrayRepo[16])},
							{ label: "9000-9500", y: parseInt(arrayRepo[17])},
							{ label: "9500-10000", y: parseInt(arrayRepo[18])},
							{ label: "10000-300000", y: parseInt(arrayRepo[19])},
						]
					},
					{
						type: "column",
						showInLegend: true,
						name: "Numero di repository 2017",
						color: "red",
						dataPoints: [
							{ label: "500-1000", y: parseInt(arrayRepo2017[0]) },
							{ label: "1000-1500", y: parseInt(arrayRepo2017[1]) },
							{ label: "1500-2000", y: parseInt(arrayRepo2017[2]) },
							{ label: "2000-2500", y: parseInt(arrayRepo2017[3]) },
							{ label: "2500-3000", y: parseInt(arrayRepo2017[4]) },
							{ label: "3000-3500", y: parseInt(arrayRepo2017[5]) },
							{ label: "3500-4000", y: parseInt(arrayRepo2017[6]) },
							{ label: "4000-4500", y: parseInt(arrayRepo2017[7]) },
							{ label: "4500-5000", y: parseInt(arrayRepo2017[8]) },
							{ label: "5000-5500", y: parseInt(arrayRepo2017[9]) },
							{ label: "5500-6000", y: parseInt(arrayRepo2017[10]) },
							{ label: "6000-6500", y: parseInt(arrayRepo2017[11]) },
							{ label: "6500-7000", y: parseInt(arrayRepo2017[12])},
							{ label: "7000-7500", y: parseInt(arrayRepo2017[13])},
							{ label: "7500-8000", y: parseInt(arrayRepo2017[14])},
							{ label: "8000-8500", y: parseInt(arrayRepo2017[15])},
							{ label: "8500-9000", y: parseInt(arrayRepo2017[16])},
							{ label: "9000-9500", y: parseInt(arrayRepo2017[17])},
							{ label: "9500-10000", y: parseInt(arrayRepo2017[18])},
							{ label: "10000-300000", y: parseInt(arrayRepo2017[19])},
						]
					}]
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