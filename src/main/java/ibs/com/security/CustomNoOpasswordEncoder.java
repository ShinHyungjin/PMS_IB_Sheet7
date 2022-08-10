package ibs.com.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

/**
 * 비밀번호 암호화
 *
 * @author 류슬희
 * @date   2021. 5. 19.
 */
@Log4j
public class CustomNoOpasswordEncoder implements PasswordEncoder{
	
	private PasswordEncoder encoder;
	
	public CustomNoOpasswordEncoder() {
		this.encoder = new BCryptPasswordEncoder(5);
	}

	@Override
	public String encode(CharSequence rawPassword) {
		String encodedPassword = encoder.encode(rawPassword);
		//log.warn("before password ... :: " + rawPassword);
		return encodedPassword;
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		//log.warn("matches ... :: " + rawPassword + " :: " + encodedPassword);
		//return rawPassword.toString().equals(encodedPassword);
		return encoder.matches(rawPassword, encodedPassword);
	}
}
