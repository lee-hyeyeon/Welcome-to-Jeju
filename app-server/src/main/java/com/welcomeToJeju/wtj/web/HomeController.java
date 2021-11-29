package com.welcomeToJeju.wtj.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.welcomeToJeju.wtj.dao.PlaceDao;
import com.welcomeToJeju.wtj.dao.PublicThemeDao;
import com.welcomeToJeju.wtj.dao.UserDao;

@Controller
public class HomeController {

  @Autowired PublicThemeDao publicThemeDao;
  @Autowired UserDao userDao;
  @Autowired PlaceDao placeDao;

  @GetMapping("/home")
  public String home(Model model/* , HttpSession session */) throws Exception {
    model.addAttribute("userRanking10", userDao.userRanking10());
    model.addAttribute("placeRaking10", placeDao.placeRanking10());
    model.addAttribute("themeRanking10", publicThemeDao.themeRanking10());
    model.addAttribute("newTheme10", publicThemeDao.newTheme10());
    model.addAttribute("themeList", publicThemeDao.findAllPublicTheme());

    return "home/Home";
  }


}
