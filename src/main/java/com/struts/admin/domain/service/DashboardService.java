package com.struts.admin.domain.service;

import com.struts.admin.domain.entity.DashboardData;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

public class DashboardService {
    private final Random random = new Random();
    
    public DashboardData getDashboardData() {
        return DashboardData.builder()
            .totalUsers(1250 + random.nextInt(100))
            .activeUsers(450 + random.nextInt(50))
            .totalOrders(3200 + random.nextInt(200))
            .revenue(125000.50 + random.nextDouble() * 10000)
            .lastLoginTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
            .systemLoad(20 + random.nextInt(60))
            .serverStatus("Online")
            .build();
    }
}