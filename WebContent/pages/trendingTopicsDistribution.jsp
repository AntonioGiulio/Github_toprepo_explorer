<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*, java.text.DecimalFormat"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trending Topics distribution</title>

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
	DecimalFormat df2 = new DecimalFormat("#.#");
	
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
int totalCountRepo = 3;
if( request.getAttribute("totalCountRepo") != null){
	totalCountRepo = (Integer) request.getAttribute("totalCountRepo");
}

//Array di String contenente i valori della distribuzione
String[] valueTopic = new String[88];
if( request.getAttribute("valueTopic") != null){
	valueTopic = (String[]) request.getAttribute("valueTopic");
}

//Array di String per i range delle star
String[] arrayTopic = new String[88];
arrayTopic[0] = "Amp";
arrayTopic[1] = "Android";
arrayTopic[2] = "Angular";
arrayTopic[3] = "Arduino";
arrayTopic[4] = "Asp.net";
arrayTopic[5] = "Atom";
arrayTopic[6] = "Awesome";
arrayTopic[7] = "Amazon Web-Services";
arrayTopic[8] = "Azure";
arrayTopic[9] = "Babel";
arrayTopic[10] = "Bash";
arrayTopic[11] = "Bitcoin";
arrayTopic[12] = "Bootstrap";
arrayTopic[13] = "C";
arrayTopic[14] = "Chrome";
arrayTopic[15] = "C++";
arrayTopic[16] = "Crystal";
arrayTopic[17] = "CSS";
arrayTopic[18] = "C#";
arrayTopic[19] = "Data Structures";
arrayTopic[20] = "Data Visualization";
arrayTopic[21] = "Database";
arrayTopic[22] = "Deep Learning";
arrayTopic[23] = "Dependency Management";
arrayTopic[24] = "Django";
arrayTopic[25] = "Docker";
arrayTopic[26] = ".Net";
arrayTopic[27] = "Ethereum";
arrayTopic[28] = "Firebase";
arrayTopic[29] = "Firefox";
arrayTopic[30] = "Git";
arrayTopic[31] = "Go";
arrayTopic[32] = "Google";
arrayTopic[33] = "Gradle";
arrayTopic[34] = "Graphql";
arrayTopic[35] = "HTML";
arrayTopic[36] = "IOS";
arrayTopic[37] = "Ipfs";
arrayTopic[38] = "Java";
arrayTopic[39] = "Javascript";
arrayTopic[40] = "JQuery";
arrayTopic[41] = "JSON";
arrayTopic[42] = "Julia";
arrayTopic[43] = "Jupyter";
arrayTopic[44] = "Latex";
arrayTopic[45] = "Linux";
arrayTopic[46] = "Machine Learning";
arrayTopic[47] = "MacOS";
arrayTopic[48] = "Markdown";
arrayTopic[49] = "Material design";
arrayTopic[50] = "Matlab";
arrayTopic[51] = "Maven";
arrayTopic[52] = "Minecraft";
arrayTopic[53] = "MongoDB";
arrayTopic[54] = "Mobile";
arrayTopic[55] = "Node.js";
arrayTopic[56] = "NoSQL";
arrayTopic[57] = "NPM";
arrayTopic[58] = "Objective C";
arrayTopic[59] = "P2P";
arrayTopic[60] = "Pearl";
arrayTopic[61] = "PHP";
arrayTopic[61] = "Postgresl";
arrayTopic[63] = "Python";
arrayTopic[64] = "R";
arrayTopic[65] = "Raspberry";
arrayTopic[66] = "Ratchet";
arrayTopic[67] = "React";
arrayTopic[68] = "Ruby";
arrayTopic[69] = "Rust";
arrayTopic[70] = "Scala";
arrayTopic[71] = "Scikit Learn";
arrayTopic[72] = "Security";
arrayTopic[73] = "Serverless";
arrayTopic[74] = "VIM";
arrayTopic[75] = "Swift";
arrayTopic[76] = "Telegram";
arrayTopic[77] = "Tensorflow";
arrayTopic[78] = "Testing";
arrayTopic[79] = "Twitter";
arrayTopic[80] = "Ubuntu";
arrayTopic[81] = "Unity";
arrayTopic[82] = "Unreal";
arrayTopic[83] = "Virtual Reality";
arrayTopic[84] = "Web App";
arrayTopic[85] = "Windows";
arrayTopic[86] = "Wordpress";
arrayTopic[87] = "XML";


