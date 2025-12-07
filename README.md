<div align="center">

# 📚 온라인 북스토어(책갈피)  
### Spring Boot · MyBatis · Oracle 기반 온라인 도서 판매 플랫폼

<br>


<img src="https://img.shields.io/badge/Java-17-007396?logo=java">
<img src="https://img.shields.io/badge/SpringBoot-2.7-6DB33F?logo=springboot">
<img src="https://img.shields.io/badge/MyBatis-000000">
<img src="https://img.shields.io/badge/Oracle-F80000?logo=oracle">
<img src="https://img.shields.io/badge/JSP-F7DF1E?logo=html5">

<img src="https://img.shields.io/badge/Lombok-FF0000?logo=lombok&logoColor=white">
<img src="https://img.shields.io/badge/Gradle-02303A?logo=gradle&logoColor=white">

<img src="https://img.shields.io/badge/Toss Payments-0055FF">
<img src="https://img.shields.io/badge/GitHub-181717?logo=github&logoColor=white">

<br><br>
</div>

---

## 📖 프로젝트 개요

온라인 북스토어는 **도서 검색, 장바구니, 결제, 주문 관리** 기능을 제공하는  
웹 기반 쇼핑몰 프로젝트입니다.

- 개발 기간 : 1차: `2025.10.13 ~ 2025.10.19`, 2차: `2025.11.13 ~ 2025.11.20`
- 개발 인원 : `7명`  
### 👨‍💻 담당 역할

- 🧑‍🏫 **팀장** — 일정 관리, 업무 분배, 코드 리뷰 및 프로젝트 총괄
- 🗂 **DB 설계** — 유저 테이블 구조 설계
- 🔐 **인증/인가** — 로그인, 소셜 로그인, 이메일 인증
- 👤 **사용자 기능** — 회원가입, 아이디/비밀번호 찾기, 회원탈퇴
- 🛠 **관리자 기능** — 대시보드, 게시물 관리, 주문 내역 관리

- 주요 특징  
  - 🤖 **Google Gemini 기반 챗봇 기능**  
    → 챗봇 기능 구현
  
  - 💳 **Toss Payments API 결제 연동**  
    → 결제 요청 → 승인 API까지 전체 결제 프로세스 구현
  
  - 🔐 **세션 기반 인증 시스템**  
    → 로그인/회원가입, 소셜 로그인(Naver/Google), 권한 구분 처리
  
  - 🛠 **관리자 페이지 구축**  
    → 도서 관리(등록/수정/삭제), 권한 관리, 회원 관리, 게시판 관리, 주문 관리
  
  - 📚 **사용자 커뮤니티 기능**  
    → 리뷰, 댓글, 사용자 게시판, 공지사항 기능 제공

---

## 🛠 기술 스택

| 분야 | 기술 |
|------|-------|
| **Frontend** | <img src="https://img.shields.io/badge/html5-E34F26?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/css-663399?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/jquery-0769AD?style=flat-square&logi=html5&logoColor=white"> |
| **Backend** | <img src="https://img.shields.io/badge/Jsp-FF4000?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/Java-F7DF1E?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/springboot-6DB33F?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/Lombok-4285F4?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/MyBatis-006600?style=flat-square&logi=html5&logoColor=white"> |
| **Database** | <img src="https://img.shields.io/badge/Oracle Database-09476B?style=flat-square&logi=html5&logoColor=white"> |
| **Infra / Server** | <img src="https://img.shields.io/badge/Apache Tomcat-F8DC75?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/GitHub-181717?style=flat-square&logi=html5&logoColor=white"> |
| **API / External Services** | <img src="https://img.shields.io/badge/Toss Payments API-4945FF?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/Google Gemini API-8E75B2?style=flat-square&logi=html5&logoColor=white"> |
| **Build Tool** | <img src="https://img.shields.io/badge/Gradle-02303A?style=flat-square&logi=html5&logoColor=white"> |
| **Tools** | <img src="https://img.shields.io/badge/STS-6DB33F?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/Figma-E73562?style=flat-square&logi=html5&logoColor=white">, <img src="https://img.shields.io/badge/SourceTree-0052CC?style=flat-square&logi=html5&logoColor=white"> |

---

## ✨ 주요 기능

### 🛍 사용자 기능
- 🔎 **도서 검색 / 카테고리별 조회**
- 📚 **도서 상세보기** (리뷰, 평점 포함)
- 🧡 **찜(좋아요) 목록 관리**
- 🛒 **장바구니** (추가, 수량 변경, 삭제)
- 💳 **도서 결제(Toss Payments API)**  
- 📦 **주문 생성 / 주문 내역 조회**

---

### 🔐 회원 기능
- 회원가입 / 로그인 / 로그아웃  
- 소셜 로그인(Naver / Google)  
- 아이디·비밀번호 찾기  
- 마이페이지(조회, 수정, 삭제)  
- 탈퇴 회원 관리  
- 찜한 도서 목록 확인

---

### 💬 커뮤니티 기능
- 사용자 게시판(글 작성, 수정, 조회, 삭제)
- 사용자 공지사항(공지 조회)
- 1대1 문의

---

### 🤖 AI 기능
- **Gemini API 기반 챗봇**  
  - 사용자 질문 자동 응답  

---

### 🛠 관리자 기능
- **회원 관리** (상태 변경, 탈퇴 회원 관리)
- **도서 관리** (등록 / 수정 / 삭제)
- **게시판 관리** (사용자 게시판·공지사항)
- **주문 관리** (주문 리스트, 주문 상세)
- **문의 리스트 관리**

---

