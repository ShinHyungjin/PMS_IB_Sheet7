package ibs.com.security;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomLoginFailedHandler implements  AuthenticationFailureHandler{
	private static final Logger LOGGER = LoggerFactory.getLogger(CustomLoginFailedHandler.class);

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException {
	
		//LOGGER.info("로그인 실패!");
		
		//LOGGER.info("Exception : " + exception.getMessage());
		
		if (exception instanceof AuthenticationServiceException) {
			request.setAttribute("msg", "존재하지 않는 사용자입니다.");
		} else if(exception instanceof BadCredentialsException) {
			request.setAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다.");
		}  else if(exception instanceof DisabledException) {
			request.setAttribute("msg", "관리자 승인이 필요한 유저 입니다.");
		} 
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/user/loginFailed");
		dispatcher.forward(request, response);
		
		//response.sendRedirect("/user/loginFailed");
	}
}
