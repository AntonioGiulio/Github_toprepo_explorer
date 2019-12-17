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



@WebServlet("/generateCreationDateDistribution")
public class generateCreationDateDistribution extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	public generateCreationDateDistribution() {
		super();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession s = request.getSession();
		
		boolean lockResourceCreationDate=false;
		if(s.getAttribute("lockResourceCreationDate")!=null) {
			System.out.println("Inizio -> Attributo in sessione:" + s.getAttribute("lockResourceCreationDate"));
		}
		
		System.out.println("Entro nel while -> Attributo in sessione:" + s.getAttribute("lockResourceCreationDate"));
		while(true) {
			if(s.getAttribute("lockResourceCreationDate") != null) {
				lockResourceCreationDate = (boolean) s.getAttribute("lockResourceCreationDate");
			}
			
			//se la risorsa è occupata (lockResource=true) aspetto 60 secondi, altrimenti esco dal while e procedo con l'esecuzione
			if(lockResourceCreationDate) {
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
		System.out.println("Esco dal while -> Attributo in sessione:" + s.getAttribute("lockResourceCreationDate"));
		
		RequestGenerator reqGen = new RequestGenerator("repositories", "tulipano96", "a865f57b6adf6f54e335b43b905d8783e948ef4c");
		List<String> list = new ArrayList<String>();
		String[] arrayRepo;
		int totalCountRepo = 0;
		
		
		
		//otteniamo la lista
		try {
			s.setAttribute("lockResourceCreationDate", true);
			System.out.println("Eseguo API -> Attributo in sessione:" + s.getAttribute("lockResourceCreationDate"));
			list = reqGen.searchDistributionByCreationDate();
			s.setAttribute("lockResourceCreationDate", false);
		} catch (JSONException e) {
			s.setAttribute("lockResourceCreationDate", false);
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
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/creationDateDistribution.jsp");
        dispatcher.forward(request,response);
        
		//response.sendRedirect("./pages/starDistribution.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}
}
