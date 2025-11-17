package com.boot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.OrderHistoryDAO;
import com.boot.dto.OrderHistoryDetailDTO;
import com.boot.dto.OrderHistoryListDTO;

import java.util.List;

@Service
public class OrderHistoryServiceImpl implements OrderHistoryService {

    @Autowired
    private OrderHistoryDAO orderHistoryDAO;

    @Override
    public List<OrderHistoryListDTO> getAllOrders() {
        return orderHistoryDAO.getAllOrders();
    }

    @Override
    public List<OrderHistoryListDTO> getTodayOrders() {
        return orderHistoryDAO.getTodayOrders();
    }

    @Override
    public OrderHistoryDetailDTO getOrderDetail(int order_id) {
        OrderHistoryDetailDTO info = orderHistoryDAO.getOrderInfo(order_id);
        info.setItems(orderHistoryDAO.getOrderItems(order_id));
        return info;
    }

	@Override
	public List<OrderHistoryListDTO> getPage(int page, int size) {
		int offset = (page - 1) * size;
        return orderHistoryDAO.selectPage(offset, size);
	}

	@Override
	public List<OrderHistoryListDTO> getSearchPage(String type, String keyword, int page, int size) {
		int offset = (page - 1) * size;
        return orderHistoryDAO.searchPage(type, keyword, offset, size);
	}

	@Override
	public int getTotalCount() {
		return orderHistoryDAO.countAll();
	}

	@Override
	public int getSearchTotalCount(String type, String keyword) {
		return orderHistoryDAO.countSearch(type, keyword);
	}
	
	@Override
	public List<OrderHistoryListDTO> getTodayPage(String type, String keyword, int page, int size) {

	    int offset = (page - 1) * size;
	    return orderHistoryDAO.getTodayPage(type, keyword, offset, size);
	}
	
	@Override
	public int getTodayTotalCount(String type, String keyword) {
	    return orderHistoryDAO.getTodayTotalCount(type, keyword);
	}
}
