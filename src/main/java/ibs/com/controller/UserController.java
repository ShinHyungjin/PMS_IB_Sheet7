package ibs.com.controller;

import java.security.Principal;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import ibs.com.domain.CriteriaVO;
import ibs.com.domain.ProjectVO;
import ibs.com.domain.UserVO;
import ibs.com.security.CustomNoOpasswordEncoder;
import ibs.com.service.JobService;
import ibs.com.service.UserService;
import lombok.extern.log4j.Log4j;

/**
 * @FileName : UserController.java
 * @Date : 2021. 8. 24. 
 * @작성자 : 류슬희, 윤주영
 * @설명 : 유저 컨트롤러
 */


@Log4j
@Controller
@RequestMapping("user")
public class UserController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private CustomNoOpasswordEncoder encoder;
	
	@Resource(name="userService")
	private UserService userService;
    @Resource(name = "jobService")
    private JobService jobService;
    
    
    @RequestMapping(value="/test", method=RequestMethod.GET)
    public ModelAndView test(Principal loginUser, Model model, String selectDepartment) throws ParseException, org.json.simple.parser.ParseException {
        
        int menu_Id=54;
        String User=loginUser.getName();
        if(User==null){
            User="";
        }
        
        List<Map> projectMemberList = jobService.selectProjectMember(menu_Id); //해당 프로젝트에 소속된 멤버들을 가져온다
      //  System.out.println("프로젝트 소속 멤버 출력 형식 Test: "+projectMemberList);
        JSONArray projectMemberjsonarr = new JSONArray();
        
        for(int i=0; i<projectMemberList.size(); i++) {
            ObjectMapper objectMapper = new ObjectMapper();
            
            String jsonString;
            try {
                jsonString = objectMapper.writeValueAsString(projectMemberList.get(i));
             //   System.out.println("writeValueAsString: "+jsonString);
                JSONParser jsonParser = new JSONParser();
                JSONObject jsonObj = (JSONObject) jsonParser.parse(jsonString);
               // System.out.println("jsonParser한것을 JSONObject에 담은 후 "+jsonObj);
                projectMemberjsonarr.add(jsonObj);
                
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        }
      //  System.out.println("JsonArray 출력: "+projectMemberjsonarr);
        JSONObject projectMemberjson = new JSONObject();
        projectMemberjson.put("DATA", projectMemberjsonarr);
        //LOGGER.info("DATA : " + projectMemberjson);

        ModelAndView mav = new ModelAndView("user/test");
        mav.addObject("projectMemberjson", projectMemberjson);
        mav.addObject("getProjectId", menu_Id);
        //mav.addObject("loginauth", menuService.loginauth(User));
        //LOGGER.info("loginauth : " + User);
        return mav;
        
    }
    
	
	//슬희ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		@RequestMapping(value="/join", method=RequestMethod.GET)
		public void join() {
		}
		
		@RequestMapping(value="/join", method=RequestMethod.POST)
		@ResponseBody
		public String join(@RequestBody UserVO vo) {
			log.info("================================");
			/*log.info("야매0 유저 아이디:");*/
			//log.info("register: " + userVO);
			try {
				String encodedPassword = encoder.encode(vo.getPassword());
				vo.setPassword(encodedPassword);
				
				userService.join(vo);
				log.info("야매0 유저 아이디:" + vo.getId());

				return "{ \"success\": true }";
			} catch (Exception e) {
				return "";
			}
		}
				
		//개인정보 수정
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value="/modify", method=RequestMethod.GET)
		public void getmodify(Principal loginUser,String title, String id,Model model,CriteriaVO cri) throws Exception{
			
			String User=loginUser.getName();
	        if(User==null){
	            User="";
	        }
	        cri.setUserid(User);
	        cri.setProject_title(title);
			UserVO myInfo=userService.selectUserById(User);
			//LOGGER.info("나의 개인정보 조회 테스트: "+myInfo);
			model.addAttribute("myInfo",myInfo);
			model.addAttribute("beforeCnt",jobService.beforeMyJobCntById(cri));
			System.out.println("beforeCnt: " + jobService.beforeMyJobCntById(cri));
			model.addAttribute("ingCnt",jobService.ingMyJobCntById(cri));
			model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
		    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
		}				
		
		
		//개인정보 조회
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value={"/get"})
		public void getAndMofify(Principal loginUser,String title, String id,Model model,CriteriaVO cri){
			String User=loginUser.getName();
	        if(User==null){
	            User="";
	        }
	        cri.setUserid(User);
	        cri.setProject_title(title);
			UserVO myInfo=userService.selectUserById(User);
			//LOGGER.info("나의 개인정보 조회 테스트: "+myInfo);
			model.addAttribute("myInfo",myInfo);
			
			/*String encodedPassword = encoder.encode(myInfo.getPassword());
			myInfo.setPassword(encodedPassword);*/
			model.addAttribute("beforeCnt",jobService.beforeMyJobCntById(cri));
			model.addAttribute("ingCnt",jobService.ingMyJobCntById(cri));
			model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
		    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	      /*  if(encoder.matches(inputPw, myInfo.getPassword())) {
	        	
	        }*/
		}
		
		@PreAuthorize("isAuthenticated()")
		@RequestMapping(value="/modify", method=RequestMethod.POST)
		@ResponseBody
		public Map<String,String> postmodify(@RequestBody UserVO vo) throws Exception{
	        
				String encodedPassword = encoder.encode(vo.getPassword());
				System.out.println("encodedPassword" + encodedPassword);
				vo.setPassword(encodedPassword);
			
				//System.out.println("넘어온 타입:"+vo);
				userService.modify(vo);
				Map map = new HashMap();
				map.put("data", "success");
				return map;
			
		}
		
		
		
		//아이디 중복체크
		@RequestMapping(value="/idcheck", method=RequestMethod.POST)
		@ResponseBody
		public Map<Object, Object> idcheck(@RequestBody UserVO vo) {
			//log.info(vo); 
			int count = 0;
			Map<Object, Object> map = new HashMap<Object, Object>();
			 
			count = userService.idChk(vo);
			map.put("cnt", count);
			//log.info("중복체크 값 : " + count);
			 
			return map;
		}
		
		
		//주영ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		@RequestMapping(value="/getAllUserInfo",method=RequestMethod.POST)
		@ResponseBody
		public List<UserVO> getAllUserInfo(){
			
			List<UserVO> allUserInfo=userService.selectAllUserInfo();
			//System.out.println(allUserInfo);
			return allUserInfo;
		}
		
		
		
		@RequestMapping(value="/login", method=RequestMethod.GET)
		public void moveLoginPage(){
				//LOGGER.info("로그인 화면 이동");
		/*		String id="yjy";
				UserVO test=userservice.selectUserById(id);
				System.out.println(test.toString());*/
		}
		
		@RequestMapping(value="/logout", method=RequestMethod.POST)
		public void userLogOut(){
				//LOGGER.info("로그아웃");
		
		}
		
		public static void logout(HttpServletRequest request) {
			request.getSession().invalidate();
			request.getSession(true);
		}
		
		@RequestMapping(value="/logout", method=RequestMethod.GET)
		public void moveLogOut(){
				//LOGGER.info("로그아웃 페이지로 이동");
		
		}
		
		@RequestMapping(value="/loginFailed", method=RequestMethod.POST)
		public String moveLoginFailed(Model model, HttpServletRequest request){
				//LOGGER.info("로그인 실패 팝업 페이지 이동");
				model.addAttribute("msg",request.getAttribute("msg"));
				
				return "/err/err_Login";
		}
	
}
