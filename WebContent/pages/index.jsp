<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Analisi delle repository Github</title>
<style>
					#textLoader {
					  position: absolute;
					  left: 44%;
					  top: 63%;
					  z-index: 1;
					  width: 200px;
					  height: 200px;
					}
					/* Center the loader */
					#loader {
					  position: absolute;
					  left: 50%;
					  top: 50%;
					  z-index: 1;
					  width: 150px;
					  height: 150px;
					  margin: -75px 0 0 -75px;
					  border: 16px solid #f3f3f3;
					  border-radius: 50%;
					  border-top: 16px solid #3498db;
					  width: 120px;
					  height: 120px;
					  -webkit-animation: spin 2s linear infinite;
					  animation: spin 2s linear infinite;
					}
					
					@-webkit-keyframes spin {
					  0% { -webkit-transform: rotate(0deg); }
					  100% { -webkit-transform: rotate(360deg); }
					}
					
					@keyframes spin {
					  0% { transform: rotate(0deg); }
					  100% { transform: rotate(360deg); }
					}
					
					/* Add animation to "page content" */
					.animate-bottom {
					  position: relative;
					  -webkit-animation-name: animatebottom;
					  -webkit-animation-duration: 1s;
					  animation-name: animatebottom;
					  animation-duration: 1s
					}
					
					@-webkit-keyframes animatebottom {
					  from { bottom:-100px; opacity:0 } 
					  to { bottom:0px; opacity:1 }
					}
					
					@keyframes animatebottom { 
					  from{ bottom:-100px; opacity:0 } 
					  to{ bottom:0; opacity:1 }
					}
					
					#myDiv {
					  display: none;
					  text-align: center;
					}	
</style>
</head>
<body>
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

<div style="display:none;" id="loader"></div>
<div style="display:none;" id="textLoader">Request to server...please wait.<br> Do not refresh the page!</div>

<div style="display:block;" id="myDiv" class="animate-bottom">

<div id="intestazione">
<center>
	<h1>Analisi delle repository di Github</h1><br>
	<font size="4px">Autori: Michele Delli Paoli, Antonio Giulio</font>
</center>
</div>
<br>

<div id="testo" style="margin-left: 20px; margin-right: 20px; margin-top: 50px; margin-bottom: 50px;">
Nel seguente lavoro è stato riprodotto lo studio e l'analisi delle repository presenti su Github denominata <a href="https://medium.appbase.io/analyzing-20k-github-repositories-af76de21c3fc">"Analyzing top 20k Github Repository"</a>, effettuata nel 2017 da Siddharth Kothari, al fine di ottenere informazioni utili riguardo l'evoluzione, nel corso di due anni (dal 2017 al 2019), dell' Open Source Software (OSS).<br>
Nell'analisi del 2017 sono state prese in considerazione le repository di Github più popolari, ovvero quelle con un numero di Star superiore a 500.<br>
Il dataset ottenuto comprendeva 29,577 repository.<br>
Per analizzare i valori attuali relativi alle repository si farà utilizzo delle Search API di Github.<br>
Il primo passo da compiere è, pertanto, quello di ottenere un dataset di repository il cui numero di Star sia superiore a 500.<br><br>
Sulla base del dataset ottenuto, saranno confrontati i risultati dell'analisi effettuata da S. Kothari con i valori attuali, prendendo in esaminazione alcuni criteri principali:<br>

-<a onclick="myFunction()" href="../generateStarDistribution">Numero di Star;</a><br>
-<a onclick="myFunction()" href="../generateForkDistribution">Numero di Fork;</a><br>
-<a onclick="myFunction()" href="../generateTopLanguagesDistribution">Linguaggi di programmazione principali;</a><br>
-<a onclick="myFunction()" href="../generateTopLanguagesDistributionLastMonth">Linguaggi di programmazione utilizzati dalle repository attive nell'ultimo mese;</a><br>
-<a onclick="myFunction()" href="../generateCreationDateDistribution">Data di creazione;</a><br>
-<a onclick="myFunction()" href="../generateTopTopicsDistribution">Topic più popolari;</a><br>
-<a onclick="myFunction()" href="../generateTrendingTopicsDistribution">Trending Topics;</a><br><br>

Inoltre, sono stati analizzati alcuni criteri, di seguito elencati, non presi in considerazione dall'analisi del 2017:<br>
-<a onclick="myFunction()" href="../generateUnisaTrendingTopicsDistribution">UNISA trending topics;</a><br>
-<a onclick="myFunction()" href="../generateGenderDistribution">Genere dei Contributors.</a><br>
-<a onclick="myFunction()" href="../generateContributorsAnalysis">Distribuzione dei Contributors per repository.</a><br>

<br><br><br>
<b>N.B.</b> I dati dell'analisi sono aggiornati alla data odierna <%=getData()%>


</div>
</div>

</body>

<script type="text/javascript">
	function myFunction() {
			document.getElementById("myDiv").style.display = "none";
			document.getElementById("loader").style.display = "block";
			document.getElementById("textLoader").style.display = "block";
			}
</script>

</html>