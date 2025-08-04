package com.struts.admin.infrastructure.web.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import java.util.Map;

public class AuthInterceptor extends AbstractInterceptor {
    
    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        Map<String, Object> session = invocation.getInvocationContext().getSession();
        
        Boolean authenticated = (Boolean) session.get("authenticated");
        
        if (authenticated == null || !authenticated) {
            return "login";
        }
        
        return invocation.invoke();
    }
}