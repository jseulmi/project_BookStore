<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>총 주문 내역</title>

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f2eee9;
            margin: 0;
            padding: 0;
        }

        .title {
            font-size: 32px;
            font-weight: 700;
            margin: 60px 0 26px 8%;
            color: #3e2c1c;
        }

        .table-container {
            width: 85%;
            margin: 0 auto 40px auto;
            background: #ffffff;
            border-radius: 16px;
            padding: 10px 0 20px 0;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }

        thead {
            background: #6b4f34;
            color: white;
            font-size: 15px;
        }

        th {
            padding: 14px 12px;
            text-align: center;
            font-weight: 600;
        }

        td {
            padding: 16px 12px;
            text-align: center;
            border-bottom: 1px solid #ece4d9;
            color: #4b3b2a;
        }

        tbody tr:hover {
            background: #f8f5f1;
        }

        .order-link {
            color: #6b4f34;
            font-weight: 600;
            text-decoration: underline;
            cursor: pointer;
        }

        .summary-bar {
            width: 85%;
            margin: 0 auto 10px auto;
            display: flex;
            justify-content: space-between;
            gap: 16px;
            font-size: 14px;
            color: #5d4732;
        }
		/* 검색 영역 */
	    .board-search {
	      display: flex;
	      gap: 12px;
	      margin-top: 30px;
	      justify-content: center;
	    }
	    .search-input {
	      padding: 12px 20px;
	      border: 2px solid #eee;
	      border-radius: 12px;
	      font-size: 14px;
	      outline: none;
	      transition: all .3s ease;
	      width: 300px;
	    }
	    .search-input:focus {
	      border-color: var(--brand);
	      box-shadow: 0 0 0 3px rgba(44,95,141,.1);
	    }
	    .search-btn {
	      padding: 12px 24px;
	      background: var(--brand);
	      color: #fff;
	      border: none;
	      border-radius: 12px;
	      font-size: 14px;
	      font-weight: 600;
	      cursor: pointer;
	      transition: all .3s ease;
	    }
	    .search-btn:hover {
	      background: var(--brand-dark);
	      transform: translateY(-2px);
	    }

	    /* 페이지네이션 */
	    .pagination {
	      display: flex;
	      justify-content: center;
	      align-items: center;
	      gap: 8px;
	      margin-top: 40px;
	    }
	    .pagination a,
	    .pagination span {
	      display: inline-flex;
	      align-items: center;
	      justify-content: center;
	      width: 40px;
	      height: 40px;
	      border-radius: 8px;
	      text-decoration: none;
	      color: var(--text);
	      font-size: 14px;
	      transition: all .2s ease;
	     
	     background-color: #f8f9fa;
	     border: 1px solid #ddd;
	     
	    }
	    .pagination a:hover {
	      background: var(--section-bg);
	      color: var(--brand);
	    }
	    .pagination .active {
	      background: var(--brand);
	      color: #fff;
	    }
	   
	   .pagination a {
	     cursor: pointer;
	   }

	   .pagination span {
	     cursor: default;
	   }

	   .pagination a:hover {
	     background: #D3D3D3;
		 color: #000;
	   }
    </style>
</head>

<body>

	<div class="title">총 주문 내역</div>

	<div class="summary-bar">
	    <div>총 주문 건수 : <strong>${total}</strong> 건</div>
	    <div>
	        <a href="javascript:void(0)" onclick="loadPage('/admin/order/today')">
	            오늘 주문내역 보기 ▶
	        </a>
	    </div>
	</div>

	<div class="table-container">
	    <table>
	        <thead>
	        <tr>
	            <th>주문번호</th>
	            <th>회원 ID</th>
	            <th>회원명</th>
	            <th>이메일</th>
	            <th>총 수량</th>
	            <th>총 금액</th>
	            <th>주문일</th>
	            <th>관리</th>
	        </tr>
	        </thead>

	        <tbody>
	        <c:forEach var="o" items="${orders}">
	            <tr>
	                <td>
	                    <span class="order-link"
	                          onclick="loadPage('/admin/order/detail?order_id=${o.order_id}')">
	                        ${o.order_id}
	                    </span>
	                </td>
	                <td>${o.user_id}</td>
	                <td>${o.user_name}</td>
	                <td>${o.user_email}</td>
	                <td>${o.total_quantity}</td>
	                <td><fmt:formatNumber value="${o.total_price}" /></td>
	                <td>${o.order_date}</td>
	                <td>
	                    <button class="btn-detail"
	                            onclick="loadPage('/admin/order/detail?order_id=${o.order_id}')">
	                        상세보기
	                    </button>
	                </td>
	            </tr>
	        </c:forEach>
	        </tbody>
	    </table>
	</div>
	<!-- 검색 영역 -->
      <div class="board-search">
        <form method="get" id="searchForm">
          <select name="type" style="padding: 12px; border: 2px solid #eee; border-radius: 12px; font-size: 14px; margin-right: 8px;">
			<option value="uid"   ${type == 'uid' ? 'selected' : ''}>회원 ID</option>
			<option value="uname" ${type == 'uname' ? 'selected' : ''}>회원명</option>
			<option value="email" ${type == 'email' ? 'selected' : ''}>이메일</option>
          </select>
          <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력하세요" value="${param.keyword}">
          <button type="submit" class="search-btn">검색</button>
        </form>
      </div>

      <!-- 페이지네이션 -->
      <div class="pagination">
		<c:if test="${startPage > 1}">
		    <a href="javascript:void(0)"
		       onclick="loadPage('${pageContext.request.contextPath}/admin/order/list?page=${startPage-1}&type=${type}&keyword=${keyword}')">
		        <
		    </a>
		</c:if>

		<c:forEach var="i" begin="${startPage}" end="${endPage}">
		    <a href="javascript:void(0)"
		       onclick="loadPage('${pageContext.request.contextPath}/admin/order/list?page=${i}&type=${type}&keyword=${keyword}')"
		       class="${i == page ? 'active' : ''}">
		       ${i}
		    </a>
		</c:forEach>

		<c:if test="${endPage < pageCount}">
		    <a href="javascript:void(0)"
		       onclick="loadPage('${pageContext.request.contextPath}/admin/order/list?page=${endPage+1}&type=${type}&keyword=${keyword}')">
		        >
		    </a>
		</c:if>
      </div>
    </div>
	<script>
	  document.getElementById("searchForm").addEventListener("submit", function(e) {
	      e.preventDefault(); // 기존 submit 막기

	      const type = this.type.value;
	      const keyword = this.keyword.value;

	      const url = "${pageContext.request.contextPath}/admin/order/list"
	                  + "?type=" + encodeURIComponent(type)
	                  + "&keyword=" + encodeURIComponent(keyword);

	      loadPage(url); // 비동기로 페이지 로드
	  });
	  </script>
</body>
</html>
