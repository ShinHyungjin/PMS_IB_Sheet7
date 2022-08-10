package ibs.com.domain;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class CriteriaVO {
	private String project_title;
	private String userid;
	private String todayYearMonthDays;
	private String twoMonthsAgo;

	//웹페이지에서 항상 파라미터값 유지, 인코딩 자동 설정됨
		public String getListLink() {

			UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
					.queryParam("project_title", this.project_title);
				
			return builder.toUriString();

		}

	
	
/*	public String[] getTypeArr() {
		
		return project_title == null? new String[] {}:project_title.split("");
	}
	
		public String getListLink() {

			UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
					.queryParam("project_title", this.getProject_title());

			return builder.toUriString();

		}*/


}
