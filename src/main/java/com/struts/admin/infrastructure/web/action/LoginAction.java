package com.struts.admin.infrastructure.web.action;

import com.opensymphony.xwork2.ActionSupport;
import com.struts.admin.application.dto.LoginDTO;
import com.struts.admin.application.dto.UserDTO;
import com.struts.admin.application.usecase.LoginUseCase;
import com.struts.admin.domain.service.AuthenticationService;
import com.struts.admin.infrastructure.persistence.InMemoryUserRepository;
import lombok.Getter;
import lombok.Setter;
import org.apache.struts2.interceptor.SessionAware;

import java.util.Map;
import java.util.Optional;

@Getter
@Setter
public class LoginAction extends ActionSupport implements SessionAware {
    private String username;
    private String password;
    private Map<String, Object> session;
    private LoginUseCase loginUseCase;
    
    public LoginAction() {
        // Initialize dependencies (in a real app, use dependency injection)
        InMemoryUserRepository userRepository = new InMemoryUserRepository();
        AuthenticationService authService = new AuthenticationService(userRepository);
        this.loginUseCase = new LoginUseCase(authService);
    }
    
    @Override
    public String execute() throws Exception {
        if (username == null || password == null) {
            return INPUT;
        }
        
        LoginDTO loginDTO = new LoginDTO(username, password);
        Optional<UserDTO> userDTO = loginUseCase.execute(loginDTO);
        
        if (userDTO.isPresent()) {
            session.put("user", userDTO.get());
            session.put("authenticated", true);
            return SUCCESS;
        } else {
            addActionError("Invalid username or password");
            return INPUT;
        }
    }
    
    public String logout() {
        if (session != null) {
            session.clear();
        }
        return SUCCESS;
    }
    
    public String input() {
        return INPUT;
    }
    
    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
}