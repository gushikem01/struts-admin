package com.struts.admin.application.usecase;

import com.struts.admin.application.dto.DashboardDTO;
import com.struts.admin.application.dto.UserDTO;
import com.struts.admin.domain.entity.DashboardData;
import com.struts.admin.domain.service.DashboardService;

public class GetDashboardDataUseCase {
    private final DashboardService dashboardService;
    
    public GetDashboardDataUseCase(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }
    
    public DashboardDTO execute(UserDTO currentUser) {
        DashboardData data = dashboardService.getDashboardData();
        
        return DashboardDTO.builder()
            .totalUsers(data.getTotalUsers())
            .activeUsers(data.getActiveUsers())
            .totalOrders(data.getTotalOrders())
            .revenue(data.getRevenue())
            .lastLoginTime(data.getLastLoginTime())
            .systemLoad(data.getSystemLoad())
            .serverStatus(data.getServerStatus())
            .currentUser(currentUser)
            .build();
    }
}