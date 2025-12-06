<div align="center">

# 📚 온라인 북스토어(책갈피)  
### Spring Boot · MyBatis · Oracle 기반 온라인 도서 판매 플랫폼

<br>

<img src="https://img.shields.io/badge/Java-17-007396?logo=java">
<img src="https://img.shields.io/badge/SpringBoot-2.7-6DB33F?logo=springboot">
<img src="https://img.shields.io/badge/MyBatis-000000">
<img src="https://img.shields.io/badge/Oracle-F80000?logo=oracle">
<img src="https://img.shields.io/badge/JSP-F7DF1E?logo=html5">
<img src="https://img.shields.io/badge/AWS EC2-232F3E?logo=amazonaws">
<img src="https://img.shields.io/badge/Toss Payments-0055FF">

<br><br>
</div>

---

## 📖 프로젝트 개요

온라인 북스토어는 **도서 검색, 장바구니, 결제, 주문 관리** 기능을 제공하는  
웹 기반 쇼핑몰 프로젝트입니다.

- 개발 기간 : 1차: `2025.10.13 ~ 2025.10.19`, 2차: `2025.11.13 ~ 2025.11.20`
- 개발 인원 : `7명`  
- 담당 역할 : `팀장, 유저 테이블 설계,로그인,소셜로그인,회원가입,이메일 인증,아이디/비밀번호 찾기,관리자 대시보드, 관리자 게시물 관리, 관리자 주문내역,회원탈퇴 로직 설계 및 구현`  
- 주요 특징  
  - REST 기반 API 설계  
  - 토스 결제 API 연동  
  - 세션 기반 로그인 시스템  
  - 관리자 페이지(도서 등록, 재고 관리)

---

## 🛠 기술 스택

| 분야 | 기술 |
|------|-------|
| **Backend** | Spring Boot, MyBatis, Java 17 |
| **Frontend** | JSP, JavaScript, JQuery, CSS |
| **Database** | MySQL, ERDCloud |
| **Infra** | AWS EC2(Ubuntu), Apache/Tomcat, GitHub |
| **Payment** | Toss Payments API |
| **Tools** | IntelliJ / STS, Figma, Postman, SourceTree |

---

## ✨ 주요 기능

### 🛍 사용자 기능
- 🔎 **도서 검색 / 카테고리별 조회**  
- 🛒 **장바구니** (수량 변경, 삭제)  
- 💳 **토스 결제 연동**  
- 📦 **주문 생성 / 주문 내역 조회**

### 🔐 회원 기능
- 회원가입 / 로그인 / 로그아웃  
- 사용자 정보 수정  
- 탈퇴 처리

### 🛠 관리자 기능
- 도서 등록 / 수정 / 삭제  
- 재고 관리  
- 주문 관리 페이지

---

## 🧭 메뉴 구조도 (PDF)

📄 메뉴 구조도 보기  
👉 `/docs/menu-structure.pdf`

---

## 🖥 화면 설계서 (PDF)

📄 화면 기획서 보기  
👉 `/docs/ui-design.pdf`

---

## 🗂 ERD 및 테이블 명세서

📄 ERD  
👉 `/docs/erd.pdf`

📄 테이블 명세서  
👉 `/docs/table-definition.pdf`

---

## 🔍 핵심 구현 내용 (내가 담당한 기능)

### ✔ 1. 결제 모듈(Toss Payments) 구현
- 클라이언트 → Toss 위젯 → 승인 API까지 전체 흐름 설계
- 결제 성공 시 주문/주문상세 DB 트랜잭션 처리  
- 실패 시 롤백 적용

### ✔ 2. 장바구니 기능 (세션/DB 혼합 방식)
- 비로그인 상태에서도 장바구니 유지되도록 세션 로직 구현  
- 로그인 시 장바구니 DB로 병합 처리 로직 개발

### ✔ 3. 주문/결제 트랜잭션 처리
- 주문 생성과 결제 처리를 하나의 트랜잭션으로 관리  
- 재고 부족 시 예외 처리 및 자동 롤백

### ✔ 4. 관리자 페이지 기능 개발
- 도서 등록/수정/삭제  
- 이미지 업로드 처리  
- 재고 변경 API

---

## 🚀 시연 영상 & 데모

아래 영상은 온라인 북스토어(BookShelf)의 주요 기능을 실제 화면과 함께 보여줍니다.  
각 기능별 동작 방식과 흐름을 직관적으로 확인할 수 있습니다.

### 📌 전체 시연 영상 (Full Demo)
🔗 YouTube 링크: https://youtu.be/your-video-url  
또는  
🎥 EC2 배포 버전 직접 테스트: http://your-ec2-ip

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
