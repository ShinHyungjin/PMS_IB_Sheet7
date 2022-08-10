package ibs.com.batch;

import static org.hamcrest.CoreMatchers.nullValue; 
import static org.junit.Assert.* ;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.enterprise.inject.Disposes;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import ibs.com.controller.ReportController;

public class CreateBeforeWeekReportTest {
	
/*	@Autowired
	CreateBeforeWeekReport createBeforeWeekReport;*/

	private MockMvc mockMvc;
/*	
	@Before
	public void setUp(){
		mockMvc = MockMvcBuilders.standaloneSetup(createBeforeWeekReport).build();
	}*/
	
	@Test
	public void 날짜사이의_평일_테스트() throws Exception{
		CreateBeforeWeekReport create = new CreateBeforeWeekReport();
		
		Method method = create.getClass().getDeclaredMethod("calculateWeekDays", Date.class,Date.class);
		method.setAccessible(true);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String start = "2021-10-27";
		String end = "2021-11-12";		
		Date start_date = (Date) format.parse(start);
		Date end_date = (Date) format.parse(end);
		
		Long result = (Long) method.invoke(create,start_date, end_date);
		Long test = (long) 13;
		//assertEquals(test, result);
		//assertNotNull("조회결과 null",result);
		System.out.println(result);
		method.setAccessible(false);
	}
	
	@Test
	public void 현재_날짜를_기준으로_금주차주_월토_구하기() throws Exception{
		CreateBeforeWeekReport create = new CreateBeforeWeekReport();
		
		Method method = create.getClass().getDeclaredMethod("createWhatsDay");
		method.setAccessible(true);
		
		Map<String, Object> date =create.createWhatsDay();
		int nowDay = LocalDate.now().getDayOfWeek().getValue();
		System.out.println(nowDay);
		System.out.println("현재_날짜를_기준으로_금주차주_월토_구하기: "+date);
		method.setAccessible(false);
	}


}
