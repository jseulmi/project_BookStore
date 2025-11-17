package com.boot.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dao.BookDAO;
import com.boot.dao.CartDAO;
import com.boot.dao.OrderDAO;
import com.boot.dao.OrderDetailDAO;
import com.boot.dto.BookDTO;
import com.boot.dto.CartDTO;
import com.boot.dto.OrderDTO;
import com.boot.dto.OrderDetailDTO;
import com.boot.service.CartService;
import com.boot.service.CartServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class OrderController {
	@Autowired
	private BookDAO bookDAO;
	@Autowired
	private CartDAO cartDAO;
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private OrderDetailDAO orderDetailDAO;
	@Autowired
	private CartServiceImpl cartServiceImpl;
	@Autowired
    private CartService cartService;

	private String getLoginId(HttpSession session) {
		return (String) session.getAttribute("loginId");
	}

	// ------------------ 장바구니 ------------------
	@RequestMapping("/cart")
	public String cart(Model model, HttpSession session) {
		log.info("@# cart()");

		String userId = getLoginId(session);
		if (userId == null)
			return "redirect:/login";

		List<CartDTO> cartList = cartDAO.selectCartWithBookByUserId(userId);
		model.addAttribute("cartList", cartList);
		return "cart";
	}

	// ------------------ 장바구니 삭제 ------------------
	@PostMapping("/deleteCartItems")
	@ResponseBody
	@Transactional
	public ResponseEntity<?> deleteCartItems(@RequestBody Map<String, List<Integer>> body, HttpSession session) {
		log.info("==deleteCartItems called==");
		String userId = getLoginId(session);
		if (userId == null) {
			log.warn("Unauthorized access attempt in deleteCartItems");
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}

		List<Integer> cartIds = body.get("cartIds");
		log.info("Received cartIds: {}", cartIds);

		if (cartIds == null || cartIds.isEmpty()) {
			log.warn("Bad request: cartIds is null or empty");
			return ResponseEntity.badRequest().build();
		}

		try {
			int deletedCount = cartDAO.deleteCartItems(cartIds);
			log.info("Deleted rows count: {}", deletedCount); // 여기에 삽입
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			log.error("Error deleting cart items", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	// ------------------ 장바구니 전체 삭제------------------
	@ResponseBody
	@Transactional
	@PostMapping("/clearCart")
	public ResponseEntity<?> clearCart(HttpSession session) {
		String userId = getLoginId(session);
		if (userId == null) {
			log.warn("Unauthorized access attempt in clearCart");
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}

		try {
			cartDAO.deleteCartByUserId(userId);
			return ResponseEntity.ok().build();
		} catch (Exception e) {
			log.error("Error clearing cart", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	//장바구니 수량 변경
	@PostMapping("/api/cart/updateQuantity")
	public ResponseEntity<?> updateCartQuantity(@RequestBody Map<String, Object> payload, HttpSession session) {
	    String userId = (String) session.getAttribute("loginId");
	    if (userId == null) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
	                .body(Map.of("success", false, "message", "로그인이 필요합니다."));
	    }

	    Object bookIdObj = payload.get("book_id");
	    Object quantityObj = payload.get("quantity");

	    if (bookIdObj == null || quantityObj == null) {
	        return ResponseEntity.badRequest().body(Map.of("success", false, "message", "book_id 또는 quantity 누락"));
	    }

	    int bookId;
	    int quantity;

	    try {
	        bookId = Integer.parseInt(bookIdObj.toString());
	        quantity = Integer.parseInt(quantityObj.toString());
	    } catch (NumberFormatException e) {
	        return ResponseEntity.badRequest().body(Map.of("success", false, "message", "book_id 또는 quantity 형식 오류"));
	    }

	    boolean updated = cartService.updateQuantity(userId, bookId, quantity);
	    if (updated) {
	        return ResponseEntity.ok(Map.of("success", true));
	    } else {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(Map.of("success", false, "message", "수량 업데이트 실패"));
	    }
	}

	// 주문하기
    @PostMapping("/orderBooks")
    @Transactional
    public String orderBooks(@RequestParam("book_id") List<Integer> bookIds,
                             @RequestParam("quantity") List<Integer> quantities,
                             HttpSession session,
                             Model model) {
        String userId = getLoginId(session);
        if (userId == null) {
            log.warn("User not logged in - redirect to login");
            return "redirect:/login";
        }
        if (bookIds == null || bookIds.isEmpty()) {
            log.warn("No bookIds received - redirect to cart");
            return "redirect:/cart";
        }

        List<Integer> invalidBookIds = new ArrayList<>();

        int totalQuantity = 0;
        int totalPrice = 0;
        int shippingFee = 0;

        List<OrderDetailDTO> orderDetails = new ArrayList<>();

        for (int i = 0; i < bookIds.size(); i++) {
            int bookId = bookIds.get(i);
            int qty = quantities.get(i);

            log.info("Checking existence for bookId: {}", bookId);
            if (!bookDAO.existsById(bookId)) {
                log.error("Book ID {} does not exist", bookId);
                invalidBookIds.add(bookId);
                continue;
            }

            BookDTO book = bookDAO.selectBookById(bookId);
            int purchasePrice = book.getBook_price();

            totalQuantity += qty;
            totalPrice += purchasePrice * qty;

            OrderDetailDTO detail = new OrderDetailDTO();
            detail.setBook_id(bookId);
            detail.setQuantity(qty);
            detail.setPurchase_price(purchasePrice);
            orderDetails.add(detail);
        }

        if (!invalidBookIds.isEmpty()) {
            model.addAttribute("error", "일부 책이 존재하지 않습니다: " + invalidBookIds);
            return "cart";
        }

        // 배송비 계산: 3만원 이상 무료, 미만 3000원
        shippingFee = totalPrice >= 30000 ? 0 : 3000;
        int grandTotal = totalPrice + shippingFee;

        // 주문 정보 생성
        OrderDTO order = new OrderDTO();
        order.setUser_id(userId);
        order.setOrder_date(new Date());
        order.setTotal_quantity(totalQuantity);
        order.setTotal_price(grandTotal);
        order.setShipping_fee(shippingFee); // DTO에 배송비 필드 추가했다고 가정

        // 주문 저장 (Order 테이블)
        orderDAO.insertOrder(order);

        long orderId = order.getOrder_id(); // insertOrder 시 자동 채번된 값이 세팅됨

        // 주문 상세 저장 (OrderDetail 테이블)
        for (OrderDetailDTO detail : orderDetails) {
            detail.setOrder_id(orderId);
            orderDetailDAO.insertOrderDetail(detail);
        }

        // 장바구니에서 주문한 상품 삭제
        for (int bookId : bookIds) {
            cartDAO.deleteCartItemByUserIdAndBookId(userId, bookId);
        }

        log.info("Order processing completed, redirecting to purchaseList");
        return "redirect:/MyPage/purchaseList";
    }
}
