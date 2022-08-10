package ibs.com.domain;

import lombok.Data;

@Data
public class MenuAuthorityVO {
	private int menu_id; //접근 가능한 메누테이블 아이디
	private int permission_check;
	private int group_id; //그룹id
	private int project_id; //프로젝트 id
	private String user_id; //아직 비활성화
}
