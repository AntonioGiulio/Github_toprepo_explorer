<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, java.text.DecimalFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Last month Top Languages distribution </title>

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
	if(mese.length()==1) {
		mese = "0"+mese;
	}
	String giorno = String.valueOf(data.get(Calendar.DAY_OF_MONTH));
	if(giorno.length()==1) {
		giorno = "0" + giorno;
	}
	String dataString = giorno + "-" + mese + "-" + anno;
	return dataString;
}
%>
<%!
public static String getDataLastMonth(){
	Calendar data = Calendar.getInstance();
	String anno = String.valueOf(data.get(Calendar.YEAR));
	String mese = String.valueOf(data.get(Calendar.MONTH));
	if(mese.length()==1) {
		mese = "0"+mese;
	}
	String giorno = String.valueOf(data.get(Calendar.DAY_OF_MONTH));
	if(giorno.length()==1) {
		giorno = "0" + giorno;
	}
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
if( request.getAttribute("arrayRepo") != null){
	arrayRepo = (String[]) request.getAttribute("arrayRepo");
}

//Array di String per i range delle star
String[] arrayLinguaggi = new String[18];
arrayLinguaggi[0] = "JavaScript";
arrayLinguaggi[1] = "Python";
arrayLinguaggi[2] = "Java";
arrayLinguaggi[3] = "C++";
arrayLinguaggi[4] = "Go";
arrayLinguaggi[5] = "PHP";
arrayLinguaggi[6] = "Ruby";
arrayLinguaggi[7] = "C";
arrayLinguaggi[8] = "Swift";
arrayLinguaggi[9] = "C#";
arrayLinguaggi[10] = "Julia";
arrayLinguaggi[11] = "Rust";
arrayLinguaggi[12] = "Assembly";
arrayLinguaggi[13] = "Perl";
arrayLinguaggi[14] = "Matlab";
arrayLinguaggi[15] = "Pascal";
arrayLinguaggi[16] = "Groovy";
arrayLinguaggi[17] = "R";



DecimalFormat df2 = new DecimalFormat("#.#");

String[] arrayRepo2017 =  new String[18];
arrayRepo2017[0] = "2456";
arrayRepo2017[1] = "1187";
arrayRepo2017[2] = "1171";
arrayRepo2017[3] = "571";
arrayRepo2017[4] = "565";
arrayRepo2017[5] = "564";
arrayRepo2017[6] = "499";
arrayRepo2017[7] = "497";
arrayRepo2017[8] = "324";
arrayRepo2017[9] = "298";
arrayRepo2017[10] = "0";
arrayRepo2017[11] = "0";
arrayRepo2017[12] = "0";
arrayRepo2017[13] = "0";
arrayRepo2017[14] = "0";
arrayRepo2017[15] = "0";
arrayRepo2017[16] = "0";
arrayRepo2017[17] = "0";

%>

<!-- valore da passare a javascript -->
<input type="hidden" id="arrayLenght" value="<%=arrayRepo.length%>">

<%for(int i=0; i<arrayRepo.length; i++){ %>
<input type="hidden" id="arrayLinguaggi<%=i%>" value=<%=arrayLinguaggi[i]%>>
<input type="hidden" id="arrayRepo<%=i%>" value=<%=arrayRepo[i]%>>
<input type="hidden" id="arrayRepo2017<%=i%>" value=<%=arrayRepo2017[i]%>>
<%} %>

<br>
<center><h2>Distribuzione delle repository più popolari e attive nell'ultimo mese<br> in base ai linguaggi di programmazione principali</h2>
<br><br>
<div id="introduzione" style="margin-left: 30px; margin-bottom: 50px">
<font>
Osserviamo la distribuzione delle repository più popolari e attive nell'utimo mese in base ai linguaggi di programmazione principali.<br>
Per repository attive nell' ultimo mese si intendono quelle repository che hanno ricevuto un commit da uno dei contributors negli ultimi 30 giorni.<br>
Sulla base di quest'osservazione è possibile capire quali siano, nell'ultimo mese, i linguaggi più utilizzati dai developers.<br><br>

Nel seguente grafico sono riportati i risultati delle analisi aggiornati alla data odierna <b><%=getData()%></b>:

</font>
</div>
</center>

<br>
<div class="container">

	<!-- Grafico delle star -->
	<div class="row m-b-1">
					<div class="col-xs-12">
						<div class="card shadow">
							<h4 class="card-header">Numero di repository attive nell'ultimo mese: <span class="tag tag-success" id="revenue-tag"> <%=totalCountRepo%></span></h4>
							<div class="card-block">
								<div id="starDistribution-chart"></div>
							</div>
						</div>
					</div>
	</div>
	
</div>
<br>
<br><br>
<div class="container">
	<!-- Grafico di confronto -->
	<div class="row m-b-1">
					<div class="col-xs-12">
						<div class="card shadow">
							<h4 class="card-header">Distribuzione nell'ultimo mese vs distribuzione dal 15-07-17 al 15-08-17</h4>
							<div class="card-block">
								<div id="chartContainer" style="height: 370px; width: 100%;"></div>
							</div>
						</div>
					</div>
	</div>

</div>
<center>
<div>
	Di seguito osserviamo come la distribuzione delle repository più popolari e attive nell'ultimo mese sia cambiata dal 2017 ad oggi <br>
	in base ai linguaggi di programmazione.<br>
</div>
<br>
<div>
	<table style="border-collapse: collapse; border: 1px solid black; width: 80%">
		<tr style="width: 100%">
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Linguaggio di programmazione</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Numero di repository attive nell'ultimo mese (dal <%=getDataLastMonth()%> al <%=getData() %>) </b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" >
				<center><b>Numero di repository attive <br> dal 15-07-17 al 15-08-17</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Differenza in percentuale</b></center>
			</td>
		</tr>
		<%for(int i=0; i<arrayRepo.length; i++){ %>
		<tr>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=arrayLinguaggi[i]%></center>
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
					if( arrayRepo[i].equals("0") ||  arrayRepo2017[i].equals("0")){
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

-dal 15-07-17 al 15-08-17, <b><%=getCount(arrayRepo2017, 0, 1)%></b> repository su <b><%=getCount(arrayRepo2017, 0, arrayRepo2017.length)%></b> rilsutavano essere attive utilizzando JavaScript come linguaggio di programmazione (circa il <%=getPercentuale(getCount(arrayRepo2017, 0, 1), getCount(arrayRepo2017, 0, arrayRepo2017.length))%>%).
<br>
-Nell'ultimo mese, dal <%=getDataLastMonth()%> al <%=getData() %>, <b><%=getCount(arrayRepo, 0, 1)%></b> repository su <b><%=getCount(arrayRepo, 0, arrayRepo.length)%></b> risultano essere attive utilizzando JavaScript come linguaggio di programmazione (circa il <%=getPercentuale(getCount(arrayRepo, 0, 1), getCount(arrayRepo, 0, arrayRepo.length))%>%).<br>
Ricordiamo che <b><%=getCount(arrayRepo, 0, arrayRepo.length)%></b> è il numero di repository che risultano essere attive negli ultimi 30 giorni. <br>
<b>N.B.</b> I dati sono aggiornati alla data odierna <%=getData()%>.

</font>
</div>
</center>

</body>

<script type="text/javascript">
				window.onload = function () {
					
					var arrayRepo = []
					var arrayRepo2017 = [];
					var arrayLinguaggi = [];
					var arrayLenght = $("#arrayLenght").val();
					
					for(var i=0; i<arrayLenght; i++){
						arrayRepo[i] = $("#arrayRepo"+i).val();
						arrayRepo2017[i] = $("#arrayRepo2017"+i).val();
						arrayLinguaggi[i] = $("#arrayLinguaggi"+i).val();
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
						title: "Linguaggio di programmazione",
					},
					axisY: {
						labelFontSize: 12,
						title: "Numero di repository attive",
					},
					data: [{
						type: "column", //change type to bar, line, area, pie, etc
						//indexLabel: "{y}", //Shows y value on all Data Points
						indexLabelFontColor: "#5A5757",
						indexLabelPlacement: "outside",
						dataPoints: [
							{ label: arrayLinguaggi[0], y: parseInt(arrayRepo[0]) },
							{ label: arrayLinguaggi[1], y: parseInt(arrayRepo[1]) },
							{ label: arrayLinguaggi[2], y: parseInt(arrayRepo[2]) },
							{ label: arrayLinguaggi[3], y: parseInt(arrayRepo[3]) },
							{ label: arrayLinguaggi[4], y: parseInt(arrayRepo[4]) },
							{ label: arrayLinguaggi[5], y: parseInt(arrayRepo[5]) },
							{ label: arrayLinguaggi[6], y: parseInt(arrayRepo[6]) },
							{ label: arrayLinguaggi[7], y: parseInt(arrayRepo[7]) },
							{ label: arrayLinguaggi[8], y: parseInt(arrayRepo[8]) },
							{ label: arrayLinguaggi[9], y: parseInt(arrayRepo[9]) },
							{ label: arrayLinguaggi[10], y: parseInt(arrayRepo[10]) },
							{ label: arrayLinguaggi[11], y: parseInt(arrayRepo[11]) },
							{ label: arrayLinguaggi[12], y: parseInt(arrayRepo[12]) },
							{ label: arrayLinguaggi[13], y: parseInt(arrayRepo[13]) },
							{ label: arrayLinguaggi[14], y: parseInt(arrayRepo[14]) },
							{ label: arrayLinguaggi[15], y: parseInt(arrayRepo[15]) },
							{ label: arrayLinguaggi[16], y: parseInt(arrayRepo[16]) },
							{ label: arrayLinguaggi[17], y: parseInt(arrayRepo[17]) },
						]
					}]
				});
				chart.render();
				
				var chart1 = new CanvasJS.Chart("chartContainer", {
					animationEnabled: true,
					axisX: {
						labelFontSize: 12,
						title: "Linguaggio di programmazione",
					},
					axisY: {
						labelFontSize: 12,
						title: "Numero di repository attive",
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
						name: "Numero di repository attive nell'ultimo mese",
						color: "green",
						dataPoints: [
							{ label: arrayLinguaggi[0], y: parseInt(arrayRepo[0]) },
							{ label: arrayLinguaggi[1], y: parseInt(arrayRepo[1]) },
							{ label: arrayLinguaggi[2], y: parseInt(arrayRepo[2]) },
							{ label: arrayLinguaggi[3], y: parseInt(arrayRepo[3]) },
							{ label: arrayLinguaggi[4], y: parseInt(arrayRepo[4]) },
							{ label: arrayLinguaggi[5], y: parseInt(arrayRepo[5]) },
							{ label: arrayLinguaggi[6], y: parseInt(arrayRepo[6]) },
							{ label: arrayLinguaggi[7], y: parseInt(arrayRepo[7]) },
							{ label: arrayLinguaggi[8], y: parseInt(arrayRepo[8]) },
							{ label: arrayLinguaggi[9], y: parseInt(arrayRepo[9]) },
							{ label: arrayLinguaggi[10], y: parseInt(arrayRepo[10]) },
							{ label: arrayLinguaggi[11], y: parseInt(arrayRepo[11]) },
							{ label: arrayLinguaggi[12], y: parseInt(arrayRepo[12]) },
							{ label: arrayLinguaggi[13], y: parseInt(arrayRepo[13]) },
							{ label: arrayLinguaggi[14], y: parseInt(arrayRepo[14]) },
							{ label: arrayLinguaggi[15], y: parseInt(arrayRepo[15]) },
							{ label: arrayLinguaggi[16], y: parseInt(arrayRepo[16]) },
							{ label: arrayLinguaggi[17], y: parseInt(arrayRepo[17]) },
						]
					},
					{
						type: "column",
						showInLegend: true,
						name: "Numero di repository attive dal 15-07-17 al 15-08-17",
						color: "red",
						dataPoints: [
							{ label: arrayLinguaggi[0], y: parseInt(arrayRepo2017[0]) },
							{ label: arrayLinguaggi[1], y: parseInt(arrayRepo2017[1]) },
							{ label: arrayLinguaggi[2], y: parseInt(arrayRepo2017[2]) },
							{ label: arrayLinguaggi[3], y: parseInt(arrayRepo2017[3]) },
							{ label: arrayLinguaggi[4], y: parseInt(arrayRepo2017[4]) },
							{ label: arrayLinguaggi[5], y: parseInt(arrayRepo2017[5]) },
							{ label: arrayLinguaggi[6], y: parseInt(arrayRepo2017[6]) },
							{ label: arrayLinguaggi[7], y: parseInt(arrayRepo2017[7]) },
							{ label: arrayLinguaggi[8], y: parseInt(arrayRepo2017[8]) },
							{ label: arrayLinguaggi[9], y: parseInt(arrayRepo2017[9]) },
							{ label: arrayLinguaggi[10], y: parseInt(arrayRepo2017[10]) },
							{ label: arrayLinguaggi[11], y: parseInt(arrayRepo2017[11]) },
							{ label: arrayLinguaggi[12], y: parseInt(arrayRepo2017[12]) },
							{ label: arrayLinguaggi[13], y: parseInt(arrayRepo2017[13]) },
							{ label: arrayLinguaggi[14], y: parseInt(arrayRepo2017[14]) },
							{ label: arrayLinguaggi[15], y: parseInt(arrayRepo2017[15]) },
							{ label: arrayLinguaggi[16], y: parseInt(arrayRepo2017[16]) },
							{ label: arrayLinguaggi[17], y: parseInt(arrayRepo2017[17]) },
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