<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>권한 관리</title>

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
            margin: 60px 0 10px 8%;
            color: #3e2c1c;
        }

        .subtitle {
            font-size: 14px;
            color: #6b7280;
            margin: 0 0 30px 8%;
        }

        .stats-container {
            width: 85%;
            margin: 0 auto 30px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
        }

        .stat-card {
            background: #ffffff;
            padding: 24px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            text-align: center;
        }

        .stat-card-title {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .stat-card-value {
            font-size: 28px;
            font-weight: 700;
            color: #3e2c1c;
        }

        .stat-card-value.admin {
            color: #795438;
        }

        .stat-card-value.user {
            color: #10b981;
        }

        .table-container {
            width: 85%;
            margin: 0 auto 40px;
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

        .role-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        td.role-cell {
            text-align: center !important;
            vertical-align: middle !important;
            padding: 18px 12px !important;
        }

        td.role-cell .role-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .role-badge.USER {
            background: #e0f2fe;
            color: #0369a1;
        }

        .role-badge.ADMIN {
            background: #fef3c7;
            color: #92400e;
        }

        .role-select {
            padding: 8px 12px;
            border: 1px solid #d9cfc4;
            border-radius: 8px;
            background: #faf7f3;
            font-size: 14px;
            color: #4b3b2a;
            cursor: pointer;
            outline: none;
            transition: 0.2s;
            margin-right: 8px;
        }

        .role-select:focus {
            border-color: #8a6b52;
            background: #fff;
            box-shadow: 0 0 0 2px rgba(138, 107, 82, 0.2);
        }

        .btn-save-role {
            padding: 8px 20px;
            background: #795438;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn-save-role:hover {
            background: #8a6141;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .btn-remove-admin {
            padding: 8px 20px;
            background: #b6463b;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn-remove-admin:hover {
            background: #cc5247;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .action-cell {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .empty-message {
            text-align: center;
            padding: 60px 20px;
            color: #6b7280;
            font-size: 15px;
        }

        .section-title {
            font-size: 24px;
            font-weight: 700;
            margin: 50px 0 20px 8%;
            color: #3e2c1c;
        }
    </style>

</head>

<body>

<div class="title">권한 관리</div>
<div class="subtitle">회원 권한을 관리하고 관리자 계정을 설정할 수 있습니다.</div>

<%
    java.util.List membersList = (java.util.List)request.getAttribute("members");
    java.util.List adminsList = (java.util.List)request.getAttribute("admins");
    
    int totalMembers = membersList != null ? membersList.size() : 0;
    int adminCount = adminsList != null ? adminsList.size() : 0;
    int userCount = 0;
    
    if (membersList != null) {
        for (Object m : membersList) {
            if (m instanceof java.util.Map) {
                java.util.Map map = (java.util.Map)m;
                Object role = map.get("USER_ROLE");
                if (role != null && "USER".equals(role.toString())) {
                    userCount++;
                }
            }
        }
    }
    
    pageContext.setAttribute("totalMembers", totalMembers);
    pageContext.setAttribute("adminCount", adminCount);
    pageContext.setAttribute("userCount", userCount);
%>

<div class="stats-container">
    <div class="stat-card">
        <div class="stat-card-title">전체 회원</div>
        <div class="stat-card-value">${totalMembers}</div>
    </div>
    <div class="stat-card">
        <div class="stat-card-title">관리자</div>
        <div class="stat-card-value admin">${adminCount}</div>
    </div>
    <div class="stat-card">
        <div class="stat-card-title">일반 회원</div>
        <div class="stat-card-value user">${userCount}</div>
    </div>
</div>

<div class="section-title">회원 권한 관리</div>

<div class="table-container">
    <table>
        <thead>
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>현재 권한</th>
            <th>권한 변경</th>
        </tr>
        </thead>

        <tbody>
        <c:choose>
            <c:when test="${empty members}">
                <tr>
                    <td colspan="4" class="empty-message">등록된 회원이 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="m" items="${members}">
                    <tr>
                        <td>${m.USER_ID}</td>
                        <td>${m.USER_NAME}</td>
                        <td class="role-cell">
                            <span class="role-badge ${m.USER_ROLE}">
                                ${m.USER_ROLE == 'ADMIN' ? '관리자' : '일반'}
                            </span>
                        </td>
                        <td>
                            <div class="action-cell">
                                <select class="role-select" id="role_${m.USER_ID}">
                                    <option value="USER"  ${m.USER_ROLE == 'USER'  ? 'selected' : ''}>일반</option>
                                    <option value="ADMIN" ${m.USER_ROLE == 'ADMIN' ? 'selected' : ''}>관리자</option>
                                </select>
                                <button class="btn-save-role"
                                        onclick="updateRole('${m.USER_ID}')">
                                    변경
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>

    </table>
</div>

<div class="section-title">관리자 계정 목록</div>

<div class="table-container">
    <table>
        <thead>
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>이메일</th>
            <th>권한</th>
            <th>관리</th>
        </tr>
        </thead>

        <tbody>
        <c:choose>
            <c:when test="${empty admins}">
                <tr>
                    <td colspan="5" class="empty-message">등록된 관리자가 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="a" items="${admins}">
                    <tr>
                        <td>${a.USER_ID}</td>
                        <td>${a.USER_NAME}</td>
                        <td>${a.USER_EMAIL}</td>
                        <td class="role-cell">
                            <span class="role-badge ADMIN">관리자</span>
                        </td>
                        <td>
                            <button class="btn-remove-admin"
                                    onclick="if(confirm('정말 관리자 권한을 제거하시겠습니까?')) removeAdmin('${a.USER_ID}')">
                                관리자 제거
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>

    </table>
</div>

<script>
function updateRole(userId) {
    const select = document.getElementById('role_' + userId);
    const newRole = select.value;
    
    if (!confirm('권한을 변경하시겠습니까?')) {
        return;
    }

    fetch('/admin/member/updateRole', {
        method: 'POST',
        headers: { 
            'Content-Type': 'application/json' 
        },
        body: JSON.stringify({
            user_id: userId,
            user_role: newRole
        })
    })
    .then(res => res.text())
    .then(result => {
        alert('권한이 변경되었습니다.');
        if (typeof loadPage === 'function') {
            loadPage('/admin/member/authority');
        } else {
            location.reload();
        }
    })
    .catch(err => {
        console.error(err);
        alert('오류가 발생했습니다.');
    });
}

function removeAdmin(userId) {
    if (!confirm('해당 사용자의 관리자 권한을 제거하시겠습니까?')) {
        return;
    }

    fetch('/admin/member/updateRole', {
        method: 'POST',
        headers: { 
            'Content-Type': 'application/json' 
        },
        body: JSON.stringify({
            user_id: userId,
            user_role: 'USER'
        })
    })
    .then(res => res.text())
    .then(result => {
        alert('관리자 권한이 제거되었습니다.');
        if (typeof loadPage === 'function') {
            loadPage('/admin/member/authority');
        } else {
            location.reload();
        }
    })
    .catch(err => {
        console.error(err);
        alert('오류가 발생했습니다.');
    });
}
</script>

</body>
</html>
