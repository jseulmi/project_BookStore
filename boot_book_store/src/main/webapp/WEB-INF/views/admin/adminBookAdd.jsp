<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="title">도서 등록</div>

<div class="form-container">

  <div class="form-row">
    <label>제목</label>
    <input type="text" name="book_title">
  </div>

  <div class="form-row">
    <label>저자</label>
    <input type="text" name="book_writer">
  </div>

  <div class="form-row">
    <label>출판사</label>
    <input type="text" name="book_pub">
  </div>

  <div class="form-row">
    <label>출간일</label>
    <input type="date" name="book_date">
  </div>

  <div class="form-row">
    <label>장르</label>
    <select name="genre_id">
      <c:forEach var="g" items="${genres}">
        <option value="${g.genre_id}">${g.genre_name}</option>
      </c:forEach>
    </select>
  </div>

  <div class="form-row">
    <label>가격</label>
    <input type="number" name="book_price">
  </div>

  <div class="form-row">
    <label>재고</label>
    <input type="number" name="book_count">
  </div>

  <div class="form-row">
    <label>ISBN</label>
    <input type="text" name="book_isbn">
  </div>

  <div class="form-row">
    <label>설명</label>
    <textarea name="book_comm"></textarea>
  </div>

  <div class="form-row">
    <label>이미지 URL</label>
    <input type="text" name="book_image_path">
  </div>

  <div class="form-actions">
    <button type="button" class="btn-primary" onclick="saveBookAdd()">등록</button>
    <button type="button" class="btn-outline" onclick="loadPage('/admin/book/list')">취소</button>
  </div>

</div>
