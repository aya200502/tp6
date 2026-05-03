package com.tp.springmvc.service;

import com.tp.springmvc.entity.User;
import java.util.Optional;

public interface UserService {
    Optional<User> findByLoginAndPassword(String login, String password);

    Optional<User> findByLogin(String login);

    void initializeDefaultUsers();
}
