package com.boot.dao;

import com.boot.dto.OrderDTO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface OrderDAO {
    // 주문 저장
    int insertOrder(OrderDTO order);
    
    // 주문 조회
    List<OrderDTO> selectPurchaseListByUserId(@Param("userId") String userId);    
    
    OrderDTO selectOrderById(long orderId);

}
