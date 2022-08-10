package ibs.com.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;


public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(CustomAccessDeniedHandler.class);
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException ad)
			throws IOException, ServletException {
			request.setAttribute("msg", "접근권한이 없습니다.");
			//LOGGER.info("에러 출력");
			response.sendRedirect("/err/error");
		
	}

}
