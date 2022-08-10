package ibs.com.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import ibs.com.domain.CommonVO;
import ibs.com.domain.CriteriaVO;
import ibs.com.domain.JobVO;
import ibs.com.domain.MemberVO;
import ibs.com.domain.MenuAuthorityVO;
import ibs.com.domain.ProjectDTO;
import ibs.com.domain.ProjectVO;
import ibs.com.domain.UserVO;
import ibs.com.domain.WbsVO;
import ibs.com.service.JobService;
import ibs.com.service.MenuService;
import ibs.com.service.ProjectService;
import ibs.com.service.UserService;
import ibs.com.service.WbsService;

/**
 * @FileName : ProjectController.java
 * @Date : 2021. 8. 20.
 * @작성자 : 신형진,윤주영, 류슬희
 * @설명 : 프로젝트 컨트롤러
 */

@Controller
@RequestMapping("project")
public class ProjectController {
   private static final Logger LOGGER = LoggerFactory.getLogger(ProjectController.class);
   //특정 프로젝트 클릭 시, ajax로 넘긴 jsp 데이터를 저장하고, 다른 jsp에서 이를 이용
   private int projectId = 0;
   
   @Resource(name = "menuService")
   private MenuService menuService;

   @Resource(name = "jobService")
   private JobService jobService;
    
   @Resource(name="userService")
   private UserService userService;
   
   @Resource(name="projectService")
   private ProjectService projectService;
   
   @Resource(name="wbsService")
   private WbsService wbsService;

   
   @RequestMapping(value = "/sheet/list", method = RequestMethod.POST)
   @ResponseBody
   public ProjectDTO data(Model model, HttpServletRequest request, Integer state, Principal loginUser){
	 //  System.out.println("ProjectDTO-------------------------------------");
	   if(state== null){
           state= 112;
       }
	   
	   String userid=loginUser.getName(); 
       if(userid==null){
          userid="";
       }
		ProjectDTO projectDTO = new ProjectDTO();
		//db에서 데이터 조회(VO의 리스트)
		List<ProjectVO> projectList = jobService.getMystate(userid, state);
		//LOGGER.info("projectList : " + jobService.getMystate(userid, state));
		//db에서 가져온 데이터를 data 필드에 넣어줌
		projectDTO.setData(projectList);
		return projectDTO;
   }
   
   
   @RequestMapping(value = "/list", method = RequestMethod.GET)
   public void list(Model model, HttpServletRequest request, Principal loginUser, CriteriaVO cri,String title){
	   LOGGER.info("project List 진입");
       String User=loginUser.getName();
       if(User==null){
           User="";
       }
   		
   		cri.setUserid(User);
        cri.setProject_title(title);
        model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
   }
   
   
   //슬희 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
   @RequestMapping(value = "/main", method = RequestMethod.GET)
   public String MainPage(Principal loginUser, Model model, int id,CriteriaVO cri,String title) {
      String userid = loginUser.getName().toString();
     // System.out.println("유저아이디: " + userid);

      String User=loginUser.getName();
      if(User==null){
          User="";
      }
      cri.setUserid(User);
      cri.setProject_title(title);
      
      
    //  System.out.println("------------------권한--------------------------");
    //  System.out.println(userid);
    //  System.out.println("wbs에서 전달받은 프로젝트id "+id);
      UserVO auth = userService.selectUserById(userid);
      String real_Auth=auth.getAuthList().get(0).getAuthority();
    //  System.out.println("권한" + auth.getAuthList().get(0).getAuthority());
      
      MenuAuthorityVO menuVo= new MenuAuthorityVO();
      menuVo.setProject_id(id);
      menuVo.setUser_id(userid);

       if(userid == null || userid.isEmpty()) {
         return "redirect:/user/login";
      }
      
     // LOGGER.info("menuService.loginauth2(userId, id, 1).intValue() 실행 후 PERMISSION CHECK : " + menuService.loginauth2(userid, id, 1));
      model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
	    
       if (menuService.loginauth2(userid, id, 1) != 0 || real_Auth.equals("ROLE_ADMIN") || real_Auth.equals("ROLE_MANAGER") ){ // menu ID 1에 대한 권한 체크
         model.addAttribute("menu",menuService.loginauth2(userid, id, 1));
         model.addAttribute("auth",real_Auth);
         return "redirect:/project/wbs?id=" + id;
      }
      else if (menuService.loginauth2(userid, id, 2) != 0 || real_Auth.equals("ROLE_ADMIN") || real_Auth.equals("ROLE_MANAGER")){ // menu ID 2에 대한 권한 체크
         model.addAttribute("menu",menuService.loginauth2(userid, id, 1));
         model.addAttribute("auth",real_Auth);
         return "redirect:/project/user?id=" + id;
      }
      else if (menuService.loginauth2(userid, id, 3) != 0 || real_Auth.equals("ROLE_ADMIN") || real_Auth.equals("ROLE_MANAGER")){ // menu ID 3에 대한 권한 체크
         model.addAttribute("menu",menuService.loginauth2(userid, id, 1));
         model.addAttribute("auth",real_Auth);
         return "redirect:/project/info?id=" + id;
      }
      else if (menuService.loginauth2(userid, id, 4) != 0 || real_Auth.equals("ROLE_ADMIN") || real_Auth.equals("ROLE_MANAGER")){ // menu ID 4에 대한 권한 체크
         model.addAttribute("menu",menuService.loginauth2(userid, id, 1));
         model.addAttribute("auth",real_Auth);
         return "redirect:/project/authority?id=" + id;
      }else{
         return "/err/Auth";
      }
      
   }
   
   
   //프로젝트 참여자 탭을 클릭했을 때 동작한다
      @RequestMapping(value = "/user", method = RequestMethod.GET)
      @ResponseBody
      public ModelAndView User(Principal loginUser, Model model, int id, HttpServletRequest request,CriteriaVO cri,String title) {
         int menu_Id=2;
         int getProjectId = Integer.parseInt(request.getParameter("id"));
         String User=loginUser.getName();
         if(User==null){
            User="";
         }
         cri.setUserid(User);
         cri.setProject_title(title);
         
         MenuAuthorityVO vo = new MenuAuthorityVO();
         vo.setUser_id(User);
         vo.setProject_id(id);
        // System.out.println(id);
         vo.setMenu_id(menu_Id);
         
         
         //vo.setGroup_id(groupidVo);
         
         LOGGER.info("권한 설정 테스트");
         String loginUserId = loginUser.getName();
         
         //System.out.println("메뉴권한"+ menuService.loginauth(vo));
         //model.addAttribute("loginauth", menuService.loginauth(vo));
         
         LOGGER.info("loginauth : " + User);
         
         
         model.addAttribute("userid", loginUserId); 
         
         String userId=loginUser.getName();
         if(userId==null){
            userId="";
         }
         int perm = menuService.loginauth2(userId, id, menu_Id);;
         if(perm == 0) {
            // 권한 에러 출력
            // return ~~
            
         }
         
         UserVO auth = userService.selectUserById(userId);
         String real_Auth=auth.getAuthList().get(0).getAuthority();
       //  System.out.println("권한" + auth.getAuthList().get(0).getAuthority());
         
         model.addAttribute("auth",real_Auth);
         model.addAttribute("userid", userId);
         model.addAttribute("menuId", menu_Id);
         model.addAttribute("authWbs", menuService.loginauth2(userId, id, 1));
         model.addAttribute("authUser", menuService.loginauth2(userId, id, 2));
         model.addAttribute("authInfo", menuService.loginauth2(userId, id, 3));
         model.addAttribute("authAuthority", menuService.loginauth2(userId, id, 4));
         model.addAttribute("project_id", id);
         model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
		    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
         
         List<Map> projectMemberList = jobService.selectProjectMember(getProjectId); //해당 프로젝트에 소속된 멤버들을 가져온다
         JSONArray projectMemberjsonarr = new JSONArray();
         
         for(int i=0; i<projectMemberList.size(); i++) {
            ObjectMapper objectMapper = new ObjectMapper();
            
            String jsonString;
            try {
               jsonString = objectMapper.writeValueAsString(projectMemberList.get(i));
               JSONParser jsonParser = new JSONParser();
               JSONObject jsonObj = (JSONObject) jsonParser.parse(jsonString);
               projectMemberjsonarr.add(jsonObj);
            } catch (JsonProcessingException e) {
               e.printStackTrace();
            } catch (ParseException e) {
               e.printStackTrace();
            }
         }
         
         JSONObject projectMemberjson = new JSONObject();
         projectMemberjson.put("DATA", projectMemberjsonarr);
         //LOGGER.info("DATA : " + projectMemberjson);

         ModelAndView mav = new ModelAndView("project/user");
         mav.addObject("projectMemberjson", projectMemberjson);
         //mav.addObject("loginauth", menuService.loginauth(User));
         LOGGER.info("loginauth : " + User);
            mav.addObject("getProjectId", getProjectId);
         return mav;
      }
      
