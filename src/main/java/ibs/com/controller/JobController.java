package ibs.com.controller;

import java.awt.PageAttributes.MediaType;
import java.security.Principal; 
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringEscapeUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ibs.com.domain.CriteriaVO;
import ibs.com.domain.JobVO;
import ibs.com.service.JobService;
import ibs.com.service.UserService;

/**
 * @FileName : JobController.java
 * @Date : 2021. 8. 24. 
 * @작성자 : 윤주영
 * @설명 : 내작업 컨트롤러
 */

@Controller("JobController")
@RequestMapping("job")
public class JobController {
   
   private static final Logger LOGGER = LoggerFactory.getLogger(JobController.class);
   
   @Resource(name="jobService")
   private JobService jobService; 
   @Resource(name="userService")
   private UserService userService;
   
    
   @RequestMapping(value="subregister")
      public void subregister(Principal loginUser,Model model,String title, CriteriaVO cri) {
	   String User=loginUser.getName();
       if(User==null){
           User="";
       }
       cri.setUserid(User);
       cri.setProject_title(title);
		
		model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
      }
   
   @RequestMapping(value="sregister")
      public void sregister() {
      }
   
   @RequestMapping(value="modify2")
      public void modify2() {
      }
   
   //제일 작은 날짜
   public static String minDay(List<String>minday) throws ParseException{
      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
      Date day1 = null;
      Date day2 = null;
      
      Date minTest = format.parse(minday.get(0).toString());
         
         for(int i=0; i<minday.size(); i++){
            day1=format.parse(minday.get(i).toString());
            if(minTest.compareTo(day1)>0){
               minTest = day1;
               
            }
         }
         String test = format.format(minTest);
      return test;
   }
   
   //제일 큰 날짜
   public static String maxDay(List<String>maxday) throws ParseException{
      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
      Date day1 = null;
      Date day2 = null;
      
      Date maxTest = format.parse(maxday.get(0).toString());
         
         for(int i=0; i<maxday.size(); i++){
            day1=format.parse(maxday.get(i).toString());
            if(maxTest.compareTo(day1)<0){
               maxTest = day1;
               
            }
         }
         String test = format.format(maxTest);
      return test;
   }
   
   
	  //String 형태의 2021-10-11 을 날짜형태로 변환하는 함수
   public static LocalDate Changed(String date){
      SimpleDateFormat weekSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
      LocalDate test = null; 
    		  	test = LocalDate.parse(date,DateTimeFormatter.ISO_DATE);         
      return test;
   }
   
   
   //평일 계산
   public static int createWeekDay(String start, String end) throws ParseException{
      
      Calendar startDate = Calendar.getInstance(); // 작업 시작일 (START_DATE)
      Calendar endDate = Calendar.getInstance(); // 작업 종료일 (END_DATE)
      Calendar addDate = Calendar.getInstance(); // 시작일~종료일 사이의 주말을 제외하기 위한 계산용 날짜
      int workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)
      
      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
      
      Date start_Date = format.parse(start); 
      Date end_Date = format.parse(end);
      
      startDate.setTime(start_Date);
      addDate.setTime(start_Date);
      endDate.setTime(end_Date);
      
      while(!addDate.after(endDate)){
         int day = addDate.get(Calendar.DAY_OF_WEEK);
         if((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)){
            workingDays++;
         }
         addDate.add(Calendar.DATE, 1);
      }
      
