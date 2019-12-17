package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;

import newCore.RequestGenerator;



@WebServlet("/generateStarDistribution")
public class generateStarDistribution extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	public generateStarDistribution() {
		super();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession s = request.getSession();
		
		boolean lockResource=false;
		if(s.getAttribute("lockResource")!=null) {
			System.out.println("Inizio -> Attributo in sessione:" + s.getAttribute("lockResource"));
		}
		
		System.out.println("Entro nel while -> Attributo in sessione:" + s.getAttribute("lockResource"));
		while(true) {
			if(s.getAttribute("lockResource") != null) {
				lockResource = (boolean) s.getAttribute("lockResource");
			}
			
			//se la risorsa è occupata (lockResource=true) aspetto 60 secondi, altrimenti esco dal while e procedo con l'esecuzione
			if(lockResource) {
				try {
				    Thread.sleep(60000);
				} catch(InterruptedException e) {
					s.setAttribute("lockResource", false);
				    System.err.println(e);
				}
			}else {
				break;
			}
			
		}
		System.out.println("Esco dal while -> Attributo in sessione:" + s.getAttribute("lockResource"));
		
		RequestGenerator reqGen = new RequestGenerator("repositories", "tulipano96", "a865f57b6adf6f54e335b43b905d8783e948ef4c");
		List<String> list = new ArrayList<String>();
		String[] arrayRepo;
		int totalCountRepo = 0;
		
		
		
		//otteniamo la lista
		try {
			s.setAttribute("lockResource", true);
			System.out.println("Eseguo API -> Attributo in sessione:" + s.getAttribute("lockResource"));
			list = reqGen.searchStarsDistribution(500, 10000, 500);
			list.add(String.valueOf(reqGen.searchByRangeOfStars(10000, 300000)));
			s.setAttribute("lockResource", false);
		} catch (InterruptedException | JSONException e) {
			s.setAttribute("lockResource", false);
			e.printStackTrace();
		}
		
		//conversione da lista ad array di String da passare come parametro tra servlet e jsp per generazione del grafico.
		arrayRepo = list.toArray(new String[list.size()]);
		
		
		
		
		
		
		/*
		String[] arrayRepo =  new String[20];
		arrayRepo[0] = "20800";
		arrayRepo[1] = "7351";
		arrayRepo[2] = "3951";
		arrayRepo[3] = "2255";
		arrayRepo[4] = "1671";
		arrayRepo[5] = "1193";
		arrayRepo[6] = "886";
		arrayRepo[7] = "672";
		arrayRepo[8] = "572";
		arrayRepo[9] = "440";
		arrayRepo[10] = "337";
		arrayRepo[11] = "298";
		arrayRepo[12] = "252";
		arrayRepo[13] = "208";
		arrayRepo[14] = "195";
		arrayRepo[15] = "194";
		arrayRepo[16] = "161";
		arrayRepo[17] = "119";
		arrayRepo[18] = "105";
		arrayRepo[19] = "1349";
		
		int totalCountRepo = 0;
		*/
		
		for(int i=0; i<arrayRepo.length; i++) {
			totalCountRepo+= Integer.parseInt(arrayRepo[i]);
		}
		
		
		request.setAttribute("totalCountRepo", totalCountRepo);
		request.setAttribute("arrayRepo", arrayRepo);		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/starDistribution.jsp");
        dispatcher.forward(request,response);
        
		//response.sendRedirect("./pages/starDistribution.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}
}
