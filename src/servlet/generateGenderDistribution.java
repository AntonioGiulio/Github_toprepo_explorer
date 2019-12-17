package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/generateGenderDistribution")
public class generateGenderDistribution extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	public generateGenderDistribution() {
		super();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession s = request.getSession();
		
		int totalCountUser = 22500;
		int countFemale = 948;
		int countMale = totalCountUser - countFemale;
		
		request.setAttribute("totalCountUser", totalCountUser);
		request.setAttribute("countFemale", countFemale);
		request.setAttribute("countMale", countMale);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/genderDistribution.jsp");
        dispatcher.forward(request,response);
		//response.sendRedirect("./pages/starDistribution.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		doGet(request, response);
	}
}
