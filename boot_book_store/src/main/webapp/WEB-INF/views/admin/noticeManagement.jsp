<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>공지사항 관리</title>

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background: #f2eee9;
      margin: 0;
      padding: 0;
    }

    .title-header {
      width: 85%;
      margin: 60px auto 26px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .title {
      font-size: 32px;
      font-weight: 700;
      color: #3e2c1c;
      margin: 0;
    }

    .table-container {
      width: 85%;
      margin: 0 auto;
      background: #ffffff;
      border-radius: 16px;
      padding: 0;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
      overflow: hidden;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 15px;
      margin: 0;
    }

    thead {
      background: #6b4f34;
      color: white;
      font-size: 15px;
    }

    th {
      padding: 16px 12px;
      text-align: center;
      font-weight: 600;
      border: none;
    }

    tbody {
      background: #ffffff;
    }

    td {
      padding: 18px 12px;
      text-align: center;
      border: none;
      border-bottom: 1px solid #ece4d9;
      color: #4b3b2a;
      background: #ffffff;
    }

    tbody tr {
      background: #ffffff;
      transition: background-color 0.2s;
    }

    tbody tr:hover {
      background: #f8f5f1;
    }

    tbody tr:last-child td {
      border-bottom: none;
    }

    td.title-cell {
      text-align: left;
    }

    .link-title {
      color: #4b3b2a;
      text-decoration: none;
      font-weight: 600;
    }

    .link-title:hover {
      color: #795438;
      text-decoration: underline;
    }

    .action-bar {
      width: 85%;
      margin: 20px auto 0;
      display: flex;
      justify-content: flex-end;
    }

    .btn-primary {
      padding: 12px 22px;
      background: #795438;
      color: #fff;
      border: none;
      border-radius: 10px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      transition: 0.2s;
    }

    .btn-primary:hover {
      background: #8a6141;
    }

    .search-container {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      flex-wrap: wrap;
      gap: 12px;
    }

    .search-form {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
    }

    .search-form select,
    .search-form input {
      padding: 12px 14px;
      border: 1px solid #d9cfc4;
      border-radius: 10px;
      background: #faf7f3;
      font-size: 14px;
      color: #4b3b2a;
      outline: none;
    }

    .search-form input:focus,
    .search-form select:focus {
      border-color: #8a6b52;
      background: #fff;
      box-shadow: 0 0 0 2px rgba(138, 107, 82, 0.2);
    }

    .btn-search {
      padding: 12px 22px;
      background: #795438;
      color: white;
      border: none;
      border-radius: 10px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      transition: 0.2s;
    }

    .btn-search:hover {
      background: #8a6141;
    }

    .pagination {
      width: 85%;
      margin: 30px auto 60px;
      display: flex;
      justify-content: center;
      gap: 8px;
      flex-wrap: wrap;
    }

    .pagination a {
      min-width: 34px;
      padding: 8px 12px;
      text-align: center;
      border-radius: 8px;
      border: 1px solid #d9cfc4;
      color: #4b3b2a;
      text-decoration: none;
      font-weight: 600;
      transition: 0.2s;
    }

    .pagination a:hover {
      background: #f8f5f1;
    }

    .pagination a.active {
      background: #6b4f34;
      color: #fff;
      border-color: #6b4f34;
    }
  </style>
</head>
<body>

<div class="title-header">
  <div class="title">공지사항 관리</div>
  <div class="search-container">
    <form class="search-form" method="get" id="searchForm">
      <select name="type">
        <option value="tc" ${type == 'tc' ? 'selected' : ''}>제목+내용</option>
        <option value="title" ${type == 'title' ? 'selected' : ''}>제목</option>
        <option value="content" ${type == 'content' ? 'selected' : ''}>내용</option>
      </select>
      <input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${param.keyword}">
      <button type="submit" class="btn-search">검색</button>
    </form>
  </div>
</div>

<div class="table-container">
  <table>
    <thead>
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>조회수</th>
    </tr>
    </thead>
    <tbody>
    <c:choose>
      <c:when test="${empty noticeList}">
        <tr>
          <td colspan="5">등록된 공지사항이 없습니다.</td>
        </tr>
      </c:when>
      <c:otherwise>
        <c:forEach var="notice" items="${noticeList}">
          <tr>
            <td>${notice.noticeNo}</td>
            <td class="title-cell">
              <a class="link-title" href="javascript:void(0)"
                 onclick="loadPage('${pageContext.request.contextPath}/admin/notice/detail?noticeNo=${notice.noticeNo}')">
                <c:out value="${notice.noticeTitle}" />
              </a>
            </td>
            <td>관리자</td>
            <td>${notice.formattedDate}</td>
            <td>${notice.noticeHit}</td>
          </tr>
        </c:forEach>
      </c:otherwise>
    </c:choose>
    </tbody>
  </table>
</div>

<div class="action-bar">
  <button type="button" class="btn-primary" onclick="loadPage('/admin/notice/write')">공지 등록</button>
</div>

<div class="pagination">
  <c:if test="${startPage > 1}">
    <a href="javascript:void(0)"
       onclick="loadPage('${pageContext.request.contextPath}/admin/noticeManagement?page=${startPage-1}')">&lt;</a>
  </c:if>

  <c:forEach var="i" begin="${startPage}" end="${endPage}">
    <a href="javascript:void(0)"
       onclick="loadPage('${pageContext.request.contextPath}/admin/noticeManagement?page=${i}')"
       class="${i == page ? 'active' : ''}">${i}</a>
  </c:forEach>

  <c:if test="${endPage < pageCount}">
    <a href="javascript:void(0)"
       onclick="loadPage('${pageContext.request.contextPath}/admin/noticeManagement?page=${endPage+1}')">&gt;</a>
  </c:if>
</div>

<script>
  document.getElementById("searchForm").addEventListener("submit", function(e) {
    e.preventDefault();

    const type = this.type.value;
    const keyword = this.keyword.value;

    const url = "${pageContext.request.contextPath}/admin/noticeManagement"
      + "?type=" + encodeURIComponent(type)
      + "&keyword=" + encodeURIComponent(keyword);

    loadPage(url);
  });
</script>
</body>
</html>
