package com.lin.lostandfound.entities.vo;

import com.lin.lostandfound.entities.domain.User;

import java.util.List;

public class UserModel {
	
	private List<User> users;
	
	public UserModel() {
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public UserModel(List<User> users) {
        super();
        this.users = users;
    }

	@Override
	public String toString() {
		return "UserModel [users=" + users + "]";
	}
}
