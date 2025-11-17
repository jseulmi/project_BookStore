<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>${post.boardTitle}</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/css/adminBoardDetail.css">
</head>
<body>

	<section class="write-section">
	  <div class="write-container">
	    <form class="write-form readonly">

	      <!-- 제목 -->
	      <div class="form-group">
	        <label class="form-label">제목</label>
	        <input type="text" class="form-input" value="${post.boardTitle}" readonly>
	      </div>

	      <!-- 첨부 이미지 -->
	      <div class="form-group">
	        <c:choose>
	          <c:when test="${not empty attaches}">
	            <c:forEach var="att" items="${attaches}">
	              <img src="${att.filePath}" alt="${att.fileName}" style="max-width:400px; margin-bottom:10px;">
	            </c:forEach>
	          </c:when>
	          <c:otherwise>
	            <p>첨부된 이미지가 없습니다.</p>
	          </c:otherwise>
	        </c:choose>
	      </div>

	      <!-- 내용 -->
	      <div class="form-group">
	        <textarea class="form-textarea" readonly>${post.boardContent}</textarea>
	      </div>

	      <!-- 게시글 정보 -->
	      <table class="info-table">
	        <tr>
	          <th>번호</th><td>${post.boardNo}</td>
	          <th>작성자</th><td>${post.userId}</td>
	        </tr>
	        <tr>
	          <th>작성일</th>
	          <td>
	            <fmt:formatDate value="${boardDate}" pattern="yyyy-MM-dd HH:mm"/>
	          </td>
	          <th>조회수</th><td>${post.boardHit}</td>
	        </tr>
	      </table>

	      <!-- ✅ 버튼 영역 -->
		  <div class="form-actions">
		        <button type="button" class="btn btn-write"
		                onclick="loadPage('${pageContext.request.contextPath}/admin/board/edit/${post.boardNo}')">수정</button>

		        <button type="button" class="btn btn-delete"
		                onclick="deleteBoard('/admin/board/delete/${post.boardNo}')">삭제</button>

		        <button type="button" class="btn btn-list"
		                onclick="loadPage('${pageContext.request.contextPath}/admin/boardManagement')">목록</button>
		  </div>
	    </form>
	  </div>
	</section>
	<script>
		function deleteBoard(url) {
			if (!confirm("삭제하시겠습니까?")) return;

			    fetch(url)
		        .then(() => {
		            loadPage("/admin/boardManagement"); 
		        });
		}

	</script>
</body>
</html>
