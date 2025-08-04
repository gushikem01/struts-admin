package com.struts.admin.infrastructure.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.struts.admin.application.dto.DashboardDTO;
import com.struts.admin.application.dto.UserDTO;
import com.struts.admin.application.usecase.GetDashboardDataUseCase;
import com.struts.admin.domain.service.DashboardService;
import lombok.Getter;
import lombok.Setter;
import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;

@Getter
@Setter
public class DashboardAction extends ActionSupport implements SessionAware {
    private Map<String, Object> session;
    private DashboardDTO dashboardData;
    private GetDashboardDataUseCase getDashboardDataUseCase;
    
    public DashboardAction() {
        // Initialize dependencies (in a real app, use dependency injection)
        DashboardService dashboardService = new DashboardService();
        this.getDashboardDataUseCase = new GetDashboardDataUseCase(dashboardService);
    }
    
    @Override
    public String execute() throws Exception {
        UserDTO currentUser = (UserDTO) session.get("user");
        
        if (currentUser == null) {
            return "login";
        }
        
        dashboardData = getDashboardDataUseCase.execute(currentUser);
        return SUCCESS;
    }
    
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
}