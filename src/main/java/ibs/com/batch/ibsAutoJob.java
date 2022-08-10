/*package ibs.com.batch;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ibsAutoJob implements Job {

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		
		Date date = new Date();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy년 MM월 dd일");
		SimpleDateFormat sdf2 = new SimpleDateFormat("HH시 mm분 ss초");
		
		String currentDate = sdf1.format(date);
		String currentTime = sdf1.format(date);
		
		log.info("================자동 작업 시작=====================");
		log.info("Start Time >>> {}", currentDate + " "+ currentTime);
	
	}

}
*/