      return workingDays;
   }
   
   public static int sumWeekDay(List<Integer>day){
      
      int sum = 0;
      for (int i = 0; i < day.size(); i++) {
         sum+=day.get(i);
      }
      
      return sum;
   }
   
   //전주 토요일, 금주 월요일, 금주 차주 토요일 뽑아오는 함수
   public static Map<String,Object> createWhatsDay(){
	   Map<String,Object> day = new HashMap<>();
	   int nowDay = 0;
	   nowDay = LocalDate.now().getDayOfWeek().getValue();
         LocalDate today_date = LocalDate.now();
         LocalDate last_week_saturday = null; //저번주 토요일
         LocalDate this_week_monday = null; //이번주 월요일 
         LocalDate this_week_saturday = null; //이번주 토요일
         LocalDate next_week_monday = null; // 다움주 월요일
         LocalDate next_week_friday = null; // 다움주 금요일
         LocalDate next_week_saturday = null; // 다움주 토요일
         
         
         switch (nowDay) {
         case 1: //찍힌 날짜가 월요일 이라면
        	 	last_week_saturday = LocalDate.now().minusDays(2);
	        	 this_week_monday = LocalDate.now(); 
	        	 this_week_saturday = LocalDate.now().plusDays(5);
	        	 next_week_monday = LocalDate.now().plusDays(7);
	        	 next_week_friday = LocalDate.now().plusDays(11);
				next_week_saturday = LocalDate.now().plusDays(12);	
				break;
			case 2: //찍힌 날짜가 화요일 이라면
				last_week_saturday = LocalDate.now().minusDays(3);
				this_week_monday = LocalDate.now().minusDays(1);
				this_week_saturday = LocalDate.now().plusDays(4);
				next_week_monday = LocalDate.now().plusDays(6);
				next_week_friday = LocalDate.now().plusDays(10);
				next_week_saturday = LocalDate.now().plusDays(11);	
				break;
			case 3: //찍힌 날짜가 수요일 이라면
				last_week_saturday = LocalDate.now().minusDays(4);
				this_week_monday = LocalDate.now().minusDays(2);
				this_week_saturday = LocalDate.now().plusDays(3);
				next_week_monday = LocalDate.now().plusDays(5);
				next_week_friday = LocalDate.now().plusDays(9);		
				next_week_saturday = LocalDate.now().plusDays(10);		
				break;
			case 4: //찍힌 날짜가 목요일 이라면
				last_week_saturday = LocalDate.now().minusDays(5);
				this_week_monday = LocalDate.now().minusDays(3);
				this_week_saturday = LocalDate.now().plusDays(2);
				next_week_monday = LocalDate.now().plusDays(4);
				next_week_friday = LocalDate.now().plusDays(8);
				next_week_saturday = LocalDate.now().plusDays(9);
				break;
			case 5: //찍힌 날짜가 굼요일 이라면
				last_week_saturday = LocalDate.now().minusDays(6);
				this_week_monday = LocalDate.now().minusDays(4);
				this_week_saturday = LocalDate.now().plusDays(1);
				next_week_monday = LocalDate.now().plusDays(3);
				next_week_friday = LocalDate.now().plusDays(7);
				next_week_saturday = LocalDate.now().plusDays(8);
				break;
			case 6: //찍힌 날짜가 토요일 이라면
				last_week_saturday = LocalDate.now().minusDays(7);
				this_week_monday = LocalDate.now().minusDays(5);
				this_week_saturday = LocalDate.now();
				next_week_monday = LocalDate.now().plusDays(2);
				next_week_friday = LocalDate.now().plusDays(6);
				next_week_saturday = LocalDate.now().plusDays(7);
				break;
			case 7: //찍힌 날짜가 일요일 이라면
				last_week_saturday = LocalDate.now().minusDays(8);
				this_week_monday = LocalDate.now().minusDays(6);
				this_week_saturday = LocalDate.now().minusDays(1);
				next_week_monday = LocalDate.now().plusDays(1);
				next_week_friday = LocalDate.now().plusDays(5);
				next_week_saturday = LocalDate.now().plusDays(6);
				break;
			default:
				break;
         }
         day.put("this_week_monday", this_week_monday);
         day.put("this_week_saturday", this_week_saturday);
         day.put("next_week_friday", next_week_friday);
         day.put("next_week_monday", next_week_monday);
         day.put("next_week_saturday", next_week_saturday);
         day.put("last_week_saturday", last_week_saturday);
       
		return day;
   }
   

   
   //주어진 기간의 총 평일수를 구하는 함수
   public static Long calculateWeekDays(Date StartDate, Date EndDate){
       Calendar startDate = Calendar.getInstance(); // 작업 시작일 (START_DATE)
       Calendar endDate = Calendar.getInstance(); // 작업 종료일 (END_DATE)
       Calendar addDate = Calendar.getInstance(); // 시작일~종료일 사이의 주말을 제외하기 위한 계산용 날짜
	   
       long workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)

      startDate.setTime(StartDate);
      addDate.setTime(StartDate);
      endDate.setTime(EndDate);
      
      // 주말을 제외한 총 기간 구하기
      while (!addDate.after(endDate)) {
      int day = addDate.get(Calendar.DAY_OF_WEEK);
      if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)) {
      workingDays++; // 평일 수
      }
      addDate.add(Calendar.DATE, 1);
      }
	   
      return workingDays;
   }
   
   //String 형태의 2021-10-11 을 날짜형태로 변환하는 함수
   public static LocalDate changed(String date){
      SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd"); 
      LocalDate test = LocalDate.parse(date,DateTimeFormatter.ISO_DATE);         
      return test;
   }
   
   public static Date stringToDate(String target) throws ParseException{

	   SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

	   Date to = new Date();
			to = transFormat.parse(target);

	   return to;

   }
   
   public static Map<String,Float> thisWeekPlan_NextWeekPlan(String start, String end) throws ParseException{
	// 금주 계획, 차주 계획, 주말제외한 평일수 
	int thisWeekPlan = 0;
	int nextWeekPlan = 0;
	int weekDays=0;
    long byThisWeekSatudayWeekDays = 0; //시작일~ 금주까지의 평일수
    long byNextWeekSatudayWeekDays = 0; //시작일~ 다음주까지의 평일수
    Date start_date_forWeekDays = new Date();
    Date end_date_forWeekDays =new Date();
    
	start_date_forWeekDays = stringToDate(start);
	end_date_forWeekDays = stringToDate(end);
	
	LocalDate real_Start_Date = null;
	real_Start_Date = changed(start);
	LocalDate real_End_Date = null;
	real_End_Date =	changed(end);
	//System.out.println("LocalDate 타입의 시작일: "+real_Start_Date+"\n LocalDate 타입의 종료일: "+real_End_Date);
	
	weekDays = calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
	//System.out.println("주말 제외한 평일의 수는?: "+weekDays);
	Map<String,Object> createThisMon_NextSat=new HashMap<String,Object>();
	createThisMon_NextSat= createWhatsDay();
	byNextWeekSatudayWeekDays = calculateWeekDays(start_date_forWeekDays,  stringToDate(createThisMon_NextSat.get("next_week_saturday").toString()));
   
	// 금주 계획 계산
   // 1. 종료일이 금주 금요일보다 클때 ex) 종료일:10-28 , 금주 금요일:10-28=========================================================================
   if(real_End_Date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
 	  //System.out.println("[금주계산] 종료일이 금주 금요일보다 크다");
 	  thisWeekPlan = (int) byThisWeekSatudayWeekDays;
 	
 	  //1.2 시작일이 금주 월요일보다 작을때 ex) 시작일:10-24 , 금주 월요일:10-25
 	   if(real_Start_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_monday"))){
 		  thisWeekPlan = calculateWeekDays(start_date_forWeekDays, stringToDate(createThisMon_NextSat.get("this_week_saturday").toString() ) ).intValue();
 		  if(real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_monday"))){
			  thisWeekPlan = (int)calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
		  }
 	  }
 	  //1.3 시작일이 금주 토요일보다 느릴때 ex) 시작일:10-26 , 금주 월요일:10-25
 	  else if(real_Start_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
 		  //System.out.println("[금주계산] 시작일이 금주 토요일보다 작다");
 		  thisWeekPlan = calculateWeekDays(start_date_forWeekDays, stringToDate(createThisMon_NextSat.get("this_week_saturday").toString() )).intValue();
 		  //System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
 	  }
   } // End 1. 종료일이 금주 금요일보다 늦다 
   
   // 2.종료일이 금주 금요일보다 빠르다.  ex) 종료일:10-26 , 금주 금요일:10-28
   else if(real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
 	  //System.out.print("[금주계산] 종료일이 금주 토요일보다 작을때.");
 	  thisWeekPlan = calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
 	  //2.1 before는 시간단위가지 계산하기 때문에 같은 날짜라도 다르게 나오는 예외케이스가 존재하기 때문에 혹시나 같은 일 일 경우는 시간단위로는 계산안한다.(종료일이 금주 금요일이면)
 	  //2.2 시작일이 금주 월요일보다 작을때ex) 시작일:10-24 , 금주 월요일:10-25
 	   if(real_Start_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_monday"))){
 		   //System.out.println(" 시작일이 금주 월요일보다 작을면.");
 		  thisWeekPlan = calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
 		
 	  }
 	  //2.3 시작일이 금주 월요일보다 클때 ex) 시작일:10-26 , 금주 월요일:10-25
 	  else if(real_Start_Date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_monday"))){
 		 // System.out.println("시작일이 금주 월요일보다 크면.");
 		  thisWeekPlan = calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
 	  }
 	   
   }
   
   //차주 계획 계산
   //1. 종료일이 금주 토요일보다 크면
   if(real_End_Date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
 	 // System.out.println("[차주계산] 종료일이 금주 금요일보다 클때");
 	  nextWeekPlan = (int) byNextWeekSatudayWeekDays;
 	  //System.out.println(nextWeekPlan);
 	 //1.1 종료일이 차주 월요일보다 클때
 	  if(real_End_Date.isAfter((LocalDate) createThisMon_NextSat.get("next_week_monday"))){
 		  nextWeekPlan =(int)  byNextWeekSatudayWeekDays;
 		//1.1.1 종료일이 차주 토요일보다 작을때
 		  if(real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_saturday"))){
 			nextWeekPlan = (int)calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
 		  }
 		  //1.1.2 종료일이 차주 토요일을 넘을때
 		  else if(real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_monday"))){
 		  nextWeekPlan =0;
 	  }
 	  
 	  }
	  //1.2 종료일이 차주 월요일과 같을때
  	  else if(real_End_Date.isEqual((LocalDate) createThisMon_NextSat.get("next_week_monday"))){
  		  nextWeekPlan =(int) calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
  	  }
 	  
   }
   //2. 종료일이 금주 토요일보다 작으면
   else if(real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
 	 // System.out.println("[차주계산] 종료일이 금주 금요일보다 작을때");
 	
 		  nextWeekPlan =0;
 	  
   }
   
	float thisWeekPlanProgress = (float) thisWeekPlan / (float) weekDays;
	float nextWeekPlanProgress = (float) nextWeekPlan / (float) weekDays;
	
	if (nextWeekPlanProgress <= 0) {
		nextWeekPlanProgress = 0.0f;
	}
	if(thisWeekPlanProgress<=0){
		thisWeekPlanProgress = 0.0f;
	}
	
	   Map<String,Float> map = new HashMap<String, Float>();
	   map.put("thisWeekPlanProgress", thisWeekPlanProgress);
	   map.put("nextWeekPlanProgress", nextWeekPlanProgress);
   
	   return map;
   
   }
   
   
   
   /*전체작업목록*/
   @PreAuthorize("isAuthenticated()")
   @RequestMapping(value="/list") 
   public String list(Principal loginUser,String title,CriteriaVO cri, Model model){
      //System.out.println("내작업 리스트로 이동");
   
      //System.out.println("검색 조건: "+title);
      if(title==null || title==""){
         title="0";
      }else if(title.equals("전체")){
         title="2";
      }
      
      
      //System.out.println("받아온 타이틀 테스트 변경후 : "+title);
      String User=loginUser.getName();
      if(User==null){
         User="";
      }
      cri.setUserid(User);
      cri.setProject_title(title);
      
      //내가 속한 프로젝트 이름,별칭 값을 가져온다.
      List<HashMap<String,Object>> vo=jobService.getMyJobById(User);
      //System.out.println(vo);
      HashMap<String,Object> test= new HashMap();
      
      List<String>project_title=new ArrayList();
      List<String>project_nickname=new ArrayList();
      
      for(int i = 0; i<vo.size(); i++){
         test=vo.get(i);
         Set<String> keys = test.keySet();
         for(String key : keys){
            if(key.contains("PROJECT_NICKNAME")){
            //프로젝트 별칭 배열 생성   
            project_nickname.add(test.get(key).toString());
            }else if(key.contains("PROJECT_TITLE")){
            //프로젝트 이름 배열 생성   
               project_title.add(test.get(key).toString());
            }
         }
      }
      
      
      model.addAttribute("selectedTitle",title);
      //System.out.println("모델에 들어가는 제목: "+title);
      //뷰에서의 셀렉트박스 값에 넣어지는 부분===================================
      model.addAttribute("project_title",project_title);
      model.addAttribute("project_nickname",project_nickname);
      //=======================================================
      
      HashMap<String, Object> map = new HashMap<>();
      String userNameById=userService.selectUserName(User).getName(); // 로그인된 사용자의 이름을 출력
      model.addAttribute("userid",User);
      model.addAttribute("list",jobService.getAllMyJob(User)); //모든 일
      model.addAttribute("name",userNameById); //유저이름
      
      model.addAttribute("beforelist",jobService.getBeforeMyJobById(cri)); //진행전
      model.addAttribute("beforeCnt",jobService.beforeMyJobCntById(cri));
      
      model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
      model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
      //System.out.println("진행전인 내작업 출력: "+jobService.getBeforeMyJobById(cri));
      
      model.addAttribute("inglist",jobService.getIngMyJobById(cri)); //진행중
      model.addAttribute("ingCnt",jobService.ingMyJobCntById(cri));
      //System.out.println("진행중인 내작업 출력: "+jobService.getIngMyJobById(cri));
      
       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
       Calendar c1 = Calendar.getInstance();
       cri.setTodayYearMonthDays(sdf.format(c1.getTime()));
       c1.add(Calendar.MONTH, -2);
       cri.setTwoMonthsAgo(sdf.format(c1.getTime()));
      model.addAttribute("endlist",jobService.getEndMyJobById(cri)); //완료
      model.addAttribute("endlistBefore2Months",jobService.getEndMyJobByIdBefore2Months(cri)); //완료된 작업 최대 2개월전까지의 작업들만 가져온다.
      model.addAttribute("endCnt",jobService.endMyJobCntById(cri));
      
      return "job/list";
      
   }
   @RequestMapping(value="/list", method=RequestMethod.POST)
   public String postlist(Principal loginUser,CriteriaVO cri, Model model) {
      //System.out.println("post list로 왔어");
      model.addAttribute("beforelist",jobService.getBeforeMyJobById(cri)); //진행전 
      return "redirect:/list";
      
   }
    
   //ajax의 select 박스로 안의 option값 넘기는 조건
   @RequestMapping(value="/myjob2", method=RequestMethod.POST)
   @ResponseBody
   public List<HashMap<String,Object>> myjob(@RequestParam("user")String userid, @RequestParam("state")Integer state){
      //System.out.println("============job/myjob post 방식==============");
	   System.out.println("단계 : " + state);
	   LOGGER.info(userid);
      JSONArray jsonArr= new JSONArray();
   
      List<HashMap<String,Object>> vo=jobService.getMyJobByState(userid, state);
      System.out.println("이름 : " + userid);
      
	   LOGGER.info(vo.toString());
      //Map to JSON 변환 함수 사용
      for(HashMap<String,Object>map: vo){
         jsonArr.add(convertMapToJson(map));
      }
      return jsonArr;
   }
   
   //ajax의 select 박스로 안의 option값 넘기는 조건
   @RequestMapping(value="/myjob", method=RequestMethod.POST)
   @ResponseBody
   public List<HashMap<String,Object>> myjob(String userid){
      //System.out.println("============job/myjob post 방식==============");
	   
      JSONArray jsonArr= new JSONArray();
   
      List<HashMap<String,Object>> vo=jobService.getMyJobById(userid);
      
	   LOGGER.info(vo.toString());
      //Map to JSON 변환 함수 사용
      for(HashMap<String,Object>map: vo){
         jsonArr.add(convertMapToJson(map));
      }
      return jsonArr;
   }
   
   //Map to JSON 변환 함수
   public static JSONObject convertMapToJson(HashMap<String,Object> map){
      
      JSONObject json = new JSONObject();
      for(Map.Entry<String, Object>entry:map.entrySet()){
         String key = entry.getKey();
         Object value = entry.getValue();
         json.put(key, value);
      }
      return json;
   }

   /*작업 등록*/
   @PreAuthorize("isAuthenticated()")
    @ResponseBody
   @RequestMapping(value="/register", method=RequestMethod.POST)
   public String projectRegisterByMySelf1(Principal loginUser, JobVO vo,Model model,String title, CriteriaVO cri){
     // System.out.println("내작업 등록 시작[job/register]===================================================");
	   String User=loginUser.getName();
       if(User==null){
           User="";
       }
       cri.setUserid(User);
       cri.setProject_title(title);
		
		model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
       //1. 내작업 등록 시작
       int result=jobService.registerMyJobByMySelf(vo);
      //작업이 등록되었으면 success, 아니면 false
      if(result>0){
         //System.out.println("내작업 등록 성공@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
         return "success";
      }else{
         //System.out.println("내작업 등록 실패@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
         return "false";
      }
   }
    
    
    
   @RequestMapping(value="/search", method=RequestMethod.POST)
   public void searchMyJobList(Principal userid){
      
   }
   
   @PreAuthorize("isAuthenticated()")
   @RequestMapping(value="/stop")
      public void stop(Principal loginUser,Model model,CriteriaVO cri,String title) {
      
      if(title==null || title==""){
         title="0";
      }else if(title.equals("전체")){
         title="2";
      }
      String User=loginUser.getName();
      if(User==null){
         User="";
      }
      cri.setUserid(User);
      cri.setProject_title(title);

      model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	  model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
      model.addAttribute("selectedTitle",title);
      model.addAttribute("stoplist",jobService.getStopMyJobById(cri)); //진행전 
      
      
      }
   
   @PreAuthorize("isAuthenticated()")
   @RequestMapping(value="/before")
   public void before(Principal loginUser,Model model,CriteriaVO cri,String title) {
     // System.out.println("내작업 진행전 리스트로 이동");
   
      if(title==null || title==""){
         title="0";
      }else if(title.equals("전체")){
         title="2";
      }
     // System.out.println("받아온 타이틀 테스트 변경후 : "+title);
     String User=loginUser.getName();
      if(User==null){
         User="";
      }
      cri.setUserid(User);
      cri.setProject_title(title);
      
      model.addAttribute("beforeCnt",jobService.beforeMyJobCntById(cri));
      model.addAttribute("ingCnt",jobService.ingMyJobCntById(cri));;
      
      model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
      model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
      model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
      model.addAttribute("selectedTitle",title);
      model.addAttribute("beforelist",jobService.getBeforeMyJobById(cri)); //진행전 

   }
    
   
   //삭제
   @PreAuthorize("isAuthenticated()")
      @RequestMapping(value="/delete", method=RequestMethod.POST)
      @ResponseBody
       public String removeMyJobByJobId(int id){
           
           jobService.removeMyJobByJobId(id);
           //하위작업들도 삭제 진행
           jobService.removeSubInfoByParentId(id);
           return "success";
           
       }
    
    @PreAuthorize("isAuthenticated()")
   @RequestMapping(value="/ing")
   public void ing(Principal loginUser,Model model,CriteriaVO cri,String title) {
     // System.out.println("내작업 진행중 리스트로 이동");
      
      if(title==null || title==""){
         title="0";
      }else if(title.equals("전체")){
         title="2";
      }
      String User=loginUser.getName();
      if(User==null){
         User="";
      }
      cri.setUserid(User);
      cri.setProject_title(title);
      
      model.addAttribute("beforeCnt",jobService.beforeMyJobCntById(cri));
      model.addAttribute("ingCnt",jobService.ingMyJobCntById(cri));
      
      model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
      model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
      model.addAttribute("selectedTitle",title);
      model.addAttribute("inglist",jobService.getIngMyJobById(cri)); //진행중
   }
   
    @PreAuthorize("isAuthenticated()")
   @RequestMapping(value="/end")
   public void end(Principal loginUser,Model model,CriteriaVO cri,String title) {
      //System.out.println("내작업 완료 리스트로 이동");
      
      if(title==null || title==""){
         title="0";
      }else if(title.equals("전체")){
         title="2";
      }
     // System.out.println("받아온 타이틀 테스트 변경후 : "+title);
      String User=loginUser.getName();
      if(User==null){
         User="";
      }
      cri.setUserid(User);
      cri.setProject_title(title);
      
      model.addAttribute("beforeCnt",jobService.beforeMyJobCntById(cri));
      model.addAttribute("ingCnt",jobService.ingMyJobCntById(cri));
      
      
      model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
      model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
      model.addAttribute("selectedTitle",title);
      model.addAttribute("endlist",jobService.getEndMyJobById(cri)); //진행전 
   }
   

    @PreAuthorize("isAuthenticated()")
   /*작업 상세 및 수정*/
   @RequestMapping(value={"/get","/modify","/submodify"})
   public void get(Principal loginUser,int id,Model model,String title, CriteriaVO cri) {
     // System.out.println("내작업 상세페이지로 이동");
      String User=loginUser.getName();
      if(User==null){
         User="";
      }

      cri.setUserid(User);
      cri.setProject_title(title);
		
		model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
      //상위 작업값을 가져온다.
      JobVO vo=jobService.selectOneMyJobById(id);
      //System.out.println(vo);
      String parent=String.valueOf(vo.getId());
      
      
      
      //상위 값에 대해 자식밧이 존재한다면 자식값 또한 가져온다.
      if(jobService.selectSubJobInfoByParentId(vo.getId())!=null){
         List<JobVO> subVo=jobService.selectSubJobInfoByParentId(vo.getId());
         //System.out.println("하위작업 리스트: "+subVo);
         model.addAttribute("sub",subVo);
      }

      model.addAttribute("job",vo);
      model.addAttribute("User",User);
      
   }
   
    
   /*작업 수정*/
    @PreAuthorize("isAuthenticated()")
   @RequestMapping(value="/modify", method=RequestMethod.POST)
   @ResponseBody
   public String modify(Principal loginUser,Model model,JobVO vo,@RequestParam("sub_name[]")String[] name,
         @RequestParam("sub_start_date[]")String[] start_date,@RequestParam("sub_end_date[]")String[] end_date,
         @RequestParam("sub_week[]")int[] week,@RequestParam("sub_contents[]")String[] contents
         ,@RequestParam("sub_progress[]")float[] progress) throws ParseException {
      
         //하위작업의 새로운 등록인지 수정인지 구분하기위해서 기존의 등록된 하위작업들을 모두 삭제한뒤 진행한다.
           jobService.removeSubInfoByParentId(vo.getId());
            
            List<String>sub_name=new ArrayList<>();
            List<String>sub_start_date=new ArrayList<>();
            List<String>sub_end_date=new ArrayList<>();
            List<Integer>sub_week=new ArrayList<>();
            List<Float>sub_progress=new ArrayList<>();
            List<String>sub_content=new ArrayList<>();
            List<Integer>sub_monday=new ArrayList<>();
            
            List<String>mindayArr = new ArrayList<>();
            List<String>maxdayArr = new ArrayList<>();
            
            List<Float>this_week_plan = new ArrayList<>();
            List<Float>next_week_plan = new ArrayList<>();
            float this_week_plan_Sum = 0;
            float next_week_plan_Sum = 0;
            float this_week_plan_Avg = 0;
            float next_week_plan_Avg = 0;
            
            for(String real_name : name){
               if(real_name!=null && real_name!=""){
               sub_name.add(real_name);
               }
            }
            for(String real_start_date : start_date){
               if(real_start_date!=null && real_start_date!=""){
               sub_start_date.add(real_start_date);
               }
            }
            for(String real_end_date : end_date){
               if(real_end_date!=null && real_end_date!=""){
               sub_end_date.add(real_end_date);
               }
            }
            for(int real_week : week){
               if(real_week!=3){
            	   sub_week.add(real_week);
                 }
            }
         
            for(String real_contents : contents){
            	if(real_contents!=null && real_contents!=""&&!real_contents.contains("999")){
               sub_content.add(real_contents);
            	}
            	}
      
            for(float real_progress : progress){
                if(real_progress!=999){
                	  sub_progress.add(real_progress);
                    }
              
             }
            
            for(int i=0; i<sub_end_date.size(); i++){
               mindayArr.add(sub_start_date.get(i).toString());
            }
            
            for(int i=0; i<sub_end_date.size(); i++){
               maxdayArr.add(sub_end_date.get(i).toString());
            }
            
 
            
   	     for(int i=0; i<sub_start_date.size(); i++){
	            //종료일이 금주 월요일보다 작지 않고 시작일이 금주 토요일보다 작을때 ==>금주 계산식
	    	 if(thisWeekPlan_NextWeekPlan(sub_start_date.get(i).toString(),sub_end_date.get(i).toString()).get("thisWeekPlanProgress")!=0.0){
	    	 this_week_plan.add(thisWeekPlan_NextWeekPlan(sub_start_date.get(i).toString(),sub_end_date.get(i).toString()).get("thisWeekPlanProgress"));
	    	 }
	    	 if(thisWeekPlan_NextWeekPlan(sub_start_date.get(i).toString(),sub_end_date.get(i).toString()).get("nextWeekPlanProgress")!=0.0){
	    	 next_week_plan.add(thisWeekPlan_NextWeekPlan(sub_start_date.get(i).toString(),sub_end_date.get(i).toString()).get("nextWeekPlanProgress"));   
	    	 }
   	     }
	    	 
         for(int i=0; i<this_week_plan.size(); i++){
  	    	this_week_plan_Sum+=this_week_plan.get(i);
  	    }
  	 
  	    for(int i=0; i<next_week_plan.size(); i++){
  	    	next_week_plan_Sum+=next_week_plan.get(i);
  	    }
  	    
  	    this_week_plan_Avg = Double.isNaN(this_week_plan_Sum/this_week_plan.size())?0:this_week_plan_Sum/this_week_plan.size();
  	    next_week_plan_Avg = Double.isNaN(next_week_plan_Sum/next_week_plan.size())?0:next_week_plan_Sum/next_week_plan.size();
  	    
              //1.작업을 등록
              JobVO newVO= new JobVO(); //상위
              JobVO subNewVO= new JobVO(); //하위
              
              //유저 아이디(영어)
              String userid = loginUser.getName(); 
              if(userid==null){
                  userid="";
              }
              //유저 아이디로 이름 출력(한글)
                String userNameById=userService.selectUserName(userid).getName();
                
                Map<String,Float> this_next_plan = new HashMap<String,Float>();
                
                //상위작업 생성
                newVO.setId(vo.getId());
                newVO.setName(vo.getName());
                newVO.setWork_type(vo.getWork_type());
                
                //상위작업의 real_progress 생성시 하위작업의 여부를 판단하여 있을시엔 하위작업을 합산한값을 계산하여야한다.
                if(sub_name.size()>0){
                   //하위작업이 있을때는 하위작업의 시작 종료일이 최종 상위작업의 시작 종료일이 된다.
                   newVO.setReal_start_date(minDay(mindayArr));
                    newVO.setReal_end_date(maxDay(maxdayArr));
                   
                    //하위작업 진행도 계산식 적용
                   
                   float sum=0;
                   float result=0;
                   int planThisSum = 0;
                   int planNextSum = 0;
                   for(int i=0; i<sub_name.size(); i++){
                      //각각 하위작업의 평일의 합
                      result += createWeekDay(sub_start_date.get(i),sub_end_date.get(i));
                   }
                   
                   for(int i=0; i<sub_name.size(); i++){
                      this_next_plan = thisWeekPlan_NextWeekPlan(sub_start_date.get(i),sub_end_date.get(i));
                      sum+=(float)createWeekDay(sub_start_date.get(i),sub_end_date.get(i))/(float)result*(float)sub_progress.get(i);
                      planThisSum+=this_next_plan.get("thisWeekPlanProgress").intValue();
                      planNextSum+=this_next_plan.get("nextWeekPlanProgress").intValue();
                   }
                    newVO.setReal_progress(Double.isNaN(sum/100f)?0:sum/100f);
                    newVO.setThis_week_plan(Double.isNaN(this_week_plan_Avg)?0:this_week_plan_Avg);  
	                newVO.setNext_week_plan(Double.isNaN(next_week_plan_Avg)?0:next_week_plan_Avg);  
                }else{
                    this_next_plan = thisWeekPlan_NextWeekPlan(vo.getStart_date(),vo.getEnd_date());
	                newVO.setThis_week_plan(Double.isNaN(this_next_plan.get("thisWeekPlanProgress")/100)?0:this_next_plan.get("thisWeekPlanProgress")/100);  
	                newVO.setNext_week_plan(Double.isNaN(this_next_plan.get("nextWeekPlanProgress")/100)?0:this_next_plan.get("nextWeekPlanProgress")/100);  
	                newVO.setReal_progress(Double.isNaN(vo.getReal_progress()/100f)?0:vo.getReal_progress()/100f);
	                newVO.setReal_start_date(vo.getStart_date());
	                newVO.setReal_end_date(vo.getEnd_date());
	               
                }
	                newVO.setContents( vo.getContents()==null||vo.getContents()==""?"":vo.getContents());
	                newVO.setWork_detail_type(vo.getWork_detail_type());
	                newVO.setWork_division(vo.getWork_division());
	                newVO.setPrivacy_state(vo.getPrivacy_state());
	                newVO.setWeek(vo.getWeek());
	                newVO.setComment(vo.getComment());
	                newVO.setManager(userid);
	                newVO.setProject_id(vo.getProject_id());
	               
               
               for(int i=0; i<sub_end_date.size(); i++){
                  sub_monday.add(createWeekDay(sub_start_date.get(i), sub_end_date.get(i)));
               }
        
               int result = 0;
               for(int i=0; i<sub_end_date.size(); i++){
                  
                 result += createWeekDay(sub_start_date.get(i),sub_end_date.get(i));
               }
               //하위작업에 대한 공백처리 유효성
                //하위작업 생성
            
                for(int i=0; i < sub_name.size(); i++){
                   if(sub_name.get(i)==null||sub_name.get(i)==""){
                      break;
                   }else{
                   this_next_plan = thisWeekPlan_NextWeekPlan(sub_start_date.get(i),sub_end_date.get(i));
                
                   subNewVO.setThis_week_plan(this_next_plan.get("thisWeekPlanProgress"));
                   subNewVO.setNext_week_plan(this_next_plan.get("nextWeekPlanProgress"));
                   subNewVO.setProject_id(vo.getProject_id());
                   subNewVO.setManager(userid);
                   subNewVO.setParent(vo.getId());
                   subNewVO.setName(sub_name.get(i));
                   subNewVO.setReal_start_date(sub_start_date.get(i));
                   subNewVO.setReal_end_date(sub_end_date.get(i));
                   subNewVO.setStart_date(sub_start_date.get(i));
                   subNewVO.setEnd_date(sub_end_date.get(i));
                   subNewVO.setContents(sub_content.get(i)==null||sub_content.get(i)=="" ?"":sub_content.get(i));
                   subNewVO.setWork_type(vo.getWork_type());
                   subNewVO.setWork_detail_type(vo.getWork_detail_type());
                   subNewVO.setWork_division(vo.getWork_division());   
                   subNewVO.setReal_progress(sub_progress.get(i)/100);      
                   subNewVO.setWeek(sub_week.get(i));
                   subNewVO.setPrivacy_state(vo.getPrivacy_state());
                   jobService.registerMySubJobByMySelf(subNewVO); 
                   }
                }

                //상위작업 수정
                jobService.modifyMyJobByJobId(newVO);
            return "success";
            }
    
    
    @RequestMapping(value="/getMySubJobList",method=RequestMethod.POST)
    @ResponseBody
    public List<JobVO> getMySubJobList(int id){
    	
    	return jobService.selectSubJobInfoByParentId(id);
    }
         
   
}