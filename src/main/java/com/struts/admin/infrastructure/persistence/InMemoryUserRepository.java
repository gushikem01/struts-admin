package com.struts.admin.infrastructure.persistence;

import com.struts.admin.domain.entity.User;
import com.struts.admin.domain.repository.UserRepository;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

public class InMemoryUserRepository implements UserRepository {
    private static final Map<Long, User> users = new HashMap<>();
    private static Long idCounter = 1L;
    
    static {
        // Initialize with mock users
        users.put(1L, new User(1L, "admin", "admin123", "admin@example.com", 
                              "Admin", "User", "ADMIN", true));
        users.put(2L, new User(2L, "user", "user123", "user@example.com", 
                              "Regular", "User", "USER", true));
        users.put(3L, new User(3L, "guest", "guest123", "guest@example.com", 
                              "Guest", "User", "GUEST", true));
        idCounter = 4L;
    }
    
    @Override
    public Optional<User> findByUsername(String username) {
        return users.values().stream()
            .filter(user -> user.getUsername().equals(username))
            .findFirst();
    }
    
    @Override
    public Optional<User> findById(Long id) {
        return Optional.ofNullable(users.get(id));
    }
    
    @Override
    public User save(User user) {
        if (user.getId() == null) {
            user.setId(idCounter++);
        }
        users.put(user.getId(), user);
        return user;
    }
    
    @Override
    public void delete(Long id) {
        users.remove(id);
    }
}