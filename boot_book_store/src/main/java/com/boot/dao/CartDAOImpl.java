package com.boot.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAOImpl {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int updateCartItemQuantity(String userId, int bookId, int quantity) {
        String sql = "UPDATE Cart SET quantity = ? WHERE user_id = ? AND book_id = ?";
        return jdbcTemplate.update(sql, quantity, userId, bookId);
    }
}
