package ibs.com.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class SecurityVO extends User {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(SecurityVO.class);
	

	private UserVO user;
	/*
	private String username; // ID
	private String password; // PW
	private List<GrantedAuthority> authorities;


	// setter
		public void setUsername(String username) {
			this.username = username;
		}

		// setter
		public void setPassword(String password) {
			this.password = password;
		}

		// setter
		public void setAuthorities(List<String> authList) {

			List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

			for (int i = 0; i < authList.size(); i++) {
				authorities.add(new SimpleGrantedAuthority(authList.get(i)));
			}

			this.authorities = authorities;
		}

		@Override
		// ID
		public String getUsername() {

			return username;
		}

		@Override
		// PW
		public String getPassword() {

			return password;
		}

		@Override
		// 권한
		public Collection<? extends GrantedAuthority> getAuthorities() {

			return authorities;
		}

		@Override
		// 계정이 만료 되지 않았는가?
		public boolean isAccountNonExpired() {

			return true;
		}

		@Override
		// 계정이 잠기지 않았는가?
		public boolean isAccountNonLocked() {

			return true;
		}

		@Override
		// 패스워드가 만료되지 않았는가?
		public boolean isCredentialsNonExpired() {

			return true;
		}

		@Override
		// 계정이 활성화 되었는가?
		public boolean isEnabled() {

			return true;
		}
	*/
		
	public SecurityVO(String username, String password, boolean enabled,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public SecurityVO(UserVO vo) {
		super(vo.getId(), vo.getPassword(), vo.getType()==1, true, true, true, vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuthority())).collect(Collectors.toList()));
		this.user = vo;
		
		//LOGGER.info("SecurityVO : " + vo);
	}

}
