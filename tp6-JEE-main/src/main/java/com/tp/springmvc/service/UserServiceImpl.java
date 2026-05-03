package com.tp.springmvc.service;

import com.tp.springmvc.entity.User;
import com.tp.springmvc.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public Optional<User> findByLoginAndPassword(String login, String password) {
        return userRepository.findByLoginAndPassword(login, password);
    }

    @Override
    public Optional<User> findByLogin(String login) {
        return userRepository.findByLogin(login);
    }

    @Override
    public void initializeDefaultUsers() {
        if (userRepository.findByLogin("jalal").isEmpty()) {
            userRepository.save(new User("jalal", "1234", "admin"));
        }
        if (userRepository.findByLogin("test").isEmpty()) {
            userRepository.save(new User("test", "1234", "user"));
        }
    }
}
