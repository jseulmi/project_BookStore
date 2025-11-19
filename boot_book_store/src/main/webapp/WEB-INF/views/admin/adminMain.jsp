<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>관리자 페이지 — 뼈대</title>
  <link rel="stylesheet" href="/css/adminMain.css">
  <style>
	/* 제목 스타일 - 회원관리와 동일 */
	.admin-title {
	  font-size: 28px;
	  font-weight: 800;
	  color: #3e2c1c;
	  margin: 0 0 10px 0;
	}

	.admin-sub {
	  font-size: 14px;
	  color: #7a6a58;
	  margin-bottom: 30px;
	}

	/* 카드 그리드 */
	.quick-menu-grid {
	  display: grid;
	  grid-template-columns: repeat(3, 1fr);  /* ← 3개씩 고정 */
	  gap: 24px;
	  margin-top: 20px;

	  /* 가운데 정렬 */
	  max-width: 1100px;
	  margin-left: auto;
	  margin-right: auto;
	}

	/* 카드 스타일 - 회원관리 table 느낌과 통일 */
	.quick-card {
	  background: #ffffff;
	  border: 1px solid #e5dccc;
	  border-radius: 16px;
	  padding: 25px 20px;
	  text-align: center;

	  /* 회원관리 테이블과 통일된 그림자 */
	  box-shadow: 0 6px 20px rgba(0,0,0,0.10);
	  transition: 0.25s;
	}

	.quick-card:hover {
	  transform: translateY(-4px);
	  box-shadow: 0 12px 26px rgba(0,0,0,0.16);
	  background: #faf8f4;
	}

	/* 아이콘 */
	.quick-icon {
	  font-size: 40px;
	  margin-bottom: 14px;
	}

	/* 메뉴 제목 */
	.quick-title {
	  font-size: 18px;
	  font-weight: 700;
	  color: #3e2c1c;
	  margin-bottom: 6px;
	}

	/* 메뉴 설명 */
	.quick-desc {
	  font-size: 13px;
	  color: #7b6b5e;
	}
  </style>
</head>
<body>
  <div class="app">
    <!-- SIDEBAR -->
    <aside class="sidebar" aria-label="사이드바">
      <div class="brand">
        <img src="/img/book_logo.png" alt="책갈피 로고" class="brand-logo" style="width:100px;height:40px;" />
        <span style="color:#8B4513;font-weight:600;">관리자 페이지</span>
      </div>

      <nav class="nav">
		
        <!-- 회원 관리 -->
        <div class="nav-section">
          <div class="nav-section-title">회원관리</div>
          <ul class="nav-list">
            <li class="nav-item">
				<button data-page="/admin/member/adminlist">회원관리</button>
			</li>
			<li class="nav-item">
			    <button data-page="/admin/member/authority">권한관리</button>
			</li>

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
<!--            <li class="nav-item">-->
<!--				<button data-page="/admin/qnaManagement">QnA 관리</button>-->
<!--			</li>-->
          </ul>
        </div>

        <!-- 도서 관리 -->
        <div class="nav-section">
          <div class="nav-section-title">도서관리</div>
          <ul class="nav-list">
            <li class="nav-item">
		      <button onclick="loadPage('/admin/book/list')">
		        도서 등록/삭제/수정
		      </button>
		    </li>
