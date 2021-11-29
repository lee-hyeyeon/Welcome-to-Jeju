package com.welcomeToJeju.wtj.servlet.theme.myTheme;

import java.io.IOException;
import java.util.Collection;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.welcomeToJeju.wtj.dao.PublicThemeDao;
import com.welcomeToJeju.wtj.dao.UserDao;
import com.welcomeToJeju.wtj.domain.Theme;
import com.welcomeToJeju.wtj.domain.User;

@WebServlet("/mytheme/list")
public class MyThemeListController extends HttpServlet {
  private static final long serialVersionUID = 1L;

  HttpSession httpSession;
  PublicThemeDao publicThemeDao;
  UserDao userDao;

  @Override
  public void init(ServletConfig config) throws ServletException {
    ServletContext 웹애플리케이션공용저장소 = config.getServletContext();
    publicThemeDao = (PublicThemeDao) 웹애플리케이션공용저장소.getAttribute("themeDao");
    userDao = (UserDao) 웹애플리케이션공용저장소.getAttribute("userDao");
  }


  @Override
  protected void service(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    //    httpSession = request.getSession(true);
    //    User loginUser = (User) httpSession.getAttribute("loginUser");
    //    System.out.println(loginUser);

    User loginUser = (User) request.getSession(true).getAttribute("loginUser");

    try {

      Collection<Theme> themeList = publicThemeDao.findByUserNo(loginUser.getNo());

      request.setAttribute("myThemeList", themeList);
      request.setAttribute("pageTitle", "나의 테마 목록보기");
      request.setAttribute("contentUrl", "/theme/myTheme/MyThemeList.jsp");
      request.getRequestDispatcher("/template_main.jsp").forward(request, response);

    } catch (Exception e){
      request.setAttribute("error", e);
      request.getRequestDispatcher("/Error.jsp").forward(request, response);
    }
  }


}
