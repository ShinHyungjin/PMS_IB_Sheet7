package ibs.com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ibs.com.domain.AuthVO;
import ibs.com.domain.CommonVO;
import ibs.com.domain.MemberVO;
import ibs.com.domain.UserVO;

public interface UserService {
	
	//슬희ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	 //회원가입
	 public void join(UserVO vo);

	 //아이디 중복체크
	 public int idChk(UserVO vo);
	 
	 //개인정보 수정
	 public int modify(UserVO vo) throws Exception;	 
	 
	 //가지고있는 권한 확인
	 public AuthVO adminAuth(String userid);
	 //내가 참여중인 프로젝트의 id로 검색하여 job에 등록되지 않는 나의 프로젝트 멤버들 출력하기
	 public List<MemberVO> getProjectMemberNotInJob(Map<String,Object>projectIdAndWeekDate);
	 
	 
	public int permitionDelectSubmit(List<UserVO> allUserVOList);

	public int updatePermitionback(List<UserVO> unPermittedUserVOList);

	public int permitionRollbackSubmit(List<UserVO> allUserVOList);
	
	public int resetPassword(List<UserVO> allUserVOList);

	
	public List<UserVO> selectAllDelUser();
    
	
	 
	//주영ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	
	public List<UserVO> selectAllUserInfoExceptThisProjectMemeberByDepartment(HashMap<String, Object> map);
	//유저정보 가져오기
	public UserVO selectUserInfo(UserVO vo);
	//시큐리티 로그인
	public UserVO selectUserById(String id);
	//유저 이름 가져오기
	public UserVO selectUserName(String id);
	//부서코드로 부서이름 가져오기
	public String getMyDeptNameByCode(String dept);
	//유저 이름으로 아이디 가져오기
	public String selectUserIdByName(String name);
	//아이디로 유저정보 가져오기
	//모든 유저정보 가져오기
	public List<UserVO> selectAllUserInfo();
	//(부서,이름,부서+이름)으로 출력할 유저 리스트 판단하기
	public List<UserVO> resultToSearchUserList(String department, String name);
	//부서+이름 으로 유저 리스트
	public List<UserVO> selectUserListByDeptAndName(UserVO vo);
	//(부서,이름,부서+이름)으로 해당 프로젝트에 참여하지 않는 유저 리스트 판단
	public List<UserVO> resultToSearchByDeptAndNameNotInProject(Map<String,Object>map);
	//job테이블에 어느 정보도 등록되지있지 않는 나의 부서 사람들 출력하기
	public List<UserVO> getDeptMemberNotInJob(Map<String,Object>map);
	
	
	//형진ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//아이디로 유저정보 가져오기
	public UserVO selectUserInfoById(String id);
	//가입된 모든 유저 가져오기
	public List<UserVO> selectAllPermittedUser();
	//가입안된 모든 유저 가져오기
	public List<UserVO> selectAllUnpermittedUser();
	
	//가입안된 모든 유저 가져오기
	public List<UserVO> selectDelectUser();
		
	//해당 부서의 유저가져오기
	public List<UserVO> selectUserByDept(int department);
	//관리자의 유저 정보 수정
	public int updateUserInfo(UserVO vo);
	//승인대기 사용자들의 승인처리
	public int updatePermitionSave(List<UserVO> unPermittedUserVOList);
	//시스템관리 - 유저이름으로 검색
	public List<UserVO> selectUserByName(String name);
    //해당 프로젝트에 참여하지 않는 인원들 가져오기
    public List<UserVO> selectAllUserInfoExceptThisProjectMemeber(int project_id);

	public List<CommonVO> selectCommon(CommonVO vo);





	
}
