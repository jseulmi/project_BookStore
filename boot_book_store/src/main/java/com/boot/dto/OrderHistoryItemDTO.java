package com.boot.dto;

import lombok.Data;

@Data
public class OrderHistoryItemDTO {

    private int order_detail_id;

    private int book_id;
    private String book_title;
    private String book_writer;
    private int purchase_price;
    private int quantity;
    
    private String book_image_path;
}
