package ibs.com.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @FileName : HomeController.java
 * @Date : 2021. 8. 24. 
 * @작성자 : 류슬희
 * @설명 : 메인 컨트롤러
 */ 

@Controller
public class HomeController {
        private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);
            
        @RequestMapping(value="/", method = RequestMethod.GET)
        public String home(){
        	LOGGER.warn("/ 접근");
        	return "redirect:/user/login";
        }
}
