<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>주문 상세 | 책갈피</title>
  
  <!-- 폰트: 전체는 Noto Sans KR -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet"> 
  
  <!-- CSS 파일 링크 -->
  <link rel="stylesheet" href="/css/purchaseDetail.css" />
</head>
<body>
  <header>
    <nav class="nav" aria-label="주요 메뉴">
      <a href="<c:url value='/main'/>" class="brand">
        <img src="/img/book_logo.png" alt="책갈피 로고" class="brand-logo" />
      </a>
	  <div class="nav-right">
	    <a href="<c:url value='/mypage'/>">마이페이지</a>
	      <a href="<c:url value='/cart'/>">장바구니</a>
	      <a href="<c:url value='/logout'/>">로그아웃</a>
	      <span style="color:#666; font-weight:700;">
	        ${sessionScope.loginDisplayName}님
	  </div>
    </nav>
  </header>

  <div class="promo" aria-hidden="true"></div>
  
  <main class="page-wrap">
    <div class="page-container">
      <h1 class="page-title">구매 상세 내역</h1>

      <c:if test="${not empty orderDetails}">
        <table class="detail-table">
          <thead>
            <tr>
              <th>도서 이미지</th>
              <th>도서명</th>
              <th>수량</th>
              <th>도서 가격</th>
<!--              <th>배송비</th>-->
<!--              <th>합계 금액</th>-->
            </tr>
          </thead>
          <tbody>
            <c:forEach var="detail" items="${orderDetails}">
              <tr>
                <td>
                  <img src="${detail.book_image_url}" alt="${detail.book_title}" class="thumb" />
                </td>
                <td>${detail.book_title}</td>
                <td>${detail.quantity}</td>
                <td>₩<fmt:formatNumber value="${detail.purchase_price}" type="currency" currencySymbol=""/></td>
<!--                <td>₩<fmt:formatNumber value="${detail.shipping_fee}" type="currency" currencySymbol=""/></td>-->
<!--                <td>-->
<!--                  ₩<fmt:formatNumber value="${detail.purchase_price * detail.quantity + detail.shipping_fee}" type="currency" currencySymbol=""/>-->
<!--                </td>-->
              </tr>
            </c:forEach>
          </tbody>
        </table>

		<div class="summary-section">
		    <div>총 수량: <strong>${totalQuantity}</strong></div>
		    <div>배송비: <strong>₩<fmt:formatNumber value="${order.shipping_fee}" type="currency" currencySymbol=""/></strong></div>
		    <div>총 결제 금액: <strong>₩<fmt:formatNumber value="${order.total_price}" type="currency" currencySymbol=""/></strong></div>
		</div>

      </c:if>

      <c:if test="${empty orderDetails}">
        <p class="empty">해당 주문에 대한 상세 내역이 없습니다.</p>
      </c:if>

      <a href="<c:url value='/MyPage/purchaseList'/>" class="btn btn-brand">구매 내역으로 돌아가기</a>
    </div>
  </main>

  <footer class="footer">
    <div class="container">
      © 책갈피 BRAND · 부산시 부산진구 범내골 · 00-0000-0000 · <a href="mailto:qshop@naver.com">qshop@naver.com</a>
    </div>
  </footer>
</body>
</html>
