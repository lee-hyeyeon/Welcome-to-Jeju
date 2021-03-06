
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true" %>
    
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>    
    
<style>
	.card-container{
		display : flex;
		justify-content: center;
		padding: var(--font-great) 0 ;
	}
	
	.btn{
	float:left;
	margin-left: 20px;
	margin-right: 20px;
	}
	
</style>

<div class="card-container">
  <div class="card align-middle" style="width:20rem; border-radius:20px;">
    <div class="card-title" style="margin-top:30px;">
      <h2 class="card-title text-center" style="color:#113366;">๐ ๋ก๊ทธ์ธํ๊ธฐ</h2>
    </div>
    <div class="card-body">
      <form id = "form-signin" class="form-signin" action='../auth/login' method="POST" onSubmit="logincall();return false">
        <h5 class="form-signin-heading">๋ก๊ทธ์ธ ์ ๋ณด๋ฅผ ์๋ ฅํ์ธ์</h5>
        <label for="inputEmail" class="sr-only">์ด๋ฉ์ผ</label>
        <input id='f-email' type='email' name='email' value="${cookie.email.value}" class="form-control" placeholder="Your ID" required autofocus><BR>
        
        <label for="inputPassword" class="sr-only">์ํธ</label>
        <input type="password" id="f-password" name = "password" class="form-control" placeholder="Password" required><br>
        
        <div class="checkbox">
          <label>
            <input type="checkbox" name="saveEmail" ${not empty cookie.email ? "checked":""}/> ์ด๋ฉ์ผ ์ ์ฅ
          </label>
        </div>
        <br>
        <button id="btn-Yes" class="btn btn-lg btn-primary btn-block" type="submit" style="color : #ffff; background-color:#F6BB43; border:none;">๋ก ๊ทธ ์ธ</button>
    </form>
      <form class="form-signin" action='../user/addform'>
        <button id="btn-Yes" class="btn btn-lg btn-primary btn-block" type="submit" style="color : #ffff; background-color:#F6BB43; border:none;">ํ์๊ฐ์</button><br>
     </form>
     <br>
      <!-- ๋ค์ด๋ฒ ๋ก๊ทธ์ธ ํ๋ฉด์ผ๋ก ์ด๋ ์ํค๋ URL -->
      <!-- ๋ค์ด๋ฒ ๋ก๊ทธ์ธ ํ๋ฉด์์ ID, PW๋ฅผ ์ฌ๋ฐ๋ฅด๊ฒ ์๋ ฅํ๋ฉด callback ๋ฉ์๋ ์คํ ์์ฒญ -->
      <div id="naver_id_login" style="text-align:center"><a href="${url}">
        <img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
      </div>
</div>

  <div class="modal">
  </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> 
  </div>
  </body>
