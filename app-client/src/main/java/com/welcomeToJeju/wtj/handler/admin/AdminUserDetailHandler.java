package com.welcomeToJeju.wtj.handler.admin;

import com.welcomeToJeju.util.Prompt;
import com.welcomeToJeju.wtj.dao.UserDao;
import com.welcomeToJeju.wtj.domain.User;
import com.welcomeToJeju.wtj.handler.Command;
import com.welcomeToJeju.wtj.handler.CommandRequest;

public class AdminUserDetailHandler implements Command {

  UserDao userDao;

  public AdminUserDetailHandler(UserDao userDao) {
    this.userDao = userDao;
  }

  @Override
  public void execute(CommandRequest request) throws Exception {
    System.out.println("[회원 상세 보기]");

    //    String nickname = Prompt.inputString("닉네임(취소 : 엔터) > ");
    //
    //    if (nickname.equals("") || nickname.length() == 0) {
    //      System.out.println("회원 상세 보기 취소!");
    //      return;
    //    }

    int no = Prompt.inputInt("번호 > ");

    User user = userDao.findByNo(no);

    if (user == null) {
      System.out.println("회원 없음!");
      return;
    }

    System.out.printf("이메일 > %s\n", user.getEmail());
    System.out.printf("닉네임 > %s\n", user.getNickname());
    System.out.printf("가입일 > %s\n", user.getRegisteredDate());
    System.out.printf("조회수 > %s\n", user.getViewCount());
    System.out.printf("🚨 경고 > %s\n", user.getWarningCount());

    request.setAttribute("user", user);

    String input = Prompt.inputString("수정하기(U) / 삭제하기(D) / 취소(0) > ");

    switch (input) {
      case "U" :
      case "u" :
        request.getRequestDispatcher("/admin/userUpdate").forward(request);
        return;

      case "D" :
      case "d" :
        request.getRequestDispatcher("/admin/userDelete").forward(request);
        return;

      case "0" :
        return;

      default :
        System.out.println("올바르지 않은 명령!");
    }
  }


}
