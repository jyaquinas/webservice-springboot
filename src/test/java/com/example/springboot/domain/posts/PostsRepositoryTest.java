package com.example.springboot.domain.posts;

import org.assertj.core.error.AssertJMultipleFailuresError;
import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest // initializes the H2database for test
public class PostsRepositoryTest {

    @Autowired
    PostsRepository postsRepository;

    @After  // function executed after test
    public void cleanup() {
        postsRepository.deleteAll();
    }

    @Test
    public void saveAndGetPosts() {
        String title = "Test Post";
        String content = "Test content";

        // Create posts instance through builder pattern (lombok @Builder)
        // save() -> inserts/updates to table
        postsRepository.save(Posts.builder()
                .title(title)
                .content(content)
                .author("author@email.com")
                .build());

        // returns all rows of table (or instances of type)
        List<Posts> postList = postsRepository.findAll();

        Posts posts = postList.get(0);
        assertThat(posts.getTitle()).isEqualTo(title);
        assertThat(posts.getContent()).isEqualTo(content);
    }

    @Test
    public void register_baseTimeEntity() {
        LocalDateTime now = LocalDateTime.of(2022, 2, 27, 21, 41, 0);
        postsRepository.save(Posts.builder()
                .title("title")
                .content("content")
                .author("author")
                .build());

        List<Posts> postsList = postsRepository.findAll();

        Posts posts = postsList.get(0);

        System.out.println(">>>>> createDate=" + posts.getCreatedDate() +
                ", modifiedDate=" + posts.getModifiedDate());

        assertThat(posts.getCreatedDate()).isAfter(now);
        assertThat(posts.getModifiedDate()).isAfter(now);
    }
}
