<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>찜 목록 | 책갈피</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="/css/myinfo_edit.css">
  <style>
    /* 찜 목록 전용 스타일 */
    .wishlist-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 24px;
    }
    
    .wish-item {
      background: #fff;
      border: 1px solid var(--border);
      border-radius: 12px;
      overflow: hidden;
      transition: all 0.2s ease;
    }
    
    .wish-item:hover {
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      transform: translateY(-2px);
    }
    
    .wish-thumb {
      position: relative;
      height: 240px;
      background: linear-gradient(135deg, #f5f5f5, #e8e8e8);
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
    }
    
    .wish-thumb img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    
    .wish-thumb .placeholder {
      color: #999;
      font-size: 14px;
    }
    
    .wish-thumb .heart-btn {
      position: absolute;
      top: 12px;
      right: 12px;
      width: 36px;
      height: 36px;
      background: rgba(255, 255, 255, 0.9);
      border: none;
      border-radius: 50%;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 10;
      transition: all 0.2s ease;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
    
    .wish-thumb .heart-btn:hover {
      background: rgba(255, 255, 255, 1);
      transform: scale(1.1);
    }
    
    .wish-thumb .heart-btn svg {
      width: 20px;
      height: 20px;
    }
    
    .wish-thumb .heart-btn .heart-empty {
      fill: #e74c3c;
      stroke: #e74c3c;
      stroke-width: 2;
    }
    
    .wish-info {
      padding: 16px;
    }
    
    .wish-title {
      margin: 0 0 8px;
      font-size: 16px;
      font-weight: 700;
    }
    
    .wish-title a {
      color: var(--text);
      text-decoration: none;
    }
    
    .wish-title a:hover {
      color: var(--brand);
    }
    
    .wish-author {
      margin: 0 0 8px;
      font-size: 13px;
      color: var(--muted);
    }
    
    .wish-price {
      margin: 0 0 12px;
      font-size: 16px;
      font-weight: 800;
      color: var(--brand);
    }
    
    .wish-actions {
      margin-top: 12px;
    }
    
    .btn-sm {
      padding: 8px 14px;
      font-size: 13px;
    }
    
    .empty-state {
      text-align: center;
      padding: 60px 20px;
    }
    
    .empty-icon {
      font-size: 64px;
      margin-bottom: 16px;
    }
    
    .empty-state h3 {
      font-size: 20px;
      font-weight: 700;
      margin: 0 0 8px;
      color: var(--text);
    }
    
    .empty-state p {
      font-size: 14px;
      color: var(--muted);
      margin: 0 0 24px;
    }
    
    .count-badge {
      font-size: 14px;
      color: var(--muted);
    }
    
    .count-badge strong {
      color: var(--brand);
      font-weight: 700;
    }
    
    @media (max-width: 768px) {
      .wishlist-grid {
        grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
        gap: 16px;
      }
    }
    
    @media (max-width: 480px) {
      .wishlist-grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <header>
    <nav class="nav" aria-label="주요 메뉴">
      <a href="<c:url value='/main'/>" class="brand">
        <img src="/img/book_logo.png" alt="책갈피 로고" class="brand-logo"/>
      </a>
      <div class="nav-right">
        <span id="userGreeting" style="color:var(--brand); font-weight:700;">
          <c:choose>
			<c:when test="true">
			  마이페이지
			</c:when>
		  </c:choose>
        </span>
        <a href="<c:url value='/cart'/>">장바구니</a>
        <a href="<c:url value='/logout'/>">로그아웃</a>
        <span style="color:#666; font-weight:700;">
          ${sessionScope.loginDisplayName}님
        </span>
      </div>
    </nav>
  </header>

  <div class="promo" aria-hidden="true"></div>

  <main class="page-wrap">
    <div class="page-container">
      <h1 class="page-title">찜 목록</h1>
      
      <div class="tab-nav">
        <button class="tab-button" onclick="location.href='<c:url value="/mypage"/>'">정보</button>
        <button class="tab-button" onclick="location.href='<c:url value="/mypage/edit"/>'">내정보 수정</button>
        <button class="tab-button active" onclick="location.href='<c:url value="/wishlist"/>'">찜 목록</button>
        <button class="tab-button" onclick="location.href='<c:url value="/MyPage/purchaseList"/>'">구매내역</button>
        <button class="tab-button" onclick="location.href='<c:url value="/mypage/withdraw"/>'">회원탈퇴</button>
      </div>

      <div class="content-card">
        <div class="card">
          <div class="card-head">
            <h3 class="card-title">찜한 도서</h3>
            <div class="toolbar">
              <span class="count-badge">총 <strong id="wishCount">${fn:length(wishlist)}</strong>권</span>
              <c:if test="${not empty wishlist}">
                <button class="btn btn-sm" id="btnRemoveAll" style="background: #dc3545; color: #fff; margin-left: 12px;">전체 삭제</button>
              </c:if>
            </div>
          </div>

          <div class="card-body">
            <c:choose>
              <c:when test="${not empty wishlist}">
                <div class="wishlist-grid">
                  <c:forEach var="item" items="${wishlist}">
                    <div class="wish-item" data-wish-id="${item.wish_id}">
                      <div class="wish-thumb">
                        <a href="<c:url value='/SearchDetail?book_id=${item.book_id}'/>">
                          <c:choose>
                            <c:when test="${not empty item.book.book_image_path}">
                              <img src="<c:url value='${item.book.book_image_path}'/>" alt="${item.book.book_title}">
                            </c:when>
                            <c:otherwise>
                              <div class="placeholder">이미지 없음</div>
                            </c:otherwise>
                          </c:choose>
                        </a>
                        <button class="heart-btn active remove-wish" data-wish-id="${item.wish_id}" data-book-id="${item.book_id}" aria-label="찜 해제">
                          <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path class="heart-empty" d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                          </svg>
                        </button>
                      </div>
                      <div class="wish-info">
                        <h4 class="wish-title">
                          <a href="<c:url value='/SearchDetail?book_id=${item.book_id}'/>">
                            <c:out value="${item.book.book_title}"/>
                          </a>
                        </h4>
                        <p class="wish-author"><c:out value="${item.book.book_writer}"/></p>
                        <p class="wish-price">
                          <fmt:formatNumber value="${item.book.book_price}" pattern="#,###"/>원
                        </p>
                        <div class="wish-actions">
                          <button class="btn btn-sm add-to-cart" data-book-id="${item.book_id}">장바구니 담기</button>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </c:when>
              <c:otherwise>
                <div class="empty-state">
                  <div class="empty-icon">❤️</div>
                  <h3>찜한 도서가 없습니다</h3>
                  <p>관심 있는 도서에 하트를 눌러 찜 목록에 추가해보세요.</p>
                  <a href="<c:url value='/Search'/>" class="btn">도서 둘러보기</a>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
  </main>

  <footer class="footer">
    <div class="footer-container">
      <div class="footer-brand">BRAND</div>
      <div class="footer-info">
        BRAND | 대표자 : 홍길동 | 사업자번호 : 123-34-56789<br>
        통신판매업 : 0000-부산시-0000호 | 개인정보보호책임자 : 홍길동 | 이메일 : qshop@naver.com<br>
        전화번호: 00-0000-0000 | 주소 : 부산시 부산진구 범내골
      </div>
    </div>
  </footer>

  <script>
    const ctx = '<c:url value="/"/>';
    
    // 전체 삭제 버튼
    const btnRemoveAll = document.getElementById('btnRemoveAll');
    if (btnRemoveAll) {
      btnRemoveAll.addEventListener('click', async function() {
        if (!confirm('찜 목록의 모든 도서를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
          return;
        }
        
        try {
          const response = await fetch(ctx + 'wishlist/removeAll', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' }
          });
          
          const data = await response.json();
          
          if (data.success) {
            alert('찜 목록이 모두 삭제되었습니다.');
            location.reload();
          } else {
            alert(data.message || '삭제에 실패했습니다.');
          }
        } catch (err) {
          console.error('전체 삭제 오류:', err);
          alert('네트워크 오류가 발생했습니다.');
        }
      });
    }
    
    // 찜 해제 버튼 (하트 버튼)
    document.querySelectorAll('.remove-wish').forEach(function(btn) {
      btn.addEventListener('click', async function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        const wishId = this.getAttribute('data-wish-id');
        const bookId = this.getAttribute('data-book-id');
        
        // 값 검증
        if (!wishId || wishId === '' || isNaN(parseInt(wishId))) {
          alert('오류: 찜 정보를 찾을 수 없습니다.');
          console.error('Invalid wishId:', wishId);
          return;
        }
        
        // 확인 알림
        if (!confirm('이 상품을 찜 목록에서 삭제하시겠습니까?')) {
          return;
        }
        
        try {
          const response = await fetch(ctx + 'wishlist/removeById', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: 'wish_id=' + encodeURIComponent(wishId)
          });
          
          const data = await response.json();
          
          if (data.success) {
            // 해당 아이템 제거
            const wishItem = this.closest('.wish-item');
            if (wishItem) {
              wishItem.remove();
              
              // 카운트 업데이트
              const count = document.querySelectorAll('.wish-item').length;
              const countElement = document.getElementById('wishCount');
              if (countElement) {
                countElement.textContent = count;
              }
              
              // 빈 상태 체크
              if (count === 0) {
                location.reload();
              }
            }
          } else {
            alert(data.message || '삭제에 실패했습니다.');
          }
        } catch (err) {
          console.error('삭제 오류:', err);
          alert('네트워크 오류가 발생했습니다.');
        }
      });
    });
    
    // 장바구니 담기 버튼
    document.querySelectorAll('.add-to-cart').forEach(function(btn) {
      btn.addEventListener('click', async function() {
        const bookId = this.getAttribute('data-book-id');
        
        if (!bookId || bookId === '' || isNaN(parseInt(bookId))) {
          alert('오류: 도서 정보를 찾을 수 없습니다.');
          return;
        }
        
        if (!confirm('장바구니에 담으시겠습니까?')) {
          return;
        }
        
        try {
          const response = await fetch(ctx + 'cartAdd', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: 'book_id=' + encodeURIComponent(bookId)
          });
          
          const text = await response.text();
          
          if (text.trim() === 'success') {
            alert('장바구니에 담겼습니다!');
          } else {
            alert(text || '장바구니 담기 실패');
          }
        } catch (err) {
          console.error('장바구니 오류:', err);
          alert('네트워크 오류가 발생했습니다.');
        }
      });
    });
  </script>
</body>
</html>