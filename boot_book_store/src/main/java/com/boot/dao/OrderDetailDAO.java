package com.boot.dao;

import com.boot.dto.OrderDetailDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderDetailDAO {
    // 주문 상세 저장
    int insertOrderDetail(OrderDetailDTO orderDetail);

    // 특정 주문의 상세 내역 조회
    List<OrderDetailDTO> selectOrderDetailsByOrderId(@Param("orderId") long orderId);

    // 필요에 따라 상세내역 삭제, 수정 메서드 추가 가능
}
