package com.library.bean;

import java.io.Serializable;

public class ClassInfo implements Serializable {
    private long classId;
    private String className;

    public long getClassId() {
        return classId;
    }

    public void setClassId(long classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }
}
