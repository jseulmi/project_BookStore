package com.boot.mapper;

import com.boot.dto.UserReviewDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserReviewMapper {
    void insertReview(UserReviewDTO review);
    UserReviewDTO selectReviewById(@Param("reviewId") Long reviewId);
}
