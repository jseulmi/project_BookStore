package com.boot.controller;

import java.util.List;

import javax.servlet.http.HttpSession; // 추가

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import com.boot.dto.BookDTO;
import com.boot.dto.UserReviewDTO;
import com.boot.service.BookService;
import com.boot.service.UserReviewService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserReviewController {

    private final UserReviewService userReviewService;
    private final BookService bookService; // BookService 주입

    // 리뷰 작성
    @PostMapping("/review/write")
    public String writeReview(UserReviewDTO reviewDTO, Model model, HttpSession session) {
    	String nickname = (String) session.getAttribute("user_nickname");
        if (nickname == null || nickname.trim().isEmpty()) {
            throw new RuntimeException("세션에 닉네임 정보가 없습니다!");
        }
        reviewDTO.setUser_nickname(nickname);
        
        // 리뷰 저장
        userReviewService.writeReview(reviewDTO);

        // 작성 완료 메시지
        model.addAttribute("msg", "리뷰가 작성되었습니다.");

        // 도서 정보 조회
        BookDTO book = bookService.getAllBooks().stream()
                .filter(b -> b.getBook_id() == reviewDTO.getBook_id())
                .findFirst()
                .orElse(null);
        model.addAttribute("book", book);

        // 도서에 달린 리뷰 목록 조회
        List<UserReviewDTO> reviews = userReviewService.getReviewsByBookId(reviewDTO.getBook_id());
        model.addAttribute("reviews", reviews);

        return "redirect:/SearchDetail?book_id=" + reviewDTO.getBook_id();
    }
}
