-- 유저
DROP TABLE IF EXISTS jeju_user RESTRICT;

-- 테마
DROP TABLE IF EXISTS jeju_theme RESTRICT;

-- 장소
DROP TABLE IF EXISTS jeju_place RESTRICT;

-- 좋아하는유저
DROP TABLE IF EXISTS jeju_liked_user RESTRICT;

-- 좋아하는테마
DROP TABLE IF EXISTS jeju_liked_theme RESTRICT;

-- 장소사진
DROP TABLE IF EXISTS jeju_place_photo RESTRICT;

-- 장소후기
DROP TABLE IF EXISTS jeju_place_comment RESTRICT;

-- 카테고리
DROP TABLE IF EXISTS jeju_theme_category RESTRICT;

-- 장소_유저_테마
DROP TABLE IF EXISTS jeju_place_user_theme RESTRICT;

-- 게시판
DROP TABLE IF EXISTS jeju_board RESTRICT;

-- 게시판댓글
DROP TABLE IF EXISTS jeju_board_comment RESTRICT;

-- 유저
CREATE TABLE jeju_user (
  user_no    INTEGER      NOT NULL COMMENT '유저번호', -- 유저번호
  email      VARCHAR(255) NOT NULL COMMENT '이메일', -- 이메일
  password   VARCHAR(100) NULL     COMMENT '비밀번호', -- 비밀번호
  nickname   VARCHAR(30)  NULL     COMMENT '닉네임', -- 닉네임
  created_dt DATE         NOT NULL DEFAULT curdate() COMMENT '등록일', -- 등록일
  view_cnt   INTEGER      NULL     DEFAULT 0 COMMENT '조회수', -- 조회수
  active     INTEGER      NULL     DEFAULT 1 COMMENT '탈퇴', -- 탈퇴
  emoji      VARCHAR(255) NULL     COMMENT '이모지' -- 이모지
)
COMMENT '유저';

-- 유저
ALTER TABLE jeju_user
  ADD CONSTRAINT PK_jeju_user -- 유저 기본키
    PRIMARY KEY (
      user_no -- 유저번호
    );

-- 유저 유니크 인덱스
CREATE UNIQUE INDEX UIX_jeju_user
  ON jeju_user ( -- 유저
    email ASC,    -- 이메일
    nickname ASC  -- 닉네임
  );

ALTER TABLE jeju_user
  MODIFY COLUMN user_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '유저번호';

-- 테마
CREATE TABLE jeju_theme (
  theme_no    INTEGER      NOT NULL COMMENT '테마번호', -- 테마번호
  user_no     INTEGER      NOT NULL COMMENT '유저번호', -- 유저번호
  category_no INTEGER      NOT NULL COMMENT '카테고리번호', -- 카테고리번호
  title       VARCHAR(255) NOT NULL COMMENT '제목', -- 제목
  public      INTEGER      NOT NULL DEFAULT 1 COMMENT '공개여부', -- 공개여부
  share       INTEGER      NOT NULL COMMENT '공유여부', -- 공유여부
  created_dt  DATE         NOT NULL DEFAULT curdate() COMMENT '등록일', -- 등록일
  view_cnt    INTEGER      NULL     DEFAULT 0 COMMENT '조회수', -- 조회수
  emoji       VARCHAR(255) NOT NULL COMMENT '이모지' -- 이모지
)
COMMENT '테마';

-- 테마
ALTER TABLE jeju_theme
  ADD CONSTRAINT PK_jeju_theme -- 테마 기본키
    PRIMARY KEY (
      theme_no -- 테마번호
    );

ALTER TABLE jeju_theme
  MODIFY COLUMN theme_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '테마번호';

-- 장소
CREATE TABLE jeju_place (
  place_id      VARCHAR(255) NOT NULL COMMENT '장소번호', -- 장소번호
  place_name    VARCHAR(50)  NOT NULL COMMENT '장소이름', -- 장소이름
  place_address VARCHAR(255) NOT NULL COMMENT '장소주소', -- 장소주소
  x_coord       DOUBLE       NOT NULL COMMENT '위도', -- 위도
  y_coord       DOUBLE       NOT NULL COMMENT '경도' -- 경도
)
COMMENT '장소';

-- 장소
ALTER TABLE jeju_place
  ADD CONSTRAINT PK_jeju_place -- 장소 기본키
    PRIMARY KEY (
      place_id -- 장소번호
    );

-- 좋아하는유저
CREATE TABLE jeju_liked_user (
  user_no       INTEGER NOT NULL COMMENT '유저번호', -- 유저번호
  liked_user_no INTEGER NOT NULL COMMENT '좋아하는유저' -- 좋아하는유저
)
COMMENT '좋아하는유저';

-- 좋아하는유저
ALTER TABLE jeju_liked_user
  ADD CONSTRAINT PK_jeju_liked_user -- 좋아하는유저 기본키
    PRIMARY KEY (
      user_no,       -- 유저번호
      liked_user_no  -- 좋아하는유저
    );

-- 좋아하는유저 유니크 인덱스
CREATE UNIQUE INDEX UIX_jeju_liked_user
  ON jeju_liked_user ( -- 좋아하는유저
    user_no ASC,       -- 유저번호
    liked_user_no ASC  -- 좋아하는유저
  );

