package com.struts.admin.domain.repository;

import com.struts.admin.domain.entity.User;
import java.util.Optional;

public interface UserRepository {
    Optional<User> findByUsername(String username);
    Optional<User> findById(Long id);
    User save(User user);
    void delete(Long id);
}