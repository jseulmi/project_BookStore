package com.boot.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dto.OrderHistoryDetailDTO;
import com.boot.dto.OrderHistoryListDTO;
import com.boot.service.OrderHistoryService;

@Controller
@RequestMapping("/admin/order")
public class OrderHistoryController {

    @Autowired
    private OrderHistoryService orderService;

    // 전체 주문 내역
    @GetMapping("/list")
    public String orderList(HttpSession session,
                            @RequestParam(defaultValue = "1") int page,
                            @RequestParam(defaultValue = "10") int size,
                            @RequestParam(defaultValue = "uid") String type,
                            @RequestParam(defaultValue = "") String keyword,
                            Model model) {

        // 검색 여부 판단
        List<OrderHistoryListDTO> list;
        int total;

        if (keyword.isEmpty()) {
            list = orderService.getPage(page, size);
            total = orderService.getTotalCount();
        } else {
            list = orderService.getSearchPage(type, keyword, page, size);
            total = orderService.getSearchTotalCount(type, keyword);
        }

        // 페이징 계산
        int pageCount = (int) Math.ceil(total / (double) size);
        int pageGroupSize = 5;

        int startPage = ((page - 1) / pageGroupSize) * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, pageCount);

        // 모델 전달
        model.addAttribute("orders", list);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("total", total);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        model.addAttribute("keyword", keyword);
        model.addAttribute("type", type);

        return "admin/order/orderList";
    }

    // 오늘 주문 내역
    @GetMapping("/today")
    public String todayOrders(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "uid") String type,
            @RequestParam(defaultValue = "") String keyword,
            Model model) {

        List<OrderHistoryListDTO> list;
        int total;

        list = orderService.getTodayPage(type, keyword, page, size);
        total = orderService.getTodayTotalCount(type, keyword);

        int pageCount = (int) Math.ceil(total / (double) size);
        int pageGroupSize = 5;

        int startPage = ((page - 1) / pageGroupSize) * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, pageCount);

        model.addAttribute("orders", list);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("total", total);
        model.addAttribute("pageCount", pageCount);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);

        return "admin/order/orderToday";
    }

    // 주문 상세 보기
    @GetMapping("/detail")
    public String orderDetail(@RequestParam("order_id") int orderId, Model model) {

    	OrderHistoryDetailDTO order = orderService.getOrderDetail(orderId);
        model.addAttribute("order", order);
        return "admin/order/orderDetail";
    }
}