-- 좋아하는테마
CREATE TABLE jeju_liked_theme (
  theme_no INTEGER NOT NULL COMMENT '테마번호', -- 테마번호
  user_no  INTEGER NOT NULL COMMENT '유저번호' -- 유저번호
)
COMMENT '좋아하는테마';

-- 좋아하는테마
ALTER TABLE jeju_liked_theme
  ADD CONSTRAINT PK_jeju_liked_theme -- 좋아하는테마 기본키
    PRIMARY KEY (
      theme_no, -- 테마번호
      user_no   -- 유저번호
    );

-- 장소사진
CREATE TABLE jeju_place_photo (
  place_photo_no INTEGER      NOT NULL COMMENT '장소사진번호', -- 장소사진번호
  place_id       VARCHAR(255) NOT NULL COMMENT '장소번호', -- 장소번호
  user_no        INTEGER      NOT NULL COMMENT '유저번호', -- 유저번호
  file_path      VARCHAR(255) NOT NULL COMMENT '장소사진' -- 장소사진
)
COMMENT '장소사진';

-- 장소사진
ALTER TABLE jeju_place_photo
  ADD CONSTRAINT PK_jeju_place_photo -- 장소사진 기본키
    PRIMARY KEY (
      place_photo_no -- 장소사진번호
    );

ALTER TABLE jeju_place_photo
  MODIFY COLUMN place_photo_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '장소사진번호';

-- 장소후기
CREATE TABLE jeju_place_comment (
  place_comment_no INTEGER      NOT NULL COMMENT '후기번호', -- 후기번호
  place_id         VARCHAR(255) NOT NULL COMMENT '장소번호', -- 장소번호
  user_no          INTEGER      NOT NULL COMMENT '유저번호', -- 유저번호
  comment          TEXT         NOT NULL COMMENT '장소후기' -- 장소후기
)
COMMENT '장소후기';

-- 장소후기
ALTER TABLE jeju_place_comment
  ADD CONSTRAINT PK_jeju_place_comment -- 장소후기 기본키
    PRIMARY KEY (
      place_comment_no -- 후기번호
    );

ALTER TABLE jeju_place_comment
  MODIFY COLUMN place_comment_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '후기번호';

-- 카테고리
CREATE TABLE jeju_theme_category (
  category_no INTEGER     NOT NULL COMMENT '카테고리번호', -- 카테고리번호
  name        VARCHAR(50) NOT NULL COMMENT '카테고리' -- 카테고리
)
COMMENT '카테고리';

-- 카테고리
ALTER TABLE jeju_theme_category
  ADD CONSTRAINT PK_jeju_theme_category -- 카테고리 기본키
    PRIMARY KEY (
      category_no -- 카테고리번호
    );

-- 장소_유저_테마
CREATE TABLE jeju_place_user_theme (
  place_id VARCHAR(255) NOT NULL COMMENT '장소번호', -- 장소번호
  user_no  INTEGER      NOT NULL COMMENT '유저번호', -- 유저번호
  theme_no INTEGER      NOT NULL COMMENT '테마번호' -- 테마번호
)
COMMENT '장소_유저_테마';

-- 장소_유저_테마
ALTER TABLE jeju_place_user_theme
  ADD CONSTRAINT PK_jeju_place_user_theme -- 장소_유저_테마 기본키
    PRIMARY KEY (
      place_id, -- 장소번호
      user_no,  -- 유저번호
      theme_no  -- 테마번호
    );

-- 게시판
CREATE TABLE jeju_board (
  board_no   INTEGER      NOT NULL COMMENT '게시글번호', -- 게시글번호
  user_no    INTEGER      NOT NULL COMMENT '유저번호', -- 유저번호
  title      VARCHAR(255) NOT NULL COMMENT '제목', -- 제목
  content    TEXT         NOT NULL COMMENT '내용', -- 내용
  created_dt DATETIME     NOT NULL DEFAULT now() COMMENT '등록일', -- 등록일
  view_cnt   INTEGER      NULL     DEFAULT 0 COMMENT '조회수' -- 조회수
)
COMMENT '게시판';

-- 게시판
ALTER TABLE jeju_board
  ADD CONSTRAINT PK_jeju_board -- 게시판 기본키
    PRIMARY KEY (
      board_no -- 게시글번호
    );

ALTER TABLE jeju_board
  MODIFY COLUMN board_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '게시글번호';

-- 게시판댓글
CREATE TABLE jeju_board_comment (
  board_comment_no INTEGER  NOT NULL COMMENT '게시글댓글번호', -- 게시글댓글번호
  board_no         INTEGER  NOT NULL COMMENT '게시글번호', -- 게시글번호
  user_no          INTEGER  NOT NULL COMMENT '유저번호', -- 유저번호
  content          TEXT     NOT NULL COMMENT '내용', -- 내용
  created_dt       DATETIME NOT NULL DEFAULT now() COMMENT '작성일' -- 작성일
)
COMMENT '게시판댓글';

