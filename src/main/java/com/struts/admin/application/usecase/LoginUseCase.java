package com.struts.admin.application.usecase;

import com.struts.admin.application.dto.LoginDTO;
import com.struts.admin.application.dto.UserDTO;
import com.struts.admin.domain.entity.User;
import com.struts.admin.domain.service.AuthenticationService;
import java.util.Optional;

public class LoginUseCase {
    private final AuthenticationService authenticationService;
    
    public LoginUseCase(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }
    
    public Optional<UserDTO> execute(LoginDTO loginDTO) {
        Optional<User> user = authenticationService.authenticate(
            loginDTO.getUsername(), 
            loginDTO.getPassword()
        );
        
        return user.map(this::convertToDTO);
    }
    
    private UserDTO convertToDTO(User user) {
        return UserDTO.builder()
            .id(user.getId())
            .username(user.getUsername())
            .email(user.getEmail())
            .firstName(user.getFirstName())
            .lastName(user.getLastName())
            .role(user.getRole())
            .build();
    }
}