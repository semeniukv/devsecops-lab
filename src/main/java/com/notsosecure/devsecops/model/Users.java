package com.notsosecure.devsecops.model;

import javax.persistence.*;

@Entity
@Table(name = "users")
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private int id;
    @Column
    private String name;

    @Column
    private String email;
    @Column
    private String password;
    
    @Enumerated(EnumType.STRING)
    @Column(name ="user_type")
    private UserType userType;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }


    @Override
    public String toString() {
        return "Users{" +
                "email='" + email + '\'' +
                ", id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", userType=" + userType +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Users users = (Users) o;

        if (name != null ? !name.equals(users.name) : users.name != null) return false;
        if (email != null ? !email.equals(users.email) : users.email != null) return false;
        if (password != null ? !password.equals(users.password) : users.password != null) return false;
        return userType == users.userType;

    }

    @Override
    public int hashCode() {
        int result = name != null ? name.hashCode() : 0;
        result = 31 * result + (email != null ? email.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (userType != null ? userType.hashCode() : 0);
        return result;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
