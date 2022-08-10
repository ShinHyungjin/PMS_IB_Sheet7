package ibs.com.domain;


import java.util.List;

import lombok.Data;

@Data
public class JobVO {
	private int id;
	private int project_id;
	private int job_id;
	private short deep;
	private int week;
	private int privacy_state;
	private int parent;
	private int hide;
	private int wbs_id;
	
	private String name; //*작업명
	private String manager;  //*담당자
	private String report; 
	private String work_type;//업무 종류
	private String work_detail_type; //상세업무
	private String work_division;
	private String comment;
	private String contents;
	private String order_id;
	private String department;
	private String user_id;
	
	//*기간
	private String start_date; 
	private String end_date;
	
	private String real_start_date;
	private String real_end_date;
	
	private float total_one_md;
	private float plan_one_md;
	private float total_date;
	private float plan_date;
	private float plan_progress;
	private float real_progress;
	private float this_week_plan;
	private float this_week_performence;
	private float next_week_plan;
	
	
	private ProjectVO project;
	private UserVO user;
	
	private int sub_cnt;
	private String week_date;
	private WbsVO wbs;

}
