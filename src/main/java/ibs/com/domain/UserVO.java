package ibs.com.domain;  

import java.util.List;

import lombok.Data;

@Data
public class UserVO {

	private String id;
	private String password;
	private String name;
	private String cname;
	private String email;
	private String phone;
	private String department;
	private String rank;
	private int type;
	private List<AuthVO> authList;
	
	
}
