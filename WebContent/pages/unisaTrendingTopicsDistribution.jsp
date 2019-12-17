<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, java.text.DecimalFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UNISA Trending Topics distribution</title>

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

int maxIndex = Integer.parseInt(String.valueOf(request.getAttribute("maxIndex")));
int minIndex = Integer.parseInt(String.valueOf(request.getAttribute("minIndex")));

//numero totale di repository
int totalCountRepo = 0;
if( request.getAttribute("totalCountRepo") != null){
	totalCountRepo = (Integer) request.getAttribute("totalCountRepo");
}

//Array di String contenente i valori della distribuzione
String[] valueTopic = new String[45];
if( request.getAttribute("valueTopic") != null){
	valueTopic = (String[]) request.getAttribute("valueTopic");
}

//Array di String per i range delle star
String[] arrayTopic = new String[45];
arrayTopic[0] = "Security";
arrayTopic[1] = "Cryptography";
arrayTopic[2] = "Bitcoin";
arrayTopic[3] = "BlockChain";
arrayTopic[4] = "Exploit";
arrayTopic[5] = "Malware";
arrayTopic[6] = "Malware Analysis";
arrayTopic[7] = "Penetration Testing";
arrayTopic[8] = "Cyber Security";
arrayTopic[9] = "TOR Network";
arrayTopic[10] = "Hacking";
arrayTopic[11] = "Privacy";
arrayTopic[12] = "Software Enineering";
arrayTopic[13] = "Compiler";
arrayTopic[14] = "Design Patterns";
arrayTopic[15] = "Reverse Enineering";
arrayTopic[16] = "Testing";
arrayTopic[17] = "Debugger";
arrayTopic[18] = "Cloud";
arrayTopic[19] = "Azure";
arrayTopic[20] = "AWS";
arrayTopic[21] = "Microservices";
arrayTopic[22] = "Docker";
arrayTopic[23] = "P2P";
arrayTopic[24] = "WireShark";
arrayTopic[25] = "Network";
arrayTopic[26] = "Benchmark";
arrayTopic[27] = "Consensus";
arrayTopic[28] = "Distributed System";
arrayTopic[29] = "Serverless";
arrayTopic[30] = "Data Science";
arrayTopic[31] = "Machine Learning";
arrayTopic[32] = "Deep Learning";
arrayTopic[33] = "Neural Network";
arrayTopic[34] = "CNN";
arrayTopic[35] = "Data Visualization";
arrayTopic[36] = "BigData";
arrayTopic[37] = "Database";
arrayTopic[38] = "Artificial Intelligence";
arrayTopic[39] = "IoT";
arrayTopic[40] = "Arduino";
arrayTopic[41] = "MQTT";
arrayTopic[42] = "Raspberry Pi";
arrayTopic[43] = "Home Automation";
arrayTopic[44] = "M2M";

%>


<br>
<center><h2>Distribuzione delle repository in base ai Trending Topic di UNISA</h2>
<br><br>
<div id="introduzione" style="margin-left: 30px; margin-bottom: 50px">
<font>
Di seguito, è possibile osservare la distribuzione delle repository più popolari in base ai topic UNISA.<br>
I topic vengono utilizzati per etichettare e scoprire le repository su Github.<br><br>

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
							<h4 class="card-header">Numero totale di Topic: <span class="tag tag-success" id="revenue-tag"> 45</span></h4>
							<div class="card-block">
							<div style="margin-left: 50px; margin-right: -10px" id="observablehq-46253540"></div>
								<!-- <div id="chartContainer"></div> -->
							</div>
						</div>
					</div>
	</div>
	
</div>

<br><br>
<center>
<br>
<div>
	<table style="border-collapse: collapse; border: 1px solid black; width: 80%">
		<tr style="width: 100%">
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Topic</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Numero di repository in base al topic</b></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><b>Percentuale rispetto al numero totale di repository</b></center>
			</td>
		</tr>
		<%for(int i=0; i<arrayTopic.length; i++){ %>
		<tr>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=arrayTopic[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=valueTopic[i]%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center><%=getPercentuale(getCount(valueTopic, i, i+1), getCount(valueTopic, 0, valueTopic.length))%>%</center>
			</td>
		</tr>
		<%} %>
		<tr>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center>Totale: <%=totalCountRepo%></center>
			</td>
			<td style="border-collapse: collapse; border: 1px solid black;" width="25%">
				<center></center>
			</td>
		</tr>
	</table>
<br>
<br>
</div>

<div id="considerazioni" style="margin-left: 30px; margin-bottom: 50px">
<font>
<h3>Considerazioni</h3><br><br>
Dalle analisi effettuate è possibile osservare che:<br>
<b><%=arrayTopic[maxIndex] %></b> è il topic UNISA più utilizzato tra le repository popolari (<%=valueTopic[maxIndex] %> volte).<br>
<b><%=arrayTopic[minIndex] %></b> è il topic UNISA meno utilizzato tra le repository popolari (<%=valueTopic[minIndex] %> volte).<br><br>
<b>N.B.</b> I dati sono aggiornati alla data odierna <%=getData()%>

</font>
</div>
</center>

</body>
<script type="module">
import {Runtime, Inspector} from "https://cdn.jsdelivr.net/npm/@observablehq/runtime@4/dist/runtime.js";
import define from "https://api.observablehq.com/@antonio96/bubble-chart/2.js?v=3";
const inspect = Inspector.into("#observablehq-46253540");
(new Runtime).module(define, name => (name === "chart") && inspect());
</script>



</html>