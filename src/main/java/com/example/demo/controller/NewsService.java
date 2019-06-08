package com.example.demo.controller;

import com.example.demo.dao.ManageStaffSQL;
import com.example.demo.dao.NewsSQL;
import com.example.demo.model.Comment;
import com.example.demo.model.News;
import com.example.demo.model.Profile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Collection;
import java.util.Date;
import java.util.UUID;

@RestController
@RequestMapping("/rest")
public class NewsService {
    NewsSQL newsSQL = new NewsSQL();
    @Secured({"ROLE_USER","ROLE_ADMIN"})
    @GetMapping("/getNews")
    public ResponseEntity getNews(){
        return ResponseEntity.ok(newsSQL.getNews());

    }
    @Secured("ROLE_ADMIN")
    @GetMapping("/getNewsTable")
    public ResponseEntity getNewsTable(@RequestParam String search,@RequestParam String order,@RequestParam String offset,@RequestParam String limit){
        return ResponseEntity.ok(newsSQL.getNewsTable(search,offset,limit));

    }
    @Secured({"ROLE_USER","ROLE_ADMIN"})
    @GetMapping("/getNotice")
    public ResponseEntity getNotie(){
        return ResponseEntity.ok(newsSQL.getNotice());
    }

    @Secured({"ROLE_USER","ROLE_ADMIN"})
    @GetMapping("/getNewsbyID")
    public ResponseEntity getNewsbyID(@RequestParam int id) {
        return ResponseEntity.ok(newsSQL.getNewsbyID(id));
    }

    @Secured("ROLE_ADMIN")
    @PostMapping("/addNews")
    public ResponseEntity addNews(@RequestBody News news) {
        return ResponseEntity.ok(newsSQL.addNews(news));
    }

    @Secured({"ROLE_USER","ROLE_ADMIN"})
    @PostMapping("/comment")
    public ResponseEntity addComment(@RequestBody Comment comment,Authentication authentication) {
        return newsSQL.addComment(comment,authentication);
    }

    @Secured("ROLE_ADMIN")
    @PostMapping("/editNews")
    public ResponseEntity editNews(@RequestBody News news) {
        return ResponseEntity.ok(newsSQL.editNews(news));
    }

    @Secured("ROLE_ADMIN")
    @PostMapping("/deleteNews")
    public ResponseEntity deleteNews(@RequestParam int id) {
        return ResponseEntity.ok(newsSQL.deleteNews(id));
    }

    @Secured({"ROLE_USER","ROLE_ADMIN"})
    @PostMapping("/deleteComment")
    public ResponseEntity deleteComment(@RequestParam int id, Authentication authentication) {
        return newsSQL.deleteComment(id, authentication);
    }
}
