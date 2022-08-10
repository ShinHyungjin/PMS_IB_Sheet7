package ibs.com.service;

import java.util.List;

import ibs.com.domain.MenuAuthorityVO;


public interface MenuService{
	
	//PM급 이상이 자기 프로젝트의 팀원의 접근권한 넣기
	public int insertInfo(MenuAuthorityVO vo);
	//PM급 이상이 이전에 설정한 권한 내용 확인하기
	public int getGroupAuthByManager(MenuAuthorityVO vo);
	////PM급 이상이 자기 프로젝트의 팀원의 접근권한 삭제
	public int deleteGroupAuthByManager(MenuAuthorityVO vo);
	//메뉴 권한 갱신
	public int updateMenuAuthByMyInfo(MenuAuthorityVO vo);
	//선택한 그룹 권한 확인하기
	public List<MenuAuthorityVO>getGroupAuthByGroup(MenuAuthorityVO vo);
	
	public Integer loginauth2(String user_id, int projectId, int menuId);
	
	//그룹 아이디 가져오기 프로젝트별
	public Integer getMyGroupId(MenuAuthorityVO vo);
	
	
	//로그인한 사용자의 해당 프로젝트에서의 메뉴에 대한 접근권한 
	public List<MenuAuthorityVO> getWhatIsMyAuthForEachProject(MenuAuthorityVO vo);
}
