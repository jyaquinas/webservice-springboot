package com.example.springboot.domain;

import lombok.Getter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@Getter
@MappedSuperclass   // mapping info applied to entities that inherit from it (e.g. getCreatedDate)
@EntityListeners(AuditingEntityListener.class)  // adds auditing functionality
public class BaseTimeEntity {

    @CreatedDate // automatically saves time when entity is created
    private LocalDateTime createdDate;

    @LastModifiedDate   // automatically saves time when entity is modified
    private LocalDateTime modifiedDate;

}
