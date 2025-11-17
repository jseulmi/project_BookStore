<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="title">도서 수정</div>

<div class="form-container">

  <input type="hidden" name="book_id" value="${book.book_id}">

  <div class="form-row">
    <label>제목</label>
    <input type="text" name="book_title" value="${book.book_title}">
  </div>

  <div class="form-row">
    <label>저자</label>
    <input type="text" name="book_writer" value="${book.book_writer}">
  </div>

  <div class="form-row">
    <label>출판사</label>
    <input type="text" name="book_pub" value="${book.book_pub}">
  </div>

  <div class="form-row">
    <label>출간일</label>
    <input type="date" name="book_date"
           value="<fmt:formatDate value='${book.book_date}' pattern='yyyy-MM-dd'/>">
  </div>

  <div class="form-row">
    <label>장르</label>
    <select name="genre_id">
      <c:forEach var="g" items="${genres}">
        <option value="${g.genre_id}"
                <c:if test="${g.genre_id == book.genre_id}">selected</c:if>>
          ${g.genre_name}
        </option>
      </c:forEach>
    </select>
  </div>

  <div class="form-row">
    <label>가격</label>
    <input type="number" name="book_price" value="${book.book_price}">
  </div>

  <div class="form-row">
    <label>재고</label>
    <input type="number" name="book_count" value="${book.book_count}">
  </div>

  <div class="form-row">
    <label>ISBN</label>
    <input type="text" name="book_isbn" value="${book.book_isbn}">
  </div>

  <div class="form-row">
    <label>설명</label>
    <textarea name="book_comm">${book.book_comm}</textarea>
  </div>

  <div class="form-row">
    <label>이미지 URL</label>
    <input type="text" name="book_image_path" value="${book.book_image_path}">
  </div>

  <div class="form-actions">
    <button type="button" class="btn-primary" onclick="saveBookEdit()">저장</button>
    <button type="button" class="btn-outline" onclick="loadPage('/admin/book/list')">취소</button>
  </div>

</div>
