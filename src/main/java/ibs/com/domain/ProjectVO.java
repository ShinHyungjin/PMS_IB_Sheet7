package ibs.com.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class ProjectVO {
	
	private int p_id;
	private String project_title;
	private String project_nickname;
    private String start_date;
    private String end_date;
	private int state;
	private String context;
	private String manager;
	private String team;
	private int payment;
	
	private String name;
	private String department;
	private String rank;
	private String title;
	
}
