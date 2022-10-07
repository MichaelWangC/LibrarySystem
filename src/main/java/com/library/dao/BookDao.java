package com.library.dao;

import com.library.bean.Book;
import com.library.bean.ClassInfo;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BookDao {

    private final static String NAMESPACE = "com.library.dao.BookDao.";
    @Resource
    private SqlSessionTemplate sqlSessionTemplate;

    public int matchBook(final String searchWord, final String classId) {
        String search = "%" + searchWord + "%";
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("search", search);
        paramMap.put("classId", classId);
        return sqlSessionTemplate.selectOne(NAMESPACE + "matchBook", paramMap);
    }

    public ArrayList<Book> queryBook(final String searchWord, final String classId) {
        String search = "%" + searchWord + "%";
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("search", search);
        paramMap.put("classId", classId);
        List<Book> result = sqlSessionTemplate.selectList(NAMESPACE + "queryBook", paramMap);
        return (ArrayList<Book>) result;
    }

    public ArrayList<Book> getAllBooks() {
        List<Book> result = sqlSessionTemplate.selectList(NAMESPACE + "getAllBooks");
        return (ArrayList<Book>) result;
    }

    public int addBook(final Book book) {
        return sqlSessionTemplate.insert(NAMESPACE + "addBook", book);
    }

    public Book getBook(final long bookId) {
        return sqlSessionTemplate.selectOne(NAMESPACE + "getBook", bookId);
    }

    public int editBook(final Book book) {
        return sqlSessionTemplate.update(NAMESPACE + "editBook", book);
    }

    public int deleteBook(final long bookId) {
        return sqlSessionTemplate.delete(NAMESPACE + "deleteBook", bookId);
    }

    public ArrayList<ClassInfo> getClassInfo() {
        List<ClassInfo> result = sqlSessionTemplate.selectList(NAMESPACE + "getClassInfo");
        return (ArrayList<ClassInfo>)result;
    }
}