       @RequestMapping(value={"/info","/modify"})
       public void moveProjectInfo(Principal loginUser, @RequestParam("id")int id,Model model,CriteriaVO cri,String title){
          int menu_Id=3;
          String userId=loginUser.getName();
         if(userId==null){
            userId="";
         }
         
         String User=loginUser.getName();
         if(User==null){
             User="";
         }
         cri.setUserid(User);
         cri.setProject_title(title);
         
         
         MenuAuthorityVO vo = new MenuAuthorityVO();
         vo.setUser_id(userId);
         vo.setProject_id(id);
         vo.setMenu_id(menu_Id);
         
         ProjectVO project = new ProjectVO();
         project.setManager(userId);
         project.setP_id(id);
         
         //vo.setGroup_id(groupidVo);
         
         LOGGER.info("권한 설정 테스트");
         LOGGER.info(String.valueOf(id));
         String loginUserId = loginUser.getName();
         
         model.addAttribute("project_id", id);
         
	    // System.out.println("내가 받은 id값: "+id);
	     ProjectVO info = jobService.getProjectInfoByProjectId(project);
	    //LOGGER.info("내가 찾는 프로젝트 정보는? : "+info);
	     model.addAttribute("project",info);
	       
	       
	       
          
         int perm = menuService.loginauth2(userId, id, menu_Id);;
         if(perm == 0) {
            // 권한 에러 출력
            // return ~~
            
         }
         UserVO auth = userService.selectUserById(userId);
         String real_Auth=auth.getAuthList().get(0).getAuthority();
        // System.out.println("권한" + auth.getAuthList().get(0).getAuthority());
         
         model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
		 model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
         model.addAttribute("auth",real_Auth);
         model.addAttribute("userid", userId);
         model.addAttribute("menuId", menu_Id);
         model.addAttribute("authWbs", menuService.loginauth2(userId, id, 1));
         model.addAttribute("authUser", menuService.loginauth2(userId, id, 2));
         model.addAttribute("authInfo", menuService.loginauth2(userId, id, 3));
         model.addAttribute("authAuthority", menuService.loginauth2(userId, id, 4));
         model.addAttribute("project_id", id);
         
       }
       
       @Transactional
       @RequestMapping(value="/modify",method=RequestMethod.POST)
       @ResponseBody
       public String modifyProjectInfo(ProjectVO project){
          LOGGER.info("수정해야 할 넘겨 받은 정보들: "+project);
          
      // 도도-pm -->yjy-팀원
             int result=0;
             
             //2.pm으로 바꿀사람의 권한이 이미 팀원같이 있다면
             if(jobService.getProjectAuthWhenProjectUpDateById(project)!=null){
                //3.pm으로 바꿀사람의 팀원 권한 4를 pm권한 2로 변경한뒤
                jobService.changeMyProjectAuth(project);
                //4.2번을 갖고있는 사람들중에 방금 등록한 새pm의 이름을 갖고있지않는 사람을 제거한다.
                jobService.deleteBeforePmAuth(project);
             }
             //5.최종적으로 프로젝트 수정을 실행한다.
             jobService.modifyProjectInfo(project);
            // System.out.println("수정 : " + jobService.modifyProjectInfo(project));
             return "success";
          
       }
      
      
      @RequestMapping(value = "/authority")
      public void authority(Principal loginUser,String title, Model model,int id,CriteriaVO cri) {
         int menu_Id=4;
         String userId=loginUser.getName();
         if(userId==null){
            userId="";
         }
         
         String User=loginUser.getName();
         if(User==null){
             User="";
         }
         cri.setUserid(User);
         cri.setProject_title(title);
         
         
         MenuAuthorityVO vo = new MenuAuthorityVO();
         vo.setUser_id(userId);
         vo.setProject_id(id);
         vo.setMenu_id(menu_Id);
         
         
         LOGGER.info("권한 설정 테스트");
         LOGGER.info(String.valueOf(id));
         String loginUserId = loginUser.getName();

         model.addAttribute("project_id", id);

         int perm = menuService.loginauth2(userId, id, menu_Id);;
         if(perm == 0) {
            // 권한 에러 출력
            // return ~~
            
         }
         UserVO auth = userService.selectUserById(userId);
         String real_Auth=auth.getAuthList().get(0).getAuthority();
        // System.out.println("권한" + auth.getAuthList().get(0).getAuthority());
         cri.setUserid(userId);
         cri.setProject_title(title);
         
         model.addAttribute("auth",real_Auth);
         model.addAttribute("userid", userId);
         model.addAttribute("menuId", menu_Id);
         model.addAttribute("authWbs", menuService.loginauth2(userId, id, 1));
         model.addAttribute("authUser", menuService.loginauth2(userId, id, 2));
         model.addAttribute("authInfo", menuService.loginauth2(userId, id, 3));
         model.addAttribute("authAuthority", menuService.loginauth2(userId, id, 4));
         model.addAttribute("project_id", id);
         model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
		    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
         
         LOGGER.info("loginauth : " + userId);
         
         
         model.addAttribute("userid", loginUserId);
         model.addAttribute("project_Id",id);
         /* List<HashMap> list=menuService.getGroupAuthByManager(loginUserId); */
        // System.out.println();
         /*
          * List<HashMap> list=menuService.getGroupAuthByManager(loginUserId);
          * 
          * LOGGER.info(loginUserId);
          * 
          * model.addAttribute("list",list);
          */
      }
      
      public String dbDateToString(String date) {
         SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
         try {
         return simpleDateFormat.format(simpleDateFormat.parse(date));
      } catch (java.text.ParseException e) {
         e.printStackTrace();
      }
         return "오류";
      }
   
   
      //WBS 편집 내용이 DB에 정상 적용되고 다시 바뀐내용들을 보여주거나, 처음 프로젝트를 클릭하여 WBS 보여줄 때 동작(=DB의 WBS 내용 가져오기)
      //위의 sendwbssheet 함수가 제대로 작동하여 DB에 데이터가 정상적으로 CRUD된다면, 아래의 계산식은 필요없이 그저 데이터를 가져오기만 하면 된다
      @RequestMapping(value = "/wbs", method = RequestMethod.GET)
      @ResponseBody
      public ModelAndView Wbs(Principal loginUser, Model model, int id, HttpServletRequest request,CriteriaVO cri,String title) {   
         int menu_Id=1;
         
         String userId=loginUser.getName();
         if(userId==null){
            userId="";
         }
         String User=loginUser.getName();
         if(User==null){
             User="";
         }
         cri.setUserid(User);
         cri.setProject_title(title);
         model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
 	     model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
 	    
         UserVO auth = userService.selectUserById(userId);
         String real_Auth=auth.getAuthList().get(0).getAuthority();
        // System.out.println("권한" + auth.getAuthList().get(0).getAuthority());
         
         model.addAttribute("auth",real_Auth);
         model.addAttribute("userid", userId);
         model.addAttribute("menuId", menu_Id);
         model.addAttribute("authWbs", menuService.loginauth2(userId, id, 1));
         model.addAttribute("authUser", menuService.loginauth2(userId, id, 2));
         model.addAttribute("authInfo", menuService.loginauth2(userId, id, 3));
         model.addAttribute("authAuthority", menuService.loginauth2(userId, id, 4));
         model.addAttribute("project_id", id);
         model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
		 model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
         
         LOGGER.info("ProjectController : /project/wbs 호출");
         LOGGER.info("ㅡㅡㅡㅡㅡㅡㅡㅡWBS Listㅡㅡㅡㅡㅡㅡㅡㅡ");
         
         int getProjectId = Integer.parseInt(request.getParameter("id")); // 프로젝트 클릭 시 넘겨받는 Project ID

         Calendar toDay = Calendar.getInstance(); // 오늘날짜
         Calendar startDate = null; // 작업 시작일 (START_DATE)
         Calendar endDate = null; // 작업 종료일 (END_DATE)
         Calendar addDate = null; // 시작일~종료일 사이의 주말을 제외하기 위한 계산용 날짜
         toDay.setTime(new Date());
         int managerCount = 0; //담당자 수
         String jobManager = ""; //작업 별 담당자의 이름을 뽑아오기 위한 저장변수
         long workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)
         float planMdSum = 0.0f; // toDay 기준 계획 작업량 (PLAN_ONE_MD)
         float planDateSum = 0.0f; // toDay 기준 계획 기간 (PLAN_DATE)
         long totalDate = 0;   //총작업량 (=TOTAL_DATE)
         long planDate = 0; //계획작업량 (=PLAN_DATE)
         boolean flag = true;
         
         String manager = "";
         String member = "";
         String memberId = "";
         
         SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); // objectMapper의 dateFormat
         String project_member = ""; // WBS의 Modal에게 프로젝트 참여자를 넘기기 위함

         ProjectVO projectVO = projectService.selectByProjectId(getProjectId); //프로젝트 한 개 가져오기
         List<Map> projectMemberList = jobService.selectProjectMember(getProjectId); //해당 프로젝트에 소속된 멤버들을 가져온다
         List<Map> wbsVOList = wbsService.selectByProjectId(getProjectId); //해당 프로젝트의 WBS 가져오기
         LOGGER.info("wbsVOList : " + wbsVOList);
         
         for (int j = 0; j < projectMemberList.size(); j++) {
             member = projectMemberList.get(j).get("user_name").toString();
             memberId = projectMemberList.get(j).get("user_id").toString();
             if (j != projectMemberList.size() - 1) {
                manager += member + "(" + memberId +"),";
             } else {
                manager += member + "(" + memberId + ")";
             }
          }
         project_member = manager;
         
         //GROUP_CONCAT을 사용하니 조회 데이터가 없어도 NULL로 반환하는 문제... 우선 다중 조건식으로 처리
         if(wbsVOList.size() == 0 || wbsVOList == null || wbsVOList.get(0) == null) {
            LOGGER.info("selectByProjectId 결과 없음");
            ModelAndView mav = new ModelAndView("project/wbs");
            mav.addObject("projectVO", projectVO);
            mav.addObject("project_member", project_member);
            mav.addObject("wbsjosn", null);
            model.addAttribute("projectVO", projectVO);
            return mav;
         }
         
         
         // simple Json lib를 이용하여 JSONArray를 JSP로 전송
         JSONArray wbsjsonarr = new JSONArray();
         
         // 최종 프로젝트의 WBS를 JSP에 넘겨주기 위해 WBS Sheet의 헤더인 '담당자 검색'에 프로젝트 멤버들만을 보여주기
         // 위해 | 문자열로 연결한다
         for (int i = 0; i < wbsVOList.size(); i++) {
            flag = true;
            Date date = null;
            workingDays = 0;
            LOGGER.info("wbsVOList One : " + wbsVOList.get(i));
             try {
                date = simpleDateFormat.parse((String.valueOf(wbsVOList.get(i).get("start_date"))));
                
                startDate = Calendar.getInstance();
                addDate = Calendar.getInstance();
                endDate = Calendar.getInstance();
                
                startDate.setTime(date);
                addDate.setTime(date);

                date = simpleDateFormat.parse(String.valueOf(wbsVOList.get(i).get("end_date")));
                endDate.setTime(date);

                // 주말을 제외한 총 기간 구하기
                while (!addDate.after(endDate)) {
                   int day = addDate.get(Calendar.DAY_OF_WEEK);
                   if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)) {
                      workingDays++; // 평일 수
                   }
                   addDate.add(Calendar.DATE, 1);
                }
                LOGGER.info("주말 제외 총 기간 : " + workingDays);

                totalDate = workingDays;

                workingDays = 0;
                addDate = startDate;

                // 주말을 제외한 계획 기간(=작업 N일차)구하기
                while (!addDate.after(toDay)) {
                   int day = addDate.get(Calendar.DAY_OF_WEEK);
                   if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)) {
                      workingDays++; // 평일 수
                   }
                   addDate.add(Calendar.DATE, 1);
                }
                LOGGER.info("주말 제외 계획 기간 : " + workingDays);

                planDate = workingDays;
                // 계획 기간이 총 기간보다 크거나 같다 = 오늘 기준 해당작업은 끝났어야 할 작업(=20짜리 작업이
                // 오늘기준 30이라면 종료된지 10일 지난 것)
                if (totalDate <= planDate) {
                   planDate = totalDate;
                   flag = false;
                }
             }catch (Exception e) {
                e.printStackTrace();
                }
             //TODO 작업 N일 차 구했으니 MANAGER 수 만큼 곱해서 넣어주자
             List<Map> JobVOList = wbsService.selectJobByWbsId(Integer.parseInt(String.valueOf(wbsVOList.get(i).get("id"))));
             LOGGER.info("가져온 리스트들 : " + JobVOList);
             
             
             if(JobVOList.size() <= 1) {
                wbsVOList.get(i).put("plan_date", planDate);
             } else {
                if(flag) {
                   wbsVOList.get(i).put("plan_date", planDate*JobVOList.size());
                } else {
                   wbsVOList.get(i).put("plan_date", planDate);
                }
             }
             wbsVOList.get(i).put("plan_one_md", planDate);
             
             float planProgress = Float.parseFloat(String.valueOf(wbsVOList.get(i).get("plan_date"))) / Float.parseFloat(String.valueOf(wbsVOList.get(i).get("total_date")));
             
             wbsVOList.get(i).put("plan_progress", planProgress);
             
            
            float plan_progress = Float.parseFloat(String.valueOf(wbsVOList.get(i).get("plan_date"))) /  Float.parseFloat(String.valueOf(wbsVOList.get(i).get("total_date")));
            wbsVOList.get(i).put("plan_progress", plan_progress);
            if(wbsVOList.get(i).get("job_total_real_progress") == null) {
               wbsVOList.get(i).put("total_real_progress", wbsVOList.get(i).get("wbs_total_real_progress"));
            } else {
               wbsVOList.get(i).put("total_real_progress", wbsVOList.get(i).get("job_total_real_progress"));
            }
            
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.setDateFormat(simpleDateFormat);
            
            try {
               wbsVOList.get(i).put("project_member", manager);
               
               String jsonString = objectMapper.writeValueAsString(wbsVOList.get(i));
               JSONParser jsonParser = new JSONParser();
               JSONObject jsonObj = (JSONObject) jsonParser.parse(jsonString);
               wbsjsonarr.add(jsonObj);
            } catch (JsonProcessingException | ParseException e) {
               e.printStackTrace();
            }
         }

         for (int i = 0; i < wbsjsonarr.size(); i++) {
            JSONObject json = (JSONObject) wbsjsonarr.get(i);
            LOGGER.info("wbsjsonArr --> wbsjsonObj : " + json.toString());
         }

         JSONObject wbsjson = new JSONObject();
         wbsjson.put("DATA", wbsjsonarr);

         ModelAndView mav = new ModelAndView("project/wbs");
         mav.addObject("wbsjson", wbsjson);
         mav.addObject("project_member", project_member);
         mav.addObject("project_id", id);
         mav.addObject("projectVO", projectVO);

         return mav;
      }
   
      //WBS 페이지에서 시트 내용 저장 시, 페이지의 새로고침 없이 Dosearch 함수로 시트 데이터만 새로고침한다
      //Dosearch 필수 요건 - POST, ResponseBody, Return type Map(Data, List)
      //WBS 페이지 접근이 이미 가능하기 때문에 유저의 권한체크는 할 필요가 없다
      @RequestMapping(value = "/wbs", method = RequestMethod.POST)
      @ResponseBody
      public Map<String, List<Map>> WbsPost(@RequestParam(value="projectId")Integer id, HttpServletRequest request) {   
        LOGGER.info("WBS POST CALLED");
         int menu_Id=1;
         
         int getProjectId = id.intValue(); // 프로젝트 클릭 시 넘겨받는 Project ID

         Calendar toDay = Calendar.getInstance(); // 오늘날짜
         Calendar startDate = null; // 작업 시작일 (START_DATE)
         Calendar endDate = null; // 작업 종료일 (END_DATE)
         Calendar addDate = null; // 시작일~종료일 사이의 주말을 제외하기 위한 계산용 날짜
         toDay.setTime(new Date());
         int managerCount = 0; //담당자 수
         String jobManager = ""; //작업 별 담당자의 이름을 뽑아오기 위한 저장변수
         long workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)
         float planMdSum = 0.0f; // toDay 기준 계획 작업량 (PLAN_ONE_MD)
         float planDateSum = 0.0f; // toDay 기준 계획 기간 (PLAN_DATE)
         long totalDate = 0;   //총작업량 (=TOTAL_DATE)
         long planDate = 0; //계획작업량 (=PLAN_DATE)
         boolean flag = true;
         
         String manager = "";
         String member = "";
         String memberId = "";
         
         SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); // objectMapper의 dateFormat
         String project_member = ""; // WBS의 Modal에게 프로젝트 참여자를 넘기기 위함

         ProjectVO projectVO = projectService.selectByProjectId(getProjectId); //프로젝트 한 개 가져오기
         List<Map> projectMemberList = jobService.selectProjectMember(getProjectId); //해당 프로젝트에 소속된 멤버들을 가져온다
         List<Map> wbsVOList = wbsService.selectByProjectId(getProjectId); //해당 프로젝트의 WBS 가져오기
         Map<String, List<Map>> wbsMap = new HashMap<>();
         List<Map> wbsListMap = new ArrayList<>();
         
         LOGGER.info("wbsVOList : " + wbsVOList);
         
         for (int j = 0; j < projectMemberList.size(); j++) {
             member = projectMemberList.get(j).get("user_name").toString();
             memberId = projectMemberList.get(j).get("user_id").toString();
             if (j != projectMemberList.size() - 1) {
                manager += member + "(" + memberId +"),";
             } else {
                manager += member + "(" + memberId + ")";
             }
          }
         project_member = manager;
         
         //GROUP_CONCAT을 사용하니 조회 데이터가 없어도 NULL로 반환하는 문제... 우선 다중 조건식으로 처리
         if(wbsVOList.size() == 0 || wbsVOList == null || wbsVOList.get(0) == null) {
            LOGGER.info("selectByProjectId 결과 없음");
            wbsMap.put("DATA", wbsListMap);
            return wbsMap;
         }
         
         
         // simple Json lib를 이용하여 JSONArray를 JSP로 전송
         JSONArray wbsjsonarr = new JSONArray();
         
         // 최종 프로젝트의 WBS를 JSP에 넘겨주기 위해 WBS Sheet의 헤더인 '담당자 검색'에 프로젝트 멤버들만을 보여주기
         // 위해 | 문자열로 연결한다
         for (int i = 0; i < wbsVOList.size(); i++) {
            flag = true;
            Date date = null;
            workingDays = 0;
            LOGGER.info("wbsVOList One : " + wbsVOList.get(i));
             try {
                date = simpleDateFormat.parse((String.valueOf(wbsVOList.get(i).get("start_date"))));
                
                startDate = Calendar.getInstance();
                addDate = Calendar.getInstance();
                endDate = Calendar.getInstance();
                
                startDate.setTime(date);
                addDate.setTime(date);

                date = simpleDateFormat.parse(String.valueOf(wbsVOList.get(i).get("end_date")));
                endDate.setTime(date);

                // 주말을 제외한 총 기간 구하기
                while (!addDate.after(endDate)) {
                   int day = addDate.get(Calendar.DAY_OF_WEEK);
                   if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)) {
                      workingDays++; // 평일 수
                   }
                   addDate.add(Calendar.DATE, 1);
                }
                LOGGER.info("주말 제외 총 기간 : " + workingDays);

                totalDate = workingDays;

                workingDays = 0;
                addDate = startDate;

                // 주말을 제외한 계획 기간(=작업 N일차)구하기
                while (!addDate.after(toDay)) {
                   int day = addDate.get(Calendar.DAY_OF_WEEK);
                   if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)) {
                      workingDays++; // 평일 수
                   }
                   addDate.add(Calendar.DATE, 1);
                }
                LOGGER.info("주말 제외 계획 기간 : " + workingDays);

                planDate = workingDays;
                // 계획 기간이 총 기간보다 크거나 같다 = 오늘 기준 해당작업은 끝났어야 할 작업(=20짜리 작업이
                // 오늘기준 30이라면 종료된지 10일 지난 것)
                if (totalDate <= planDate) {
                   planDate = totalDate;
                   flag = false;
                }
             }catch (Exception e) {
                e.printStackTrace();
                }
             //TODO 작업 N일 차 구했으니 MANAGER 수 만큼 곱해서 넣어주자
             List<Map> JobVOList = wbsService.selectJobByWbsId(Integer.parseInt(String.valueOf(wbsVOList.get(i).get("id"))));
             LOGGER.info("가져온 리스트들 : " + JobVOList);
             
             if(JobVOList.size() <= 1) {
                wbsVOList.get(i).put("plan_date", planDate);
             } else {
                if(flag) {
                   wbsVOList.get(i).put("plan_date", planDate*JobVOList.size());
                } else {
                   wbsVOList.get(i).put("plan_date", planDate);
                }
             }
             wbsVOList.get(i).put("plan_one_md", planDate);
             
             float planProgress = Float.parseFloat(String.valueOf(wbsVOList.get(i).get("plan_date"))) / Float.parseFloat(String.valueOf(wbsVOList.get(i).get("total_date")));
             
             wbsVOList.get(i).put("plan_progress", planProgress);
             
            
            float plan_progress = Float.parseFloat(String.valueOf(wbsVOList.get(i).get("plan_date"))) /  Float.parseFloat(String.valueOf(wbsVOList.get(i).get("total_date")));
            wbsVOList.get(i).put("plan_progress", plan_progress);
            if(wbsVOList.get(i).get("job_total_real_progress") == null) {
               wbsVOList.get(i).put("total_real_progress", wbsVOList.get(i).get("wbs_total_real_progress"));
            } else {
               wbsVOList.get(i).put("total_real_progress", wbsVOList.get(i).get("job_total_real_progress"));
            }
               wbsVOList.get(i).put("project_member", "검색");
               wbsVOList.get(i).put("Level", Integer.parseInt(String.valueOf(wbsVOList.get(i).get("deep"))));
               
               wbsListMap.add(wbsVOList.get(i));
         }
         wbsMap.put("DATA", wbsListMap);
         LOGGER.info("wbsMap : " + wbsMap);
         
         return wbsMap;
      }
      
   @RequestMapping(value="register")
     public void register(){
        
     }
   
   
      @Transactional
      @RequestMapping(value = "/usersave", method = RequestMethod.POST)
      //@ResponseBody
      public String usersave(HttpServletRequest request, Principal loginUser) {
         Map data = request.getParameterMap();
            JSONArray jsonArr = null; //넘겨받은 Map은 JSONArray로 변환하여 데이터 중 누락된 내용이 있는지 검수한다
            
         Iterator it = data.keySet().iterator();
         String key = "";
         while (it.hasNext()) {
            key = (String) it.next();
            String value = ((String[]) data.get(key))[0];
            LOGGER.info("시트에서 넘겨준 Map 데이터 - KEY :" + key +"\tVALUE : "+ value);
         }
            
            // JSON 데이터로 넘어오는데 {"data" : {["ORDER_ID" : "1.1"], [...]} } 형태이기 때문에
            // JSON배열로 파싱하여 작업을 구분짓는다
            try {
                JSONParser jsonParser = new JSONParser();
                JSONObject jsonObj = (JSONObject) jsonParser.parse(key);
                jsonArr = (JSONArray) jsonObj.get("data");

                LOGGER.info("jsonArr size : " + jsonArr.size() + "   jsonArr : " + jsonArr.toString());
                // 넘어오는 데이터 중 1행인 DEEP 0의 최상위 작업은 항상 넘어오기 때문에 이를 고려하여 Size가 1이면 변경된
                // 데이터가 없는것이며 이를 에러로 표현한다
                if (jsonArr.size() <= 0) {
                    LOGGER.info("변경 사항이 없습니다.");
                    return "/sheetsave/sheetSaveFailed";
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
            
            // 인덱스 1번 부터가 트랜잭션 변화가 있는 행에대한 정보들이 담겨져있다
               for (int i = 0; i < jsonArr.size(); i++) {
                JSONObject obj = (JSONObject) jsonArr.get(i);
                // 해당 행에서 작업명, 시작일, 종료일은 필수적으로 들어있어야 하는 값이다 (REPORT와 MANAGER는 null
                // 이여도 된다)
                if (((String) obj.get("Status")).equals("U")) {
                LOGGER.info("업데이트 시작");
                String userName=obj.get("user_name").toString();
              //  System.out.println("유저이름??: "+ userName);
               // System.out.println("아이디: "+ userName.substring(userName.indexOf("(")+1, userName.indexOf(")")));
                String RealuserId = userName.substring(userName.indexOf("(")+1, userName.indexOf(")"));
                String userId=userService.selectUserIdByName(userName);
                int group_id=Integer.parseInt(obj.get("group_id").toString());
                int project_id=Integer.parseInt(obj.get("project_id").toString());
                
                //1.새로은 pm으로 변경해주세요~ 라는 요청사항이 들어오면
                if(group_id==2){
                  // System.out.println("2번 pm고치러 들어왓어!!!!!!!!!!!!!!!");
                      MemberVO updateGroup = new MemberVO();
                       updateGroup.setGroup_id(2);
                       updateGroup.setProject_id(project_id);
                       updateGroup.setUser_id(RealuserId);
                       
                       //2.기존의 pm이였던 사람인 팀원 으로 변경되며
                       projectService.updateProjectMemberAuth2To4(updateGroup);
                       
                       //3.pm으로 선택된 사람은 기존의 가지고있던 권한을 pm으로 변경시킨다.
                       projectService.updateGroupIdByEachProject(updateGroup);
                       //4.프로젝트 에서도 담당자를 새로운 pm으로 바꿔준다.
                       projectService.updateProjectPmByChangedPmAtIbsheet(updateGroup);
                       
                }//pm변경요청이 아니면 pm아래급끼리는 다른 조건없이 자유자재로 변경이된다.
                else{
                MemberVO updateGroup = new MemberVO();
                updateGroup.setGroup_id(group_id);
                updateGroup.setProject_id(project_id);
                updateGroup.setUser_id(RealuserId);
                
                projectService.updateGroupIdByEachProject(updateGroup);
                }
                }
                if (((String) obj.get("Status")).equals("D")) {
                    LOGGER.info("추가 시작");
                    String userName=obj.get("user_name").toString();
                   // System.out.println("유저아이디: "+userName);
                    
                    String RealuserId = userName.substring(userName.indexOf("(")+1, userName.indexOf(")"));
                    
                    String userId=userService.selectUserIdByName(userName);
                    int group_id=Integer.parseInt(obj.get("group_id").toString());
                    int project_id=Integer.parseInt(obj.get("project_id").toString());
                    
                    MemberVO deleteGroup = new MemberVO();
                    deleteGroup.setGroup_id(group_id);
                    deleteGroup.setProject_id(project_id);
                    deleteGroup.setUser_id(RealuserId);
                    projectService.deleteMemberFromProject(deleteGroup);
                }
                
              //  System.out.println("출력해볼까나?: "+obj.get("STATUS"));
              //  System.out.println("출력해볼까나?: "+obj.get("group_id"));
            }
         return "/sheetsave/sheetSaveSuccess";
         
      }
      
      @RequestMapping(value="/permitionSave",method = RequestMethod.POST)
      @ResponseBody
      public String permitionSave(@RequestParam(value="userIdList[]")String[] userid,String project_Id){
        // System.out.println(Arrays.toString(userid));
        // System.out.println("프로젝트 번호:"+Integer.parseInt(project_Id));
         int projectId= Integer.parseInt(project_Id);
         List<String> id = new ArrayList<>();
         
         for(String user_Id : userid){
            id.add(user_Id);
         }
         
         for(int i=0; i<userid.length; i++){
            MemberVO vo = new MemberVO();
            vo.setGroup_id(4);
            vo.setProject_id(projectId);
            vo.setUser_id(id.get(i));
            projectService.insertProjectMemberByManager(vo);
         }
         return "/sheetsave/sheetSaveSuccess";
      }
      
      //프로젝트 참여인력
      @RequestMapping(value = "/useradd")
       public void user(Principal loginUser, Model model, String name, String department,int id)throws IOException{
         int menu_Id=2;
         String User=loginUser.getName();
         if(User==null){
            User="";
         }
         //  System.out.println("넘어온 프로젝트 아이디: "+id);
         //  System.out.println("넘어온 부서 정보: "+department);
           model.addAttribute("department",department);
           
           Map<String, Object>map = new HashMap<>();
           if(name!=null){
              map.put("name", name);
           }else if(department!=null){
              map.put("department", department);
           }
           
           map.put("project_id", id);
           
           
           String userId=loginUser.getName();
           if(userId==null){
              userId="";
           }
           UserVO auth = userService.selectUserById(userId);
           String real_Auth=auth.getAuthList().get(0).getAuthority();
           
           int perm = menuService.loginauth2(userId, id, menu_Id);
           List<UserVO> userVOList=userService.resultToSearchByDeptAndNameNotInProject(map);
           
           model.addAttribute("auth",real_Auth);
           model.addAttribute("userVOList", userVOList);
           model.addAttribute("userid", userId);
           model.addAttribute("project_Id",id);
           model.addAttribute("authWbs", menuService.loginauth2(userId, id, 1));
           model.addAttribute("authUser", menuService.loginauth2(userId, id, 2));
           model.addAttribute("authInfo", menuService.loginauth2(userId, id, 3));
           model.addAttribute("authAuthority", menuService.loginauth2(userId, id, 4));
         
      }
   
       //참여인력 부서별 조회로 검색했을 때 동작한다
      @RequestMapping(value = "/userdepartment2", method = RequestMethod.POST)
        public String userDepartmentSearch(Principal loginUser, Model model, String selectDepartment,String project_Id) {
         List<UserVO> userVOList;
         String User=loginUser.getName();
         if(User==null){
            User="";
         }

          //  System.out.println("넘어온 프로젝트 아이디: "+project_Id);
          //  System.out.println("넘어온 부서 정보: "+selectDepartment);
            HashMap<String, Object> map = new HashMap<>();
            map.put("project_id", project_Id);
            map.put("department", selectDepartment);
            userVOList=userService.selectAllUserInfoExceptThisProjectMemeberByDepartment(map);
         return "project/useradd";
      }
      
      //참여인력  사용자 이름으로 검색했을 때 동작한다
      @RequestMapping(value = "/usernamesearch2", method = RequestMethod.POST)
      public String userNameSearch(Model model, String userNameText) {
         List<UserVO> userVOList;

         if (userNameText == null || userNameText == "") {
            userVOList = userService.selectAllPermittedUser();
         } else {
            userVOList = userService.selectUserByName(userNameText);
         }

         for (UserVO vo : userVOList) {
            LOGGER.info("userVOList : " + vo);
         }

         model.addAttribute("userVOList", userVOList);
         model.addAttribute("userNameText", userNameText);

         return "project/useradd";
         
      }

   @RequestMapping(value="/showMyAuth", method=RequestMethod.POST)
   @ResponseBody
   public Map<String, Object> showMyAuth(Principal loginUser,@RequestParam(value="group")int group,@RequestParam(value="project_id") int project_id){
      LOGGER.info("============showMyAuth 넘어온 프로젝트 정보============: ");
      LOGGER.info(String.valueOf(group));
      LOGGER.info(String.valueOf(project_id));
      String userId=loginUser.getName();
      
      MenuAuthorityVO vo = new MenuAuthorityVO();
      vo.setGroup_id(group);
      vo.setProject_id(project_id);
      vo.setUser_id(userId);
      
      
      Map<String,Object> test = new HashMap<>();
      LOGGER.info(menuService.getGroupAuthByGroup(vo).toString());
      test.put("data", menuService.getGroupAuthByGroup(vo));
      return test;
   }
   
   //프로젝트 등록
   @Transactional
   @RequestMapping(value="/register", method=RequestMethod.POST)
   @ResponseBody
   public String register(ProjectVO vo) {
      //등록시 db에 진행되야 할 부분 
      //(새로 등록시) DB 트리거 이름: When_Project_Insert
      //1.project 테이블에 insert
      //2.해당 프로젝트 담당자로 지정되면 menu_authority 테이블에 메뉴에 대한 권한 insert
      //3.project_memeber 테이블에 pm으로 insert
      
      
      //(변경시) DB 트리거 이름: When_Project_Update
      //1.project 테이블에 update
      //2.project_member 테이블에 pm update
      
      //(삭제시)  DB 트리거 이름: When_Project_Delete
      //1.project 테이블에  delete
      //2.project_member에 해당 프로젝트 id로 멤버 delete
      //3.menu_authority 에 해당프로젝트 id로 권한 delete
      LOGGER.info("넘어온 프로젝트 정보: "+vo);
      int result=jobService.addNewProject(vo);
   /*   int projectId=jobService.getMyProjectIdByProjectTitle(vo);
      
      for(int i=1; i<=4; i++){
         MenuAuthorityVO menu = new MenuAuthorityVO();
         menu.setGroup_id(2);
         menu.setProject_id(projectId);
         menu.setMenu_id(i);
         menu.setPermission_check(2);
         menuService.insertInfo(menu);
      }
      
      MemberVO newVo = new MemberVO();
      newVo.setUser_id(vo.getManager());
      newVo.setProject_id(projectId);
      newVo.setGroup_id(2);
      //프로젝트 생성시 담당자 권한 proeject_member테이블에 추가
      jobService.addProjectMemberAuth(newVo);*/
         if(result>0){
            return "success";
         }else{
            return "false";
         }
   }
      
   

   @RequestMapping(value = "/save", method = RequestMethod.POST)
   public String saveAuthority(Principal loginUser, @RequestParam(value="nickname") String[] nickname, @RequestParam(value="authority") int[] authority,
      @RequestParam String group, Model model) {
    //  System.out.println("======================/authority/save 권한 설정 POST 테스트=========================");
      List<Integer> menuArr = new ArrayList();
      List<Integer> authArr = new ArrayList();

      // 메뉴이름
      for (String test : nickname) {
       //  System.out.print("메뉴들 출력: " + test + " ");
         menuArr.add(Integer.parseInt(test));
      }
      // 권한
      for (int test1 : authority) {
       //  System.out.print("메뉴에 대한 권한 출력: " + test1 + " ");
         authArr.add(test1);
      }
      // 해당 유저 아이디
    //  System.out.println("적용 대상의 그룹: " + group);

      int testGroup = Integer.parseInt(group);
     // System.out.println("그룹 아이디: " + testGroup);

      // PM이 자기 그룹에 대한 메뉴 접근권한
      // 설정시==================================================
      // 1.선행되는 행동은 저장을 눌렀을때 해당 컨트롤러에 들어와서 해당 로직이 실행된다.
      String loginUserId = loginUser.getName();
      String userNameById=userService.selectUserName(loginUserId).getName(); // 로그인된 사용자의 이름을 출력
      // 2.먼저 이전의 PM,그룹 에 대한 파라미터를 받아서 이전의 권한 DB값이 존재하는지 확인한다.
      MenuAuthorityVO vo1 = new MenuAuthorityVO();
      vo1.setGroup_id(testGroup);
      
     // System.out.println("존재하는지 탐색 시작");
      int list = menuService.getGroupAuthByManager(vo1);

      // 3.존재하면 모두 삭제
      if (list>0) {
     //    System.out.println("존재하니깐 삭제작업 시작");
         menuService.deleteGroupAuthByManager(vo1);
      }

      // 4.이후 새롭게 저장되는 정보값들을 다시 Insert 해준다.
      // 5.결국 delete-insert 순서의 갱신 로직이다.

      // 입력받은 메뉴접근 권한 db에 적용해주는 부분 임시구현(추후 리팩토링
      // 필요)============================
    //  System.out.println("존재안한다! 갱싱작업 시작");
      int result = 0;
      MenuAuthorityVO vo = new MenuAuthorityVO();
      for (int i = 0; i < 4; i++) {
         vo.setMenu_id(menuArr.get(i));
         vo.setPermission_check(authArr.get(i));
         vo.setGroup_id(testGroup);
         vo.setUser_id(loginUserId);
         menuService.insertInfo(vo);

      
      //System.out.println(vo);
      }
      
      return "/project/authority";

   }
   
   @RequestMapping(value = "/save1", method = RequestMethod.POST)
   @ResponseBody
   public Map<String, Object> saveAuthority1(Principal loginUser, @RequestParam(value="menu[]") List<Integer> menu, @RequestParam(value="read[]") List<Integer> read,
         @RequestParam(value="update[]") List<Integer> update,@RequestParam(value="group") int group,@RequestParam(value="project_id") int project_id, Model model) {
    //  System.out.println("======================save1 들오았음==========================================");
      LOGGER.info("넘어온 메뉴정보: "+menu);
      LOGGER.info("넘어온 읽기 권한: "+read);
      LOGGER.info("넘어온 수정 권한: "+update);
      LOGGER.info("넘어온 선택된 적용 그룹: "+group);
      LOGGER.info("넘어온 프로젝트 아이디: "+project_id);
      
   
      //메뉴에 대한 권한배열
      List<Integer>menuAuth = new ArrayList<>();
      for(int i=0; i<menu.size(); i++){
         if(update.get(i)==1 ){
            menuAuth.add(2);
         }else if(read.get(i)==1&&update.get(i)==0){
            menuAuth.add(1);
         }else if(read.get(i)==0&&update.get(i)==0){
            menuAuth.add(0);
         }
      }
      LOGGER.info("DB에 들어가는 계산된 권한처리 결과: "+menuAuth);
      
      //메뉴 배열
      List<Integer>menu_Arr = new ArrayList<>();
      
      for(int menuInfo : menu){
         menu_Arr.add(menuInfo);
      }
      LOGGER.info("메뉴장보: "+menu_Arr);
      
      Map<String,Object> test = new HashMap<>();
      
      MenuAuthorityVO vo=new MenuAuthorityVO();
      vo.setGroup_id(group);
      vo.setProject_id(project_id);
      
    //  System.out.println("존재하는지 탐색 시작");
      int result = menuService.getGroupAuthByManager(vo);
      
      if(result>0){
         LOGGER.info("존재하니깐 수정작업 시작!");
         for (int i = 0; i < 4; i++) {
         MenuAuthorityVO menu_Authority1=new MenuAuthorityVO();
         menu_Authority1.setPermission_check(menuAuth.get(i));
         menu_Authority1.setGroup_id(group);
         menu_Authority1.setProject_id(project_id);
         menu_Authority1.setMenu_id(menu_Arr.get(i));
         menuService.updateMenuAuthByMyInfo(menu_Authority1);
         }
      }else{
         LOGGER.info("존재안한다 추가작업 시작!");
      for (int i = 0; i < 4; i++) {
         MenuAuthorityVO menu_Authority = new MenuAuthorityVO();
         menu_Authority.setPermission_check(menuAuth.get(i));
         menu_Authority.setGroup_id(group);
         menu_Authority.setProject_id(project_id);
         menu_Authority.setMenu_id(menu_Arr.get(i));
         menuService.insertInfo(menu_Authority);
       //  System.out.println(menu_Authority);
      }
      }
      test.put("data", "success");
      return test;

   }
   

// =====================================================================형진씨 작업 내용===============================================
   // 시작==============================
   // WBS 편집 시 동작(=WBS IB Sheet에 작업추가, 삭제, 갱신)
   @RequestMapping(value = "/sendwbssheet", method = RequestMethod.POST)
   public String sendWbsSheet(HttpServletRequest request, Principal loginUser) {
     LOGGER.info("=========================================================================");
      LOGGER.info("Send WBS IB Sheet JSON Data!");
      Map data = request.getParameterMap(); // DoSave로 넘어온 데이터를 Map으로 받는다

      List<WbsVO> wbsVOInsertList = new ArrayList<>(); // Insert 대상 VO List
      List<WbsVO> wbsVOUpdateList = new ArrayList<>(); // STATUS가 'U'인 VO List
      List<WbsVO> wbsVODeleteList = new ArrayList<>(); // Delete 대상 VO List
      
      List<Map> jobVOList = new ArrayList<>(); //시트의 WBS ID와 일치하는 JobVO List
      List<JobVO> jobVOInsertList = new ArrayList<>(); //JOB테이블에 추가할 JobVO List
      List<JobVO> jobVOUpdateList = new ArrayList<>(); //JOB테이블에 편집할 JobVO List
      List<JobVO> jobVODeleteList = new ArrayList<>(); //JOB테이블에 삭제할 JobVO List

      Calendar toDay = Calendar.getInstance(); // 오늘날짜
      toDay.setTime(new Date());
      Calendar startDate = null; // 작업 시작일 (START_DATE)
      Calendar endDate = null; // 작업 종료일 (END_DATE)
      Calendar addDate = null; // 시작일~종료일 사이의 주말을 제외하기 위한 계산용 날짜
      long workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)
      long totalDate = 0;   //총작업량 (=TOTAL_DATE)
      long planDate = 0; //계획작업량 (=PLAN_DATE)
      int result = 0; // SQL처리 확인용 변수

      SimpleDateFormat beforeSimpleDateFormat = new SimpleDateFormat("yyyyMMdd");

      JSONArray jsonArr = null; // 넘겨받은 Map은 JSONArray로 변환하여 데이터 중 누락된 내용이 있는지 검수한다

      // 트랜잭션 변화가 있는 IB Sheet의 Data는 "Param"의 데이터를 넣어줬기 때문에 맨 마지막 요소가 변화된 행의 정보들이 담겨져있다
      Iterator it = data.keySet().iterator();
      String key = "";
      while (it.hasNext()) {
         key = (String) it.next();
         String value = ((String[]) data.get(key))[0];
      }

      LOGGER.info("Last Key : " + key);

      // JSON 데이터로 넘어오는데 {"data" : {["ORDER_ID" : "1.1"], [...]} } 형태이기 때문에 JSON배열로 파싱하여 작업을 구분짓는다
      try {
         JSONParser jsonParser = new JSONParser();
         JSONObject jsonObj = (JSONObject) jsonParser.parse(key);
         jsonArr = (JSONArray) jsonObj.get("data");

         LOGGER.info("jsonArr size : " + jsonArr.size() + "   jsonArr : " + jsonArr.toString());
         // 넘어오는 데이터 중 1행인 DEEP 0의 최상위 작업은 항상 넘어오기 때문에 이를 고려하여 Size가 1이면 변경된 데이터가 없는것이며 이를 에러로 표현한다
         if (jsonArr.size() <= 0) {
            LOGGER.info("변경 사항이 없습니다.");
            return "/sheetsave/sheetSaveFailed";
         }
      } catch (ParseException e) {
         e.printStackTrace();
      }
      // 인덱스 0번 부터가 트랜잭션 변화가 있는 행에대한 정보들이 담겨져있다
      for (int i = 0; i < jsonArr.size(); i++) {
         JSONObject obj = (JSONObject) jsonArr.get(i);
         // 해당 행에서 작업명, 시작일, 종료일은 필수적으로 들어있어야 하는 값이다 (REPORT와 MANAGER는 null 이여도 된다)
         if (((String) obj.get("name")).equals("")) {
            LOGGER.info("작업명이 누락되었습니다.");
            return "/sheetsave/sheetSaveFailed";
         }
         if (((String) obj.get("start_date")).equals("")) {
            LOGGER.info("시작일이 누락되었습니다.");
            return "/sheetsave/sheetSaveFailed";
         }
         if (((String) obj.get("end_date")).equals("")) {
            LOGGER.info("종료일이 누락되었습니다.");
            return "/sheetsave/sheetSaveFailed";
         }
         
         LOGGER.info("WBS시트에서 보내준 데이터는 : " + obj.toJSONString());
         
         //WBS 시트의 상태값이 U라면 WBS 자체는 Update, JOB은 아래의 1,2,3 경우에따라 적용
         /*
          * 1. 담당자가 추가됬다면 JOB에는 INSERT
          * 2. 담당자가 삭제됬다면 JOB에는 DELETE
         * 3. 담당자가 그대로라면 JOB에는 UPDATE
          * */
         
         startDate = Calendar.getInstance();
         addDate = Calendar.getInstance();
         endDate = Calendar.getInstance();
         workingDays = 0;
         
         // 총 작업량, 계획 작업량, 총 기간, 계획 기간, 계획 진행률은(=WBS상에서의 주황색) 계산되어서
         // INSERT 되야하므로 아래에서 계산한다
         Date date;
         try {
            date = beforeSimpleDateFormat.parse((String) obj.get("start_date"));
            startDate.setTime(date);
            addDate.setTime(date);

            date = beforeSimpleDateFormat.parse((String) obj.get("end_date"));
            endDate.setTime(date);

            // 주말을 제외한 총 기간 구하기
            while (!addDate.after(endDate)) {
               int day = addDate.get(Calendar.DAY_OF_WEEK);
               if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)) {
                  workingDays++; // 평일 수
               }
               addDate.add(Calendar.DATE, 1);
            }
            LOGGER.info("주말 제외 총 기간 : " + workingDays);

            totalDate = workingDays;

            workingDays = 0;
            addDate = startDate;

            // 주말을 제외한 계획 기간(=작업 N일차)구하기
            while (!addDate.after(toDay)) {
               int day = addDate.get(Calendar.DAY_OF_WEEK);
               if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)) {
                  workingDays++; // 평일 수
               }
               addDate.add(Calendar.DATE, 1);
            }
            LOGGER.info("주말 제외 계획 기간 : " + workingDays);

            planDate = workingDays;
            // 계획 기간이 총 기간보다 크거나 같다 = 오늘 기준 해당작업은 끝났어야 할 작업(=20짜리 작업이
            // 오늘기준 30이라면 종료된지 10일 지난 것)
            if (totalDate <= planDate) {
               planDate = totalDate;
            }
         }catch (Exception e) {
            e.printStackTrace();
            }
         
         if(((String) obj.get("status")).equals("U")) {
            String [] wbsManagerIdarr;
            
            if(!String.valueOf(obj.get("manager_id")).equals("")) {
               wbsManagerIdarr = String.valueOf(obj.get("manager_id")).split(",");
            } else {
               wbsManagerIdarr = null;
            }
            
            WbsVO wbsVO = new WbsVO();
            
            
            if(!String.valueOf(obj.get("parent")).equals("Y")){
               if(wbsManagerIdarr == null || wbsManagerIdarr.length ==1) {
                   wbsVO.setTotal_date(totalDate);
                   wbsVO.setTotal_real_progress(Float.parseFloat(String.valueOf(obj.get("total_real_progress"))));
                } else {
                   wbsVO.setTotal_date(totalDate*wbsManagerIdarr.length);
                } 
               wbsVO.setTotal_one_md(totalDate);
            } else {
               wbsVO.setTotal_date(Float.parseFloat(String.valueOf(obj.get("total_date"))));
               wbsVO.setTotal_one_md(Float.parseFloat(String.valueOf(obj.get("total_one_md"))));
            }
            /*
            wbsVO.setTotal_date(Float.parseFloat(String.valueOf(obj.get("total_date"))));
            wbsVO.setTotal_one_md(Float.parseFloat(String.valueOf(obj.get("total_one_md"))));
            wbsVO.setTotal_real_progress(Float.parseFloat(String.valueOf(obj.get("total_real_progress"))));
            */
            
            wbsVO.setId(Integer.parseInt(String.valueOf(obj.get("id"))));
            wbsVO.setRow_index(Integer.parseInt(String.valueOf(obj.get("row_index"))));
            wbsVO.setDeep(Integer.parseInt(String.valueOf(obj.get("treelevel"))));
            wbsVO.setName(String.valueOf(obj.get("name")));
            wbsVO.setOrder_id(String.valueOf(obj.get("order_id")));
            wbsVO.setStart_date(String.valueOf(obj.get("start_date")));
            wbsVO.setEnd_date(String.valueOf(obj.get("end_date")));
            wbsVO.setReport(String.valueOf(obj.get("report")));
            
            int wbs_id = Integer.parseInt(String.valueOf(obj.get("id")));
            
            jobVOList = jobService.selectJobByWbsId(wbs_id);
            LOGGER.info("갖고온 JOB VO List : " + jobVOList);
            
            //1. WBS 시트에서 '담당자' 칸을 빈칸으로 넘겼다면
            if(wbsManagerIdarr == null ) {
               if(jobVOList.size() == 0) {
                  LOGGER.info("WBS 시트에서 모든 담당자를 삭제했거나 담당자를 지정하지 않았고, 해당 WBS ID로 가져온 JOB이 없으므로 단순 WBS UPDATE 대상");
               } else {
                  LOGGER.info("WBS 시트에서 모든 담당자를 삭제했거나 담당자를 지정하지 않았지만, 해당 WBS ID로 가져온 JOB이 존재하므로 해당 JOB은 전부 DELETE 대상");
                  for(Map map : jobVOList) {
                     JobVO jobVO = new JobVO();
                     jobVO.setId(Integer.parseInt(String.valueOf(map.get("id"))));
                     jobVO.setWbs_id(wbs_id);
                     jobVO.setManager(String.valueOf(map.get("manager")));
                     
                     jobVODeleteList.add(jobVO);
                  }
//                  if(!String.valueOf(obj.get("parent")).equals("Y")) {
//                     wbsVO.setTotal_real_progress(0.0f);
//                  }
               }
            }else {
               //2. WBS 시트에서 담당자를 지정해서 넘겼다면 JOB의 담당자와 WBS의 담당자를 비교해서 JOB의 UPDATE, INSERT, DELETE 작업을 수행
               //2.1 만약 JOB에 할당된 담당자가 있다면 비교를 통해 작업 수행
               if(jobVOList.size() != 0) {
                  for(int k=0; k<wbsManagerIdarr.length; k++) {
                     String wbsManagerId = wbsManagerIdarr[k];
                     for(int o=0; o<jobVOList.size(); o++) {
                        Map map = jobVOList.get(o);
                        LOGGER.info("JOB : " + map);
                          LOGGER.info("WBS : " + obj);
                        
                        //WBS 시트 담당자와 JOB 담당자가 같다 = UPDATE 대상이다
                        if(wbsManagerId.equals(String.valueOf(map.get("manager")))) {
                           LOGGER.info("시트 담당자와 JOB 담당자가 같다! WBS : " + wbsManagerId + "  시트 : " + map.get("manager"));
                           JobVO jobVO = new JobVO();
                           jobVO.setId(Integer.parseInt(String.valueOf(map.get("id"))));
                           jobVO.setName(String.valueOf(obj.get("name")));
                           jobVO.setReport(String.valueOf(obj.get("report")));
                           
                           jobVOUpdateList.add(jobVO);
                           
                           break;
                        } else {
                           //WBS 시트 담당자와 JOB 담당자가 같지않고, JOB 담당자를 모두 순회했다 = 추가된 담당자이므로 INSERT 대상이다
                           if(o == jobVOList.size()-1) {
                              LOGGER.info("JOB을 전부 순회했는데 일치하는 담당자가 없슴 : " + wbsManagerId);
                              LOGGER.info("JOB : " + map);
                              LOGGER.info("WBS : " + obj);
                              JobVO jobVO = new JobVO();
                               jobVO.setWbs_id(Integer.parseInt(String.valueOf(obj.get("id"))));
                               jobVO.setReal_start_date(String.valueOf(obj.get("start_date")));
                               jobVO.setReal_end_date(String.valueOf(obj.get("end_date")));
                               jobVO.setProject_id(Integer.parseInt(String.valueOf(obj.get("project_id"))));
                               jobVO.setManager(wbsManagerId);
                               jobVO.setWeek(1);
                               jobVO.setPrivacy_state(111);
                               jobVO.setName(String.valueOf(obj.get("name")));
                               jobVO.setReport(String.valueOf(obj.get("report")));
                              
                               jobVOInsertList.add(jobVO);
                           }
                        }
                     }
                  }
               } 
               //2.2  만약 JOB에 할당된 담당자가 없다면 전부 INSERT 대상
               else {
                  for(int k=0; k<wbsManagerIdarr.length; k++) {
                     String wbsManagerId = wbsManagerIdarr[k];
                     
                     JobVO jobVO = new JobVO();
                    jobVO.setWbs_id(Integer.parseInt(String.valueOf(obj.get("id"))));
                    jobVO.setReal_start_date(String.valueOf(obj.get("start_date")));
                    jobVO.setReal_end_date(String.valueOf(obj.get("end_date")));
                    jobVO.setProject_id(Integer.parseInt(String.valueOf(obj.get("project_id"))));
                    jobVO.setManager(wbsManagerId);
                    jobVO.setWeek(1);
                    LOGGER.info("==============================================");
                    LOGGER.info("projectService selectByProjectId : " + projectService.selectByProjectId(Integer.parseInt(String.valueOf(obj.get("project_id")))).getState()); 
                    //jobVO.setPrivacy_state(projectService.selectByProjectId(Integer.parseInt(String.valueOf(obj.get("project_id")))).getState());
                    jobVO.setPrivacy_state(111);          
                    jobVO.setName(String.valueOf(obj.get("name")));
                    jobVO.setReport(String.valueOf(obj.get("report")));
                   
                    jobVOInsertList.add(jobVO);
                  }
               }
               
               for(int k=0; k<jobVOList.size(); k++) {
                  Map map = jobVOList.get(k);
                  for(int o=0; o<wbsManagerIdarr.length; o++) {
                     String wbsManagerId = wbsManagerIdarr[o];
                     //JOB 담당자와 WBS 시트 담당자가 같다 = UPDATE 대상이다(이미 작업한 내용으로 패스)
                     if(wbsManagerId.equals(String.valueOf(map.get("manager")))) {
                        break;
                     } else {
                        //JOB 담당자와 WBS 시트 담당자가 같지않고, WBS 시트 담당자를 모두 순회했다 = 삭제된 담당자이므로 DELETE 대상이다
                        if(o == wbsManagerIdarr.length-1) {
                           JobVO jobVO = new JobVO();
                           jobVO.setId(Integer.parseInt(String.valueOf(map.get("id"))));
                           jobVO.setWbs_id(Integer.parseInt(String.valueOf(obj.get("id"))));
                           jobVO.setManager(String.valueOf(map.get("manager")));
                           
                           LOGGER.info("삭제될 WBS_ID : " + obj.get("id"));
                            
                           jobVODeleteList.add(jobVO);
                        }
                     }
                  }
               }
            }
            LOGGER.info("최종 WBS 업데이트 리스트에 담기는 WBS VO : " + wbsVO);
            wbsVOUpdateList.add(wbsVO);
         } 
         //WBS 시트의 상태값이 I라면 WBS 자체는 INSERT, JOB은 담당자가 있다면 INSERT 없다면 수행X
         else if(((String) obj.get("status")).equals("I")) {
            String [] wbsManagerIdarr;
            
            if(!String.valueOf(obj.get("manager_id")).equals("")) {
               wbsManagerIdarr = String.valueOf(obj.get("manager_id")).split(",");
            } else {
               wbsManagerIdarr = null;
            }
            
            WbsVO wbsVO = new WbsVO();
            
            if(!String.valueOf(obj.get("parent")).equals("Y")) {
               if(wbsManagerIdarr == null || wbsManagerIdarr.length ==1) {
                    wbsVO.setTotal_date(totalDate);
                    wbsVO.setTotal_real_progress(Float.parseFloat(String.valueOf(obj.get("total_real_progress"))));
                 } else {
                    wbsVO.setTotal_date(totalDate*wbsManagerIdarr.length);
                 }
                 wbsVO.setTotal_one_md(totalDate);
            }else {
               wbsVO.setTotal_date(Float.parseFloat(String.valueOf(obj.get("total_date"))));
                wbsVO.setTotal_one_md(Float.parseFloat(String.valueOf(obj.get("total_one_md"))));
                wbsVO.setTotal_real_progress(Float.parseFloat(String.valueOf(obj.get("total_real_progress"))));
            }
            
            wbsVO.setTotal_real_progress(Float.parseFloat(String.valueOf(obj.get("total_real_progress"))));
            wbsVO.setRow_index(Integer.parseInt(String.valueOf(obj.get("row_index"))));
            wbsVO.setDeep(Integer.parseInt(String.valueOf(obj.get("treelevel"))));
            wbsVO.setName(String.valueOf(obj.get("name")));
            wbsVO.setOrder_id(String.valueOf(obj.get("order_id")));
            wbsVO.setProject_id(Integer.parseInt(String.valueOf(obj.get("project_id"))));
            wbsVO.setReport(String.valueOf(obj.get("report")));
            wbsVO.setStart_date(String.valueOf(obj.get("start_date")));
            wbsVO.setEnd_date(String.valueOf(obj.get("end_date")));
            
            wbsVOInsertList.add(wbsVO);
            
            if (wbsVOInsertList.size() > 0) {
                 result = wbsService.insertWbsList(wbsVOInsertList);
                 if (result == 0) {
                    return "/sheetsave/sheetSaveFailed";
                 }
                 result = wbsService.selectWbsLastId();
                 LOGGER.info("get Last Insert WBS ID : " + result);
                 LOGGER.info("ㅡㅡㅡㅡㅡㅡㅡㅡWBS Insert Completedㅡㅡㅡㅡㅡㅡㅡㅡ");
                 wbsVOInsertList.removeAll(wbsVOInsertList);
              }
            
           //1. WBS 시트에서 '담당자' 칸을 빈칸으로 넘겼다면
            if(wbsManagerIdarr == null ) {
               continue;
            } 
            //2. WBS 시트에서 담당자를 지정했다면 그 수만큼 JOB에 INSERT
            else {
               for(int k=0; k<wbsManagerIdarr.length; k++) {
                  String wbsManagerId = wbsManagerIdarr[k];
                  
                  JobVO jobVO = new JobVO();
                jobVO.setWbs_id(result);
                //jobVO.setStart_date(String.valueOf(obj.get("start_date")));
                //jobVO.setEnd_date(String.valueOf(obj.get("end_date")));
                jobVO.setReal_start_date(String.valueOf(obj.get("start_date")));
                jobVO.setReal_end_date(String.valueOf(obj.get("end_date")));
                jobVO.setProject_id(Integer.parseInt(String.valueOf(obj.get("project_id"))));
                jobVO.setManager(wbsManagerId);
                jobVO.setWeek(1);
                LOGGER.info("==============================================");
                LOGGER.info("projectService selectByProjectId : " + projectService.selectByProjectId(Integer.parseInt(String.valueOf(obj.get("project_id")))).getState()); 
                //jobVO.setPrivacy_state(projectService.selectByProjectId(Integer.parseInt(String.valueOf(obj.get("project_id")))).getState());
                jobVO.setPrivacy_state(111);
                jobVO.setName(String.valueOf(obj.get("name")));
                jobVO.setReport(String.valueOf(obj.get("report")));
                
                jobVOInsertList.add(jobVO);
               }
            }
         } 
         //WBS 시트의 상태값이 D라면 WBS와 JOB 모두 DELETE 대상
         else if(((String) obj.get("status")).equals("D")) {
            int wbs_id = Integer.parseInt(String.valueOf(obj.get("id")));
            WbsVO wbsVO = new WbsVO();
            wbsVO.setId(wbs_id);

            wbsVODeleteList.add(wbsVO);

            jobVOList = wbsService.selectJobByWbsId(wbs_id);
            if(jobVOList.size() != 0) {
               for(Map map : jobVOList) {
                  JobVO jobVO = new JobVO();
                  
                  jobVO.setId(Integer.parseInt(String.valueOf(map.get("id"))));
                    jobVO.setWbs_id(Integer.parseInt(String.valueOf(map.get("wbs_id"))));
                    jobVO.setManager(String.valueOf(map.get("manager")));
                    
                    jobVODeleteList.add(jobVO);

                  }
               }
         }
      }
      LOGGER.info("===========WBS===========");
      LOGGER.info("Insert WBS VO List : " + wbsVOInsertList);
      LOGGER.info("Update WBS VO List : " + wbsVOUpdateList);
      LOGGER.info("Delete WBS VO List : " + wbsVODeleteList);
     
      LOGGER.info("===========JOB===========");
      LOGGER.info("Insert JOB VO List : " + jobVOInsertList);
      LOGGER.info("Update JOB VO List : " + jobVOUpdateList);
      LOGGER.info("Delete JOB VO List : " + jobVODeleteList);
      
      LOGGER.info("=========================");
      
       if (wbsVOUpdateList.size() > 0) {
          result = wbsService.updateWbsList(wbsVOUpdateList);
          if (result == 0) {
             return "/sheetsave/sheetSaveFailed";
          }
          LOGGER.info("ㅡㅡㅡㅡㅡㅡㅡㅡWBS Update Completedㅡㅡㅡㅡㅡㅡㅡㅡ");
       }
       
       if (jobVOInsertList.size() > 0) {
           result = wbsService.insertJobList(jobVOInsertList);
           if (result == 0) {
              return "/sheetsave/sheetSaveFailed";
           }
           LOGGER.info("ㅡㅡㅡㅡㅡㅡㅡㅡJOB Insert Completedㅡㅡㅡㅡㅡㅡㅡㅡ");
        }
       
       if (jobVOUpdateList.size() > 0) {
           result = wbsService.updateJobList(jobVOUpdateList);
           if (result == 0) {
              return "/sheetsave/sheetSaveFailed";
           }
           LOGGER.info("ㅡㅡㅡㅡㅡㅡㅡㅡJOB Update Completedㅡㅡㅡㅡㅡㅡㅡㅡ");
        }
      
      if (jobVODeleteList.size() > 0) {
         result = wbsService.deleteJobList(jobVODeleteList);
         if (result == 0) {
            return "/sheetsave/sheetSaveFailed";
         }
         LOGGER.info("ㅡㅡㅡㅡㅡㅡㅡㅡJOB Delete Completedㅡㅡㅡㅡㅡㅡㅡㅡ");
      }
      
      if (wbsVODeleteList.size() > 0) {
          result = wbsService.deleteWbsList(wbsVODeleteList);
          if (result == 0) {
             return "/sheetsave/sheetSaveFailed";
          }
          LOGGER.info("ㅡㅡㅡㅡㅡㅡㅡㅡWBS Delete Completedㅡㅡㅡㅡㅡㅡㅡㅡ");
       }
       
      return "/sheetsave/sheetSaveSuccess";
   }
   
   @RequestMapping(value = "/sheet/project", method = RequestMethod.POST)
   @ResponseBody
   public ProjectDTO project(Model model, HttpServletRequest request, String project_title,String team, Principal loginUser){
	//   System.out.println("projectListAll-------------------------------------");
	   String userid=loginUser.getName();
       if(userid==null){
          userid="";
       }
	    
		ProjectDTO project = new ProjectDTO();
		//db에서 데이터 조회(VO의 리스트)
		List<ProjectVO> projectList = projectService.allProject(team, project_title);
		LOGGER.info("projectListAll-- : " + projectService.allProject(team, project_title));
		LOGGER.info("team-- :" + team);
		LOGGER.info("title-- :" + project_title);
		//db에서 가져온 데이터를 data 필드에 넣어줌
		project.setData(projectList);
		//System.out.println("project : " +project);
		return project;
   }
   
   
   	//프로젝트 프로젝트 탭을 클릭했을 때 동작한다
      @RequestMapping(value = "/project", method = RequestMethod.GET)
      public void project(HttpServletRequest request, Principal loginUser,Model model, CommonVO vo) throws Exception {
    	  
    	  List<CommonVO> commonVOList = userService.selectCommon(vo);
  		  model.addAttribute("common", commonVOList);
      }
      
	   //ajax로 project ID 넘기기
	   @RequestMapping(value="/sendProjectId", method=RequestMethod.POST)
	   @ResponseBody
	   public int sendProjectId(int projectId){      
	      this.projectId = projectId;
	      return projectId;
	   }
	   //ajax로 project ID 받기
	   @RequestMapping(value="/getProjectId", method=RequestMethod.POST)
	   @ResponseBody
	   public int getProjectId(){      
	      return projectId;
	   }
}