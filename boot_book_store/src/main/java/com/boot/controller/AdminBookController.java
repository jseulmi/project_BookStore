package com.boot.controller;

import com.boot.dao.BookDAO;
import com.boot.dto.BookDTO;
import com.boot.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/book")
@RequiredArgsConstructor
@Slf4j
public class AdminBookController {

    private final BookDAO bookDAO;
    private final BookService bookService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(java.util.Date.class,
            new org.springframework.beans.propertyeditors.CustomDateEditor(
                new java.text.SimpleDateFormat("yyyy-MM-dd"), true
            )
        );
    }
    
    /** 도서 목록 (관리자) */
    @GetMapping("/list")
    public String bookList(
            @RequestParam(defaultValue = "1") int page,
            Model model) {

        int pageSize = 10; // 한 페이지 10개
        int offset = (page - 1) * pageSize;

        // 목록 + 전체 개수
        List<BookDTO> list = bookDAO.selectBooksPaging(offset, pageSize);
        int totalCount = bookDAO.countBooks();

        model.addAttribute("books", list);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", pageSize);

        return "admin/adminBook";
    }

    /** 도서 등록 화면 */
    @GetMapping("/add")
    public String addPage(Model model) {
        model.addAttribute("genres", bookService.getAllGenres());
        return "admin/adminBookAdd";  // /WEB-INF/views/admin/adminBookAdd.jsp
    }

    /** 도서 등록 처리 */
    @PostMapping("/add")
    @ResponseBody
    public String addBook(@RequestBody BookDTO dto) {
        bookDAO.insertBook(dto);
        return "OK";
    }

    /** 도서 수정 화면 */
    @GetMapping("/edit")
    public String editPage(@RequestParam("id") int bookId, Model model) {
        BookDTO book = bookDAO.findById(bookId);
        model.addAttribute("book", book);
        model.addAttribute("genres", bookService.getAllGenres());
        return "admin/adminBookEdit"; // /WEB-INF/views/admin/adminBookEdit.jsp
    }

    /** 도서 수정 처리 */
    @PostMapping("/edit")
    @ResponseBody
    public String editBook(@RequestBody BookDTO dto) {
        bookDAO.updateBook(dto);
        return "OK";
    }


    /** 도서 삭제 (AJAX) */
    @PostMapping("/delete")
    @ResponseBody
    public String deleteBook(@RequestParam("id") int bookId) {
        log.info("== [ADMIN] delete book : {}", bookId);
        bookDAO.deleteBook(bookId);
        return "OK";
    }
}
