-- 테이블 생성 
CREATE TABLE wishlist (
    wish_id NUMBER PRIMARY KEY,
    user_id VARCHAR2(50) NOT NULL,
    book_id NUMBER NOT NULL,
    wish_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_wishlist_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_wishlist_book FOREIGN KEY (book_id) REFERENCES book(book_id),
    CONSTRAINT uk_wishlist_user_book UNIQUE (user_id, book_id)
);

-- 시퀀스 생성 
CREATE SEQUENCE wishlist_seq START WITH 1 INCREMENT BY 1;

-- 찜 목록 조회 
SELECT 
    w.*,
    b.BOOK_TITLE,
    b.BOOK_WRITER,
    b.BOOK_PRICE
FROM wishlist w
JOIN book b ON w.BOOK_ID = b.BOOK_ID
ORDER BY w.WISH_DATE DESC;
