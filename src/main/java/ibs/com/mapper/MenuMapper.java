package ibs.com.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ibs.com.domain.MenuAuthorityVO;

@Mapper("menuMapper")
public interface MenuMapper{

	
	public int insertInfo(MenuAuthorityVO vo);
	
	public int getGroupAuthByManager(MenuAuthorityVO vo);
	
	public int deleteGroupAuthByManager(MenuAuthorityVO vo);
	
	public int updateMenuAuthByMyInfo(MenuAuthorityVO vo);
	
	public List<MenuAuthorityVO>getGroupAuthByGroup(MenuAuthorityVO vo);

	
	//로그인한 사용자의 프로젝트 권한
	public Integer loginauth2(MenuAuthorityVO vo);
	
	//그룹 아이디 가져오기 프로젝트별
	public Integer getMyGroupId(MenuAuthorityVO vo);
	
	
	//로그인한 사용자의 해당 프로젝트에서의 메뉴에 대한 접근권한 
	public List<MenuAuthorityVO>getWhatIsMyAuthForEachProject(MenuAuthorityVO vo);

	
}

