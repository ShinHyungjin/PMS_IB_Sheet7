package ibs.com.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ibs.com.controller.MenuController;
import ibs.com.domain.MenuAuthorityVO;
import ibs.com.mapper.MenuMapper;

@Service("menuService")
public class MenuServiceImpl implements MenuService {

	@Resource(name="menuMapper")
	private MenuMapper mapper;
	private static final Logger logger = LoggerFactory.getLogger(MenuController.class);
	
	@Override
	public int insertInfo(MenuAuthorityVO vo) {
		// TODO Auto-generated method stub
		return mapper.insertInfo(vo);
	}

	@Override
	public int getGroupAuthByManager(MenuAuthorityVO vo) {
		// TODO Auto-generated method stub
		return mapper.getGroupAuthByManager(vo);
	}

	@Override
	public int deleteGroupAuthByManager(MenuAuthorityVO vo) {
		// TODO Auto-generated method stub
		return mapper.deleteGroupAuthByManager(vo);
	}

	@Override
	public int updateMenuAuthByMyInfo(MenuAuthorityVO vo) {
		// TODO Auto-generated method stub
		return mapper.updateMenuAuthByMyInfo(vo);
	}

	@Override
	public List<MenuAuthorityVO> getGroupAuthByGroup(MenuAuthorityVO vo) {
		// TODO Auto-generated method stub
		return mapper.getGroupAuthByGroup(vo);
	}

	
	public Integer loginauth2(String user_id, int projectId, int menuId) {
		MenuAuthorityVO vo = new MenuAuthorityVO();
		vo.setUser_id(user_id);
		vo.setProject_id(projectId);
		vo.setMenu_id(menuId);
		
		if(this.getMyGroupId(vo) == null || this.getMyGroupId(vo) == 0 || this.getMyGroupId(vo).toString()== ""){
			vo.setGroup_id(0);

		}else{
			vo.setGroup_id(this.getMyGroupId(vo));
		}
		
		Integer permissionCheck = mapper.loginauth2(vo);
		
		if(permissionCheck == null) {
			return 0;
		}
		
		//System.out.println("MenuServiceImplㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ ");
		//System.out.println("MenuAuthority:" + vo);
		//System.out.println("setGroup_id: " + this.getMyGroupId(vo) );
		//System.out.println("permissionCheck" + permissionCheck);
		
		return permissionCheck.intValue();
	}
		

	@Override
	public Integer getMyGroupId(MenuAuthorityVO vo) {
		//System.out.println(vo);
		// TODO Auto-generated method stub
		return mapper.getMyGroupId(vo);
	}

	
	
	@Override
	public List<MenuAuthorityVO>getWhatIsMyAuthForEachProject(MenuAuthorityVO vo) {
		// TODO Auto-generated method stub
		return mapper.getWhatIsMyAuthForEachProject(vo);
	}

	
	
	
	/*	 @Override
	   public Integer loginauth2(String userId, int projectId, int menuId) {
	      MenuAuthorityVO vo = new MenuAuthorityVO();
	      vo.setUser_id(userId);
	      vo.setProject_id(projectId);
	      vo.setMenu_id(menuId);
	      
	      if(this.getMyGroupId(vo) == null || this.getMyGroupId(vo) == 0 || this.getMyGroupId(vo).toString()== ""){
	         vo.setGroup_id(0);
	         
	      }else{
	         vo.setGroup_id(this.getMyGroupId(vo));
	      }
	      Integer permissionCheck = mapper.loginauth2(vo);
	      
	      if(permissionCheck == null) {
	         return 0;
	      }
	      
	      return permissionCheck.intValue();
	   }
	   

	*/

}
