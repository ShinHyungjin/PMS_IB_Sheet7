/*package ibs.com.batch;

import java.util.Collection;

import javax.annotation.PostConstruct;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.stereotype.Component;

@Component
public class ibsScheduler {

	private SchedulerFactory schedulerFactory;
	private Scheduler scheduler;
	
	@PostConstruct
    public void start() throws SchedulerException {
 
        schedulerFactory = new StdSchedulerFactory();
        scheduler = schedulerFactory.getScheduler();
        scheduler.start();
 
        JobDetail job = JobBuilder.newJob(ibsAutoJob.class).withIdentity("ibsAutoJob").build();
        Trigger trigger = TriggerBuilder.newTrigger()
                            .withSchedule(CronScheduleBuilder.cronSchedule("10 * * * * ?"))
                            .build();
 
        //Trigger trigger = TriggerBuilder.newTrigger().startAt(startDateTime).endAt(endDateTime)
        //        .withSchedule(CronScheduleBuilder.cronSchedule("*1 * * * *")).build();
 
        scheduler.scheduleJob(job, trigger);
    }
}
*/