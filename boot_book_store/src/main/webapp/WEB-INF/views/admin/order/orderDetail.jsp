<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세보기</title>

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f2eee9;
            margin: 0;
            padding: 0 0 40px 0;
        }

        .title {
            font-size: 32px;
            font-weight: 700;
            margin: 40px 0 20px 8%;
            color: #3e2c1c;
        }

        .detail-container {
            width: 85%;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 16px;
            padding: 24px 32px 32px 32px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        h2 {
            font-size: 20px;
            margin: 16px 0 8px 0;
            color: #5a412b;
        }

        .section {
            margin-top: 16px;
            border-top: 1px solid #ece4d9;
            padding-top: 12px;
        }

        .field-row {
            display: flex;
            margin-bottom: 8px;
        }

        .field-label {
            width: 140px;
            font-weight: 600;
            color: #6b4f34;
        }

        .field-value {
            flex: 1;
            color: #4b3b2a;
        }

        .book-info {
            display: flex;
            gap: 24px;
        }

        .book-image {
            width: 120px;
            height: 160px;
            background: #f2eee9;
            border-radius: 8px;
            overflow: hidden;
            flex-shrink: 0;
        }

        .book-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .btn-back {
            margin-top: 20px;
            padding: 8px 18px;
            border: none;
            border-radius: 6px;
            background: #795438;
            color: white;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-back:hover {
            background: #8a6141;
        }
    </style>
</head>

<body>

	<!-- 주문 기본 정보 -->
	<div class="table-container" style="padding: 30px;">
	    <table style="width:50%; margin-bottom: 30px;">
	        <tr>
	            <th style="width:35%;">주문번호</th>
	            <td>${order.order_id}</td>
	        </tr>
	        <tr>
	            <th>회원 ID</th>
	            <td>${order.user_id}</td>
	        </tr>
	        <tr>
	            <th>회원명</th>
	            <td>${order.user_name}</td>
	        </tr>
	        <tr>
	            <th>이메일</th>
	            <td>${order.user_email}</td>
	        </tr>
	        <tr>
	            <th>총 수량</th>
	            <td>${order.total_quantity}</td>
	        </tr>
	        <tr>
	            <th>총 금액</th>
	            <td><fmt:formatNumber value="${order.total_price}" /></td>
	        </tr>
	        <tr>
	            <th>배송비</th>
	            <td><fmt:formatNumber value="${order.shipping_fee}" /></td>
	        </tr>
	        <tr>
	            <th>주문일</th>
	            <td>${order.order_date}</td>
	        </tr>
	    </table>

	    <!-- 뒤로가기 -->
	    <button class="btn-detail" onclick="loadPage('/admin/order/list')">전체 주문 목록으로</button>
	</div>


	<!-- 주문 상세 리스트 -->
	<div class="table-container">
	    <table>
	        <thead>
	        <tr>
	            <th>책번호</th>
	            <th>도서명</th>
	            <th>저자</th>
	            <th>수량</th>
	            <th>판매가</th>
	        </tr>
	        </thead>

	        <tbody>
	        <c:forEach var="item" items="${order.items}">
	            <tr>
	                <td>${item.book_id}</td>
	                <td>${item.book_title}</td>
	                <td>${item.book_writer}</td>
	                <td>${item.quantity}</td>
	                <td><fmt:formatNumber value="${item.purchase_price}" /></td>
	            </tr>
	        </c:forEach>
	        </tbody>
	    </table>
	</div>
</div>

</body>
</html>
