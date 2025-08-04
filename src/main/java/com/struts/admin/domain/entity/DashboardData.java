package com.struts.admin.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DashboardData {
    private int totalUsers;
    private int activeUsers;
    private int totalOrders;
    private double revenue;
    private String lastLoginTime;
    private int systemLoad;
    private String serverStatus;
}