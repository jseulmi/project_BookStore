package com.boot.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dao.CartDAO;
import com.boot.dto.OrderDTO;
import com.boot.dto.OrderRequestDTO;
import com.boot.service.OrderService;
import com.boot.service.TossPayService;

@Controller
public class PaymentController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private TossPayService tossPayService;
    @Autowired
    private CartDAO cartDAO;

    @GetMapping("/paymentSuccess")
    public String paymentSuccess(@RequestParam Map<String,String> params, Model model, HttpSession session) {
        String paymentKey = params.get("paymentKey");
        String orderIdStr = params.get("orderId");
        long amount = Long.parseLong(params.get("amount"));

        String numericPart = orderIdStr.replaceAll("[^0-9]", "");
        long orderId = Long.parseLong(numericPart);

        String userId = (String) session.getAttribute("loginId");

        boolean approved = tossPayService.approvePayment(paymentKey, amount, orderIdStr);

        if (approved) {
            // TODO: 임시 저장된 주문 품목 리스트 가져오기 (예시: 세션, redis 등)
            List<OrderRequestDTO.OrderItemDto> items = (List<OrderRequestDTO.OrderItemDto>) session.getAttribute(orderIdStr);
            if (items == null || items.isEmpty()) {
                model.addAttribute("errorMessage", "주문 정보가 존재하지 않습니다.");
                return "fail";
            }

            // 주문 DB 저장
            long savedOrderId = orderService.createOrderWithDetails(userId, items);

            // 장바구니에서 구매한 상품만 삭제
            List<Integer> purchasedBookIds = items.stream()
                                                  .map(OrderRequestDTO.OrderItemDto::getBook_id)
                                                  .toList();
            cartDAO.deleteCartItemByUserIdAndBookIds(userId, purchasedBookIds);

            // 주문 정보 세션 정리
            session.removeAttribute(orderIdStr);

            return "redirect:/MyPage/purchaseList";
        } else {
            model.addAttribute("errorMessage", "결제 승인에 실패했습니다.");
            return "fail";
        }
    }

}
