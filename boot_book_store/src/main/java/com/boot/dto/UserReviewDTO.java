package com.boot.dto;

import lombok.Data;
import java.util.Date;

@Data
public class UserReviewDTO {
    private Long review_id;
    private String user_id;
    private String user_nickname;
    private Long book_id;
    private int review_rating;
    private String review_content;
    private Date review_date;
}
