package ibs.com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ibs.com.domain.AuthVO;
import ibs.com.domain.CommonVO;
import ibs.com.domain.MemberVO;
import ibs.com.domain.UserVO;
import ibs.com.mapper.UserMapper;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("userService")
public class UserServiceImpl implements UserService{
	private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);

	@Resource(name="userMapper")
	private UserMapper userMapper;
	
	//슬희ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@Transactional
	@Override
	public void join(UserVO UserVO) {
		AuthVO authVo = new AuthVO();
		authVo.setId(UserVO.getId());
		//log.info("service register..." + UserVO);
		/*String encodePw = encoder.encode(UserVO.getPassword());
		UserVO.setPassword(encodePw);*/
		
		// 회원 정보 입력
		userMapper.insert(UserVO);
		
		// 회원 권한 입력
		userMapper.insertAuth(authVo);
		
	}

	//아이디 중복체크
	@Override
	public int idChk(UserVO UserVO) {
	  int result = userMapper.idChk(UserVO);
	  return result;
	}
	
	//회원가입 수정
	public int modify(UserVO UserVO){
		return userMapper.modify(UserVO);
	}
	

	
	
	//주영ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    @Override
    public List<UserVO> selectAllUserInfoExceptThisProjectMemeberByDepartment(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return userMapper.selectAllUserInfoExceptThisProjectMemeberByDepartment(map);
    }
	@Override
	public UserVO selectUserInfo(UserVO vo) {
		return userMapper.selectUserInfo(vo);
	}

	@Override
	public UserVO selectUserById(String id) {
		return userMapper.selectUserById(id);
	}

	@Override
	public UserVO selectUserName(String id) {
		return userMapper.selectUserName(id);
	}

	@Override
	public List<UserVO> selectAllUserInfo() {
		return userMapper.selectAllUserInfo();
	}
	
	@Override
	public String selectUserIdByName(String name) {
		// TODO Auto-generated method stub
		return userMapper.selectUserIdByName(name);
	}

	@Override
	public int permitionDelectSubmit(List<UserVO> allUserVOList) {
		// TODO Auto-generated method stub
		return userMapper.permitionDelectSubmit(allUserVOList);
	}
	
	@Override
	public int permitionRollbackSubmit(List<UserVO> allUserVOList) {
		// TODO Auto-generated method stub
		return userMapper.permitionRollbackSubmit(allUserVOList);
	}
	
	@Override
	public int resetPassword(List<UserVO> allUserVOList) {
		// TODO Auto-generated method stub
		return userMapper.resetPassword(allUserVOList);
	}

	
	//부서,이름,부서+이름 으로 조건에 따로 유저 리스트 가져오기
	@Override
	public List<UserVO> resultToSearchUserList(String department, String name){
		
		UserVO vo = new UserVO();
		
		//LOGGER.info("조건으로 들어온 부서: "+department);
		//LOGGER.info("조건으로 들어온 이름: "+name);
		
	   if(department!=null && department!="" && name==null){
			return userMapper.selectUserByDept(Integer.parseInt(department));
		}else if(department==null && name!=null){
			return userMapper.selectUserByName(name);
		}else if(department!=null && department!="" && name!=null){
			vo.setDepartment(department);
			vo.setName(name);
			return userMapper.selectUserListByDeptAndName(vo);
		}else
			return userMapper.selectAllPermittedUser();
		}
		

	@Override
	public List<UserVO> resultToSearchByDeptAndNameNotInProject(Map<String, Object>map) {
		
		UserVO vo = new UserVO();
		
		//LOGGER.info("조건으로 들어온 부서: "+map.get("department"));
		//LOGGER.info("조건으로 들어온 이름: "+map.get("name"));
		//LOGGER.info("조건으로 들어온 프로젝트 번호: "+map.get("project_id"));
		
       return userMapper.resultToSearchByDeptAndNameNotInProject(map);
	}

	
	//형진ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//아이디로 유저 정보 가져오기
	@Override
	public UserVO selectUserInfoById(String id) {
		//LOGGER.info("UserServiceImpl Called updateUserInfo !");
		return userMapper.selectUserInfoById(id);
	}
	
	//가입된 모든 유저 가져오기
	@Override
	public List<UserVO> selectAllPermittedUser() {
		//LOGGER.info("UserServiceImpl Called selectAllPermittedUser !");
		return userMapper.selectAllPermittedUser();
	}
	
	//가입안된 모든 유저 가져오기
	@Override
	public List<UserVO> selectAllUnpermittedUser() {
		//LOGGER.info("UserServiceImpl Called selectAllUnpermittedUser !");
		return userMapper.selectAllUnpermittedUser();
	}
	
	//삭제된 모든 유저 가져오기
	@Override
	public List<UserVO> selectAllDelUser() {
		// TODO Auto-generated method stub
		return userMapper.selectAllDelUser();
	}
	
	//해당 부서의 유저가져오기
	@Override
	public List<UserVO> selectUserByDept(int department) {
		//LOGGER.info("UserServiceImpl Called selectUserByDept !");
		return userMapper.selectUserByDept(department);
	}
	
	//관리자의 유저 정보 수정
	@Override
	public int updateUserInfo(UserVO vo) {
		//LOGGER.info("UserServiceImpl Called updateUserInfo !");
		return userMapper.updateUserInfo(vo);
	}
	
	//승인대기 사용자들의 승인처리
	@Override
	public int updatePermitionSave(List<UserVO> unPermittedUserVOList) {
		//LOGGER.info("UserServiceImpl Called updatePermitionSave !");
		return userMapper.updatePermitionSave(unPermittedUserVOList);
	}
	
	//시스템관리 - 유저이름으로 검색
	@Override
	public List<UserVO> selectUserByName(String name) {
		//LOGGER.info("UserServiceImpl Called selectUserByName !");
		return userMapper.selectUserByName(name);
	}

	@Override
	public List<UserVO> selectAllUserInfoExceptThisProjectMemeber(int project_id) {
		// TODO Auto-generated method stub
        return userMapper.selectAllUserInfoExceptThisProjectMemeber(project_id);
	}

	@Override
	public AuthVO adminAuth(String userid) {
		// TODO Auto-generated method stub
		return userMapper.adminAuth(userid);
	}

	@Override
	public List<UserVO> selectUserListByDeptAndName(UserVO vo) {
		// TODO Auto-generated method stub
		return userMapper.selectUserListByDeptAndName(vo);
	}

	@Override
	public List<UserVO> selectDelectUser() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updatePermitionback(List<UserVO> unPermittedUserVOList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<UserVO> getDeptMemberNotInJob(Map<String,Object>map) {
		// TODO Auto-generated method stub
		return userMapper.getDeptMemberNotInJob(map);
	}

	@Override
	public String getMyDeptNameByCode(String dept) {
		// TODO Auto-generated method stub
		return userMapper.getMyDeptNameByCode(dept);
	}

	@Override
	public List<MemberVO> getProjectMemberNotInJob(Map<String,Object>projectIdAndWeekDate) {
		// TODO Auto-generated method stub
		return userMapper.getProjectMemberNotInJob(projectIdAndWeekDate);
	}

	@Override
	public List<CommonVO> selectCommon(CommonVO vo) {
		// TODO Auto-generated method stub
		return userMapper.selectCommon(vo);
	}

	




}
