/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.DoctorDAO;
import DAO.SlotDAO;
import DTO.Appointments;
import DTO.Doctor;
import DTO.Slot;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class SearchDoctorServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.print("Haha");
            String keyword = request.getParameter("keyword");
            String chooseBy = request.getParameter("chooseBy");

            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String status = request.getParameter("status");

            SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy");
            Calendar calendar = Calendar.getInstance();

            if (keyword == null) {
                keyword = "";
            }
            if (chooseBy == null) {
                chooseBy = "";
            }
            if (startDate == null) {
                calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                Date firstDateOfWeek = calendar.getTime();
                startDate = dateFormat.format(firstDateOfWeek);

                request.setAttribute("startDate", null);
            } else {
                request.setAttribute("startDate", startDate);
            }
            if (endDate == null) {
                calendar.add(Calendar.DATE, 6);
                Date lastDateOfWeek = calendar.getTime();
                endDate = dateFormat.format(lastDateOfWeek);

                request.setAttribute("startDate", null);
            } else {
                request.setAttribute("endDate", endDate);
            }

//                        out.println(keyword + " " + chooseBy + " " +  startDate + " " +  endDate + " " + status);
//            out.print(startDate + " " + endDate);
            List<Doctor> doctorList = new ArrayList<>();

            switch (chooseBy) {
                case "id":
                    doctorList = DoctorDAO.getDoctorListByID(keyword);
                    break;
                case "name":
                    doctorList = DoctorDAO.getDoctorListByName(keyword);
                    break;
                default:
                    doctorList = DoctorDAO.getDoctorListByID("");
                    break;
            }

            //<Doctor ID, Appointmennt.AppointDate>
            HashMap<String, List<String>> appointmentDateHashMap = new HashMap<>();

            //<Appointment Date, Slot>
            HashMap<String, List<Slot>> slotHashMap = new HashMap<>();

            //<Doctor ID, status>
            HashMap<String, Integer> doctorStatusHashMap = new HashMap<>();

            for (Doctor d : doctorList) {
                int doctorStatus = 0;

                List<String> appointmentDateList = DoctorDAO.getAppointmentDateList(d.getDocID(), startDate, endDate);
                appointmentDateHashMap.put(d.getDocID(), appointmentDateList);

                for (String appointmentDate : appointmentDateList) {

                    List<Slot> slotList = SlotDAO.getSlotList(d.getDocID(), appointmentDate);

                    slotHashMap.put(appointmentDate, slotList);

                    if (isDoctorHaveShiftAtDate(appointmentDate)) {
                        doctorStatus = checkDoctorStatusTime(slotList);
                    }
                }

                doctorStatusHashMap.put(d.getDocID(), doctorStatus);
//                out.print(doctorStatus);
            }

            request.setAttribute("keyword", keyword);
            request.setAttribute("chooseBy", chooseBy);

            request.setAttribute("status", status);

            request.setAttribute("doctorList", doctorList);
            request.setAttribute("appointmentDateHashMap", appointmentDateHashMap);
            request.setAttribute("slotHashMap", slotHashMap);
            request.setAttribute("doctorStatusHashMap", doctorStatusHashMap);

            request.getRequestDispatcher("StaffDoctorList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static boolean isDoctorHaveShiftAtDate(String appointmentDate) {
        // Get the current date and time
        LocalDateTime currentDateTime = LocalDateTime.now();

        // Check if the current date is appoinntmentDate
        LocalDate currentDate = currentDateTime.toLocalDate();
        LocalDate targetDate = LocalDate.parse(appointmentDate);

        if (!currentDate.equals(targetDate)) {
            return false;
        }

        return true;
    }

    public static int checkDoctorStatusTime(List<Slot> slotList) throws Exception {
        // Get the current date and time
        LocalDateTime currentDateTime = LocalDateTime.now();

        //Get current time
        LocalTime currentTime = currentDateTime.toLocalTime();
        for (Slot slot : slotList) {
            LocalTime startTime = LocalTime.parse(slot.getStartTime());
            LocalTime endTime = LocalTime.parse(slot.getEndTime());
            if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
                return 1;
            }
        }

        return 0;
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
