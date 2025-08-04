package com.struts.admin.domain.service;

import com.struts.admin.domain.entity.User;
import com.struts.admin.domain.repository.UserRepository;
import java.util.Optional;

public class AuthenticationService {
    private final UserRepository userRepository;
    
    public AuthenticationService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    
    public Optional<User> authenticate(String username, String password) {
        Optional<User> user = userRepository.findByUsername(username);
        
        if (user.isPresent() && user.get().isActive()) {
            // In a real application, you would hash and compare passwords
            if (password.equals(user.get().getPassword())) {
                return user;
            }
        }
        
        return Optional.empty();
    }
}