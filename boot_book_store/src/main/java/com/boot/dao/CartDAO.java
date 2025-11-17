package com.boot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.boot.dto.CartDTO;

@Mapper
public interface CartDAO {

    int insertCartItem(CartDTO cart);

    List<CartDTO> selectCartByUserId(@Param("user_id") String userId);

    int updateCartQuantityByParams(@Param("cart_id") int cartId,
            @Param("quantity") int quantity);

    int deleteCartItem(@Param("cart_id") int cartId);

    int deleteCartByUserId(@Param("user_id") String userId);
    
    int deleteCartItemByUserIdAndBookIds(@Param("user_id") String userId, @Param("bookIds") List<Integer> bookIds);

    List<CartDTO> selectCartWithBookByUserId(@Param("user_id") String userId);

    int deleteCartItemByUserIdAndBookId(@Param("user_id") String userId, @Param("book_id") int bookId);

    CartDTO selectCartItemByUserAndBook(@Param("user_id") String userId, @Param("book_id") int bookId);

    int deleteCartItems(@Param("cartIds") List<Integer> cartIds);
}
