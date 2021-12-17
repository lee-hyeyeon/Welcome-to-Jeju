package com.welcomeToJeju.wtj.web.place;

import java.util.Collection;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import com.welcomeToJeju.wtj.dao.PlaceCommentDao;
import com.welcomeToJeju.wtj.dao.PlaceDao;
import com.welcomeToJeju.wtj.dao.PlacePhotoDao;
import com.welcomeToJeju.wtj.dao.ThemeDao;
import com.welcomeToJeju.wtj.domain.Place;
import com.welcomeToJeju.wtj.domain.PlaceComment;
import com.welcomeToJeju.wtj.domain.PlacePhoto;
import com.welcomeToJeju.wtj.domain.Theme;
import com.welcomeToJeju.wtj.domain.User;
import net.coobird.thumbnailator.ThumbnailParameter;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import net.coobird.thumbnailator.name.Rename;

@Controller
public class PlaceController {

  @Autowired PlaceDao placeDao;
  @Autowired PlacePhotoDao placePhotoDao;
  @Autowired ServletContext sc;
  @Autowired PlaceCommentDao placeCommentDao;
  @Autowired ThemeDao themeDao;
  @Autowired SqlSessionFactory sqlSessionFactory;

  @PostMapping("/place/addform")
  public ModelAndView addform(Place place, int no) {
    ModelAndView mv = new ModelAndView();
    mv.addObject("place", place);
    mv.addObject("no", no);
    mv.addObject("pageTitle", "장소 등록하기");
    mv.addObject("contentUrl", "place/PlaceAddForm.jsp");
    mv.setViewName("template_main");
    return mv;
  }

  @PostMapping("/place/add")
  public ModelAndView add(Place place, Part photoFile, String comment,
      HttpSession session, int no) throws Exception{

    User user = (User) session.getAttribute("loginUser");

    if (placeDao.findById(place.getId()) == null) {
      placeDao.insert(place);

      HashMap<String,Object> placeParam = new HashMap<>();
      placeParam.put("placeId", place.getId());
      placeParam.put("userNo", user.getNo());
      placeParam.put("themeNo", no);
      placeDao.insertPlaceUserTheme(placeParam);
    }

    if (photoFile.getSize() > 0) {
      String filename = UUID.randomUUID().toString();
      photoFile.write(sc.getRealPath("/upload/place") + "/" + filename);

      Thumbnails.of(sc.getRealPath("/upload/place") + "/" + filename)
      .size(20, 20)
      .outputFormat("jpg")
      .crop(Positions.CENTER)
      .toFiles(new Rename() {
        @Override
        public String apply(String name, ThumbnailParameter param) {
          return name + "_20x20";
        }
      });

      Thumbnails.of(sc.getRealPath("/upload/place") + "/" + filename)
      .size(100, 100)
      .outputFormat("jpg")
      .crop(Positions.CENTER)
      .toFiles(new Rename() {
        @Override
        public String apply(String name, ThumbnailParameter param) {
          return name + "_100x100";
        }
      });

      HashMap<String,Object> photoParam = new HashMap<>();
      photoParam.put("filePath", filename);
      photoParam.put("placeId", place.getId());
      photoParam.put("userNo", user.getNo());
      placePhotoDao.insert(photoParam);
    }

    HashMap<String,Object> commentParam = new HashMap<>();
    commentParam.put("comment", comment);
    commentParam.put("placeId", place.getId());
    commentParam.put("userNo", user.getNo());
    placeCommentDao.insert(commentParam);

    sqlSessionFactory.openSession().commit();

    ModelAndView mv = new ModelAndView();
    mv.setViewName("redirect:list?no=" + no);

    return mv;
  }

  @GetMapping("/place/list")
  public ModelAndView list(int no) throws Exception {
    Collection<Place> placeList = placeDao.findAllByThemeNo(no);
    Theme theme = themeDao.findByNo(no);

    ModelAndView mv = new ModelAndView();
    mv.addObject("placeList", placeList);
    mv.addObject("theme", theme);
    mv.addObject("pageTitle", "장소 목록 보기");
    mv.addObject("contentUrl", "place/kakao_map_list.jsp");
    mv.setViewName("template_main");

    return mv;
  }

  @GetMapping("/place/search")
  public ModelAndView place(String keyword, int no) throws Exception {
    ModelAndView mv = new ModelAndView();
    mv.addObject("keyword", keyword);
    mv.addObject("no", no);
    mv.addObject("contentUrl", "place/kakao_map_search.jsp");
    mv.setViewName("template_main");

    return mv;
  }

  @GetMapping("/place/detail")
  public ModelAndView detail(String id, int no) throws Exception {
    Place place = placeDao.findById(id);
    Collection<PlacePhoto> photoList = placePhotoDao.findAllByPlaceId(id);
    Collection<PlaceComment> commentList = placeCommentDao.findAllByPlaceId(id);

    ModelAndView mv = new ModelAndView();
    mv.addObject("place", place);
    mv.addObject("photoList", photoList);
    mv.addObject("commentList", commentList);
    mv.addObject("no", no);
    mv.addObject("pageTitle", "장소 상세 보기");
    mv.addObject("contentUrl", "place/PlaceDetail.jsp");
    mv.setViewName("template_main");

    return mv;
  }

  @GetMapping("/place/delete")
  public ModelAndView delete(String id, int no) throws Exception {
    HashMap<String,Object> param = new HashMap<>();
    param.put("placeId", id);
    param.put("themeNo", no);
    placeDao.deletePlaceUserTheme(param);
    sqlSessionFactory.openSession().commit();

    ModelAndView mv = new ModelAndView();
    mv.setViewName("redirect:list?no=" + no);

    return mv;
  }


}
