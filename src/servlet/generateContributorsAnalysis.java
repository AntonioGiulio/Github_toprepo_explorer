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

import org.json.JSONException;

import newCore.RequestGenerator;

@WebServlet("/generateContributorsAnalysis")
public class generateContributorsAnalysis extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
    public generateContributorsAnalysis() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/contributorsAnalysis.jsp");
	        dispatcher.forward(request,response);
					
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
