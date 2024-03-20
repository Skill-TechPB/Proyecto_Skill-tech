/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author olthek
 */
@WebServlet(urlPatterns = {"/gen"})
public class gen extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true); 
        String gene = request.getParameter("gene");
        String gene1 = request.getParameter("gene1");
        String gene2 = request.getParameter("gene2");
        System.out.println(gene);
        System.out.println(gene1);
        System.out.println(gene2);
        if(gene!=null && gene2==null && gene2==null){
        session.setAttribute("generacion",gene);
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("graficasgen.jsp");
        } else if(gene1!=null && gene==null && gene2==null){
        session.setAttribute("generacion",gene1);
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("graficasgen.jsp");
        }else if(gene2!=null && gene==null && gene1==null){
        session.setAttribute("generacion",gene2);
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("graficasgen.jsp");
        }else{
            System.out.println("ME ESTOY SALTANDO EL IF");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
