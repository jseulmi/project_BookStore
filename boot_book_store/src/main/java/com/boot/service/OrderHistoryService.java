package com.boot.service;

import java.util.List;


import com.boot.dto.OrderHistoryListDTO;
import com.boot.dto.OrderHistoryDetailDTO;

public interface OrderHistoryService {
	
	// 전체 주문 목록
    List<OrderHistoryListDTO> getAllOrders();

    // 오늘 주문 목록
    List<OrderHistoryListDTO> getTodayOrders();

    // 주문 상세 (주문 기본 정보 + 주문 품목 리스트)
    OrderHistoryDetailDTO getOrderDetail(int order_id);
    
    List<OrderHistoryListDTO> getPage(int page, int size);
    List<OrderHistoryListDTO> getSearchPage(String type, String keyword, int page, int size);

    int getTotalCount();
    int getSearchTotalCount(String type, String keyword);

    
	List<OrderHistoryListDTO> getTodayPage(String type, String keyword, int page, int size);
	int getTodayTotalCount(String type, String keyword);
}
