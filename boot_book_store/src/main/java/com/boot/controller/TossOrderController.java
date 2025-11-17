package com.boot.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.boot.dao.CartDAO;
import com.boot.dto.OrderDTO;
import com.boot.dto.OrderRequestDTO;
import com.boot.dto.OrderRequestDTO.OrderItemDto;
import com.boot.service.OrderService;
import com.boot.service.TossPayService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api")
public class TossOrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private TossPayService tossPayService;
    @Autowired
    private CartDAO cartDAO;


 // 결제 준비 단계: 주문 생성은 하지 않고 임시 주문 정보만 세션에 저장
    @PostMapping("/createTossOrder")
    public ResponseEntity<?> createTossOrder(@RequestBody OrderRequestDTO orderRequest, HttpSession session) {
        String userId = (String) session.getAttribute("loginId");
        if (userId == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("success", false, "message", "로그인이 필요합니다."));
        }

        try {
            int totalPrice = orderService.calculateTotalPrice(orderRequest.getItems());
            // 임시 주문 ID 생성 (예: UUID 대신 타임스탬프 + userId)
            String tempOrderId = "TEMP" + userId + "_" + System.currentTimeMillis();

            // 임시 주문 정보를 세션에 저장 (실무에서는 Redis 같은 외부 저장소 추천)
            session.setAttribute(tempOrderId, orderRequest.getItems());

            return ResponseEntity.ok(Map.of(
                "success", true,
                "order_id", tempOrderId,
                "total_price", totalPrice,
                "user_id", userId
            ));
        } catch (Exception e) {
            log.error("createTossOrder 오류", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("success", false, "message", e.getMessage()));
        }
    }
    
    
    @PostMapping("/updateOrderStatus")
    public ResponseEntity<?> updateOrderStatus(@RequestBody Map<String, Object> payload) {
        try {
            int orderId = (int) payload.get("orderId");
            String status = (String) payload.get("status");
            String tid = (String) payload.get("tid");

            OrderDTO order = new OrderDTO();
            order.setOrder_id(orderId);

            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false, "message", e.getMessage()));
        }
    }
    
 // 결제 승인 콜백: 결제가 성공하면 임시 주문 데이터를 꺼내 실제 주문을 생성
    @PostMapping("/approvePayment")
    public ResponseEntity<?> approvePayment(@RequestBody Map<String, Object> payload, HttpSession session) {
        String paymentKey = (String) payload.get("paymentKey");
        Number amountNum = (Number) payload.get("amount");
        long amount = amountNum.longValue();
        String tempOrderId = (String) payload.get("orderId");
        String userId = (String) session.getAttribute("loginId");

        boolean approved = tossPayService.approvePayment(paymentKey, amount, tempOrderId);
        if (approved && userId != null) {
            @SuppressWarnings("unchecked")
            List<OrderRequestDTO.OrderItemDto> items = (List<OrderRequestDTO.OrderItemDto>) session.getAttribute(tempOrderId);

            if (items == null || items.isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Map.of("success", false, "message", "주문 정보가 없습니다."));
            }

            // 주문 생성
            long orderId = orderService.createOrderWithDetails(userId, items);

            // 구매한 상품 리스트만 추출
            List<Integer> purchasedBookIds = items.stream()
                    .map(OrderRequestDTO.OrderItemDto::getBook_id)
                    .toList();

            // 선택된 상품만 장바구니에서 삭제
            cartDAO.deleteCartItemByUserIdAndBookIds(userId, purchasedBookIds);

            session.removeAttribute(tempOrderId);

            return ResponseEntity.ok(Map.of("success", true, "order_id", orderId));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("success", false, "message", "결제 승인 실패 또는 세션 만료"));
        }
    }

}

