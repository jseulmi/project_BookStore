<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>책갈피 – 도서 관리의 혁신</title>

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@200;300;400;500;600;700&family=Inter:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<!-- 페이지 전용 CSS -->
<link rel="stylesheet" href="/css/main.css">
</head>
<body>

	<!-- 헤더 & 네비 -->
	<header>
		<nav class="nav" aria-label="주요 메뉴">
			<a href="<c:url value='/main'/>" class="brand"> <img
				src="/img/book_logo.png" alt="책갈피 로고"
				class="brand-logo" /> <span class="brand-text" aria-hidden="true"></span>
			</a>

			<!-- 로그인 전/후 분기 -->
			<div class="nav-right">
				<c:choose>
					<%-- 로그인 전 --%>
					<c:when test="${empty sessionScope.loginDisplayName}">
						<a href="<c:url value='/login'/>">로그인</a>
						<a href="<c:url value='/register'/>">회원가입</a>
						<a href="<c:url value='/cart'/>">장바구니</a>
					</c:when>

					<%-- 로그인 후 --%>
					<c:otherwise>
						<a href="<c:url value='/mypage'/>">마이페이지</a>
						<a href="<c:url value='/cart'/>">장바구니</a>
						<a href="<c:url value='/logout'/>">로그아웃</a>
						<span style="color: #666; font-weight: 700;">
							${sessionScope.loginDisplayName}님 </span>
						<!-- 🔥 일반 사용자 & 관리자 공통 → 드롭다운 버튼 -->
					    <div class="admin-dropdown">
					        <span class="admin-text">
					            고객지원
					            <span class="arrow">▼</span>
					        </span>

					        <div class="admin-menu">
					            <!-- 모든 사용자에게 보임 -->
					            <a href="<c:url value='/inquiry'/>">1:1 문의</a>
					            <c:if test="${sessionScope.userRole == 'ADMIN'}">
								    <li><a href="/adminMain">관리자 모드</a></li>
					            </c:if>
					        </div>
					    </div>
					</c:otherwise>
				</c:choose>
			</div>
		</nav>
	</header>

	<!-- 상단 프로모션 -->
	<div class="promo" role="note" aria-label="프로모션">
		<div class="promo-content">
			<div class="promo-nav">
				<a href="<c:url value='/Search'/>" class="nav-search">도서</a> <a
					href="<c:url value='/board'/>" class="nav-board">게시판</a>
			</div>
		</div>
	</div>

	<main>
		<!-- 히어로: 로그인 전/후 문구/버튼만 다르게 -->
		<section class="hero">
			<div class="hero-content">
				<c:choose>
					<c:when test="${empty sessionScope.loginDisplayName}">
						<h1>온라인 서점에 오신 것을 환영합니다</h1>
						<p>다양한 도서를 만나보세요</p>
					</c:when>
					<c:otherwise>
						<h1>${sessionScope.loginDisplayName}님, 오늘도 반가워요 👋</h1>
						<p>관심사 기반 추천과 최근 본 도서를 이어서 확인해보세요</p>
					</c:otherwise>
				</c:choose>

				<div class="main-search">
					<form action="<c:url value='/Search'/>" method="get"
						class="search-box">
						<input type="text" name="q" class="search-input"
							placeholder="도서명, 저자명으로 검색하세요..." required />
						<button type="submit" class="search-button" aria-label="검색">
							<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		        <circle cx="11" cy="11" r="7"></circle>
		        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
		      </svg>
						</button>
					</form>
				</div>
		</section>

		<!-- 이달의 책 / 개인화 추천 섹션 제목 분기 -->
		<section class="products-section">
			<div class="products-container">
				<c:choose>
					<c:when test="${empty sessionScope.loginId}">
						<h2 class="section-title">이달의 책 😊</h2>
					</c:when>
					<c:otherwise>
						<h2 class="section-title">${sessionScope.loginDisplayName}님을 위한 추천 📚</h2>
					</c:otherwise>
				</c:choose>

				<!-- 기존 카드 그대로 사용(나중에 서버데이터 바인딩하면 됨) -->
				<div class="products-grid" id="productsGrid">
					<div class="product-card">
						<div class="product-image"></div>
						<div class="product-info">
							<h3 class="product-title">책장 정리왕</h3>
							<div class="product-price">4,000원</div>
							<div class="product-rating">
								<div class="stars">
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
								</div>
								<span class="rating-text">0 (0)</span>
							</div>
						</div>
					</div>

					<div class="product-card">
						<div class="product-image"></div>
						<div class="product-info">
							<h3 class="product-title">리딩 트래커</h3>
							<div class="product-price">3,000원</div>
							<div class="product-rating">
								<div class="stars">
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
								</div>
								<span class="rating-text">0 (0)</span>
							</div>
						</div>
					</div>

					<div class="product-card">
						<div class="product-image"></div>
						<div class="product-info">
							<h3 class="product-title">도서관 매니저</h3>
							<div class="product-price">2,000원</div>
							<div class="product-rating">
								<div class="stars">
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
								</div>
								<span class="rating-text">0 (0)</span>
							</div>
						</div>
					</div>
				</div>

				<!-- 숨김 추가 카드(그대로) -->
				<div class="products-grid hidden" id="additionalProducts"
					style="margin-top: 40px;">
					<div class="product-card">
						<div class="product-image"></div>
						<div class="product-info">
							<h3 class="product-title">스마트 도서 추천</h3>
							<div class="product-price">5,000원</div>
							<div class="product-rating">
								<div class="stars">
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
								</div>
								<span class="rating-text">0 (0)</span>
							</div>
						</div>
					</div>

					<div class="product-card">
						<div class="product-image"></div>
						<div class="product-info">
							<h3 class="product-title">독서 통계 분석</h3>
							<div class="product-price">3,500원</div>
							<div class="product-rating">
								<div class="stars">
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
								</div>
								<span class="rating-text">0 (0)</span>
							</div>
						</div>
					</div>

					<div class="product-card">
						<div class="product-image"></div>
						<div class="product-info">
							<h3 class="product-title">도서 대출 관리</h3>
							<div class="product-price">2,500원</div>
							<div class="product-rating">
								<div class="stars">
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
									<div class="star"></div>
								</div>
								<span class="rating-text">0 (0)</span>
							</div>
						</div>
					</div>
				</div>

				<button class="load-more-btn" id="loadMoreBtn">더보기</button>
			</div>
		</section>

		<!-- 책 속 한 줄 -->
		<section class="quotes-section">
			<div class="quotes-container">
				<div class="quotes-header">
					<h2 class="quotes-title">책 속 한 줄</h2>
					<p class="quotes-sub">오늘의 문장을 골라 담아보세요 ✨</p>
				</div>

				<div class="q-wrap">
					<div class="q-track" id="quotesTrack">
						<!-- 카드들 -->
						<article class="q-card">
							<div class="q-bar"></div>
							<div class="q-body">
								<p class="q-quote">위험과 기회는 종이 한 장 차이다. 한 걸음 더 내딛는 용기가 삶을
									바꾼다.</p>
								<div class="q-meta">
									<div class="q-book">
										<div class="q-thumb" aria-hidden="true"></div>
										<div class="q-info">
											<span class="q-title">책이 들려주는 이야기</span> <span
												class="q-author">민음사</span>
										</div>
									</div>
									<span class="q-pub">추천</span>
								</div>
							</div>
						</article>

						<article class="q-card">
							<div class="q-bar"></div>
							<div class="q-body">
								<p class="q-quote">나이가 들수록 단단해지는 건 껍질이 아니라 마음의 방향이다.</p>
								<div class="q-meta">
									<div class="q-book">
										<div class="q-thumb"></div>
										<div class="q-info">
											<span class="q-title">책이 들려주는 이야기</span> <span
												class="q-author">수오서재</span>
										</div>
									</div>
									<span class="q-pub">오늘의 한줄</span>
								</div>
							</div>
						</article>

						<article class="q-card">
							<div class="q-bar"></div>
							<div class="q-body">
								<p class="q-quote">작게는 마음 한켠, 크게는 세계를 움직이는 문장들이 있다.</p>
								<div class="q-meta">
									<div class="q-book">
										<div class="q-thumb"></div>
										<div class="q-info">
											<span class="q-title">책이 들려주는 이야기</span> <span
												class="q-author">한겨레출판</span>
										</div>
									</div>
									<span class="q-pub">NEW</span>
								</div>
							</div>
						</article>

						<article class="q-card">
							<div class="q-bar"></div>
							<div class="q-body">
								<p class="q-quote">좋은 문장은 하루를 바꾸고, 좋은 책은 삶을 바꾼다.</p>
								<div class="q-meta">
									<div class="q-book">
										<div class="q-thumb"></div>
										<div class="q-info">
											<span class="q-title">책이 들려주는 이야기</span> <span
												class="q-author">민음사</span>
										</div>
									</div>
									<span class="q-pub">베스트</span>
								</div>
							</div>
						</article>
					</div>

					<div class="q-nav">
						<button type="button" class="q-btn" id="quotesPrev"
							aria-label="이전">‹</button>
						<button type="button" class="q-btn" id="quotesNext"
							aria-label="다음">›</button>
					</div>
				</div>
			</div>
		</section>

		<!-- 후기 -->
		<section class="testimonials-section">
			<div class="testimonials-container">
				<h2 class="testimonials-title">10,000명이 선택한 도서관리 시스템!</h2>
				<div class="testimonials-grid">
					<div class="testimonial-card">
						<h3 class="testimonial-title">간편한 사용법으로 만족도가 높습니다.</h3>
						<p class="testimonial-text">도서 대출과 반납이 너무 쉬워졌어요. 이제 도서관 업무가 한결
							수월해졌습니다!</p>
						<div class="testimonial-author">김00님</div>
					</div>
					<div class="testimonial-card">
						<h3 class="testimonial-title">효율적인 관리로 시간을 절약합니다.</h3>
						<p class="testimonial-text">도서 관리가 체계적으로 이루어져 업무 효율이 크게
							향상되었습니다. 추천합니다!</p>
						<div class="testimonial-author">박00님</div>
					</div>
					<div class="testimonial-card">
						<h3 class="testimonial-title">사용자 경험이 매우 뛰어납니다.</h3>
						<p class="testimonial-text">도서관 이용자들이 쉽게 접근할 수 있어 사용자 만족도가
							높습니다. 인터페이스도 직관적입니다.</p>
						<div class="testimonial-author">이00님</div>
					</div>
				</div>
			</div>
		</section>

		<!-- FAQ -->
		<section class="faq-section">
			<div class="faq-container">
				<h2 class="section-title">자주 묻는 질문</h2>

				<div class="faq-item">
					<div class="faq-question">
						<span>배송 기간은 얼마나 걸리나요?</span> <span class="faq-icon">▼</span>
					</div>
					<div class="faq-answer">일반 배송은 지역에 따라 1~3일 소요됩니다. 택배사 사정에 따라
						다소 지연될 수 있습니다.</div>
				</div>

				<div class="faq-item">
					<div class="faq-question">
						<span>단순 변심으로도 반품이 가능한가요?</span> <span class="faq-icon">▼</span>
					</div>
					<div class="faq-answer">상품 수령 후 7일 이내라면 미개봉 상태에 한해 반품이 가능합니다.
						왕복 배송비가 부과될 수 있습니다.</div>
				</div>

				<div class="faq-item">
					<div class="faq-question">
						<span>주문 내역은 어디서 확인할 수 있나요?</span> <span class="faq-icon">▼</span>
					</div>
					<div class="faq-answer">상단의 마이페이지에서 주문 내역을 확인할 수 있으며, 주문번호로
						상세 조회가 가능합니다.</div>
				</div>

				<div class="faq-item">
					<div class="faq-question">
						<span>배송지는 변경하고 싶은데 어떻게 변경하나요?</span> <span class="faq-icon">▼</span>
					</div>
					<div class="faq-answer">상품 출고 전까지 마이페이지 또는 고객센터를 통해 주소 변경이
						가능합니다.</div>
				</div>
			</div>
		</section>
	</main>
	<!-- 챗봇 플로팅 버튼 -->
	<div id="chatbot-float-btn">
	  <button id="chatbotBtn" aria-label="챗봇 열기">
		<img src="/img/chatbot2.png" alt="챗봇 아이콘" style="width: 40px; height: 40px; bottom:20px;">
	  </button>
	</div>

	<!-- 챗봇 창(초기 숨김) -->
	<div id="chatbotModal" class="chatbot-modal" style="display:none;">
	  <div class="chatbot-window">

	    <!-- 닫기 버튼 -->
	    <button id="chatbotClose" class="chatbot-close">✕</button>

	    <!-- 대화 내용 -->
	    <div id="chatMessages" class="chat-messages"></div>

	    <!-- 입력 영역 -->
	    <div class="chat-input-box">
	      <input id="chatInput" type="text" placeholder="메시지를 입력하세요" />
	      <button id="sendBtn" class="chat-send-btn">전송</button>
	    </div>

	  </div>
	</div>
	<!-- 푸터 -->
	<footer class="footer">
		<div class="footer-container">
			<div class="footer-brand">BRAND</div>
			<div class="footer-info">
				BRAND | 대표자 : 홍길동 | 사업자번호 : 123-34-56789<br> 통신판매업 :
				0000-부산시-0000호 | 개인정보보호책임자 : 홍길동 | 이메일 : qshop@naver.com<br>
				전화번호: 00-0000-0000 | 주소 : 부산시 부산진구 범내골
			</div>
			<div class="footer-links">
				<a href="#">이용약관</a> <a href="#">개인정보처리방침</a>
			</div>
		</div>
	</footer>

	<!-- 페이지 전용 JS -->
	<script src="/js/main.js"></script>

	<!-- 고객지원 전용 JS-->
	<script src="/js/dropdown.js"></script>

	<!-- ✅ 회원 탈퇴 완료 알림 -->
	<script>
	  document.addEventListener("DOMContentLoaded", function() {
	    const urlParams = new URLSearchParams(window.location.search);
	    if (urlParams.get("status") === "withdraw_success") {
	      alert("회원 탈퇴가 완료되었습니다.");
	    }
	  });
	</script>
</body>
</html>
