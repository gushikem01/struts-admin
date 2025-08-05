package com.struts.admin.infrastructure.web.action;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

/**
 * Health check action for Cloud Run and monitoring
 */
@ParentPackage("json-default")
public class HealthCheckAction extends ActionSupport {
    
    private String status;
    private long timestamp;
    
    @Action(value = "health", results = {
        @Result(name = SUCCESS, type = "json")
    })
    public String health() {
        this.status = "healthy";
        this.timestamp = System.currentTimeMillis();
        return SUCCESS;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public long getTimestamp() {
        return timestamp;
    }
    
    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }
}