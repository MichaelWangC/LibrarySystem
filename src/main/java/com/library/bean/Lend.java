package com.library.bean;

import java.io.Serializable;
import java.util.Date;

public class Lend implements Serializable {

    private long ser_num;
    private long book_id;
    private String book_name;
    private long reader_id;
    private Date lendDate;
    private Date backDate;
    private String readerName;
    private String employeeId;

    public long getReaderId() {
        return reader_id;
    }

    public void setReaderId(long reader_id) {
        this.reader_id = reader_id;
    }

    public long getBookId() {
        return book_id;
    }

    public void setBookId(long book_id) {
        this.book_id = book_id;
    }

    public void setSer_num(long ser_num) {
        this.ser_num = ser_num;
    }

    public Date getBackDate() {
        return backDate;
    }

    public void setBackDate(Date back_date) {
        this.backDate = back_date;
    }

    public Date getLendDate() {
        return lendDate;
    }

    public void setLendDate(Date lend_date) {
        this.lendDate = lend_date;
    }

    public long getSer_num() {
        return ser_num;
    }

    public String getBookName() {
        return book_name;
    }

    public void setBookName(String book_name) {
        this.book_name = book_name;
    }

    public String getReaderName() {
        return readerName;
    }

    public void setReaderName(String readerName) {
        this.readerName = readerName;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
}
