package ibs.com.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(CustomAccessDeniedHandler.class);
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
			
	/*	WebAuthenticationDetails web = (WebAuthenticationDetails) auth.getDetails();
		System.out.println("IP : " + web.getRemoteAddress());
		System.out.println("Session ID : " + web.getSessionId());
		
		// 인증 ID
		System.out.println("name : " + auth.getName());*/
		
		//LOGGER.info("로그인 성공");
		List<String>roleNames = new ArrayList();
		//auth:인증된 사용자의 정보
		auth.getAuthorities().forEach(authority -> roleNames.add(authority.getAuthority()));
		
		//LOGGER.info("권한"+roleNames);
		
		//인증 권한이 어드민이면 어드민 페이지로 따로 이동 0:관리자 1:세미관리자 2:그냥 유
	/*	if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("admin");
			response.sendRedirect("/authority/settings");
		}*/
		
		response.sendRedirect("job/list");
	
	}
	}