<!--            <li class="nav-item"><button>재고관리</button></li>-->
          </ul>
        </div>

        <!-- 주문 내역 -->
        <div class="nav-section">
          <div class="nav-section-title">주문내역</div>
          <ul class="nav-list">
             <li class="nav-item">
				<button data-page="/admin/order/list">전체 주문내역</button>
			</li>
            <li class="nav-item">
				<button data-page="/admin/order/today">오늘 주문내역</button>
			</li>
          </ul>
        </div>

        <!-- 문의 내역 -->
        <div class="nav-section">
          <div class="nav-section-title">문의내역</div>
          <ul class="nav-list">
            <li class="nav-item"><button data-page="/inquiry/admin/list">문의 리스트</button></li>
          </ul>
        </div>

      </nav>
    </aside>

    <!-- MAIN -->
    <main class="main" role="main">

      <!-- TOPBAR -->
      <header class="topbar">
        <div class="left">
        </div>

        <div class="center">
          <button aria-label="메뉴 토글" style="border:0;background:transparent;cursor:pointer;padding:6px;border-radius:8px;margin-right:12px;">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
              <path d="M4 7h16M4 12h16M4 17h16" stroke="#8B4513" stroke-width="1.6" stroke-linecap="round"/>
            </svg>
          </button>
          <input type="text" placeholder="검색..." class="search-input" style="padding:8px 16px;border-radius:20px;border:1px solid #ddd;background:white;width:300px;outline:none;">
        </div>

        <div class="right">
          <a href="<c:url value='/main'/>" style="color:#8B4513;font-size:13px;margin-right:12px;text-decoration:none;">사이트 바로가기</a>
          <span style="color:#8B4513;font-size:13px;font-weight:700;">
            <c:choose>
              <c:when test="${not empty sessionScope.loginDisplayName}">
                ${sessionScope.loginDisplayName}
              </c:when>
              <c:otherwise>
                관리자명
              </c:otherwise>
            </c:choose>
          </span>
        </div>
      </header>

      <!-- CONTENT -->
      <section class="content" id="content-area">

		<h1 class="admin-title">관리자 대시보드</h1>
		<p class="admin-sub">관리자가 자주 사용하는 기능을 빠르게 실행하세요.</p>

		<div class="quick-menu-grid">

		  <div class="quick-card" onclick="loadPage('/admin/member/adminlist')">
		    <div class="quick-icon">👥</div>
		    <div class="quick-title">회원 관리</div>
		    <div class="quick-desc">회원 목록 조회 및 수정</div>
		  </div>

		  <div class="quick-card" onclick="loadPage('/admin/member/authority')">
		    <div class="quick-icon">🔐</div>
		    <div class="quick-title">권한 관리</div>
		    <div class="quick-desc">관리자 / 일반회원 권한 설정</div>
		  </div>

		  <div class="quick-card" onclick="loadPage('/admin/noticeManagement')">
		    <div class="quick-icon">📢</div>
		    <div class="quick-title">공지사항 관리</div>
		    <div class="quick-desc">공지 등록 및 수정</div>
		  </div>

		  <div class="quick-card" onclick="loadPage('/admin/book/list')">
		    <div class="quick-icon">📚</div>
		    <div class="quick-title">도서 관리</div>
		    <div class="quick-desc">도서 등록, 수정, 삭제</div>
		  </div>

		  <div class="quick-card" onclick="loadPage('/admin/order/list')">
		    <div class="quick-icon">🧾</div>
		    <div class="quick-title">전체 주문내역</div>
		    <div class="quick-desc">주문 현황 확인</div>
		  </div>

		  <div class="quick-card" onclick="loadPage('/inquiry/admin/list')">
		    <div class="quick-icon">💬</div>
		    <div class="quick-title">문의 내역</div>
		    <div class="quick-desc">1:1 문의 확인 및 답변</div>
		  </div>

		</div>

      </section>
    </main>
  </div>
  <script>
	// 공통 페이지 로더
	function loadPage(url) {
		history.pushState({ path: url }, "", "#" + url);
		fetch(url)
	    .then(res => res.text())
	    .then(html => {
	      const area = document.getElementById("content-area");
	      area.innerHTML = html;

	      // 🚀 삽입된 JSP 내부 script 실행
	      const scripts = area.querySelectorAll("script");
	      scripts.forEach(oldScript => {
	        const newScript = document.createElement("script");

	        if (oldScript.src) {
	          newScript.src = oldScript.src;
	        } else {
	          newScript.textContent = oldScript.textContent;
	        }

	        oldScript.replaceWith(newScript);
	      });

	      // 🚀 페이지마다 초기화 함수 실행
	      if (url.includes("/admin/notice/write")) {
	        if (typeof initNoticeWrite === "function") {
	          initNoticeWrite();
	        }
	      }

	      if (url.includes("/admin/notice/edit")) {
	        if (typeof initNoticeEdit === "function") {
	          initNoticeEdit();
	        }
	      }

	      if (url.includes("/admin/notice/detail")) {
	        if (typeof initNoticeDetail === "function") {
	          initNoticeDetail();
	        }
	      }

	      // 회원 상세 페이지 데이터 로드
	      if (url.includes("/admin/member/detail")) {
	        afterLoad(url);
	      }
	    })
	    .catch(err => {
	      document.getElementById("content-area").innerHTML =
	        "<div style='padding:20px;color:red'>페이지 로딩 실패</div>";
	    });
	}

	
	// 페이지 로드 후 처리 (memberDetail 일 때만)
	function afterLoad(pageUrl) {

	  // 회원 상세 페이지일 때만 실행
	  if (pageUrl.startsWith("/admin/member/detail")) {

	    const urlParams = new URLSearchParams(pageUrl.split("?")[1]);
	    const userId = urlParams.get("user_id");

	    fetch("/admin/member/detailData?user_id=" + userId)
	      .then(res => res.json())
	      .then(data => {

	        document.querySelector("input[name='user_id']").value = data.USER_ID;
	        document.querySelector("input[name='user_name']").value = data.USER_NAME;
	        document.querySelector("input[name='user_nickname']").value = data.USER_NICKNAME;
	        document.querySelector("input[name='user_email']").value = data.USER_EMAIL;
	        document.querySelector("input[name='user_phone_num']").value = data.USER_PHONE_NUM;
	        document.querySelector("input[name='user_address']").value = data.USER_ADDRESS;
	        document.querySelector("input[name='user_detail_address']").value = data.USER_DETAIL_ADDRESS;
	      });
	  }
	}

	// 문의 상세보기 로드 함수
	function loadInquiryDetail(inquiryId) {
	  loadPage('/inquiry/admin/detail?inquiry_id=' + inquiryId);
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
	function saveMember() {

	  const formData = {
	    user_id: document.querySelector("input[name='user_id']").value,
	    user_nickname: document.querySelector("input[name='user_nickname']").value,
	    user_email: document.querySelector("input[name='user_email']").value,
	    user_phone_num: document.querySelector("input[name='user_phone_num']").value,
	    user_address: document.querySelector("input[name='user_address']").value,
	    user_detail_address: document.querySelector("input[name='user_detail_address']").value
	  };

	  fetch("/admin/member/edit", {
	    method: "POST",
	    headers: {"Content-Type": "application/json"},
	    body: JSON.stringify(formData)
	  })
	    .then(res => res.json())
	    .then(result => {

	      alert("수정이 완료되었습니다.");

	      // 다시 회원 목록으로 이동
	      loadPage("/admin/member/adminlist");
	    })
	    .catch(err => {
	      alert("에러 발생");
	    });
	}

	// ===== 권한 변경 처리 =====
	function updateRole(userId) {
	  const newRole = document.getElementById("role_" + userId).value;

	  fetch("/admin/member/updateRole", {
	      method: "POST",
	      headers: { "Content-Type": "application/json" },
	      body: JSON.stringify({
	        user_id: userId,
	        user_role: newRole
	      })
	    })
	    .then(res => res.text())
	    .then(result => {
	      alert("권한이 변경되었습니다.");
	      loadPage("/admin/member/authority");
	    })
	    .catch(err => {
	      console.error(err);
	      alert("오류 발생");
	    });
	}
	function removeAdmin(userId) {
	    if (!confirm("해당 사용자의 관리자 권한을 제거하시겠습니까?")) return;

	    fetch("/admin/member/updateRole", {
	        method: "POST",
	        headers: {"Content-Type": "application/json"},
	        body: JSON.stringify({
	            user_id: userId,
	            user_role: "USER"
	        })
	    })
	    .then(res => res.text())
	    .then(result => {
	        alert("관리자 권한이 제거되었습니다.");
	        loadPage("/admin/member/authority");
	    })
	    .catch(err => {
	        alert("오류 발생");
	    });
	}

	/**********************************************************
	 * 📌 도서 수정 — saveBookEdit()
	 **********************************************************/
	function saveBookEdit() {

	  const data = {
	    book_id: document.querySelector("input[name='book_id']").value,
	    book_title: document.querySelector("input[name='book_title']").value,
	    book_writer: document.querySelector("input[name='book_writer']").value,
	    book_pub: document.querySelector("input[name='book_pub']").value,
	    book_date: document.querySelector("input[name='book_date']").value,
	    genre_id: document.querySelector("select[name='genre_id']").value,
	    book_price: document.querySelector("input[name='book_price']").value,
	    book_count: document.querySelector("input[name='book_count']").value,
	    book_comm: document.querySelector("textarea[name='book_comm']").value,
	    book_isbn: document.querySelector("input[name='book_isbn']").value,
	    book_image_path: document.querySelector("input[name='book_image_path']").value
	  };

	  fetch("/admin/book/edit", {
	    method: "POST",
	    headers: {"Content-Type": "application/json"},
	    body: JSON.stringify(data)
	  })
	    .then(res => res.text())
	    .then(result => {
	      alert("도서 수정 완료!");
	      loadPage("/admin/book/list");
	    })
	    .catch(err => {
	      console.error(err);
	      alert("수정 중 오류 발생");
	    });
	}

	/**********************************************************
	 * 📌 도서 등록 — saveBookAdd()
	 **********************************************************/
	function saveBookAdd() {

	  const data = {
	    book_title: document.querySelector("input[name='book_title']").value,
	    book_writer: document.querySelector("input[name='book_writer']").value,
	    book_pub: document.querySelector("input[name='book_pub']").value,
	    book_date: document.querySelector("input[name='book_date']").value,
	    genre_id: document.querySelector("select[name='genre_id']").value,
	    book_price: document.querySelector("input[name='book_price']").value,
	    book_count: document.querySelector("input[name='book_count']").value,
	    book_comm: document.querySelector("textarea[name='book_comm']").value,
	    book_isbn: document.querySelector("input[name='book_isbn']").value,
	    book_image_path: document.querySelector("input[name='book_image_path']").value
	  };

	  fetch("/admin/book/add", {
	    method: "POST",
	    headers: {"Content-Type": "application/json"},
	    body: JSON.stringify(data)
	  })
	    .then(res => res.text())
	    .then(result => {
	      alert("도서 등록 완료!");
	      loadPage("/admin/book/list");
	    })
	    .catch(err => {
	      console.error(err);
	      alert("등록 중 오류 발생");
	    });
	}


	/**********************************************************
	 * 📌 도서 삭제 — deleteBook()
	 **********************************************************/
	function deleteBook(id) {

	  if (!confirm("정말 삭제하시겠습니까?")) return;

	  fetch("/admin/book/delete?id=" + id, { method: "POST" })
	    .then(res => res.text())
	    .then(result => {
	      if (result.trim() === "OK") {
	        alert("도서 삭제 완료!");
	        loadPage("/admin/book/list");
	      } else {
	        alert("삭제 실패: " + result);
	      }
	    })
	    .catch(err => {
	      console.error(err);
	      alert("서버 오류 발생");
	    });
	}


	/*******************************************
	 * 📌 왼쪽 메뉴 버튼 → loadPage() 연결
	 *******************************************/
	document.querySelectorAll('.nav-item button').forEach(btn => {
	  btn.addEventListener("click", () => {
	    const page = btn.dataset.page;
	    if (page) loadPage(page);
	  });
	});
	window.addEventListener("popstate", function (event) {
	  if (event.state && event.state.path) {
	    loadPage(event.state.path);
	  }
	});
  </script>
</body>
</html>
