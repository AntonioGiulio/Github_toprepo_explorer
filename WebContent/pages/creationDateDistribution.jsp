<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, java.text.DecimalFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Creation Date distribution</title>

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
	DecimalFormat df2 = new DecimalFormat("#.##");
	
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


String[] arrayRepo =  new String[13];
arrayRepo[0] = "2007";
arrayRepo[1] = "2008";
arrayRepo[2] = "2009";
arrayRepo[3] = "2010";
arrayRepo[4] = "2011";
arrayRepo[5] = "2012";
arrayRepo[6] = "2013";
arrayRepo[7] = "2014";
arrayRepo[8] = "2015";
arrayRepo[9] = "2016";
arrayRepo[10] = "2017";
arrayRepo[11] = "2018";
arrayRepo[12] = "2019";


//Array di String contenente i valori della distribuzione
String[] arrayValue =  new String[13];
if( request.getAttribute("arrayRepo") != null){
	arrayValue = (String[]) request.getAttribute("arrayRepo");
}
/*arrayValue[0] = "1";
arrayValue[1] = "319";
arrayValue[2] = "723";
arrayValue[3] = "1416";
arrayValue[4] = "2565";
arrayValue[5] = "3490";
arrayValue[6] = "4727";
arrayValue[7] = "5637";
arrayValue[8] = "6783";
arrayValue[9] = "6731";
arrayValue[10] = "5675";
arrayValue[11] = "3467";
arrayValue[12] = "1386";
*/
%>

<!-- valore da passare a javascript -->
<input type="hidden" id="arrayLenght" value="<%=arrayRepo.length%>">

<%for(int i=0; i<arrayRepo.length; i++){ %>
<input type="hidden" id="arrayRepo<%=i%>" value=<%=arrayRepo[i]%>>
<input type="hidden" id="arrayValue<%=i%>" value=<%=arrayValue[i]%>>
<%} %>

<br>
<center><h2>Distribuzione delle repository in base alla data di creazione</h2>
<br><br>
<div id="introduzione" style="margin-left: 30px; margin-bottom: 50px">
<font>
Consideriamo la distribuzione delle repository più popolari in base alla data di creazione.<br>
La data di creazione è indice dello sviluppo e della popolarità acquisita dalla piattaforma di Github e dall'Open Source Software nel corso degli anni,<br>
rivelando quante delle attuali repository più popolari sono state create in uno specifico anno.<br><br>

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
							<h4 class="card-header">Numero totale repository: <span class="tag tag-success" id="revenue-tag"> <%=totalCountRepo%></span></h4>
							<div class="card-block">
								<div id="chartContainer"></div>
							</div>
						</div>
					</div>
	</div>
	
</div>
<br><br>
<br>
<center>
<div>
	Nella seguente tabella è riportato il numero di repository che attualmente sono più popolari, create nel corso degli anni a partire dal 2007.
</div>
<br>
<div>
	<table style="border-collapse: collapse; border: 1px solid black; width: 80%">
		<tr style="width: 100%">
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Anno</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Numero di repository create</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Percentuale rispetto al numero totale di repository</b></center>
			</td>
		</tr>
		<%for(int i=0; i<arrayRepo.length; i++){ %>
		<tr>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=arrayRepo[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=arrayValue[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=getPercentuale(getCount(arrayValue, i, i+1), getCount(arrayValue, 0, arrayValue.length))%>%</center>
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

-nel 2019, sono state create <b><%=getCount(arrayValue, 12, 13)%></b> su <b><%=getCount(arrayValue, 0, arrayValue.length)%></b> delle repository attualmente più popolari (circa il <%=getPercentuale(getCount(arrayValue, 12, 13), getCount(arrayValue, 0, arrayValue.length))%>%).
<br>
<b>N.B.</b> I dati sono aggiornati alla data odierna <%=getData()%>

</font>
</div>
</center>

</body>

<script type="text/javascript">
				window.onload = function () {
					
				var arrayRepo = []
				var arrayValue = [];
				var arrayLenght = $("#arrayLenght").val();
				
				for(var i=0; i<arrayLenght; i++){
					arrayRepo[i] = $("#arrayRepo"+i).val();
					arrayValue[i] = $("#arrayValue"+i).val();
				}
				
				
				
				var chart = new CanvasJS.Chart("chartContainer", {
					animationEnabled: true,
					exportEnabled: true,
					theme: "light2", // "light1", "light2", "dark1", "dark2"
					axisX: {
						labelFontSize: 12,
						title: "Anno",
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
							{ label: arrayRepo[0], y: parseInt(arrayValue[0]) },
							{ label: arrayRepo[1], y: parseInt(arrayValue[1]) },
							{ label: arrayRepo[2], y: parseInt(arrayValue[2]) },
							{ label: arrayRepo[3], y: parseInt(arrayValue[3]) },
							{ label: arrayRepo[4], y: parseInt(arrayValue[4]) },
							{ label: arrayRepo[5], y: parseInt(arrayValue[5]) },
							{ label: arrayRepo[6], y: parseInt(arrayValue[6]) },
							{ label: arrayRepo[7], y: parseInt(arrayValue[7]) },
							{ label: arrayRepo[8], y: parseInt(arrayValue[8]) },
							{ label: arrayRepo[9], y: parseInt(arrayValue[9]) },
							{ label: arrayRepo[10], y: parseInt(arrayValue[10]) },
							{ label: arrayRepo[11], y: parseInt(arrayValue[11]) },
							{ label: arrayRepo[12], y: parseInt(arrayValue[12]) },
							
						]
					}]
				});
				chart.render();

				}
</script>

</html>