package com.example.demo.dao;

import com.example.demo.dto.ListNewsDto;
import com.example.demo.model.Comment;
import com.example.demo.model.News;

import java.sql.*;

import com.example.demo.dao.config.MyConnectionSql;
import com.example.demo.model.Salary;
import com.example.demo.model.UploadFileResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class NewsSQL {
    @Autowired
    static MyConnectionSql myConnectionSQL = new MyConnectionSql();
    public static Connection connection = myConnectionSQL.getConnection();

    public ArrayList<News> getNews() {
        ArrayList<News> newsArrayList = new ArrayList<>();
        try {
            Statement statement = connection.createStatement();
            String sql = "select * from News order by ID desc";
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                News news = new News(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        null
                        );

                newsArrayList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        for (News news : newsArrayList)
        {
            try{
                Statement statement = connection.createStatement();
                ArrayList<UploadFileResponse> files = new ArrayList<UploadFileResponse>();
                String sql2 = "select ID,FileName from File_News where NewsID like " + news.getiD();
                ResultSet resultSet2 = statement.executeQuery(sql2);
                while (resultSet2.next()) {
                    UploadFileResponse up = new UploadFileResponse();
                    String fileName = ServletUriComponentsBuilder.fromCurrentContextPath()
                            .path(resultSet2.getString(2))
                            .toUriString();
                    up.setFileName(fileName);
                    up.setId(resultSet2.getInt(1));
                    files.add(up);
                }
                news.setFiles(files);
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return newsArrayList;
    }

    public ListNewsDto getNewsTable(String search, String offset, String limit) {
        ListNewsDto listNewsDto = new ListNewsDto();
        int total = 0 ;
        ArrayList<News> newsArrayList = new ArrayList<>();
        try {
            Statement statement = connection.createStatement();
            String sql = "select * from News where Title like '%"+search+"%' limit "+offset+","+ limit;
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                News news = new News(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                        null
                        );

                newsArrayList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            Statement statement = connection.createStatement();
            String sql = "select count(ID) from News ";
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                total = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        for (News news : newsArrayList)
        {
            try{
                    Statement statement = connection.createStatement();
                    ArrayList<UploadFileResponse> files = new ArrayList<UploadFileResponse>();
                    String sql2 = "select ID,FileName from File_News where NewsID like " + news.getiD();
                    ResultSet resultSet2 = statement.executeQuery(sql2);
                while (resultSet2.next()) {
                    UploadFileResponse up = new UploadFileResponse();
                    String fileName = ServletUriComponentsBuilder.fromCurrentContextPath()
                            .path(resultSet2.getString(2))
                            .toUriString();
                    up.setFileName(fileName);
                    up.setId(resultSet2.getInt(1));
                    files.add(up);
                }
                    news.setFiles(files);
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }

        listNewsDto.setRows(newsArrayList);
        listNewsDto.setTotal(total);
        listNewsDto.setTotalNotFiltered(total);
        return listNewsDto;
    }

    public ArrayList<News> getNotice() {
        ArrayList<News> newsArrayList = new ArrayList<>();
        try {
            Statement statement = connection.createStatement();
            String sql = "select ID,Title from News order by ID desc limit 3";
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                News news = new News(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        null,
                        null,
                       null,
                        0,
                        null,
                        null);

                newsArrayList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return newsArrayList;
    }

    public News getNewsbyID(int id) {
        News news= new News();
        try {
            Statement statement = connection.createStatement();
            String sql = "select * from News where ID="+id;
            ResultSet resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                 News ns = new News(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getInt(6),
                        resultSet.getString(7),
                         null
                        );
                 news = ns;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try{
            Statement statement = connection.createStatement();
            ArrayList<UploadFileResponse> files = new ArrayList<UploadFileResponse>();
            String sql2 = "select ID,FileName from File_News where NewsID like " + news.getiD();
            System.out.println(sql2);
            ResultSet resultSet2 = statement.executeQuery(sql2);
            while (resultSet2.next()) {
                UploadFileResponse up = new UploadFileResponse();
                String fileName = ServletUriComponentsBuilder.fromCurrentContextPath()
                        .path(resultSet2.getString(2))
                        .toUriString();
                up.setFileName(fileName);
                up.setId(resultSet2.getInt(1));
                files.add(up);
            }
            news.setFiles(files);
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            ArrayList<Comment> comments = new ArrayList<Comment>();
            Statement statement = connection.createStatement();
            String sql = "select Comment.* ,user.hovaten from Comment , user " +
                    "where Comment.NewsID="+id+" and Comment.UserID = user.id  order by Date";
            System.out.println(sql);
            ResultSet resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                Comment cm = new Comment(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getInt(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        null,
                        resultSet.getString(6)
                );
                comments.add(cm);
            }
            for(Comment cm : comments){
                Statement statement2 = connection.createStatement();
                String sql2 = "select Avata from Profile where UserID = "+cm.getUserID();
                ResultSet resultSet2 = statement2.executeQuery(sql2);
                while (resultSet2.next()) {
                    String avatar =  resultSet2.getString(1);
                    if(avatar != null){
                        cm.setAvatar(avatar);
                    }
                }
            }
            news.setComments(comments);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return news;
    }
    public int addNews(News news) {
        int id = 0;
        try {
            Statement statement = connection.createStatement();
            String sql = "insert into News (Title,Content,Author,Type,Summary) values " +
                    "('" + news.getTitle() +
                    "','" + news.getContent() +
                    "','" + news.getAuthor() +
                    "'," + news.getType() +
                    ",'" + news.getSummary() +
                    "')";
            statement.executeUpdate(sql);
            String sql2 = "select max(ID) from News ";
            ResultSet resultSet = statement.executeQuery(sql2);

            while (resultSet.next()) {
                id = resultSet.getInt(1);
            }
        }
         catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
        return id;
    }

    public boolean addNewsFlie(int NewsID, String file) {
        try {
            Statement statement = connection.createStatement();
            String sql = "insert into File_News (NewsID,FileName) values " +
                    "('" + NewsID +
                    "','" + file +
                    "')";
            statement.executeUpdate(sql);
        }
        catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean editNews(News news) {
        try {
            PreparedStatement ps = connection.prepareStatement("update News set " +
                    "Title =  ?," +
                    "Content = ?," +
                    "Summary = ?" +
                    " where ID = ?");
            ps.setString(1, news.getTitle());
            ps.setString(2, news.getContent());
            ps.setString(3, news.getSummary());
            ps.setInt(4, news.getiD());
            System.out.println(ps.toString());
            ps.executeUpdate();
            ps.close();
        }
        catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
    public boolean deleteNews(int id) {
        try {
            Statement statement = connection.createStatement();
            String sql1 = "delete from Comment where NewsID="+id;
            statement.executeUpdate(sql1);

            String sql2 = "delete from File_News where NewsID="+id;
            statement.executeUpdate(sql2);

            String sql3 = "delete from News where ID="+id;
            statement.executeUpdate(sql3);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
    public boolean deleteFile(int id) {
        try {
            Statement statement = connection.createStatement();
            String sql1 = "delete from File_News where ID="+id;
            statement.executeUpdate(sql1);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }
    public ResponseEntity addComment(Comment comment,Authentication authentication) {

        String Username = null;
        try {
            Statement statement = connection.createStatement();
            String sql1 = "select username from user where id ="+ comment.getUserID();
            ResultSet resultSet = statement.executeQuery(sql1);

            while (resultSet.next()) {
                Username = resultSet.getString(1);
            }
            if(Username == null){
                return new ResponseEntity<String>("UnAuthorized", HttpStatus.FORBIDDEN);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<String>("UnAuthorized", HttpStatus.BAD_REQUEST);
        }
        Collection<? extends GrantedAuthority> authorities
                = authentication.getAuthorities();
        for (GrantedAuthority grantedAuthority : authorities){
            if (grantedAuthority.getAuthority().equals("ROLE_USER")) {
                if(!Username.equals(authentication.getName())){
                    return new ResponseEntity<String>("UnAuthorized", HttpStatus.FORBIDDEN);
                }

            }
        }

        try {
            Statement statement = connection.createStatement();
            String sql = "insert into Comment (UserID,NewsID,Content) values " +
                    "('" + comment.getUserID() +
                    "','" + comment.getNewsID() +
                    "','" + comment.getContent() +
                    "')";
            System.out.println(sql);
            statement.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
            return ResponseEntity.ok(false);
        }

        return ResponseEntity.ok(true);
    }
    public ResponseEntity deleteComment(int id, Authentication authentication) {
        String Username = null;
        try {
            Statement statement = connection.createStatement();
            String sql1 = "select username from user where id in (select UserID from Comment where ID = "+id+")";
            ResultSet resultSet = statement.executeQuery(sql1);

            while (resultSet.next()) {
                Username = resultSet.getString(1);
            }
            if(Username == null){
                return new ResponseEntity<String>("UnAuthorized", HttpStatus.FORBIDDEN);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseEntity<String>("UnAuthorized", HttpStatus.BAD_REQUEST);
        }
        Collection<? extends GrantedAuthority> authorities
                = authentication.getAuthorities();
        for (GrantedAuthority grantedAuthority : authorities){
            if (grantedAuthority.getAuthority().equals("ROLE_USER")) {
                if(!Username.equals(authentication.getName())){
                    return new ResponseEntity<String>("UnAuthorized", HttpStatus.FORBIDDEN);
                }

            }
        }
        try {
            Statement statement = connection.createStatement();
            String sql1 = "delete from Comment where ID="+id;
            statement.executeUpdate(sql1);
        } catch (SQLException e) {
            e.printStackTrace();
            ResponseEntity.ok(false);
        }

        return ResponseEntity.ok(true);
    }
}
