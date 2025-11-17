<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>문의 관리 - 관리자</title>
  <link rel="stylesheet" href="/css/adminMain.css">
  <style>
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 16px;
      margin-bottom: 24px;
    }

    .stat-card {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }

    .stat-card-title {
      font-size: 13px;
      color: #6B7280;
      margin-bottom: 8px;
    }

    .stat-card-value {
      font-size: 24px;
      font-weight: 700;
      color: #111827;
    }

    .inquiry-table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }

    .inquiry-table thead {
      background-color: #F9FAFB;
    }

    .inquiry-table th {
      padding: 12px 16px;
      text-align: left;
      font-weight: 600;
      color: #374151;
      font-size: 13px;
      border-bottom: 2px solid #E5E7EB;
    }

    .inquiry-table td {
      padding: 12px 16px;
      border-bottom: 1px solid #E5E7EB;
      font-size: 14px;
    }

    .inquiry-table tbody tr:hover {
      background-color: #F9FAFB;
    }

    .inquiry-table tbody tr:last-child td {
      border-bottom: none;
    }

    .status-badge {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 12px;
      font-size: 11px;
      font-weight: 600;
    }

    .status-waiting {
      background-color: #FEF3C7;
      color: #92400E;
    }

    .status-completed {
      background-color: #D1FAE5;
      color: #065F46;
    }

    .btn-view {
      background-color: #4F46E5;
      color: white;
      padding: 6px 12px;
      border: none;
      border-radius: 6px;
      text-decoration: none;
      font-size: 12px;
      cursor: pointer;
      display: inline-block;
    }

    .btn-view:hover {
      background-color: #4338CA;
    }

    .btn-edit {
      background-color: #10B981;
      color: white;
      padding: 6px 12px;
      border: none;
      border-radius: 6px;
      text-decoration: none;
      font-size: 12px;
      cursor: pointer;
      display: inline-block;
    }

    .btn-edit:hover {
      background-color: #059669;
    }
  </style>
</head>
<body>
  <div class="app">
    <aside class="sidebar" aria-label="사이드바">
      <div class="brand">
        <img src="/img/book_logo.png" class="brand-logo" alt="로고">
        tqShop 관리자
      </div>
      <nav class="nav">
        <div class="nav-section">
          <div class="nav-section-title">문의내역</div>
          <ul class="nav-list">
            <li class="nav-item">
              <button onclick="location.href='<c:url value='/inquiry/admin/list'/>'">문의 리스트</button>
            </li>
          </ul>
        </div>
      </nav>
    </aside>

    <main class="main" role="main">
      <header class="topbar">
        <div class="left">
          <div class="search">문의 관리</div>
        </div>
        <div class="right">
          <div style="font-size:13px;">관리자명</div>
        </div>
      </header>

      <section class="content">
        <h1 style="font-size:18px;margin:0 0 6px 0;">1:1 문의 관리</h1>
        <div style="color:var(--muted);font-size:13px;margin-bottom:18px;">고객 문의를 확인하고 답변을 작성하세요.</div>

        <c:set var="totalCount" value="${inquiryList.size()}" />
        <c:set var="pendingCount" value="0" />
        <c:forEach var="inquiry" items="${inquiryList}">
          <c:if test="${inquiry.status == '대기중'}">
            <c:set var="pendingCount" value="${pendingCount + 1}" />
          </c:if>
        </c:forEach>

        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-card-title">전체 문의</div>
            <div class="stat-card-value">${totalCount}</div>
          </div>
          <div class="stat-card">
            <div class="stat-card-title">답변 대기</div>
            <div class="stat-card-value" style="color: #F59E0B;">${pendingCount}</div>
          </div>
          <div class="stat-card">
            <div class="stat-card-title">답변 완료</div>
            <div class="stat-card-value" style="color: #10B981;">${totalCount - pendingCount}</div>
          </div>
        </div>

        <table class="inquiry-table">
          <thead>
            <tr>
              <th style="width: 8%;">번호</th>
              <th style="width: 15%;">작성자</th>
              <th style="width: 40%;">제목</th>
              <th style="width: 12%;">상태</th>
              <th style="width: 15%;">작성일</th>
              <th style="width: 10%;">관리</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty inquiryList || inquiryList.size() == 0}">
                <tr>
                  <td colspan="6" style="text-align: center; padding: 40px; color: #6B7280;">
                    등록된 문의가 없습니다.
                  </td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="inquiry" items="${inquiryList}">
                  <tr>
                    <td>${inquiry.inquiry_id}</td>
                    <td>${inquiry.user_name}</td>
                    <td style="font-weight: 500;">${inquiry.title}</td>
                    <td>
                      <span class="status-badge ${inquiry.status == '답변완료' ? 'status-completed' : 'status-waiting'}">
                        ${inquiry.status}
                      </span>
                    </td>
                    <td>
                      <fmt:formatDate value="${inquiry.created_date}" pattern="yyyy-MM-dd" />
                    </td>
                    <td onclick="event.stopPropagation();">
                      <c:choose>
                        <c:when test="${inquiry.status == '답변완료'}">
                          <button onclick="loadInquiryDetail(${inquiry.inquiry_id})" class="btn-edit">답변수정</button>
                        </c:when>
                        <c:otherwise>
                          <button onclick="loadInquiryDetail(${inquiry.inquiry_id})" class="btn-view">답변</button>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </section>
    </main>
  </div>
</body>
</html>