String[] arrayTopic1 = new String[3];
arrayTopic1[0] = "Windows";
arrayTopic1[1] = "Wordpress";
arrayTopic1[2] = "XML";




%>

<!-- valore da passare a javascript -->
<input type="hidden" id="arrayLenght" value="<%=arrayTopic.length%>">

<%for(int i=0; i<arrayTopic.length; i++){ %>
<input type="hidden" id="arrayTopic1<%=i%>" value=<%=arrayTopic[i]%>>
<input type="hidden" id="valueTopic<%=i%>" value=<%=valueTopic[i]%>>
<%} %>

<br>
<center><h2>Distribuzione delle repository in base ai Trending Topic</h2>
<br><br>
<div id="introduzione" style="margin-left: 30px; margin-bottom: 50px">
<font>
I Trending Topic sono i topic utilizzati dalle repositories più popolari e attive negli ultimi sei mesi, ovvero quelle che hanno ricevuto un commit da un contributor negli ultimi sei mesi.<br>

Nel seguente bubble-chart, è possibile osservare la distribuzione delle repository più popolari di GitHub in base ai Trending Topic.<br><br>


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
							<h4 class="card-header">Numero totale di Topic: <span class="tag tag-success" id="revenue-tag"> 88</span></h4>
							<div class="card-block">
							<div style="margin-left: 50px; margin-right: -10px" id="observablehq-dd89c58f"></div>
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
				<center><b>Numero di repository attive negli ultimi sei mesi in base al topic</b></center>
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
		</tr>
		<%} %>
	</table>
<br>
<br>
</div>

<div id="considerazioni" style="margin-left: 30px; margin-bottom: 50px">
<font>
<h3>Considerazioni</h3><br><br>
Dalle analisi effettuate è possibile osservare che:<br>
<b><%=arrayTopic[maxIndex] %></b> è il topic più utilizzato tra le repository popolari e attive negli ultimi sei mesi (<%=valueTopic[maxIndex] %> volte).<br>
<b><%=arrayTopic[minIndex] %></b> è il topic meno utilizzato tra le repository popolari e attive negli ultimi sei mesi (<%=valueTopic[minIndex] %> volte).<br><br>
<b>N.B.</b> I dati sono aggiornati alla data odierna <%=getData()%>

</font>
</div>
</center>

</body>
<script type="module">
import {Runtime, Inspector} from "https://cdn.jsdelivr.net/npm/@observablehq/runtime@4/dist/runtime.js";
import define from "https://api.observablehq.com/@antonio96/bubble-chart/3.js?v=3";
const inspect = Inspector.into("#observablehq-dd89c58f");
(new Runtime).module(define, name => (name === "chart") && inspect());
</script>


