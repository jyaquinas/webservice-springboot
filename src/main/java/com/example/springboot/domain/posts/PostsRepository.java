package com.example.springboot.domain.posts;

import org.springframework.data.jpa.repository.JpaRepository;

public interface PostsRepository extends JpaRepository<Posts, Long> {
    // JpaRepository<EntityClass, PK type> -> Generates basic CRUD methods

}
