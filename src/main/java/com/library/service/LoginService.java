package com.library.service;

import com.library.bean.ReaderCard;
import com.library.dao.AdminDao;
import com.library.dao.ReaderCardDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    private ReaderCardDao readerCardDao;
    @Autowired
    private AdminDao adminDao;

    public boolean hasMatchReader(String employeeId,String password){
        return  readerCardDao.getIdMatchCount(employeeId, password)>0;
    }

    public String getAdminUsername(String adminId) {
        return adminDao.getUsername(adminId);
    }

    public ReaderCard findReaderCardByReaderId(long readerId){
        return readerCardDao.findReaderByReaderId(readerId);
    }

    public ReaderCard findReaderCardByEmployeeId(String employeeId){
        return readerCardDao.findReaderCardByEmployeeId(employeeId);
    }

    public boolean hasMatchAdmin(String adminId,String password){
        return adminDao.getMatchCount(adminId, password) == 1;
    }

    public boolean adminRePassword(String adminId, String newPassword){
        return adminDao.resetPassword(adminId,newPassword)>0;
    }
    public String getAdminPassword(String adminId){
        return adminDao.getPassword(adminId);
    }

    public boolean readerRePassword(long readerId, String newPassword) {
        return readerCardDao.resetPassword(readerId, newPassword) > 0;
    }

    public String getReaderPassword(long readerId) {
        return readerCardDao.getPassword(readerId);
    }


}
