<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세 정보</title>

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f2eee9;  /* 📌 베이지 */
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 70px auto;
            background: #ffffff;
            padding: 40px;
            border-radius: 16px; /* 📌 둥근 카드 */
            box-shadow: 0 10px 25px rgba(0,0,0,0.18); /* 📌 깊은 그림자 */
        }

        h2 {
            font-size: 30px;
            font-weight: 700;
            color: #3e2c1c; /* 📌 진한 브라운 */
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-top: 18px;
            margin-bottom: 6px;
            color: #4b3b2a;
            font-size: 15px;
        }

        input {
            width: 100%;
            padding: 14px 12px;
            border: 1px solid #d9cfc4;
            border-radius: 8px;
            background: #faf7f3; /* 📌 연베이지 */
            font-size: 15px;
            color: #4b3b2a;
            outline: none;
            transition: 0.2s;
        }

        input:focus {
            border-color: #8a6b52;
            background: #fff;
            box-shadow: 0 0 0 2px rgba(138, 107, 82, 0.2);
        }

        .btn-wrap {
            margin-top: 35px;
            display: flex;
            justify-content: space-between;
        }

        .btn {
            padding: 12px 26px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn-save {
            background: #795438; /* 📌 브라운 */
            color: white;
        }

        .btn-save:hover {
            background: #8e6545;
        }

        .btn-cancel {
            background: #a79a91; /* 📌 부드러운 그레이 */
            color: white;
        }

        .btn-cancel:hover {
            background: #b3a79e;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>회원 상세 정보</h2>

        <div>
            <label>아이디</label>
            <input type="text" name="user_id" readonly>

            <label>이름</label>
            <input type="text" name="user_name" readonly>

            <label>닉네임</label>
            <input type="text" name="user_nickname">

            <label>이메일</label>
            <input type="text" name="user_email">

            <label>전화번호</label>
            <input type="text" name="user_phone_num">

            <label>주소</label>
            <input type="text" name="user_address">

            <label>상세주소</label>
            <input type="text" name="user_detail_address">

            <div class="btn-wrap">
                <button class="btn btn-save" type="button" onclick="saveMember()">저장</button>
                <button class="btn btn-cancel" type="button"
                        onclick="loadPage('/admin/member/adminlist')">취소</button>
            </div>
        </div>
    </div>
</body>
</html>
