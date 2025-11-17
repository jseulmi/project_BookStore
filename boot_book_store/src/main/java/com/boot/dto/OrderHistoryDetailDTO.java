package com.boot.dto;

import lombok.Data;
import java.util.List;

@Data
public class OrderHistoryDetailDTO {

    private int order_id;
    private String user_id;
    private String user_name;
    private String user_email;

    private int total_quantity;
    private int total_price;
    private int shipping_fee;

    private String order_date;

    private List<OrderHistoryItemDTO> items; // 상세 리스트
}
