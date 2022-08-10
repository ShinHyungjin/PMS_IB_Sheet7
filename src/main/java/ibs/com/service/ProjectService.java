package ibs.com.service;

import java.util.List;
import java.util.Map;

import ibs.com.domain.MemberVO;
import ibs.com.domain.ProjectVO;

public interface ProjectService {
	///주영==================================================================
	//<!-- 프로젝트 참여중이지만 job에 어느 정보도 없는 유저 출력 -->
		public List<MemberVO> getProjectMemberNotInJob(Map<String,Object>map);
		//프로젝트id로 프로젝트 이름 가져오기
		public String getProjectNameByProjectId(int projectId);
	
	//프로젝트 전체 리스트 가져오기
		public List<ProjectVO> selectAllProject(String title);
		public List<ProjectVO> allProject(String team,String project_title);
        //해당 프로젝트에서의 역할 변경하기 ex)팀원->매니저
        public int updateGroupIdByEachProject(MemberVO vo);
        //해당 프로젝트에서 역할 변경시 pm이 다른사람으로 변하면 기존pm은 팀원으로
        public int updateProjectMemberAuth2To4(MemberVO vo);
        //해당 프로젝트에서 참여를 제외시켜라
        public int deleteMemberFromProject(MemberVO vo);
        //프로젝트 멤버로 참여시키기
        public int insertProjectMemberByManager(MemberVO vo);
        //ibsheet  project/user.jsp 에서 참여정보의 pm이 다른사람으로 변경되면 프로젝트 담당자 또한 병경
        public int updateProjectPmByChangedPmAtIbsheet(MemberVO vo);
        //<!-- 진행중인 프로젝트 id 가져오기 -->
        public List<ProjectVO> selectIngProject();
        //<!-- 진행중인 프로젝트의 참여자들 가져오기 -->
        public List<MemberVO> selectIngProjectMember(int id);
        
        
    	///형진==================================================================
        //프로젝트 한 개 가져오기
        public ProjectVO selectByProjectId(int projectId);
		
}
