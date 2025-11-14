<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f2eee9;  /* 📌 부드러운 베이지 */
            margin: 0;
            padding: 0;
        }

        .title {
            font-size: 32px;
            font-weight: 700;
            margin: 60px 0 26px 8%;
            color: #3e2c1c; /* 📌 짙은 갈색 */
        }

        .table-container {
            width: 85%;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 16px; /* 📌 더 둥글게 */
            padding: 10px 0 20px 0;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15); /* 📌 깊은 그림자 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }

        thead {
            background: #6b4f34;  /* 📌 짙은 브라운 */
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
            border-bottom: 1px solid #ece4d9; /* 📌 연갈색 라인 */
            color: #4b3b2a;
        }

        tbody tr:hover {
            background: #f8f5f1; /* 📌 은은한 hover */
        }

        .btn-edit, .btn-delete {
            padding: 7px 18px;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn-edit {
            background: #795438; /* 📌 브라운 */
            color: white;
        }

        .btn-edit:hover {
            background: #8a6141; /* 📌 hover */
        }

        .btn-delete {
            background: #b6463b; /* 📌 따뜻한 레드 */
            color: white;
        }

        .btn-delete:hover {
            background: #cc5247;
        }
    </style>
</head>

<body>

<div class="title">회원 관리</div>

<div class="table-container">
    <table>
        <thead>
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>닉네임</th>
                <th>이메일</th>
                <th>전화번호</th>
                <th>로그인 타입</th>
                <th>가입일</th>
                <th>관리</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="m" items="${members}">
                <tr>
                    <td>${m.USER_ID}</td>
                    <td>${m.USER_NAME}</td>
                    <td>${m.USER_NICKNAME}</td>
                    <td>${m.USER_EMAIL}</td>
                    <td>${m.USER_PHONE_NUM}</td>
                    <td>${m.LOGIN_TYPE}</td>
                    <td>${m.REG_DATE}</td>

                    <td>
                        <button class="btn-edit"
                                onclick="loadPage('/admin/member/detail?user_id=${m.USER_ID}')">수정</button>
                        <button class="btn-delete"
                                onclick="if(confirm('삭제할까요?')) loadPage('/admin/member/delete?user_id=${m.USER_ID}')">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
