package com.boot.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.WishlistDTO;
import com.boot.service.UserService;
import com.boot.service.WishlistService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/wishlist")
public class WishlistController {

    @Autowired
    private WishlistService wishlistService;
    
    @Autowired
    private UserService userService;

    // 찜 추가 API
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addWish(
            @RequestParam("book_id") int bookId,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        String userId = (String) session.getAttribute("loginId");
        
        if (userId == null) {
            response.put("success", false);
            response.put("message", "로그인 후 이용해주세요.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        
        boolean result = wishlistService.addWish(userId, bookId);
        
        if (result) {
            response.put("success", true);
            response.put("message", "찜 목록에 추가되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "이미 찜한 도서이거나 추가에 실패했습니다.");
        }
        
        return ResponseEntity.ok(response);
    }

    // 찜 삭제 API
    @PostMapping("/remove")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeWish(
            @RequestParam("book_id") int bookId,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        String userId = (String) session.getAttribute("loginId");
        
        if (userId == null) {
            response.put("success", false);
            response.put("message", "로그인 후 이용해주세요.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        
        boolean result = wishlistService.removeWish(userId, bookId);
        
        if (result) {
            response.put("success", true);
            response.put("message", "찜 목록에서 삭제되었습니다.");
        } else {
            response.put("success", false);
            response.put("message", "삭제에 실패했습니다.");
        }
        
        return ResponseEntity.ok(response);
    }

    // 찜 여부 확인 API
    @GetMapping("/check")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkWish(
            @RequestParam("book_id") int bookId,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        String userId = (String) session.getAttribute("loginId");
        
        if (userId == null) {
            response.put("wished", false);
            return ResponseEntity.ok(response);
        }
        
        boolean isWished = wishlistService.isWished(userId, bookId);
        response.put("wished", isWished);
        
        return ResponseEntity.ok(response);
    }

    // 찜 목록 페이지
    @GetMapping
    public String wishlist(Model model, HttpSession session) {
        String userId = (String) session.getAttribute("loginId");
        
        if (userId == null) {
            return "redirect:/login";
        }
        
        List<WishlistDTO> wishlist = wishlistService.getWishlistByUserId(userId);
        model.addAttribute("wishlist", wishlist);
        
        // 이름으로 세션 표시 업데이트
        try {
            Map<String, Object> userInfo = userService.getUser(userId);
            if (userInfo != null) {
                String name = (String) userInfo.get("user_name");
                session.setAttribute("loginDisplayName", name);
            }
        } catch (Exception e) {
            log.error("사용자 정보 조회 실패", e);
        }
        
        return "MyPage/wishlist";
    }

 // 찜 ID로 삭제 (찜 목록 페이지에서 사용)
    @PostMapping("/removeById")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeWishById(
            @RequestParam(value = "wish_id", required = false) String wishIdStr,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        String userId = (String) session.getAttribute("loginId");
        
        if (userId == null) {
            response.put("success", false);
            response.put("message", "로그인 후 이용해주세요.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        
        // 값 검증 및 변환
        if (wishIdStr == null || wishIdStr.trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "찜 정보가 올바르지 않습니다.");
            return ResponseEntity.badRequest().body(response);
        }
        
        try {
            int wishId = Integer.parseInt(wishIdStr.trim());
            boolean result = wishlistService.removeWishById(wishId);
            
            if (result) {
                response.put("success", true);
                response.put("message", "찜 목록에서 삭제되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "삭제에 실패했습니다.");
            }
        } catch (NumberFormatException e) {
            log.error("Invalid wish_id format: {}", wishIdStr, e);
            response.put("success", false);
            response.put("message", "찜 정보 형식이 올바르지 않습니다.");
            return ResponseEntity.badRequest().body(response);
        }
        
        return ResponseEntity.ok(response);
    }
    
 // 기존 메서드들 아래에 추가

		 // 찜 목록 전체 삭제 API
		 @PostMapping("/removeAll")
		 @ResponseBody
		 public ResponseEntity<Map<String, Object>> removeAllWish(HttpSession session) {
		     Map<String, Object> response = new HashMap<>();
		     String userId = (String) session.getAttribute("loginId");
		     
		     if (userId == null) {
		         response.put("success", false);
		         response.put("message", "로그인 후 이용해주세요.");
		         return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
		     }
		     
		     boolean result = wishlistService.removeAllWish(userId);
		     
		     if (result) {
		         response.put("success", true);
		         response.put("message", "찜 목록이 모두 삭제되었습니다.");
		     } else {
		         response.put("success", false);
		         response.put("message", "삭제에 실패했습니다.");
		     }
		     
		     return ResponseEntity.ok(response);
		 }
}
