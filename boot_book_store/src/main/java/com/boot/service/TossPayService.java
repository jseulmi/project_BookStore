package com.boot.service;

import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.util.Base64;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class TossPayService {

    @Value("${toss.secret.key}")
    private String secretKey;

    private RestTemplate restTemplate = new RestTemplate();

    public boolean approvePayment(String paymentKey, long amount, String orderId) {
        String url = "https://api.tosspayments.com/v1/payments/" + paymentKey;

        // 인증 헤더
        HttpHeaders headers = new HttpHeaders();
        String credentials = secretKey + ":";
        String base64Credentials = Base64.getEncoder().encodeToString(credentials.getBytes());
        headers.set("Authorization", "Basic " + base64Credentials);
        headers.setContentType(MediaType.APPLICATION_JSON);

        // 요청 Body
        Map<String, Object> body = Map.of(
            "amount", amount,
            "orderId", orderId // optional: 필요 시 포함
        );
        // 요청 내용 로그
        System.out.println("API 요청 본문: " + body);

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, request, String.class);
            // 응답 상태와 바디 출력
            System.out.println("API 응답 상태: " + response.getStatusCode());
            System.out.println("API 응답 바디: " + response.getBody());
            return response.getStatusCode() == HttpStatus.OK;
        } catch (Exception e) {
            System.err.println("API 호출 실패: " + e.getMessage());
            return false;
        }
    }
}