### 🚀 기타 기능
- **페이징, 검색**
- **세션 기반 로그인 인증 처리**

---

## 🧭 메뉴 구조도 (PDF)

📄 메뉴 구조도 다운로드  
👉 [menu_structure_online_bookstore.pdf](https://github.com/user-attachments/files/24016562/menu_structure_online_bookstore.pdf)

---

## 🖥 화면 설계서 (PDF)

📄 화면 기획서 보기  
👉 [online-bookstore-ui-design.pdf](https://github.com/user-attachments/files/24016616/online-bookstore-ui-design.pdf)

---

## 🗂 ERD 및 테이블 명세서

📄 ERD  
<details> <summary><strong>ERD 다이어그램</strong></summary>

<img width="1467" height="2106" alt="image" src="https://github.com/user-attachments/assets/443ac567-965d-4d8c-b105-995308a2aff7" />

</details>

📄 테이블 명세서  
👉 [database-table-definition.xlsx](https://github.com/user-attachments/files/24016641/database-table-definition.xlsx)

---

## 🔍 핵심 구현 내용 (내가 담당한 기능)

🔐 회원 / 인증 기능
<details> <summary><strong>회원가입 / 로그인 / 로그아웃</strong></summary>
📌 설명

Spring Security 없이 세션 기반 인증 구현

로그인/로그아웃 전체 흐름 설계

유효성 검사 + 예외 처리 적용

📸 스크린샷

(여기에 이미지 삽입)

</details> <details> <summary><strong>소셜 로그인(Kakao / Naver / Google)</strong></summary>
📌 설명

OAuth2 인증 코드 요청 → 토큰 발급 → 사용자 정보 조회

신규 사용자 자동 DB 등록

기존 계정 연동 처리

📸 스크린샷

(이미지)

</details> <details> <summary><strong>아이디·비밀번호 찾기</strong></summary>
📌 설명

이메일 인증번호 발송

비밀번호 재설정 로직 구현

📸 스크린샷

(이미지)

</details> <details> <summary><strong>탈퇴 회원 관리</strong></summary>
📌 설명

상태값 변경 방식(DELETE X → STATUS 변경)

관리자 페이지에서 조회/관리 가능

📸 스크린샷

(이미지)

</details>
🛠 관리자 기능
<details> <summary><strong>공지사항 게시판 CRUD</strong></summary>
📌 설명

관리자 권한 전용 게시판

작성/수정/삭제/조회 + 첨부 파일 지원 가능 구조

📸 스크린샷

(이미지)

</details> <details> <summary><strong>사용자 게시판 관리</strong></summary>
📌 설명

사용자 게시글 모니터링 및 삭제

신고 기능 염두에 둔 확장성 있는 구조 설계

📸 스크린샷

(이미지)

</details> <details> <summary><strong>주문 관리(주문 리스트 / 주문 상세)</strong></summary>
📌 설명

주문 테이블 + 상세 테이블 조인 조회

배송 상태 관리 등 확장 가능 구조 설계

📸 스크린샷

(이미지)

</details> <details> <summary><strong>탈퇴 회원 관리</strong></summary>
📌 설명

관리자 페이지에서 탈퇴 회원 조회

계정 상태값 기반 필터링 처리

📸 스크린샷

(이미지)

</details>
💬 커뮤니티 기능
<details> <summary><strong>공지사항 조회</strong></summary>
📌 설명

사용자 화면 전용 조회 페이지

조회수 증가 로직 포함

📸 스크린샷

(이미지)

</details>

---

## 📬 프로젝트 구조

```plaintext
📦 boot_bookstore
├─ src/main/java/com.bookstore
│  ├─ controller
│  ├─ service
│  ├─ dao
│  ├─ dto
│  └─ config
├─ src/main/resources
│  ├─ mapper
│  ├─ static
│  └─ templates(JSP)
└─ docs
   ├─ menu-structure.pdf
   ├─ ui-design.pdf
   ├─ erd.pdf
   └─ table-definition.pdf
```

## 🚀 시연 영상 & 데모

아래 영상은 온라인 북스토어(BookShelf)의 주요 기능을 실제 화면과 함께 보여줍니다.  
각 기능별 동작 방식과 흐름을 직관적으로 확인할 수 있습니다.

### 📌 전체 시연 영상
🔗 YouTube 링크: https://youtu.be/your-video-url  

---

## ✨ 기능별 시연

### 🛒 1. 장바구니 기능
- 비로그인 장바구니 유지  
- 로그인 시 DB 장바구니와 병합  
- 수량 변경 / 삭제  
<img src="/docs/demo/cart.gif" width="600"/>

---

### 💳 2. Toss 결제 프로세스
- 결제 준비 → 승인 API 처리  
- 결제 성공 시 주문 자동 생성  
<img src="/docs/demo/payment.gif" width="600"/>

---

### 📦 3. 주문 생성 및 주문 내역 조회
- 주문 상세 페이지  
- 구매 이력 확인  
<img src="/docs/demo/order.gif" width="600"/>

---

### 🛍️ 4. 도서 검색 / 카테고리 조회
- 키워드 기반 검색  
- 카테고리 필터  
<img src="/docs/demo/search.gif" width="600"/>

---

### 🔐 5. 회원가입 / 로그인 / 로그아웃
- 아이디 중복 체크  
- 세션 기반 로그인 처리  
<img src="/docs/demo/login.gif" width="600"/>

---

### 🛠 6. 관리자 페이지
- 도서 등록 / 수정 / 삭제  
- 이미지 업로드  
- 재고 관리  
<img src="/docs/demo/admin.gif" width="600"/>


