package ibs.com.batch;

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
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import ibs.com.controller.ProjectController;
import ibs.com.domain.JobVO;
import ibs.com.domain.MemberVO;
import ibs.com.domain.ProjectVO;
import ibs.com.service.JobService;
import ibs.com.service.ProjectService;
import ibs.com.service.UserService;
import ibs.com.service.WeekReportService;

@Component
public class CreateBeforeWeekReport {
   
   private static final Logger LOGGER = LoggerFactory.getLogger(ProjectController.class);
   
   @Resource(name="weekReportService")
   private WeekReportService weekReportService;
   @Resource(name="jobService")
   private JobService jobService; 
   @Resource(name="userService")
   private UserService userService; 
   @Resource(name="projectService")
   private ProjectService projectService; 
   
   public String createToday(){
      SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
      Date time = new Date();
      
      String today = format1.format(time);
      return today;
   }
   
   
     //String 형태의 2021-10-11 을 날짜형태로 변환하는 함수
      public LocalDate Changed(String date){
         SimpleDateFormat weekSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
         LocalDate test = LocalDate.parse(date,DateTimeFormatter.ISO_DATE);         
         return test;
      }

      //전주 토요일, 금주 월요일, 금주 차주 토요일 뽑아오는 함수
      public Map<String,Object> createWhatsDay(){
         Map<String,Object> day = new HashMap<>();
         int nowDay = 0; 
         nowDay =LocalDate.now().getDayOfWeek().getValue();
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
                  next_week_friday = LocalDate.now().plusDays(10);
               next_week_saturday = LocalDate.now().plusDays(11);   
               break;
            case 2: //찍힌 날짜가 화요일 이라면
               last_week_saturday = LocalDate.now().minusDays(3);
               this_week_monday = LocalDate.now().minusDays(1);
               this_week_saturday = LocalDate.now().plusDays(4);
               next_week_monday = LocalDate.now().plusDays(6);
               next_week_friday = LocalDate.now().plusDays(9);
               next_week_saturday = LocalDate.now().plusDays(10);   
               break;
            case 3: //찍힌 날짜가 수요일 이라면
               last_week_saturday = LocalDate.now().minusDays(4);
               this_week_monday = LocalDate.now().minusDays(2);
               this_week_saturday = LocalDate.now().plusDays(3);
               next_week_monday = LocalDate.now().plusDays(5);
               next_week_friday = LocalDate.now().plusDays(8);      
               next_week_saturday = LocalDate.now().plusDays(9);      
               break;
            case 4: //찍힌 날짜가 목요일 이라면
               last_week_saturday = LocalDate.now().minusDays(5);
               this_week_monday = LocalDate.now().minusDays(3);
               this_week_saturday = LocalDate.now().plusDays(2);
               next_week_monday = LocalDate.now().plusDays(4);
               next_week_friday = LocalDate.now().plusDays(7);
               next_week_saturday = LocalDate.now().plusDays(8);
               break;
            case 5: //찍힌 날짜가 굼요일 이라면
               last_week_saturday = LocalDate.now().minusDays(6);
               this_week_monday = LocalDate.now().minusDays(4);
               this_week_saturday = LocalDate.now().plusDays(1);
               next_week_monday = LocalDate.now().plusDays(3);
               next_week_friday = LocalDate.now().plusDays(6);
               next_week_saturday = LocalDate.now().plusDays(7);
               break;
            case 6: //찍힌 날짜가 토요일 이라면
               last_week_saturday = LocalDate.now().minusDays(7);
               this_week_monday = LocalDate.now().minusDays(5);
               this_week_saturday = LocalDate.now();
               next_week_monday = LocalDate.now().plusDays(2);
               next_week_friday = LocalDate.now().plusDays(5);
               next_week_saturday = LocalDate.now().plusDays(6);
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
   
      public static int createWeekDay(String start, String end) throws ParseException{
            //System.out.println(start);
            //System.out.println(end);
            
            Calendar startDate = Calendar.getInstance(); // 작업 시작일 (START_DATE)
            Calendar endDate = Calendar.getInstance(); // 작업 종료일 (END_DATE)
            Calendar addDate = Calendar.getInstance(); // 시작일~종료일 사이의 주말을 제외하기 위한 계산용 날짜
            int workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)
            
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            
            Date start_Date = format.parse(start); 
            Date end_Date = format.parse(end);
            
          //  System.out.println(start_Date);
          //  System.out.println(end_Date);
            
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
            
            
           // System.out.println("평일은?:  "+workingDays);
            
            
            //System.out.println("시작일: "+start);
            //System.out.println("마감일: "+end);
            
            return workingDays;
         }
      
      
      //주어진 기간의 총 평일수를 구하는 함수
      public Long calculateWeekDays(Date StartDate, Date EndDate){
         //System.out.println("함수로 들어온 시작일: "+StartDate);
         //System.out.println("함수로 들어온 종료일: "+EndDate);
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
         //LOGGER.info("주말 제외 총 기간 : " + workingDays);
         
         return workingDays;
      }
      
      
   @SuppressWarnings("deprecation")
   public void reportBatch(String tableName) throws ParseException{
      Calendar startDate = Calendar.getInstance(); // 작업 시작일 (START_DATE)
      Calendar endDate = Calendar.getInstance(); // 작업 종료일 (END_DATE)
      Calendar addDate = Calendar.getInstance(); // 시작일~종료일 사이의 주말을 제외하기 위한 계산용 날짜
      
        Calendar this_Week_SatDate = Calendar.getInstance();
            Calendar next_Week_SatDate = Calendar.getInstance();
            Calendar this_From_next_To_weekDay = Calendar.getInstance();
            LocalDate change_this_Week_SatDate = null;
            LocalDate change_next_Week_SatDate = null;
            LocalDate change_this_From_next_To_weekDay = null;
            
            Calendar thisMon = null;
            Calendar thisFri = null;
            Calendar thisSat = null;
            LocalDate change_thisMon = null;
            LocalDate change_thisFri = null;
            LocalDate change_thisSat = null;
            
            Calendar nextMon = null;
            Calendar nextFri = null;
            Calendar nextSat = null;
            LocalDate change_nextMon = null;
            LocalDate change_nextFri = null;
            LocalDate change_nextSat = null;
      

            int nowDay = LocalDate.now().getDayOfWeek().getValue();
            switch (nowDay) {
            case 1: //찍힌 날짜가 월요일 이라면
               change_thisMon = LocalDate.now();
               change_thisSat = LocalDate.now().plusDays(5);
               change_nextMon = LocalDate.now().plusDays(7);
               change_nextFri = LocalDate.now().plusDays(11);
               change_nextSat = LocalDate.now().plusDays(12);   
               break;
            case 2: //찍힌 날짜가 화요일 이라면
               change_thisMon = LocalDate.now().minusDays(1);
               change_thisSat = LocalDate.now().plusDays(4);
               change_nextMon = LocalDate.now().plusDays(6);
               change_nextFri = LocalDate.now().plusDays(10);
               change_nextSat = LocalDate.now().plusDays(11);   
               break;
            case 3: //찍힌 날짜가 수요일 이라면
               change_thisMon = LocalDate.now().minusDays(2);
               change_thisSat = LocalDate.now().plusDays(3);
               change_nextMon = LocalDate.now().plusDays(5);
               change_nextFri = LocalDate.now().plusDays(9);      
               change_nextSat = LocalDate.now().plusDays(10);      
               break;
            case 4: //찍힌 날짜가 목요일 이라면
               change_thisMon = LocalDate.now().minusDays(3);
               change_thisSat = LocalDate.now().plusDays(2);
               change_nextMon = LocalDate.now().plusDays(4);
               change_nextFri = LocalDate.now().plusDays(8);
               change_nextSat = LocalDate.now().plusDays(9);
               break;
            case 5: //찍힌 날짜가 굼요일 이라면
               change_thisMon = LocalDate.now().minusDays(4);
               change_thisSat = LocalDate.now().plusDays(1);
               change_nextMon = LocalDate.now().plusDays(3);
               change_nextFri = LocalDate.now().plusDays(7);
               change_nextSat = LocalDate.now().plusDays(8);
               break;
            case 6: //찍힌 날짜가 토요일 이라면
               change_thisMon = LocalDate.now().minusDays(5);
               change_thisSat = LocalDate.now().plusDays(5);
               change_nextMon = LocalDate.now().plusDays(2);
               change_nextFri = LocalDate.now().plusDays(6);
               change_nextSat = LocalDate.now().plusDays(7);
               break;
            default:
               break;
      }
            
      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
      Map<String,Object>thisMon_NextSat = new HashMap<>();
      thisMon_NextSat.put("this_week_monday", change_thisMon.toString());
      thisMon_NextSat.put("next_week_saturday", change_nextSat.toString());
      
      
      List<JobVO>list = weekReportService.getAllWeekReport(thisMon_NextSat);
      for(int i=0; i<list.size(); i++){
          long workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)
               long byThisWeekSatudayWeekDays = 0; //시작일~ 금주까지의 평일수
               long byNextWeekSatudayWeekDays = 0; //시작일~ 다음주까지의 평일수
         
      Date start_date = format.parse(list.get(i).getReal_start_date().toString());
      Date end_date = format.parse(list.get(i).getReal_end_date().toString());
        LocalDate change_start_date =  Changed(list.get(i).getReal_start_date().toString());
        LocalDate change_end_date = Changed(list.get(i).getReal_end_date().toString());
      System.out.println("시작일: "+change_start_date);
      System.out.println("종료일: "+change_end_date);
      
      
      startDate.setTime(start_date);
      addDate.setTime(start_date);
      endDate.setTime(end_date);
      
      // 주말을 제외한 총 기간 구하기
      workingDays =calculateWeekDays(start_date, end_date);

      // 이번주 월요일
        thisMon = Calendar.getInstance(Locale.KOREA);
        thisMon.set(Calendar.DAY_OF_MONTH, Calendar.MONDAY);
        Date thisWeekMonday = thisMon.getTime();
        //System.out.println("이번주 월요일: "+thisMon.get(Calendar.DAY_OF_MONTH));

         // 이번주 금요일
        thisFri = Calendar.getInstance(Locale.KOREA);
        thisFri.set(Calendar.DAY_OF_MONTH, Calendar.FRIDAY);
       // System.out.println("이번주 금요일: "+thisFri.get(Calendar.DAY_OF_MONTH));
        //이번주 토요일
        thisSat = Calendar.getInstance(Locale.KOREA);
        thisSat.set(Calendar.DAY_OF_MONTH, Calendar.SATURDAY);
        System.out.println("이번주 토요일: "+thisSat.getTime());
        Date thisWeekSaturday = thisSat.getTime();
        
        
        
        // 다음주 월요일
        nextMon = Calendar.getInstance(Locale.KOREA);
        nextMon.set(Calendar.DAY_OF_MONTH, Calendar.MONDAY);
        nextMon.add(Calendar.DAY_OF_MONTH, 7);
        //System.out.println("다음주 월요일: "+nextMon.get(Calendar.DAY_OF_MONTH));
        
        // 다음주 금요일
        nextFri = Calendar.getInstance(Locale.KOREA);
        nextFri.set(Calendar.DAY_OF_MONTH, Calendar.FRIDAY);
        nextFri.add(Calendar.DAY_OF_MONTH, 7);
        //System.out.println("다음주 금요일: "+nextFri.get(Calendar.DAY_OF_MONTH));
        
        // 다음주 토요일
        nextSat = Calendar.getInstance(Locale.KOREA);
        nextSat.set(Calendar.DAY_OF_MONTH, Calendar.SATURDAY);
        nextSat.add(Calendar.DAY_OF_MONTH, 7);
        //System.out.println("다음주 토요일: "+nextSat.get(Calendar.DAY_OF_MONTH));
        
       Map<String,Object> createThisMon_NextSat= createWhatsDay();
       
        Date nextWeekSaturday = nextSat.getTime();
        byNextWeekSatudayWeekDays = createWeekDay(list.get(i).getReal_start_date().toString(),createThisMon_NextSat.get("next_week_saturday").toString());
        byThisWeekSatudayWeekDays = createWeekDay(list.get(i).getReal_start_date().toString(),  createThisMon_NextSat.get("this_week_saturday").toString());
      // 금주 계획, 차주 계획
      int thisWeekPlan = 0;
      int nextWeekPlan = 0;

   
      System.out.println("이번주 토요일은? :"+createThisMon_NextSat.get("this_week_saturday"));
      
        // 금주 계획 계산
        // 1. 종료일이 금주 금요일보다 클때 ex) 종료일:10-28 , 금주 금요일:10-28=========================================================================
        if(change_end_date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
           System.out.println("[금주계산] 종료일이 금주 금요일보다 크다");
           thisWeekPlan = (int) byThisWeekSatudayWeekDays;
         
           //1.2 시작일이 차주 월요일보다 작을때 ex) 시작일:10-24 , 금주 월요일:10-25
            if(change_start_date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_monday"))){
              thisWeekPlan = createWeekDay(list.get(i).getReal_start_date().toString(),createThisMon_NextSat.get("this_week_saturday").toString());
              if(change_end_date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_monday"))){
               thisWeekPlan = createWeekDay(list.get(i).getReal_start_date().toString(),list.get(i).getReal_end_date().toString());
            }
              System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
           }
           //1.3 시작일이 금주 토요일보다 작을때 ex) 시작일:10-26 , 금주 월요일:10-25
           else if(change_start_date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
              System.out.println("[금주계산] 시작일이 금주 토요일보다 작다");
              thisWeekPlan = (int) byThisWeekSatudayWeekDays;
              System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
           }
        } // End 1. 종료일이 금주 금요일보다 늦다 
        
        // 2.종료일이 금주 금요일보다 빠르다.  ex) 종료일:10-26 , 금주 금요일:10-28
        else if(change_end_date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
           System.out.print("[금주계산] 종료일이 금주 토요일보다 작을때.");
           thisWeekPlan = createWeekDay(list.get(i).getReal_start_date().toString(),list.get(i).getReal_end_date().toString());
           //2.1 before는 시간단위가지 계산하기 때문에 같은 날짜라도 다르게 나오는 예외케이스가 존재하기 때문에 혹시나 같은 일 일 경우는 시간단위로는 계산안한다.(종료일이 금주 금요일이면)
           //2.2 시작일이 금주 월요일보다 작을때ex) 시작일:10-24 , 금주 월요일:10-25
            if(change_start_date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_monday"))){
               System.out.println(" 시작일이 금주 월요일보다 작을면.");
              thisWeekPlan = createWeekDay(list.get(i).getReal_start_date().toString(),list.get(i).getReal_end_date().toString());
            
           }
           //2.3 시작일이 금주 월요일보다 클때 ex) 시작일:10-26 , 금주 월요일:10-25
           else if(change_start_date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_monday"))){
              System.out.println("시작일이 금주 월요일보다 크면.");
              thisWeekPlan = createWeekDay(list.get(i).getReal_start_date().toString(),list.get(i).getReal_end_date().toString());
           }
            
        }
        
        //차주 계획 계산
        //1. 종료일이 금주 토요일보다 크면
        if(change_end_date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
           System.out.println("[차주계산] 종료일이 금주 금요일보다 클때");
           nextWeekPlan = (int) byNextWeekSatudayWeekDays;
           System.out.println(nextWeekPlan);
          //1.1 종료일이 차주 월요일보다 클때
           if(change_end_date.isAfter((LocalDate) createThisMon_NextSat.get("next_week_monday"))){
              nextWeekPlan =(int)  byNextWeekSatudayWeekDays;
            //1.1.1 종료일이 차주 토요일보다 작을때
              if(change_end_date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_saturday"))){
               nextWeekPlan = createWeekDay(list.get(i).getReal_start_date().toString(),list.get(i).getReal_end_date().toString());
              }
              //1.1.2 종료일이 차주 토요일을 넘을때
              else if(change_end_date.isAfter((LocalDate) createThisMon_NextSat.get("next_week_saturday"))){
                System.out.println("[차주계산] 종료일이 금주 금요일보다 클때");
                    nextWeekPlan = (int) byNextWeekSatudayWeekDays;
           }
           
           }
         //1.2 종료일이 차주 월요일과 같을때
            else if(change_end_date.isEqual((LocalDate) createThisMon_NextSat.get("next_week_monday"))){
               nextWeekPlan =createWeekDay(list.get(i).getReal_start_date().toString(),list.get(i).getReal_end_date().toString());
            }
           
        }
        //2. 종료일이 금주 토요일보다 작으면
        else if(change_end_date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))){
           System.out.println("[차주계산] 종료일이 금주 금요일보다 작을때");
         
              nextWeekPlan =0;
           
        }
        System.out.println("이번주 작업량: "+thisWeekPlan);
        System.out.println("다음주 작업량: "+nextWeekPlan);
        System.out.println("총 평일수는: "+workingDays);
      // 금주 계획은 이번주 작업량/전체 작업량, 차주 계획은 다음주 작업량/전체 작업량
      float thisWeekPlanProgress = (float)thisWeekPlan / (float) workingDays;
      float nextWeekPlanProgress = (float) nextWeekPlan / (float) workingDays;   
      System.out.println("금주계획은: "+thisWeekPlanProgress);
      System.out.println("차주계획은: "+nextWeekPlanProgress);
      
      
      if (nextWeekPlanProgress <= 0) {
         nextWeekPlanProgress = 0.0f;
      }
      if(thisWeekPlanProgress<=0){
         thisWeekPlanProgress = 0.0f;
      }
      
      LOGGER.info("nextWeekPlan : " + nextWeekPlan + "\tworkingDays : " + workingDays + "\tthisWeekPlanProgress : " + thisWeekPlanProgress +"\tnextWeekPlanProgress : " + nextWeekPlanProgress);
         System.out.println(list.get(i).getManager().toString());
         JobVO vo = new JobVO();
         vo.setManager(userService.selectUserName(list.get(i).getManager()).getName());
            vo.setUser_id(list.get(i).getManager());
         vo.setProject_id(list.get(i).getProject_id());
         vo.setWork_type(list.get(i).getWork_type());
         vo.setWork_detail_type(list.get(i).getWork_detail_type());
         vo.setWork_division(list.get(i).getWork_division());
         vo.setJob_id(list.get(i).getId());
         vo.setStart_date(list.get(i).getStart_date());
         vo.setEnd_date(list.get(i).getEnd_date());
         vo.setReal_start_date(list.get(i).getReal_start_date());
         vo.setReal_end_date(list.get(i).getReal_end_date());
         vo.setComment(list.get(i).getComment());
         vo.setContents(list.get(i).getContents());
         vo.setReal_progress(list.get(i).getReal_progress());
         vo.setWeek_date(createToday());
         vo.setThis_week_plan(thisWeekPlanProgress);
         vo.setThis_week_performence(list.get(i).getReal_progress());
         vo.setNext_week_plan(nextWeekPlanProgress);
          vo.setParent(list.get(i).getParent());
          vo.setReal_progress(list.get(i).getReal_progress());
          vo.setParent(list.get(i).getParent());
          vo.setDeep(list.get(i).getDeep());
          vo.setHide(list.get(i).getHide());
          vo.setReport(list.get(i).getReport());
          vo.setName(list.get(i).getName());
          vo.setTotal_date(list.get(i).getTotal_date());
          vo.setTotal_one_md(list.get(i).getTotal_one_md());
          vo.setPlan_date(list.get(i).getPlan_date());
          vo.setPlan_one_md(list.get(i).getPlan_one_md());
          vo.setPlan_progress(list.get(i).getPlan_progress());
          vo.setWeek(list.get(i).getWeek());
          vo.setPrivacy_state(list.get(i).getPrivacy_state());
       
          
          if(tableName.equals("WEEK_REPORT")){
             LOGGER.info("과거 배치");
         weekReportService.insertJobToWeekReport(vo);
          }else if(tableName.equals("WEEK_REPORT_TEMP")){
             LOGGER.info("실시간 배치");
          weekReportService.insertJobToWeekReportTemp(vo);
          }
      }
      
   }
   //프로젝트를 참여중이지만 할당받은 작업이 없는 사람들은 그냥 이름하고 프로젝트 id만 같이 넣어준다.
   @Transactional
   public void addEmptyProjectMember(String tableName){
      System.out.println(projectService.selectIngProject());
      
      //1.진행중인 프로젝트 id 리스트
      List<ProjectVO> list=projectService.selectIngProject();
      
      HashMap<String, Object> map = new HashMap<>();
      for(int i=0; i<list.size(); i++){
         map.put("projectList", list);
      }
      
      //System.out.println(list.size());
      
      System.out.println("진행중인 프로젝트 리스트: "+list);
      for(int i=0; i<list.size(); i++){
      //2. 진행중인 프로젝트의 참여자들 리스트   
      List<MemberVO>newList = projectService.selectIngProjectMember(list.get(i).getP_id());
      System.out.println("프로젝트 참여자 리스트: "+newList);
      for(int j=0; j<newList.size(); j++){
         HashMap<String, Object>newmap = new HashMap<>();
         newmap.put("project_id", newList.get(j).getProject_id());
         newmap.put("user_id", newList.get(j).getUser_id());
         newmap.put("week_date", createToday());
         
         if(tableName=="WEEK_REPORT_TEMP"){
             weekReportService.insertEmptyMembersJobAtWeekReportTemp(newmap);
             System.out.println("실시간 등록 작업: "+weekReportService.insertEmptyMembersJobAtWeekReportTemp(newmap));
         }else if(tableName=="WEEK_REPORT"){
             weekReportService.insertEmptyMembersJobAtWeekReport(newmap);
             System.out.println("과거 등록 작업: "+weekReportService.insertEmptyMembersJobAtWeekReport(newmap));
         }
          
         }
         //System.out.println("프로젝트id: "+newList.get(i).getProject_id()+" 유저id: "+newList.get(i).getUser_id());
      }
   }
   
   //이번주 주간보고서 생성 
   //매주 토요일 밤 11시 
 //Scheduled(cron = "0 0 23 ? * SAT")
   //@Scheduled(cron = "0 58 17 ? * SUN") //테스트완료
   //@Scheduled(cron = "*/30 * * * * *")// 테스트시에만 적용
   @Transactional
   public void createThisWeekReport() throws ParseException{
      LOGGER.info("배치 테스트====================");
      //System.out.println(createToday());
      //System.out.println(jobService.getAllWeekReport());
      //List<JobVO>list = jobService.getAllWeekReport();
      //System.out.println(list.size());
       reportBatch("WEEK_REPORT");
       //addEmptyProjectMember("WEEK_REPORT");
   }
   
   // 실시간 주간보고서 1시간 단위로 월~금 이내에서 내가 당장 1시간전의 주간보고서를 보고싶을때
   // @Scheduled(cron = "0 0 0/1 4-22 * MON-FRI")//월~금 사이에서 04~22시까지 1시간단위로 갱신
   // @Scheduled(cron = "0 0/1 4-22 * * *") //04~22시까지 매 1분간 테스트시에만 적용
   @Transactional
   //@Scheduled(cron = "*/30 * * * * *") //10초마다 테스트시에만 적용
   public void createRealTimeWeekReport() throws ParseException{
      weekReportService.deleteAllForRealTimeWeekReport();
       reportBatch("WEEK_REPORT_TEMP");
       //addEmptyProjectMember("WEEK_REPORT_TEMP");
       
   }
   
   //실시간 주간보고서 삭제
   //매주 토요일 새벽1시
   //@Scheduled(cron = "0 0 01 ? * SAT")
   public void deleteRealTimeWeekReport(){
         
   }
   

   

}