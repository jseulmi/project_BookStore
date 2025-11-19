package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.boot.dto.BookDTO;

@Mapper
public interface BookDAO {
    public void insertBook(BookDTO book);
    public List<BookDTO> selectAllBooks();
    public BookDTO selectBookById(int book_id);
    public BookDTO findById(int bookId);
    public void updateBook(BookDTO book);
    public void deleteBook(int book_id);
    boolean existsById(int bookId);
    int countBooks();
    List<BookDTO> selectBooksPaging(
            @Param("offset") int offset,
            @Param("limit") int limit
        );
    List<BookDTO> recommendByBuy(String userId);
    List<BookDTO> getRandomBooks();
}
