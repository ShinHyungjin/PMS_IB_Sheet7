package ibs.com.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import ibs.com.mapper.WeekReportMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
"file:src/main/resources/egovframework/spring/context-mapper.xml",
"file:src/main/resources/egovframework/spring/context-datasource.xml"})
public class WeekReportServiceTest {

	 @Autowired
		private WeekReportMapper weekReportMapper;
	
	 //안녕하세요
	@Test
	public void 서비스코드_테스트()throws Exception{
		HashMap<String,Object> map = new HashMap();
		map.put("week_date", "2021-11-06");
		map.put("department", "130");
		
		System.out.println(map); 
		List<Map>list = new ArrayList();
		
		list = weekReportMapper.selectWeekReportDeptAndDate(map);
		
		System.out.println(list.size());
		System.out.println(list);

	}
}