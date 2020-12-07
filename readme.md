# **🐶 슬기로운 반려생활 - 반려동물 관리/SNS Project**


## **프로젝트 설명**


### **기획 의도**

- 반려동물과 함께 하는 사람이 천오백만인 시대, 사랑하는 반려동물의 건강/일정 등을 관리하고 함께한 추억을 기록하고 다른 사람들과 함께 나눌 수 있는 서비스를 만들고자 하였습니다.


### **구성**

- **FrontEnd**
    - **JSP**기반으로 디자인은 **Bootstrap**을, DOM 제어 및 AJAX 호출은 **JQuery**를 사용하였습니다.
- **BackEnd**
    - **Spring FrameWork**를 기반으로 하였고 SQL Mapper로 **Mybatis**를 사용하여 연계하였습니다.
- **DB & Server**
	- DB는 관계형 데이터베이스인 **MySql**을 사용하였습니다.
    - Server는 Web Server로 Apache를, WAS로는 Tomcat를 사용하였습니다.


### 기능

- 로그인/인증
	- Spring Security로 인증/권한 처리 
	- api를 활용해 소셜로그인/회원가입 
    - JavaMail를 이용, 메일인증
- 메인화면
	- 날씨/지도 api를 활용하여 위치기반 산책지수 
    - 위치/품종/나이 등에 따른 동물친구 알고리즘
- 반려동물 관리
	- Full Calendar 라이브러리를 활용한 나의 동물 스케쥴러
    - html5 geoloaction/지도 api를 활용한 내 근처 동물병원 찾기 구현
- 반려동물 블로그
	- 반려동물 팔로우/좋아요 시스템
    - 유저 및 반려동물 기준으로 내 블로그
    - ckeditor 라이브러리 활용, 텍스트 에디터 및 이미지 dnd 첨부
- 기부게시판
	- 결제 api를 활용, 기부포인트 결제
    - mysql 스케쥴러를 활용, 기부완료 내역 관리

## etc.

- [http://spring.taepd.p-e.kr/](http://spring.taepd.p-e.kr/) 에서 본 프로젝트를 직접 테스트해 볼 수 있습니다.
- 프로젝트에 대한 보다 자세한 설명은 (링크 추가할 것)에 있습니다.
