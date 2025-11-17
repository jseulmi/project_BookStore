package com.boot.dto;

import lombok.Data;

@Data
public class OrderHistoryListDTO {
    private int order_id;

    private String user_id;
    private String user_name;
    private String user_email;

    private int total_quantity;
    private int total_price;

    private String order_date;
}
