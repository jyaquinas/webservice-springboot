package com.example.springboot.web;

import com.sun.source.tree.AssertTree;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.test.context.junit4.SpringRunner;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class IndexControllerTest {

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    public void load_main_Page(){
        // Test if html is property loaded by checking if string is contained in the body
        String body = this.restTemplate.getForObject("/", String.class);

        assertThat(body).contains("Web Service With Spring Boot");
    }
}
