import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>Struts Admin Test</title></head>");
        out.println("<body>");
        out.println("<h1>Struts Admin Dashboard - Test Page</h1>");
        out.println("<p>Server is running successfully!</p>");
        out.println("<p><a href='/login'>Go to Login</a></p>");
        out.println("</body>");
        out.println("</html>");
    }
}