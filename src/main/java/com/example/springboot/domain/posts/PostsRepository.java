package com.example.springboot.domain.posts;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PostsRepository extends JpaRepository<Posts, Long> {
    // JpaRepository<EntityClass, PK type> -> Generates basic CRUD methods

    // For custom queries:
    @Query("SELECT p from Posts p ORDER BY p.id DESC")
    List<Posts> findAllDesc();

}
