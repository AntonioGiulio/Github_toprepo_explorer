package newCore;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Scanner;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class RequestGenerator {
	private HttpURLConnection connection;
	private JSONObject obj;
	private final static String endpoint = "https://api.github.com/search/";
	private final static String genderizeEndpoint = "https://api.genderize.io?name=";
	private final static String genderApiEndpoint = "https://gender-api.com/get?name=";
	private String target;
	private String user, githubAccessToken;
	private String[] usernameArray = new String[2];
	private String[] githubTokenArray = new String[2];
	
	public RequestGenerator(String in_target, String in_user, String accessTkn) {
		target = in_target;
		user = in_user;
		githubAccessToken = accessTkn;
		usernameArray[0] = "AntonioGiulio";
		usernameArray[1] = "tulipano96";
		githubTokenArray[0] = "57c8917993cf61cd2622014c5e0ef7d94d6e28c7";
		githubTokenArray[1] = "a865f57b6adf6f54e335b43b905d8783e948ef4c";
	}
	
	public String searchByRangeOfStars(int start, int end) throws IOException, JSONException {
		String result = "";
		if(target.equals("repositories")) {
			String command =  "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A" + start + ".." + end;			
			obj = new JSONObject(this.execCommand(command));
			result = String.valueOf(obj.get("total_count"));
			System.out.println(result);
		}
		return result;
	}
	
	public ArrayList<String> searchStarsDistribution(int start, int end, int dimRange) throws InterruptedException, IOException, JSONException {
		ArrayList<String> lista = new ArrayList<>();
		System.out.println("request to server...");
		for(int i = start; i < end; i += dimRange) {
			System.out.print(i + "---" + (i+dimRange) + ": ");
			lista.add(this.searchByRangeOfStars(i, i+dimRange));
		}
		System.out.println("... request completed!");
		return lista;
	}
	
	public String searchByRangeOfForks(int start, int end) throws IOException, JSONException {
		String result = "";
		if(target.equals("repositories")) {
			String command = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500+forks%3A" + start + ".." + end;
			obj = new JSONObject(this.execCommand(command));
			result = String.valueOf(obj.get("total_count"));
			System.out.println(result);
		}
		return result;		
	}
	
	public ArrayList<String> searchForksDistribution(int start, int end, int dimRange) throws IOException, JSONException{
		ArrayList<String> lista = new ArrayList<>();
		System.out.println("request to server...");
		for(int i = start; i < end; i += dimRange) {
			System.out.print(i + "---" + (i+dimRange) + ": ");
			lista.add(this.searchByRangeOfForks(i, i+dimRange));
		}
		System.out.println("... request completed!");
		return lista;
	}
	
	public String searchByLanguages(String language) throws IOException, JSONException {
		String result = "";
		if(target.equals("repositories")) {
			String command = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500+language%3A" + language;			
			obj = new JSONObject(this.execCommand(command));
			result = String.valueOf(obj.get("total_count"));
			System.out.println(result);
		}
		return result;
	}
	
	public ArrayList<String> searchByLanguagesDistribution() throws IOException, JSONException{
		ArrayList<String> listaLinguaggi = new ArrayList<String>();
		listaLinguaggi.add("javascript");
		listaLinguaggi.add("java");
		listaLinguaggi.add("python");
		listaLinguaggi.add("objective-c");
		listaLinguaggi.add("go");
		listaLinguaggi.add("ruby");
		listaLinguaggi.add("php");
		listaLinguaggi.add("c++");
		listaLinguaggi.add("C");
		listaLinguaggi.add("swift");
		listaLinguaggi.add("julia");
		listaLinguaggi.add("c#");
		listaLinguaggi.add("rust");
		listaLinguaggi.add("assembly");
		listaLinguaggi.add("perl");
		listaLinguaggi.add("matlab");
		listaLinguaggi.add("pascal");
		listaLinguaggi.add("groovy");
		listaLinguaggi.add("R");
		ArrayList<String> lista = new ArrayList<>();
		System.out.println("request to server...");
		for(String language: listaLinguaggi) {
			System.out.print(language + ": ");
			lista.add(this.searchByLanguages(language));
		}		
		System.out.println("... request completed!");
		return lista;
	}
	
	public String searchByLastMonthLanguages(String language, String currentDate, String monthAgoDate) throws IOException, JSONException{
		String result = "";
		if(target.equals("repositories")) {
			String command = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500+language%3A" + language + "+pushed%3A" + monthAgoDate + ".." + currentDate;
			obj = new JSONObject(this.execCommand(command));
			result = String.valueOf(obj.get("total_count"));
			System.out.println(result);					
		}
		return result;
	}
	
	public ArrayList<String> searchByLastMonthLanguageDistribution() throws IOException, JSONException{
		ArrayList<String> listaLinguaggi = new ArrayList<>();
		listaLinguaggi.add("javascript");
		listaLinguaggi.add("python");
		listaLinguaggi.add("java");
		listaLinguaggi.add("c++");
		listaLinguaggi.add("go");
		listaLinguaggi.add("php");
		listaLinguaggi.add("ruby");
		listaLinguaggi.add("C");
		listaLinguaggi.add("swift");
		listaLinguaggi.add("c#");
		listaLinguaggi.add("julia");
		listaLinguaggi.add("rust");
		listaLinguaggi.add("assembly");
		listaLinguaggi.add("perl");
		listaLinguaggi.add("matlab");
		listaLinguaggi.add("pascal");
		listaLinguaggi.add("groovy");
		listaLinguaggi.add("R");
		ArrayList<String> lista = new ArrayList<>();
		System.out.println("request to server...");
		for(String language: listaLinguaggi) {
			System.out.print(language + ": ");
			lista.add(this.searchByLastMonthLanguages(language, getData(), getDataLastMonth()));
		}	
		System.out.println("... request completed!");
		return lista;
	}
	
	public String searchByCreationDate(String year1, String year2) throws IOException, JSONException {
		String result = "";
		if(target.contentEquals("repositories")) {
			String command = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500"+ "+created%3A" + year1 + "-01-01.." + year2 + "-01-01";
			obj = new JSONObject(this.execCommand(command));
			result = String.valueOf(obj.get("total_count"));
			System.out.println(result);
		}
		return result;
	}
	
	public ArrayList<String> searchDistributionByCreationDate() throws IOException, JSONException{
		ArrayList<String> lista = new ArrayList<String>();
		int earlyYear = 2007;
		int lateYear = 2008;
		System.out.println("request to server...");
		for(; lateYear <= 2020; lateYear++) {
			System.out.print(earlyYear + "--" + lateYear + ": ");
			lista.add(this.searchByCreationDate(String.valueOf(earlyYear), String.valueOf(lateYear)));
			earlyYear++;
		}
		System.out.println("... request completed!");
		return lista;
	}
	
	public String searchByTopics(String topic) throws IOException, JSONException {
		String result  = "";
		if(target.equals("repositories")) {
			String command = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500+topic%3A" + topic;
			obj = new JSONObject(this.execCommand(command));
			result = String.valueOf(obj.get("total_count"));
			System.out.println(result);
		}
		return result;
	}
	
	public ArrayList<String> searchByTopTopics() throws IOException, JSONException{
		ArrayList<String> listaTopic = new ArrayList<>();
		listaTopic.add("javascript");
		listaTopic.add("python");
		listaTopic.add("android");
		listaTopic.add("react");
		listaTopic.add("ios");
		listaTopic.add("php");
		listaTopic.add("java");
		listaTopic.add("swift");
		listaTopic.add("nodejs");
		listaTopic.add("go");
		listaTopic.add("golang");
		listaTopic.add("ruby");
		listaTopic.add("css");
		listaTopic.add("machine-learning");
		listaTopic.add("docker");
		listaTopic.add("deep-learning");
		listaTopic.add("linux");
		listaTopic.add("awesome");
		listaTopic.add("vue");
		listaTopic.add("animation");		
		ArrayList<String> lista = new ArrayList<>();
		System.out.println("request to server...");
		for(String topic: listaTopic) {
			System.out.print(topic + ": ");
			lista.add(this.searchByTopics(topic));
		}
		System.out.println("... request completed!");
		return lista;
	}
	
	public String searchByRecentTopics(String topic, String currentDate, String sixMonthAgoDate) throws IOException, JSONException {
		GregorianCalendar gc = new GregorianCalendar();
		String result = "";
		
		if(target.equals("repositories")) {
			String command = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500+pushed%3A" + sixMonthAgoDate + ".." + currentDate + "+topic%3A" + topic;
			obj = new JSONObject(this.execCommand(command));
			result = String.valueOf(obj.get("total_count"));
			System.out.println(result);
		}
		return result;
	}
	
	public ArrayList<String> searchByRecentTrendingTopics() throws IOException, JSONException{
		ArrayList<String> listaTopic = new ArrayList<>();
		listaTopic.add("amp");				listaTopic.add("android");
		listaTopic.add("angular");			listaTopic.add("arduino");
		listaTopic.add("asp-net");			listaTopic.add("atom");
		listaTopic.add("awesome");			listaTopic.add("aws");
		listaTopic.add("azure");			listaTopic.add("babel");
		listaTopic.add("bash");				listaTopic.add("bitcoin");
		listaTopic.add("bootstrap");		listaTopic.add("c");
		listaTopic.add("chrome");			listaTopic.add("c-plus-plus");
		listaTopic.add("crystal");			listaTopic.add("css");
		listaTopic.add("c#");				listaTopic.add("data-structures");
		listaTopic.add("data-visualization");listaTopic.add("database");
		listaTopic.add("deep-learning");	listaTopic.add("dependency-management");
		listaTopic.add("django");			listaTopic.add("docker");
		listaTopic.add("dot-net");			listaTopic.add("ethereum");
		listaTopic.add("firebase");			listaTopic.add("firefox");
		listaTopic.add("git");				listaTopic.add("go");
		listaTopic.add("google");			listaTopic.add("gradle");
		listaTopic.add("graphql");			listaTopic.add("html");
		listaTopic.add("ios");				listaTopic.add("ipfs");
		listaTopic.add("java");				listaTopic.add("javascript");
		listaTopic.add("jquery");			listaTopic.add("json");
		listaTopic.add("julia");			listaTopic.add("jupyter");
		listaTopic.add("latex");			listaTopic.add("linux");
		listaTopic.add("machine-learning"); listaTopic.add("macos");
		listaTopic.add("markdown"); 		listaTopic.add("material-design");
		listaTopic.add("matlab");			listaTopic.add("maven");
		listaTopic.add("minecraft");		listaTopic.add("mongodb");
		listaTopic.add("mobile");			listaTopic.add("mysql");
		listaTopic.add("nodejs");			listaTopic.add("nosql");
		listaTopic.add("npm");				listaTopic.add("objective-c");
		listaTopic.add("p2p");				listaTopic.add("perl");
		listaTopic.add("php");				listaTopic.add("postgresql");
		listaTopic.add("python");			listaTopic.add("r");
		listaTopic.add("raspberry");		listaTopic.add("ratchet");
		listaTopic.add("react");			listaTopic.add("ruby");
		listaTopic.add("rust");				listaTopic.add("scala");
		listaTopic.add("scikit-learn");		listaTopic.add("security");
		listaTopic.add("serverless");		listaTopic.add("vim");
		listaTopic.add("swift");			listaTopic.add("telegram");
		listaTopic.add("tensorflow");		listaTopic.add("testing");
		listaTopic.add("twitter");			listaTopic.add("ubuntu");
		listaTopic.add("unity");			listaTopic.add("unreal");
		listaTopic.add("virtual-reality");	listaTopic.add("web-app");
		listaTopic.add("windows");			listaTopic.add("wordpress");
		listaTopic.add("xml");		
		ArrayList<String> lista = new ArrayList<>();
		System.out.println("request to server...");
		int count = 1;
		for(String topic: listaTopic) {
			if(count == 29) {
				count = 0;
				if(this.user.equals(usernameArray[0])) {
					this.user = usernameArray[1];
					this.githubAccessToken = this.githubTokenArray[1];
				}else {
					this.user = usernameArray[0];
					this.githubAccessToken = this.githubTokenArray[0];
				}
			}
				System.out.print(topic + ": ");
				lista.add(this.searchByRecentTopics(topic, getData(), getDataSixMonthAgo()));
			
				
				
			
			count++;
		}
		System.out.println("... request completed!");
		return lista;
	}
	
	public ArrayList<String> searchByUNISATrendingTopics() throws IOException, JSONException{
		JSONObject objToFile = new JSONObject();
		JSONArray arrayToFile = new JSONArray();
		ArrayList<String> listaTopic = new ArrayList<>();
		//indirizzo sicurezza
		listaTopic.add("security");	listaTopic.add("cryptography");
		listaTopic.add("bitcoin");	listaTopic.add("blockchain");
		listaTopic.add("exploit"); listaTopic.add("malware");
		listaTopic.add("malware-analysis");	listaTopic.add("penetration-testing");
		listaTopic.add("cyber-security");	listaTopic.add("tor-network");
		listaTopic.add("hacking");	listaTopic.add("privacy");
		//indirizzo sits
		listaTopic.add("software-engineering");	listaTopic.add("compiler");
		listaTopic.add("design-patterns");	listaTopic.add("reverse-engineering");
		listaTopic.add("testing");	listaTopic.add("debugger");
		//indirizzo cloud
		listaTopic.add("cloud");	listaTopic.add("azure");
		listaTopic.add("aws"); 		listaTopic.add("microservices");
		listaTopic.add("docker");	listaTopic.add("p2p");
		listaTopic.add("wireshark");	listaTopic.add("network");
		listaTopic.add("benchmark");	listaTopic.add("consensus");
		listaTopic.add("distributed-systems"); listaTopic.add("serverless");
		//indirizzo data science
		listaTopic.add("data-science");	listaTopic.add("machine-learning");
		listaTopic.add("deep-learning");	listaTopic.add("neural-network");
		listaTopic.add("cnn");	listaTopic.add("data-visualization");
		listaTopic.add("bigdata");	listaTopic.add("database");
		listaTopic.add("artificial-intelligence");
		//indirizzo iot
		listaTopic.add("iot");	listaTopic.add("Arduino");
		listaTopic.add("mqtt");	listaTopic.add("raspberry-pi");
		listaTopic.add("home-automation");	listaTopic.add("m2m");
			
		ArrayList<String> lista = new ArrayList<>();
		System.out.println("request to server...");
		int count = 1;
		for(String topic: listaTopic) {
			if(count == 29) {
				count = 0;
				if(this.user.equals(usernameArray[0])) {
					this.user = usernameArray[1];
					this.githubAccessToken = this.githubTokenArray[1];
				}else {
					this.user = usernameArray[0];
					this.githubAccessToken = this.githubTokenArray[0];
				}
			}
			System.out.print(topic + ": ");
			String result = this.searchByTopics(topic);
			lista.add(result);		
			count++;
			
			JSONObject obj = new JSONObject();
			obj.put("count", result);
			obj.put("text", topic);
			arrayToFile.put(obj);
		}
		objToFile.put("items", arrayToFile);
		FileWriter file = new FileWriter("UNISAtrendingTopics.json");
		file.write(objToFile.toString());
		System.out.println("Successfully Copied JSON Object to File...");
		file.close();
		System.out.println("... request completed!");
		return lista;
	}
	
	public ArrayList<String> contributorsAnalysis() throws IOException, JSONException {
		BufferedReader reader = new BufferedReader(new FileReader("contributorsPerRepo.json"));
		String inputLine = reader.readLine();
		reader.close();
		obj = new JSONObject(inputLine);		
		JSONArray repos = new JSONArray();
		
		ArrayList<String> lista = new ArrayList<String>();
		
		repos = obj .getJSONArray("repositories");
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		String language;
		int total_count = repos.length();
		int dimRange = 2500;
		
		int numRange = total_count / dimRange;
		int pos = 0;
		int curr = dimRange;
		System.out.println("numero di range: " + numRange);
		int contrAccumulator = 0;
		int starsEx_1 = 0;
		int starsEx_2 = 0;
		for(int i = 0; i < numRange; i++) {			
			//System.out.println("il range dell'array è: " + pos + "--" + curr);
			starsEx_1 = repos.getJSONObject(pos).getInt("stargazers");
			starsEx_2 = repos.getJSONObject(curr).getInt("stargazers");
			System.out.println("il range di stars è: " + starsEx_1 + " -- " + starsEx_2);
			for(int j = pos; j < curr; j++) {
				language = repos.getJSONObject(j).getString("language");
				if(map.containsKey(language)) {
					int prevValue = map.get(language);
					map.remove(language);
					map.put(language, prevValue+1);
				}else {
					map.put(language, 1);
				}
				
				
				
				contrAccumulator += repos.getJSONObject(j).getInt("contributors");	
				
			}
			lista.add(String.valueOf((contrAccumulator/dimRange)));
			System.out.println("media dei contributors: " + (contrAccumulator/dimRange));
			
			
			System.out.println("JavaScript: " + map.get("JavaScript"));
			System.out.println("Java: "  + map.get("Java"));
			System.out.println("Python: " + map.get("Python"));
			System.out.println("Go: " + map.get("Go"));
			System.out.println("C#: " + map.get("C#"));
			System.out.println("C: " + map.get("C"));
			System.out.println("Swift: " + map.get("Swift"));
			map = new HashMap<String, Integer>();
			contrAccumulator = 0;			
			pos = curr;
			curr += dimRange;
			
		}
		return lista;
		
		
	}
	
	@SuppressWarnings("resource")
	public JSONObject obtainUserList() throws IOException, JSONException {
		JSONObject objToFile = new JSONObject();
		objToFile.put("name", "Github_toprepo_Explorer");
		objToFile.put("owner", "Antonio Giulio, Michele Delli Paoli");
		JSONArray names = new JSONArray();
		int total_page;
		String command_0 = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500";
		obj = new JSONObject(this.execCommand(command_0));
		total_page = obj.getInt("total_count") / 100;
		System.out.println(total_page);
		try {
			for(int k = 1; k < total_page; k++) {
				try {
					String command_1 = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500&page=" + k +"&per_page=100";			
					obj = new JSONObject(this.execCommand(command_1));
					JSONArray items = obj.getJSONArray("items");
					for( int i = 0; i < 100; i++) {
						System.out.println(items.getJSONObject(i).get("name") + "@@@@@@@@@@@@@");
						String command_2 = "curl -u " + user + ":" + githubAccessToken + " " + items.getJSONObject(i).get("contributors_url") + "?per_page=100";
						JSONArray contributorsArray;
						contributorsArray = new JSONArray(this.execCommand(command_2));
						for(int j = 0; j < contributorsArray.length(); j++) {
							String command_3 = "curl -u " + user + ":" + githubAccessToken + " " + contributorsArray.getJSONObject(j).get("url");
							JSONObject user = new JSONObject(this.execCommand(command_3));
							if(!user.get("name").equals(null)) {
								names.put(user.get("name"));
								System.out.println(user.get("name"));							
							}
						}	
					}
				}catch(JSONException e) {
					@SuppressWarnings("resource")
					Scanner s = new Scanner(System.in);
					System.out.println("Scegli se continuare la ricerca (1/0): ");
					int result = s.nextInt();
					if(result == 1)
						this.changeCredentials();
					else
						return  objToFile;
				}
			}			
		}finally {
			objToFile.put("total_count", names.length());
			objToFile.put("names_list", names);
			FileWriter file = new FileWriter("names.json");
			file.write(objToFile.toString());
			System.out.println("Successfully Copied JSON Object to File...");
			file.close();
		}
		return objToFile;			
	}
	
	public JSONObject obtainContributorsPerRepo() throws IOException, JSONException {
		JSONObject objToFile = new JSONObject();
		JSONArray arrayToFile = new JSONArray();
		objToFile.put("name", "Github_toprepo_Explorer");
		objToFile.put("owner", "Antonio Giulio, Michele Delli Paoli");
		int total_page, utilStarsValue = 1000000;
		String command_0 = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500";
		obj = new JSONObject(this.execCommand(command_0));
		total_page = obj.getInt("total_count") / 100;
		System.out.println(total_page);		
		try {
			for(int k = 0; k < total_page; k++) {
				try {
					String command_1 = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A500.." + utilStarsValue + "&page=" + ((k%10)+1) +"&per_page=100";			
								
					obj = new JSONObject(this.execCommand(command_1));
					JSONArray items = obj.getJSONArray("items");
					if(k%10+1 == 10)
						utilStarsValue = items.getJSONObject(99).getInt("stargazers_count");
					for( int i = 0; i < 100; i++) {
						String repoName = (String) items.getJSONObject(i).get("name");
						String command_2 = "curl -u " + user + ":" + githubAccessToken + " " + items.getJSONObject(i).get("contributors_url") + "?per_page=100";
						JSONArray contributorsArray;
						contributorsArray = new JSONArray(this.execCommand(command_2));
						int numOfContributors = contributorsArray.length();
						if (numOfContributors == 100) {
							boolean done = false;
							int numPage = 2;
							while(!done) {
								String command_3 = "curl -u " + user + ":" + githubAccessToken + " " + items.getJSONObject(i).get("contributors_url") + "?per_page=100&page=" + numPage;
								JSONArray newPageArray = new JSONArray(this.execCommand(command_3));
								int newNumOfContributors = newPageArray.length();
								numOfContributors += newNumOfContributors;
								if(newNumOfContributors != 100)
									done = true;
								else
									numPage++;
							}
							System.out.println(repoName + ": " + numOfContributors);
							
						}else
							System.out.println(repoName + ": " + numOfContributors);
						arrayToFile.put(repoName + ": " + numOfContributors);
					}
				}catch(JSONException e) {
					e.printStackTrace();
					@SuppressWarnings("resource")
					Scanner s = new Scanner(System.in);
					System.out.println("Scegli se continuare la ricerca (1/0): ");
					int result = s.nextInt();
					if(result == 1)
						if(this.user.equals(usernameArray[0])) {
							this.user = usernameArray[1];
							this.githubAccessToken = this.githubTokenArray[1];
						}else {
							this.user = usernameArray[0];
							this.githubAccessToken = this.githubTokenArray[0];
						}
					else
						return objToFile;
				}
			}			
		}finally {
			objToFile.put("repo_list+numOfContributors", arrayToFile);
			FileWriter file = new FileWriter("contributorsPerRepo.json");
			file.write(objToFile.toString());
			System.out.println("Successfully Copied JSON Object to File...");
			file.close();
		}
		
		return objToFile;
	}
	
	public int genderDetector(int start, int stop) throws IOException, JSONException {
		int numOfWomen = 0;
		
		BufferedReader reader = new BufferedReader(new FileReader("../Github_toprepo_explorer/names.json"));
		String inputLine = reader.readLine();
		reader.close();
		JSONObject obj = new JSONObject(inputLine);
		int total_count = obj.getInt("total_count");
		JSONArray names = new JSONArray();
		names = obj.getJSONArray("names_list");	
		for(int j = start; j < stop; j++) {
			String fullName = names.getString(j);
			String firstName;
			try {
				firstName = (String) fullName.subSequence(0, fullName.indexOf(' '));
			}catch(IndexOutOfBoundsException e) {
				firstName = fullName;
			}
			
			
			
			URL url = new URL(genderizeEndpoint  + firstName);
			connection = (HttpURLConnection) url.openConnection();
			if(connection.getResponseCode() == 200) {
				JSONObject genderResponse;
				reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				genderResponse = new JSONObject(reader.readLine());
				if(genderResponse.get("gender").equals("female")) {
					numOfWomen++;
					System.out.println(firstName);
				}
			}
		}
		
		return numOfWomen;
		
	}
	
	
	private int getRateLimit() throws IOException, JSONException {
		int result = 0;
		String inputLine = "";
		String command = "curl -u " + user + ":" + githubAccessToken + " https://api.github.com/rate_limit";
		Process p;
		p = Runtime.getRuntime().exec(command);
		BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
		String line = reader.readLine();		
		while(line != null) {			
			inputLine += line + "\n";
			line = reader.readLine();
		}		
		p.destroy();
		reader.close();		
		JSONObject obj = new JSONObject(inputLine);
		JSONObject rate = obj.getJSONObject("rate");
		result = rate.getInt("remaining");
		
		return result;
	}
	
	
	private int changeCredentials(){
		int result = 0;
		@SuppressWarnings("resource")
		Scanner in = new Scanner(System.in);
		System.out.println("Cambia le tue credenziali");
		System.out.print("Nome Utente Github: ");
		this.user = in.nextLine();
		System.out.print("Personal Access Token: ");
		this.githubAccessToken = in.nextLine();
		
		return result;
	}
	
	
	private String execCommand(String command) throws IOException {
		String result = "";
		String line = "";
		Process p;
		p = Runtime.getRuntime().exec(command);
		BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
		line = reader.readLine();		
		while(line != null) {			
			result += line + "\n";
			line = reader.readLine();
		}		
		p.destroy();
		reader.close();
		
		return result;
	}
	
	
	public void eraser() throws IOException {
		String command_0 = "curl -u " + user + ":" + githubAccessToken + " " + endpoint + target + "?q=stars%3A>500";
		for(int i = 0; i < 4500; i ++) {
			this.execCommand(command_0);
		}
	}
	
	public String getData(){
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
		String dataString = anno + "-" + mese + "-" + giorno;
		return dataString;
	}
	
	public String getDataLastMonth(){
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
		String dataString = anno + "-" + mese + "-" + giorno;
		return dataString;
	}
	
	public String getDataSixMonthAgo(){
		Calendar data = Calendar.getInstance();
		String anno = String.valueOf(data.get(Calendar.YEAR));
		String mese = String.valueOf(data.get(Calendar.MONTH)-5);
		if(mese.length()==1) {
			mese = "0"+mese;
		}
		String giorno = String.valueOf(data.get(Calendar.DAY_OF_MONTH));
		if(giorno.length()==1) {
			giorno = "0" + giorno;
		}
		String dataString = anno + "-" + mese + "-" + giorno;
		return dataString;
	}

}
