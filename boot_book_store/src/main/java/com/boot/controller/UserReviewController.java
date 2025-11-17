package com.boot.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boot.dao.UserReviewDAO;
import com.boot.dao.OrderDAO;
import com.boot.dto.UserReviewDTO;
import com.boot.dto.OrderDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserReviewService {

    private final UserReviewDAO userReviewDAO;
    private final OrderDAO orderDAO; // BookBuyDAO 주입

    // 리뷰 작성
    @Transactional
    public void writeReview(UserReviewDTO reviewDTO) {
        // 사용자 주문 내역 주문 상세 기준으로 구매 여부 확인
        boolean purchased = orderDAO.selectPurchaseListByUserId(reviewDTO.getUser_id())
                                    .stream()
                                    .flatMap(order -> order.getOrderDetails().stream()) // 주문별 상세 펼침
                                    .anyMatch(detail -> detail.getBook_id() == reviewDTO.getBook_id());

        if (!purchased) {
            throw new RuntimeException("구매한 책만 리뷰를 작성할 수 있습니다.");
        }

        userReviewDAO.insertReview(reviewDTO);
    }


    // 특정 도서의 리뷰 목록 조회
    public List<UserReviewDTO> getReviewsByBookId(Long bookId) {
        return userReviewDAO.findReviewsByBookId(bookId);
    }

    // 사용자가 해당 책을 구매했는지 확인 (컨트롤러에서 JSP용)
    public boolean hasPurchasedBook(String userId, int bookId) {
        List<OrderDTO> purchases = orderDAO.selectPurchaseListByUserId(userId);

        return purchases.stream()
            .flatMap(order -> order.getOrderDetails().stream())  // 주문별 상세 펼침
            .anyMatch(detail -> detail.getBook_id() == bookId);   // book_id 비교
    }

}
