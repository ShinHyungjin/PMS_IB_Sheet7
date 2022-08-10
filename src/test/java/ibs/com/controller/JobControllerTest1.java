/*package ibs.com.controller;

import static org.junit.Assert.*;

import java.lang.reflect.Method;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import ibs.com.service.JobService;


public class JobControllerTest1 {

	@InjectMocks
	private JobController jobController;
	
	@Mock
	private JobService jobService;
	
	private MockMvc mockMvc;
	
	@Before
	public void setUp(){
		mockMvc = MockMvcBuilders.standaloneSetup(jobController).build();
	}
	
	
	@Test
	@Ignore
	public void createWhatsDay() throws Exception{ 
		JobController create = new JobController();
		
		Method method = create.getClass().getDeclaredMethod("CreateThisWeekPlanAndNextWeekPlanByDept",Map.class);
		method.setAccessible(true);
		
		System.out.println(create.createWhatsDay().get("this_week_monday").getClass().getName());
		
		method.setAccessible(true);
	}
	
	@Test
	public void 금주계산() throws Exception{
	JobController create = new JobController();
		
		Method method = create.getClass().getDeclaredMethod("thisWeekPlan_NextWeekPlan",String.class, String.class);
		method.setAccessible(true);
		System.out.println("금주 계산: "+create.thisWeekPlan_NextWeekPlan("2021-10-25","2021-11-05").get("thisWeekPlanProgress"));
	}
	
	
	@Test
	public void job컨트롤러의_금주_차주_계산테스트() throws Exception{
		JobController create = new JobController();
		
		Method method = create.getClass().getDeclaredMethod("thisWeekPlan_NextWeekPlan",String.class, String.class);
		method.setAccessible(true);
		
		Method method1 = create.getClass().getDeclaredMethod("changed",String.class);
		method1.setAccessible(true);
		
		Method method2 = create.getClass().getDeclaredMethod("createWhatsDay");
		method2.setAccessible(true);
		
		Method method3 = create.getClass().getDeclaredMethod("calculateWeekDays",Date.class, Date.class);
		method3.setAccessible(true);
		
		//given
		String[] start = {"2021-10-25","2021-11-12","2021-11-03","2021-10-01"};
		String[] end = {"2021-11-05","2021-11-22","2021-11-03","2021-12-12"};
	    List<Float>this_week_plan = new ArrayList<>();
        List<Float>next_week_plan = new ArrayList<>();
        float this_week_plan_Sum = 0;
        float next_week_plan_Sum = 0;
        float this_week_plan_Avg = 0;
        float next_week_plan_Avg = 0;
        
        System.out.println("금주계획 배열: "+Arrays.toString(start) +"\n차주계획 배열: "+Arrays.toString(end));
        System.out.println(create.changed(end[0].toString()).getClass().getName());
        System.out.println(create.createWhatsDay().get("this_week_monday").getClass().getName());
        System.out.println(start.length);
	     for(int i=0; i<start.length; i++){
	            //종료일이 금주 월요일보다 작지 않고 시작일이 금주 토요일보다 작을때 ==>금주 계산식
	    	 if(create.thisWeekPlan_NextWeekPlan(start[i].toString(),end[i].toString()).get("thisWeekPlanProgress")!=0.0){
	    	 this_week_plan.add(create.thisWeekPlan_NextWeekPlan(start[i].toString(),end[i].toString()).get("thisWeekPlanProgress"));
	    	 }
	    	 if(create.thisWeekPlan_NextWeekPlan(start[i].toString(),end[i].toString()).get("nextWeekPlanProgress")!=0.0){
	    	 next_week_plan.add(create.thisWeekPlan_NextWeekPlan(start[i].toString(),end[i].toString()).get("nextWeekPlanProgress"));   
	    	 }
		
		Map<String,Float>map =(Map)create.thisWeekPlan_NextWeekPlan("2021-10-21", "2021-11-19");
		Iterator<String> iter = map.keySet().iterator();
		
		while(iter.hasNext()){
			String key = iter.next();
			Float value = map.get(key);
			System.out.println(key+":"+value);
		}
	}
	     
	    System.out.println("금주계획률: "+this_week_plan);
	    System.out.println("차주계획률: "+next_week_plan);
	    for(int i=0; i<this_week_plan.size(); i++){
	    	this_week_plan_Sum+=this_week_plan.get(i);
	    }
	 
	    for(int i=0; i<next_week_plan.size(); i++){
	    	next_week_plan_Sum+=next_week_plan.get(i);
	    }
	    
	    this_week_plan_Avg = (this_week_plan_Sum/this_week_plan.size());
	    next_week_plan_Avg = next_week_plan_Sum/next_week_plan.size();
	    
	    System.out.printf("최종 금주계획률: "+Math.round(this_week_plan_Avg*100));
	    System.out.print("최종 차주계획률: "+Math.round(next_week_plan_Avg*100));
	    method.setAccessible(false);
	    method1.setAccessible(false);
	    method2.setAccessible(false);
	    method3.setAccessible(false);
	}

	@Test
	public void 평일_구하기_테스트() throws Exception{
	JobController create = new JobController();
		
		Method method = create.getClass().getDeclaredMethod("createWeekDay",String.class, String.class);
		method.setAccessible(true);
		
		System.out.println(create.createWeekDay("2021-10-27", "2021-11-12"));
		method.setAccessible(false);
	}
	
}
*/