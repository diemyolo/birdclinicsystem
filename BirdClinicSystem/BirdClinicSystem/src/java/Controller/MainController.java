/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = "/main")
public class MainController extends HttpServlet {

    private String url = "errorpage.html";

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            switch (action) {
                //bao
                case "Login":
                    url = "LoginServlet";
                    break;
                case "Signup":
                    url = "SignUpServlet";
                    break;
                case "ResetPassword":
                    url = "ResetPasswordServlet";
                    break;
                case "ForgotPassword":
                    url = "ForgotPasswordServlet";
                    break;
                case "Go to Change Password":
                    url = "change-password";
                    break;
                case "Change Password":
                    url = "ChangePasswordServlet";
                    break;
                case "Search Doctor":
                    url = "SearchDoctorServlet";
                    break;
                case "AddInvoice":
                    url = "AddInvoiceServlet";
                    break;
                case "Go to invoice":
                    url = "GetInvoiceServlet";
                    break;
                case "registerSendMail":
                    url = "RegisterSendMailServlet";
                    break;
                case "verifyMail":
                    url = "VerifyMailServlet";
                    break;
                case "SaveFeedback":
                    url = "FeedbackSaveServlet";
                    break;
                //diem
                case "searchService":
                    url = "SearchServiceServlet";
                    break;
                case "searchServiceStaff":
                    url = "SearchServiceServlet";
                    break;
                case "getBirdsNameAsc":
                    url = "GetBirdsNameAscServlet";
                    break;
                case "getBirdsNameDesc":
                    url = "GetBirdsNameDescServlet";
                    break;
                case "getBirdsAgeAsc":
                    url = "GetBirdsAgeAscServlet";
                    break;
                case "getBirdsAgeDesc":
                    url = "GetBirdsAgeDescServlet";
                    break;
                case "editbird":
                    url = "UpdateBirdServlet";
                    break;
                case "hideBird":
                    url = "HideBirdServlet";
                    break;
                case "addbird":
                    url = "addBirdServlet";
                    break;
                case "getUnhiddenBirds":
                    url = "GetUnhiddenBirdsServlet";
                    break;
                case "getAllBirds":
                    url = "GetAllBirdsServlet";
                    break;
                case "searchMedicine":
                    url = "SearchMedicineServlet";
                    break;
                case "editMedicine":
                    url = "UpdateMedicineServlet";
                    break;
                case "New Medicine":
                    url = "Staff_AddMedicine.jsp";
                    break;
                case "addMedicine":
                    url = "AddMedicineServlet";
                    break;
                case "viewPaginatedDoctor":
                    url = "ShowPaginatedDoctorServlet";
                    break;
                case "checkBirdAvailable":
                    url = "CheckBirdAvailableServlet";
                    break;
                case "Add Med Category":
                    url = "AddMedicineCategoryServlet";
                    break;
                case "ChangeDoctorSalary":
                    url = "ChangeDoctorSalaryServlet";
                    break;
                //kien
                case "ChangeCustomerProfile":
                    url = "ChangeProfileServlet";
                    break;
                case "ChangeAdminProfile":
                    url = "ChangeProfileAdminServlet";
                    break;
                case "userProfile":
                    url = "user-profile";
                    break;
                case "AppointmentList":
                    url = "AppointmentListServlet";
                    break;
                case "CustomerAppointmentList":
                    url = "CustomerAppointmentListServlet";
                    break;
                case "InvoiceList":
                    url = "InvoiceListServlet";
                    break;
                case "CustomerList":
                    url = "CustomerListServlet";
                    break;
                case "StaffList":
                    url = "StaffListServlet";
                    break;
                case "DoctorList":
                    url = "DoctorListServlet";
                    break;
                case "UpdateStatus":
                    url = "UpdateUserStatusServlet";
                    break;
                case "SwitchDoctorSchedule":
                    url = "SwitchDoctorScheduleServlet";
                    break;
                //dang
                case "Logout":
                    url = "LogoutServlet";
                    break;
                case "ChangePass":
                    url = "change-password";
                    break;
                case "ChangeStaffProfile":
                    url = "ChangeProfileStaffServlet";
                    break;
                case "ChangeDoctorProfile":
                    url = "ChangeProfileDoctorServlet";
                    break;
                //suong
                case "doctor_page":
                    url = "ViewDoctorServlet";
                    break;
                case "switchCalendar":
                    url = "SwitchCalendarServlet";
                    break;
                case "finishSchedule":
                    url = "GoToFinishdetailsServlet";
                    break;
                case "finishDetail":
                    url = "GoToComfirmationServlet";
                    break;
                case "finishComfirmation":
                    url = "BookingCompletedServlet";
                    break;
                case "searchAppDoctor":
                    url="SearchAppDoctorServlet";
                    break;
                case "BookingCompleteRel":
                    url = "BookingCompleteRelServlet";
                    break;
                case "cancelApp":
                    url = "cancelAppServlet";
                    break;
                case "rescheduleApp":
                    url = "rescheduleAppServlet";
                    break;
                case "filterApp":
                    url = "FilterAppServlet";
                    break;
                case "cancelFromAppDetail":
                    url = "CancelFromAppDetailServlet";
                    break;
                default:
                    url = "errorpage.html";
                    break;
            }

            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
