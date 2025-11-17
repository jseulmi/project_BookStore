package com.boot.dto;

import lombok.Data;
import java.util.List;

@Data
public class OrderHistoryDetailDTO {

    private int order_id;
    // 사용자 정보
    private String user_id;
    private String user_name;
    private String user_email;
    private String user_phone_num;
    private String user_address;
    private String user_detail_address;

    // 주문 정보
    private int total_quantity;
    private int total_price;
    private int shipping_fee;

    private String order_date;

    // 상세 리스트
    private List<OrderHistoryItemDTO> items; // 상세 리스트
}
