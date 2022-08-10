package ibs.com.controller;

import java.security.Principal;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ibs.com.domain.CriteriaVO;
import ibs.com.service.JobService;
import ibs.com.service.UserService;

/**
  * @FileName : CommonController.java
  * @Date : 2021. 09.08 
  * @작성자 : 윤주영
  * @설명 : 공통사용 컨트롤러
  */

@Controller
public class CommonController {
	private static final Logger LOGGER = LoggerFactory.getLogger(AdminController.class);
   
	@Resource(name="jobService")
	private JobService jobService;
	
	@Resource(name="userService")
	private UserService userService;
   
	
   @RequestMapping(value="err/err")
   public void err() {
	   LOGGER.info("에러출력");
   }
   
   @RequestMapping(value="err/error")
   public void error() {
	   LOGGER.info("접근권한이 없어요");
   }
   
   @RequestMapping(value="err/Auth")
   public void errorAuth() {
	   LOGGER.info("접근권한이 없어요");
   }
   
   @RequestMapping(value="includes/header", method=RequestMethod.POST)
   @ResponseBody
   public JSONObject getUserNAME(Principal login,Model model,CriteriaVO cri){
	   String user = login.getName();
	   String userNameById=userService.selectUserName(user).getName(); // 로그인된 사용자의 이름을 출력
	   JSONObject resMap = new JSONObject();
	   model.addAttribute("id",login.getName());
	   resMap.put("name", userNameById);
	   
	   model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
	   
	   return resMap;
   }

   
} 