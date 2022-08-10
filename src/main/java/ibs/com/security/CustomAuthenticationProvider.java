package ibs.com.security;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;

import ibs.com.domain.SecurityVO;
import ibs.com.domain.UserVO;
import ibs.com.mapper.UserMapper;

public class CustomAuthenticationProvider implements AuthenticationProvider {
	private static final Logger LOGGER = LoggerFactory.getLogger(CustomAuthenticationProvider.class);
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Resource(name="userMapper")
	private UserMapper userMapper;
 
    @SuppressWarnings("unchecked")
    @Override
    public Authentication authenticate(Authentication authentication) {
        
        String username = (String) authentication.getPrincipal();
        String password = (String) authentication.getCredentials();
        
        UserVO user = userMapper.selectUserById(username);
        UserDetails details = user == null? null:new SecurityVO(user);
        
        //LOGGER.info("input password : " + password + "\tselectVO passoword : " + user.getPassword() );
       
        if(details == null) {
        	throw new AuthenticationServiceException("AuthenticationServiceException");
        }
        
        
        //if(!matchPassword(password, user.getPassword())) {
        //System.out.println(password + "," + user.getPassword());
        if(!encoder.matches(password, user.getPassword())) {
        	//LOGGER.info("password missmatch !");
            throw new BadCredentialsException("BadCredentialsException");
        }
 
        if(!details.isEnabled()) {
            throw new DisabledException("DisabledException");
        }
        return new UsernamePasswordAuthenticationToken(details, details, details.getAuthorities());
    }
 
    @Override
    public boolean supports(Class<?> authentication) {
        return true;
    }
    
    private boolean matchPassword(String loginPwd, String password) {
        return loginPwd.equals(password);
    }
}
