package com.example.springboot.web.dto;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter @ToString
@RequiredArgsConstructor
public class HelloResponseDto {

     // RequiredArgsConstructor generates constructor with required arguments
     // the arguments are final fields
     // ex: HelloResponseDto(String name, int amount)
     private final String name;
     private final int amount;
}
