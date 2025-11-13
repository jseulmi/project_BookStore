<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>관리자 페이지 — 뼈대</title>
  <link rel="stylesheet" href="/css/adminMain.css">
</head>
<body>
  <div class="app">
    <!-- SIDEBAR -->
    <aside class="sidebar" aria-label="사이드바">
      <div class="brand">
        <img src="/img/book_logo.png" class="brand-logo" alt="로고">
        tqShop 관리자
      </div>

      <nav class="nav">

        <!-- 회원 관리 -->
        <div class="nav-section">
          <div class="nav-section-title">회원관리</div>
          <ul class="nav-list">
            <li class="nav-item">
				<button data-page="/admin/member/adminlist">회원관리</button>
			</li>
            <li class="nav-item"><button>권한관리</button></li>
          </ul>
        </div>

        <!-- 게시판 관리 -->
        <div class="nav-section">
          <div class="nav-section-title">게시판관리</div>
          <ul class="nav-list">
            <li class="nav-item">
				<button data-page="/admin/boardManagement">게시글 관리</button>	
			</li>
            <li class="nav-item">
				<button data-page="/admin/noticeManagement">공지사항 관리</button>
			</li>
            <li class="nav-item">
				<button data-page="/admin/qnaManagement">QnA 관리</button>
			</li>
          </ul>
        </div>

        <!-- 도서 관리 -->
        <div class="nav-section">
          <div class="nav-section-title">도서관리</div>
          <ul class="nav-list">
            <li class="nav-item"><button>도서 등록/삭제/수정</button></li>
            <li class="nav-item"><button>재고관리</button></li>
          </ul>
        </div>

        <!-- 주문 내역 -->
        <div class="nav-section">
          <div class="nav-section-title">주문내역</div>
          <ul class="nav-list">
            <li class="nav-item"><button>전체 주문내역</button></li>
            <li class="nav-item"><button>오늘 주문내역</button></li>
          </ul>
        </div>

        <!-- 문의 내역 -->
        <div class="nav-section">
          <div class="nav-section-title">문의내역</div>
          <ul class="nav-list">
            <li class="nav-item"><button>문의 리스트</button></li>
          </ul>
        </div>

      </nav>
    </aside>

    <!-- MAIN -->
    <main class="main" role="main">

      <!-- TOPBAR -->
      <header class="topbar">
        <div class="left">
          <button aria-label="메뉴 토글" style="border:0;background:transparent;cursor:pointer;padding:6px;border-radius:8px;">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
              <path d="M4 7h16M4 12h16M4 17h16" stroke="#374151" stroke-width="1.6" stroke-linecap="round"/>
            </svg>
          </button>
          <div class="search">검색...</div>
        </div>

        <div class="right">
          <div style="font-size:13px;">내 사이트 바로가기</div>
          <div style="font-size:13px;">관리자명</div>
        </div>
      </header>

      <!-- CONTENT -->
      <section class="content" id="content-area">

        <h1 style="font-size:18px;margin:0 0 6px 0;">관리자 대시보드</h1>
        <div style="color:var(--muted);font-size:13px;margin-bottom:18px;">기본 화면 구성 예시</div>

      </section>
    </main>
  </div>
  <script>
    // 공통 페이지 로더
    function loadPage(url) {
      fetch(url)
        .then(res => res.text())
        .then(html => {
          document.getElementById("content-area").innerHTML = html;
        })
        .catch(err => {
          document.getElementById("content-area").innerHTML =
            "<div style='padding:20px;color:red'>페이지 로딩 실패</div>";
        });
    }

    // 메뉴 클릭 이벤트 연결
    document.querySelectorAll('.nav-item button').forEach(btn => {
      btn.addEventListener("click", () => {
        const page = btn.dataset.page;   // 버튼에 data-page 속성 넣을 거임
        if(page){
          loadPage(page);
        }
      });
    });
  </script>
</body>
</html>