<script type="text/javascript">
				window.onload = function () {
					
					function randomX(){
						var minX=1; 
					    var maxX=120;  
					    var randomX = 
					    Math.floor(Math.random() * (+maxX - +minX)) + +minX; 
					    return randomX;
					}
					
					function randomY(){
						var minY=1; 
					    var maxY=30;  
					    var randomY = 
					    Math.floor(Math.random() * (+maxY - +minY)) + +minY; 
					    return randomY;
					}
					
					var arrayTopic1 = []
					var valueTopic = [];
					var arrayLenght = $("#arrayLenght").val();

					for(var i=0; i<arrayLenght; i++){
						arrayTopic1[i] = $("#arrayTopic"+i).val();
						valueTopic[i] = $("#valueTopic"+i).val();
					}
					
					var chart = new CanvasJS.Chart("chartContainer", {
						animationEnabled: true,
						title:{
							text: "Distribuzione delle repository in base ai trending topics"
						},
						axisX: {
							title:"Numero di repository"
						},
						axisY: {
							title:""
						},
						legend:{
							horizontalAlign: "left"
						},
						data: [{
							type: "bubble",
							showInLegend: true,
							legendText: "Size of Bubble Represents Number of Repository",
							toolTipContent: "<b>{name}</b><br/>Numero di repository: {z}<br/>",
							dataPoints: [
								{ x: randomX(), y: randomY(), z: valueTopic[0], name: arrayTopic1[0] },
								{ x: randomX(), y: randomY(), z: valueTopic[1], name: arrayTopic1[1] },
								{ x: randomX(), y: randomY(), z: valueTopic[2], name: arrayTopic1[2] },
								{ x: randomX(), y: randomY(), z: valueTopic[3], name: arrayTopic1[3] },
								{ x: randomX(), y: randomY(), z: valueTopic[4], name: arrayTopic1[4] },
								{ x: randomX(), y: randomY(), z: valueTopic[5], name: arrayTopic1[5] },
								{ x: randomX(), y: randomY(), z: valueTopic[6], name: arrayTopic1[6] },
								{ x: randomX(), y: randomY(), z: valueTopic[7], name: arrayTopic1[7] },
								{ x: randomX(), y: randomY(), z: valueTopic[8], name: arrayTopic1[8] },
								{ x: randomX(), y: randomY(), z: valueTopic[9], name: arrayTopic1[9] },
								{ x: randomX(), y: randomY(), z: valueTopic[10], name: arrayTopic1[10] },
								{ x: randomX(), y: randomY(), z: valueTopic[11], name: arrayTopic1[11] },
								{ x: randomX(), y: randomY(), z: valueTopic[12], name: arrayTopic1[12] },
								{ x: randomX(), y: randomY(), z: valueTopic[13], name: arrayTopic1[13] },
								{ x: randomX(), y: randomY(), z: valueTopic[14], name: arrayTopic1[14] },
								{ x: randomX(), y: randomY(), z: valueTopic[15], name: arrayTopic1[15] },
								{ x: randomX(), y: randomY(), z: valueTopic[16], name: arrayTopic1[16] },
								{ x: randomX(), y: randomY(), z: valueTopic[17], name: arrayTopic1[17] },
								{ x: randomX(), y: randomY(), z: valueTopic[18], name: arrayTopic1[18] },
								{ x: randomX(), y: randomY(), z: valueTopic[19], name: arrayTopic1[19] },
								{ x: randomX(), y: randomY(), z: valueTopic[20], name: arrayTopic1[20] },
								{ x: randomX(), y: randomY(), z: valueTopic[21], name: arrayTopic1[21] },
								{ x: randomX(), y: randomY(), z: valueTopic[22], name: arrayTopic1[22] },
								{ x: randomX(), y: randomY(), z: valueTopic[23], name: arrayTopic1[23] },
								{ x: randomX(), y: randomY(), z: valueTopic[24], name: arrayTopic1[24] },
								{ x: randomX(), y: randomY(), z: valueTopic[25], name: arrayTopic1[25] },
								{ x: randomX(), y: randomY(), z: valueTopic[26], name: arrayTopic1[26] },
								{ x: randomX(), y: randomY(), z: valueTopic[27], name: arrayTopic1[27] },
								{ x: randomX(), y: randomY(), z: valueTopic[28], name: arrayTopic1[28] },
								{ x: randomX(), y: randomY(), z: valueTopic[29], name: arrayTopic1[29] },
								{ x: randomX(), y: randomY(), z: valueTopic[30], name: arrayTopic1[30] },
								{ x: randomX(), y: randomY(), z: valueTopic[31], name: arrayTopic1[31] },
								{ x: randomX(), y: randomY(), z: valueTopic[32], name: arrayTopic1[32] },
								{ x: randomX(), y: randomY(), z: valueTopic[33], name: arrayTopic1[33] },
								{ x: randomX(), y: randomY(), z: valueTopic[34], name: arrayTopic1[34] },
								{ x: randomX(), y: randomY(), z: valueTopic[35], name: arrayTopic1[35] },
								{ x: randomX(), y: randomY(), z: valueTopic[36], name: arrayTopic1[36] },
								{ x: randomX(), y: randomY(), z: valueTopic[37], name: arrayTopic1[37] },
								{ x: randomX(), y: randomY(), z: valueTopic[38], name: arrayTopic1[38] },
								{ x: randomX(), y: randomY(), z: valueTopic[39], name: arrayTopic1[39] },
								{ x: randomX(), y: randomY(), z: valueTopic[40], name: arrayTopic1[40] },
								{ x: randomX(), y: randomY(), z: valueTopic[41], name: arrayTopic1[41] },
								{ x: randomX(), y: randomY(), z: valueTopic[42], name: arrayTopic1[42] },
								{ x: randomX(), y: randomY(), z: valueTopic[43], name: arrayTopic1[43] },
								{ x: randomX(), y: randomY(), z: valueTopic[44], name: arrayTopic1[44] },
								{ x: randomX(), y: randomY(), z: valueTopic[45], name: arrayTopic1[45] },
								{ x: randomX(), y: randomY(), z: valueTopic[46], name: arrayTopic1[46] },
								{ x: randomX(), y: randomY(), z: valueTopic[47], name: arrayTopic1[47] },
								{ x: randomX(), y: randomY(), z: valueTopic[48], name: arrayTopic1[48] },
								{ x: randomX(), y: randomY(), z: valueTopic[49], name: arrayTopic1[49] },
								{ x: randomX(), y: randomY(), z: valueTopic[50], name: arrayTopic1[50] },
								{ x: randomX(), y: randomY(), z: valueTopic[51], name: arrayTopic1[51] },
								{ x: randomX(), y: randomY(), z: valueTopic[52], name: arrayTopic1[53] },
								{ x: randomX(), y: randomY(), z: valueTopic[53], name: arrayTopic1[53] },
								{ x: randomX(), y: randomY(), z: valueTopic[54], name: arrayTopic1[54] },
								{ x: randomX(), y: randomY(), z: valueTopic[55], name: arrayTopic1[55] },
								{ x: randomX(), y: randomY(), z: valueTopic[56], name: arrayTopic1[56] },
								{ x: randomX(), y: randomY(), z: valueTopic[57], name: arrayTopic1[57] },
								{ x: randomX(), y: randomY(), z: valueTopic[58], name: arrayTopic1[58] },
								{ x: randomX(), y: randomY(), z: valueTopic[59], name: arrayTopic1[59] },
								{ x: randomX(), y: randomY(), z: valueTopic[60], name: arrayTopic1[60] },
								{ x: randomX(), y: randomY(), z: valueTopic[61], name: arrayTopic1[61] },
								{ x: randomX(), y: randomY(), z: valueTopic[62], name: arrayTopic1[62] },
								{ x: randomX(), y: randomY(), z: valueTopic[63], name: arrayTopic1[63] },
								{ x: randomX(), y: randomY(), z: valueTopic[64], name: arrayTopic1[64] },
								{ x: randomX(), y: randomY(), z: valueTopic[65], name: arrayTopic1[65] },
								{ x: randomX(), y: randomY(), z: valueTopic[66], name: arrayTopic1[66] },
								{ x: randomX(), y: randomY(), z: valueTopic[67], name: arrayTopic1[67] },
								{ x: randomX(), y: randomY(), z: valueTopic[68], name: arrayTopic1[68] },
								{ x: randomX(), y: randomY(), z: valueTopic[69], name: arrayTopic1[69] },
								{ x: randomX(), y: randomY(), z: valueTopic[70], name: arrayTopic1[70] },
								{ x: randomX(), y: randomY(), z: valueTopic[71], name: arrayTopic1[71] },
								{ x: randomX(), y: randomY(), z: valueTopic[72], name: arrayTopic1[72] },
								{ x: randomX(), y: randomY(), z: valueTopic[73], name: arrayTopic1[73] },
								{ x: randomX(), y: randomY(), z: valueTopic[74], name: arrayTopic1[74] },
								{ x: randomX(), y: randomY(), z: valueTopic[75], name: arrayTopic1[75] },
								{ x: randomX(), y: randomY(), z: valueTopic[76], name: arrayTopic1[76] },
								{ x: randomX(), y: randomY(), z: valueTopic[77], name: arrayTopic1[77] },
								{ x: randomX(), y: randomY(), z: valueTopic[78], name: arrayTopic1[78] },
								{ x: randomX(), y: randomY(), z: valueTopic[79], name: arrayTopic1[79] },
								{ x: randomX(), y: randomY(), z: valueTopic[80], name: arrayTopic1[80] },
								{ x: randomX(), y: randomY(), z: valueTopic[81], name: arrayTopic1[81] },
								{ x: randomX(), y: randomY(), z: valueTopic[82], name: arrayTopic1[82] },
								{ x: randomX(), y: randomY(), z: valueTopic[83], name: arrayTopic1[83] },
								{ x: randomX(), y: randomY(), z: valueTopic[84], name: arrayTopic1[84] },
								{ x: randomX(), y: randomY(), z: valueTopic[85], name: arrayTopic1[85] },
								{ x: randomX(), y: randomY(), z: valueTopic[86], name: arrayTopic1[86] },
								{ x: randomX(), y: randomY(), z: valueTopic[87], name: arrayTopic1[87] }
						
							]
						}]
					});
					chart.render();

			}
</script>

</html>