-- 게시판댓글
ALTER TABLE jeju_board_comment
  ADD CONSTRAINT PK_jeju_board_comment -- 게시판댓글 기본키
    PRIMARY KEY (
      board_comment_no -- 게시글댓글번호
    );

ALTER TABLE jeju_board_comment
  MODIFY COLUMN board_comment_no INTEGER NOT NULL AUTO_INCREMENT COMMENT '게시글댓글번호';

-- 테마
ALTER TABLE jeju_theme
  ADD CONSTRAINT FK_jeju_user_TO_jeju_theme -- 유저 -> 테마
    FOREIGN KEY (
      user_no -- 유저번호
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 테마
ALTER TABLE jeju_theme
  ADD CONSTRAINT FK_jeju_theme_category_TO_jeju_theme -- 카테고리 -> 테마
    FOREIGN KEY (
      category_no -- 카테고리번호
    )
    REFERENCES jeju_theme_category ( -- 카테고리
      category_no -- 카테고리번호
    );

-- 좋아하는유저
ALTER TABLE jeju_liked_user
  ADD CONSTRAINT FK_jeju_user_TO_jeju_liked_user -- 유저 -> 좋아하는유저
    FOREIGN KEY (
      user_no -- 유저번호
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 좋아하는유저
ALTER TABLE jeju_liked_user
  ADD CONSTRAINT FK_jeju_user_TO_jeju_liked_user2 -- 유저 -> 좋아하는유저2
    FOREIGN KEY (
      liked_user_no -- 좋아하는유저
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 좋아하는테마
ALTER TABLE jeju_liked_theme
  ADD CONSTRAINT FK_jeju_user_TO_jeju_liked_theme -- 유저 -> 좋아하는테마
    FOREIGN KEY (
      user_no -- 유저번호
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 좋아하는테마
ALTER TABLE jeju_liked_theme
  ADD CONSTRAINT FK_jeju_theme_TO_jeju_liked_theme -- 테마 -> 좋아하는테마
    FOREIGN KEY (
      theme_no -- 테마번호
    )
    REFERENCES jeju_theme ( -- 테마
      theme_no -- 테마번호
    );

-- 장소사진
ALTER TABLE jeju_place_photo
  ADD CONSTRAINT FK_jeju_place_TO_jeju_place_photo -- 장소 -> 장소사진
    FOREIGN KEY (
      place_id -- 장소번호
    )
    REFERENCES jeju_place ( -- 장소
      place_id -- 장소번호
    );

-- 장소사진
ALTER TABLE jeju_place_photo
  ADD CONSTRAINT FK_jeju_user_TO_jeju_place_photo -- 유저 -> 장소사진
    FOREIGN KEY (
      user_no -- 유저번호
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 장소후기
ALTER TABLE jeju_place_comment
  ADD CONSTRAINT FK_jeju_place_TO_jeju_place_comment -- 장소 -> 장소후기
    FOREIGN KEY (
      place_id -- 장소번호
    )
    REFERENCES jeju_place ( -- 장소
      place_id -- 장소번호
    );

-- 장소후기
ALTER TABLE jeju_place_comment
  ADD CONSTRAINT FK_jeju_user_TO_jeju_place_comment -- 유저 -> 장소후기
    FOREIGN KEY (
      user_no -- 유저번호
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 장소_유저_테마
ALTER TABLE jeju_place_user_theme
  ADD CONSTRAINT FK_jeju_theme_TO_jeju_place_user_theme -- 테마 -> 장소_유저_테마
    FOREIGN KEY (
      theme_no -- 테마번호
    )
    REFERENCES jeju_theme ( -- 테마
      theme_no -- 테마번호
    );

-- 장소_유저_테마
ALTER TABLE jeju_place_user_theme
  ADD CONSTRAINT FK_jeju_place_TO_jeju_place_user_theme -- 장소 -> 장소_유저_테마
    FOREIGN KEY (
      place_id -- 장소번호
    )
    REFERENCES jeju_place ( -- 장소
      place_id -- 장소번호
    );

-- 장소_유저_테마
ALTER TABLE jeju_place_user_theme
  ADD CONSTRAINT FK_jeju_user_TO_jeju_place_user_theme -- 유저 -> 장소_유저_테마
    FOREIGN KEY (
      user_no -- 유저번호
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 게시판
ALTER TABLE jeju_board
  ADD CONSTRAINT FK_jeju_user_TO_jeju_board -- 유저 -> 게시판
    FOREIGN KEY (
      user_no -- 유저번호
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 게시판댓글
ALTER TABLE jeju_board_comment
  ADD CONSTRAINT FK_jeju_user_TO_jeju_board_comment -- 유저 -> 게시판댓글
    FOREIGN KEY (
      user_no -- 유저번호
    )
    REFERENCES jeju_user ( -- 유저
      user_no -- 유저번호
    );

-- 게시판댓글
ALTER TABLE jeju_board_comment
  ADD CONSTRAINT FK_jeju_board_TO_jeju_board_comment -- 게시판 -> 게시판댓글
    FOREIGN KEY (
      board_no -- 게시글번호
    )
    REFERENCES jeju_board ( -- 게시판
      board_no -- 게시글번호
    );