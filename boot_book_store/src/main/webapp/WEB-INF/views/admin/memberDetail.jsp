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
            <input type="text" name="user_email" readonly>

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

<script>
// 페이지 로드 시 회원 정보 가져오기 (AJAX 로드 대응)
(function() {
    // URL에서 user_id 파라미터 추출 (직접 접근 또는 AJAX 로드 모두 대응)
    let userId = null;
    
    // 1. window.location에서 시도
    const urlParams = new URLSearchParams(window.location.search);
    userId = urlParams.get('user_id');
    
    // 2. AJAX 로드인 경우, 현재 페이지의 스크립트 태그에서 URL 추출 시도
    if (!userId) {
        // loadPage로 전달된 URL을 찾기 위해 약간의 지연 후 재시도
        setTimeout(function() {
            loadMemberData();
        }, 100);
    } else {
        loadMemberData();
    }
    
    function loadMemberData() {
        // 다시 한번 URL에서 추출 시도
        const currentUrl = window.location.href;
        const urlMatch = currentUrl.match(/[?&]user_id=([^&]*)/);
        if (urlMatch) {
            userId = urlMatch[1];
        }
        
        // 또는 전역 변수나 다른 방법으로 user_id를 가져올 수 있다면
        if (!userId && typeof getCurrentUserId === 'function') {
            userId = getCurrentUserId();
        }
        
        if (userId) {
            // 회원 상세 정보 가져오기
            fetch('/admin/member/detailData?user_id=' + userId)
                .then(res => {
                    if (!res.ok) {
                        throw new Error('서버 오류: ' + res.status);
                    }
                    return res.json();
                })
                .then(data => {
                    if (data) {
                        // 입력 필드에 데이터 채우기
                        const userIdInput = document.querySelector("input[name='user_id']");
                        const userNameInput = document.querySelector("input[name='user_name']");
                        const userNicknameInput = document.querySelector("input[name='user_nickname']");
                        const userEmailInput = document.querySelector("input[name='user_email']");
                        const userPhoneInput = document.querySelector("input[name='user_phone_num']");
                        const userAddressInput = document.querySelector("input[name='user_address']");
                        const userDetailAddressInput = document.querySelector("input[name='user_detail_address']");
                        
                        if (userIdInput) userIdInput.value = data.USER_ID || '';
                        if (userNameInput) userNameInput.value = data.USER_NAME || '';
                        if (userNicknameInput) userNicknameInput.value = data.USER_NICKNAME || '';
                        if (userEmailInput) userEmailInput.value = data.USER_EMAIL || '';
                        if (userPhoneInput) userPhoneInput.value = data.USER_PHONE_NUM || '';
                        if (userAddressInput) userAddressInput.value = data.USER_ADDRESS || '';
                        if (userDetailAddressInput) userDetailAddressInput.value = data.USER_DETAIL_ADDRESS || '';
                    }
                })
                .catch(error => {
                    console.error('회원 정보를 불러오는 중 오류가 발생했습니다:', error);
                });
        }
    }
})();
</script>

</body>
</html>

