package com.welcomeToJeju.wtj.domain;

import java.util.ArrayList;
import java.util.List;

public class Place {

  private String id;
  private String place_name;
  private String address_name;

  private List<PlacePhoto> photos = new ArrayList<>();
  private List<PlaceComment> comments = new ArrayList<>();
  private List<Theme> themeList = new ArrayList<>();

  private String x;
  private String y;

  @Override
  public String toString() {
    return "Place [id=" + id + ", place_name=" + place_name + ", address_name=" + address_name
        + ", photos=" + photos + ", comments=" + comments + ", themeList=" + themeList + ", x=" + x
        + ", y=" + y + "]";
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getPlace_name() {
    return place_name;
  }

  public void setPlace_name(String place_name) {
    this.place_name = place_name;
  }

  public String getAddress_name() {
    return address_name;
  }

  public void setAddress_name(String address_name) {
    this.address_name = address_name;
  }

  public List<PlacePhoto> getPhotos() {
    return photos;
  }

  public void setPhotos(List<PlacePhoto> photos) {
    this.photos = photos;
  }

  public List<PlaceComment> getComments() {
    return comments;
  }

  public void setComments(List<PlaceComment> comments) {
    this.comments = comments;
  }

  public List<Theme> getThemeList() {
    return themeList;
  }

  public void setThemeList(List<Theme> themeList) {
    this.themeList = themeList;
  }

  public String getX() {
    return x;
  }

  public void setX(String x) {
    this.x = x;
  }

  public String getY() {
    return y;
  }

  public void setY(String y) {
    this.y = y;
  }


}
