package com.example.springboot.domain.user;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    // to check if user with same email exists (user registration)
    Optional<User> findByEmail(String email);
}
