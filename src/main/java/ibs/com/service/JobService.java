package ibs.com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ibs.com.domain.CriteriaVO;
import ibs.com.domain.JobVO;
import ibs.com.domain.MemberVO;
import ibs.com.domain.ProjectVO;
import ibs.com.domain.UserVO;

public interface JobService {
	// 부모 아이디로 자식 정보 모두 지우기 
	public int removeSubInfoByParentId(int parent);
	//프로젝트 제목으로 프로젝트 아이디 찾기
	public int getMyProjectIdByProjectTitle(ProjectVO vo);
	//주영이 작업내용=================================================================
	public List<HashMap<String,Object>> getMyJobById(String id);
	public List<HashMap<String,Object>> getMyJobByState(String userid,Integer state);
	//내가 진행하는 프로젝트 리스트 가져오기
	public List<JobVO> getAllMyJob(String id);
	// <!--프로젝트의 팀원이 pm으로 된경우 아이디와 프로젝트 아이디를 조회하여 삭제시켜주기 위해서 필요  -->
    public MemberVO getProjectAuthWhenProjectUpDateById(ProjectVO vo);
//<!-- PM이 변경될시 2개의 PM권한이 존재후 이전PM의 권한을 삭제시킨다, -->
    public int deleteBeforePmAuth(ProjectVO vo);
    //팀원이였던 사람이 담당자로 변할경우 새로운권한 2를 추가한다.
    public int changeMyProjectAuth(ProjectVO vo);
	//내가 진행하는 프로젝트 리스트 가져오기
	public List<JobVO> getIngMyJobById(CriteriaVO cri);
		//내가 완료된 프로젝트 리스트 가져오기
	public List<JobVO> getEndMyJobById(CriteriaVO cri);
	//2개월전 완료내용
	public List<JobVO> getEndMyJobByIdBefore2Months(CriteriaVO cri);
	//내가 진행전 프로젝트 리스트 가져오기
	public List<JobVO> getBeforeMyJobById(CriteriaVO cri);
	//중단된 프로젝트 리스트
	public List<JobVO> getStopMyJobById(CriteriaVO cri);
	//내 작업 등록하기
	public int registerMyJobByMySelf(JobVO vo);
	//내 부모 아이디 가져오기
	public Integer selectMyParentIdByJobInfo(JobVO vo);
	//내작업 하위 등록하기
	public int registerMySubJobByMySelf(JobVO vo);
	//job id로 1행 job정보 출력
	public JobVO selectOneMyJobById(int id);
	//부모 아이디로 자식정보 찾기
	public List<JobVO> selectSubJobInfoByParentId(int parent);
    //내작업 상위 수정하기
    public int modifyMyJobByJobId(JobVO vo);
    //내작업 하위 수정하기
    public int modifyMySubJobByJobId(JobVO vo);
    //내작업 삭제
    public int removeMyJobByJobId(int jobId);
    //부모키로 자식있는지 확인하기
    public JobVO checkSubJobByParent(int parent);
    //내작업 진행전-진행중-완료 카운팅
    public int beforeMyJobCntById(CriteriaVO cri);
    public int beforeMylastCnt(CriteriaVO cri);
    public int ingMyJobCntById(CriteriaVO cri);
    public int ingMylastCnt(CriteriaVO cri);
    public int endMyJobCntById(CriteriaVO cri);
    
    public JobVO selectOneMyJob_ById(int id);
   // <!-- 프로젝트 생성시 할당된 담당자 권한을 project_member테이블에 추가 -->
    public int addProjectMemberAuth(MemberVO vo);
	
    //프로젝트 아이디로 프로젝트 정보가져오기
    public ProjectVO getProjectInfoByProjectId(ProjectVO vo);
	//내 프로젝트 정보 수정
	public int modifyProjectInfo(ProjectVO project);
	//프로젝트의 정보가 수정되면 wbs 최상단의 정보가 같은 정보이기 때문에 같이 수정이 되야한다.
	public int updateJobsDateWhenProjectIsChange(ProjectVO project);
	//프로젝트 생성(등록하기)
    public int addNewProject(ProjectVO vo);
    public List<JobVO>getAllWeekReport();
    // 프로젝트가 수정될대 pm이 변경되면 새로운 pm의 권한을 추가한다.
    public int insertPmAuthWhenProjectChanged(ProjectVO project);
    
    //프로젝트 변경시 pm이 변경되면 기존pm의 권한 삭제
    public int deletePmAuthByProjectChanged(ProjectVO project);
    //<!--1.1.프로젝트가 수정될때 담당자 변경시 담당자로 지정될분이 해당 프로젝트의 팀원이였으면 그에대한 권한을 미리 삭제시켜준다. -->
    public int deletePmAuthByProjectChangedByName(ProjectVO project);
    
    //프로젝트 아이디로 job에 등록된 정보들 가져오기
    public List<JobVO> getJobByProjectId(Map<String, Object>map);
    
    
	//형진씨 작업내용===================================================================
    
    //내 부서와 같은 사람들의 주간보고서 가져오기
  	public List<Map> selectWeekReportDept(UserVO user);
  	//내가 참가한 프로젝트 리스트 가져오기
  	public List<Integer> getMyProjectIdList(UserVO user);
    //나와 같은 프로젝트를 진행한 사람들의 주간보고서 가져오기
  	public List<Map> selectWeekReportProject(List<Integer> myProjectIdList);
  	//프로젝트의 WBS 가져오기
  	public List<Map> selectWbs(int project_id);
  	//WBS의 최상위 작업인 프로젝트의 평균 진행률 가져오기
  	public Float selectProjectRealProgress(int project_id);
  	//프로젝트 참여자 가져오기
  	public List<Map> selectProjectMember(int project_id);
  	
  	//WBS 삽입,삭제,갱신을 위해 프로젝트 ID와 ORDER ID로 JOB 가져오기
  	public List<JobVO> selectByOrderProjectId(Map<String, Object> map);
  	//WBS 내용중 STATUS가 'I'인 작업 추가하기
  	public int insertWbsList(List wbsVOInsertList);
  	//WBS 내용중 STATUS가 'D'인 작업 삭제하기
  	public int deleteWbsList(List wbsVODeleteList);
  	//WBS 내용중 STATUS가 'U'인 작업 갱신하기
  	public int updateWbsList(List wbsVOUpdateList);
  	//WBS ID와 일치하는 JOB 가져오기
  	public List<Map> selectJobByWbsId(int wbs_id);
  	//변경된 담당자의 기존에 있던 권한을 삭제해준다.
  	public int deleteTargetUserAuth(ProjectVO vo);
  	
  	//프로젝트 참여인력 추가
  	public int insertMember(List MemberInsertList);
  	//참여인력  STATUS가 'D'인 작업 삭제하기
  	public int deleteMember(List MemberDeleteList);
  	//참여인력  STATUS가 'U'인 작업 갱신하기
  	public int updateMember(List MemberUpdateList);
	List<ProjectVO> getMyJobById2(String id);
	
	List<ProjectVO> getMystate(String userid, int state);
	
	List<ProjectVO> getMystate2(String userid);
  	
}
