package com.welcomeToJeju.wtj.handler.place;

import java.util.ArrayList;
import com.welcomeToJeju.wtj.dao.PlaceDao;
import com.welcomeToJeju.wtj.domain.Comment;
import com.welcomeToJeju.wtj.domain.Photo;
import com.welcomeToJeju.wtj.domain.Place;
import com.welcomeToJeju.wtj.domain.Theme;
import com.welcomeToJeju.wtj.handler.Command;
import com.welcomeToJeju.wtj.handler.CommandRequest;

public class PlaceListHandler implements Command {

  PlaceDao placeDao;

  public PlaceListHandler(PlaceDao placeDao) {
    this.placeDao = placeDao;
  }

  @Override
  public void execute(CommandRequest request) throws Exception {
    System.out.println("[장소 목록보기]");

    Theme theme = (Theme) request.getAttribute("theme");
    ArrayList<Place> list = (ArrayList<Place>) placeDao.findAllByThemeNo(theme.getNo());
    System.out.printf("[%s] 테마 제목 > %s\n", theme.getCategory().getName(), theme.getTitle());

    int index = 1;

    for (Place place : list) {
      String filePaths = "";
      String comments = "";
      System.out.printf("<%d>\n", index++);
      System.out.printf("장소 이름 > %s\n", place.getStoreName());
      System.out.printf("장소 주소 > %s\n", place.getStoreAddress());
      System.out.printf("위도 > %s\n", place.getxCoord());
      System.out.printf("경도 > %s\n", place.getyCoord());
      for(Photo p : place.getPhotos()) {
        if(filePaths.length()==0) {
          filePaths += p.getFilePath(); 
          continue;
        }
        filePaths += ", " + p.getFilePath();
      }
      System.out.printf("사진 > %s\n",filePaths);

      for(Comment c : place.getComments()) {
        if(comments.length()==0) {
          comments += c.getComment(); 
          continue;
        }
        comments += ", " + c.getComment();
      }
      System.out.printf("장소 후기 > %s\n", comments);
    }

  }

}