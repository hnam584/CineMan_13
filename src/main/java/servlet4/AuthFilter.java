package servlet4;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model4.Member4;

/**
 * Phân quyền theo 2 modul:
 *  - MANAGER  : modul 1 (quản lý phim)
 *  - CUSTOMER : modul 2 (mua vé trực tuyến)
 *  - SALES_STAFF : chỉ vào trang chính (chức năng bán vé tại quầy chưa cài đặt)
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    private static boolean isPublic(String path) {
        return path.equals("/login")
                || path.equals("/logout")
                || path.equals("/LoginInterface4.jsp")
                || path.equals("/index.jsp")
                || path.equals("/favicon.ico")
                || path.isEmpty()
                || path.equals("/");
    }

    private static boolean isManagerPath(String path) {
        return path.equals("/manage-movies")
                || path.equals("/add-movie")
                || path.equals("/ManageMovieInterface4.jsp")
                || path.equals("/AddMovieInterface4.jsp");
    }

    private static boolean isCustomerPath(String path) {
        return path.equals("/movies")
                || path.equals("/showtimes")
                || path.equals("/seats")
                || path.equals("/payment")
                || path.equals("/invoice")
                || path.equals("/ListMovieInterface4.jsp")
                || path.equals("/ShowtimeInterface4.jsp")
                || path.equals("/SeatInterface4.jsp")
                || path.equals("/PaymentInterface4.jsp")
                || path.equals("/ExportInvoiceInterface4.jsp");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        if (isPublic(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        Member4 member = session == null ? null : (Member4) session.getAttribute("member");

        if (member == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        boolean manager = "MANAGER".equals(member.getRole());
        boolean customer = "CUSTOMER".equals(member.getRole());

        if (isManagerPath(path) && !manager) {
            resp.sendRedirect(req.getContextPath() + "/CinemaInterface4.jsp");
            return;
        }

        if (isCustomerPath(path) && !customer) {
            resp.sendRedirect(req.getContextPath() + "/CinemaInterface4.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
