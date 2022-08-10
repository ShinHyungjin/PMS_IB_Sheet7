package ibs.com.domain;


import lombok.Data;

@Data
public class WeekReportVO {
	private int id;
	private int project_id;
	private int job_id;
	private String user_id;
	private int parent;
	private int child_id;
	
	private String work_type;
	private String work_detail_type;
	private String work_division;
	private String privacy_state;

	private String start_date;
	private String end_date;
	private float this_week_plan;
	private float this_week_performence;
	private float next_week_plan;
	private String comment;
	private String week_date;
	private String job_name;
	private String contents;
	private float real_progress;
	
	private String name;
	private String this_week_monday;
	private String this_week_saturday;
	private String next_week_monday;
	private String next_week_saturday;
	
	
	private JobVO job;
}
