package ibs.com.service;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.stringtemplate.v4.compiler.CodeGenerator.primary_return;

import ibs.com.domain.CriteriaVO;
import ibs.com.domain.JobVO;
import ibs.com.domain.MemberVO;
import ibs.com.domain.ProjectVO;
import ibs.com.domain.UserVO;
import ibs.com.mapper.JobMapper;
import ibs.com.mapper.ProjectMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.quartz.Job;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service("jobService")
public class JobServiceImpl implements JobService {

	private static final Logger logger = LoggerFactory.getLogger(JobServiceImpl.class);
	@Resource(name = "jobMapper")
	private JobMapper jobMapper;

	
	@Override
	public List<ProjectVO> getMystate(String userid, int state) {
		ProjectVO vo = new ProjectVO();
		
	    if(state == 0){ //진행중 진행전...
	    	//System.out.println("state 0 : " + state);
	    	return jobMapper.getMyJobById2(userid);
		}else //
	        if(userid==null){
	           userid="";
	        }
			vo.setName(userid);
			vo.setState(state);
			//System.out.println("찐 유저 아이디 : " + userid);
	    	//System.out.println("찐 state : " + state);
			return jobMapper.getMystate(userid, state);
	}
	
	@Override
	public List<ProjectVO> getMystate2(String userid) {
		return jobMapper.getMystate2(userid);
	}
	
	
	// 주영이 작업내용===================================================================\
	@Override
	public int getMyProjectIdByProjectTitle(ProjectVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.getMyProjectIdByProjectTitle(vo);
	}

	
	@Override
	public List<HashMap<String, Object>> getMyJobById(String id) {
		// TODO Auto-generated method stub
		return jobMapper.getMyJobById(id);
	}
	
	@Override
	public List<HashMap<String, Object>> getMyJobByState(String userid, Integer state) {
		// TODO Auto-generated method stub
		return jobMapper.getMyJobByState(userid, state);
	}
	
	@Override
	public List<ProjectVO> getMyJobById2(String id) {
		// TODO Auto-generated method stub
		return jobMapper.getMyJobById2(id);
	}
	

	


	@Override
	public List<JobVO> getAllMyJob(String id) {
		// TODO Auto-generated method stub
		return jobMapper.getAllMyJob(id);
	}

	@Override
	public List<JobVO> getIngMyJobById(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.getIngMyJobById(cri);
	}

	@Override
	public List<JobVO> getEndMyJobById(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.getEndMyJobById(cri);
	}

	@Override
	public List<JobVO> getBeforeMyJobById(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.getBeforeMyJobById(cri);
	}

	//내작업 등록하기
	@Transactional
	@Override
	public int registerMyJobByMySelf(JobVO vo) {
		logger.debug(vo.toString());
		JobVO newVO = new JobVO();
        newVO.setName(vo.getName());
        newVO.setProject_id(vo.getProject_id());
        newVO.setStart_date(vo.getStart_date());
        newVO.setEnd_date(vo.getEnd_date());
        newVO.setReal_start_date(vo.getStart_date());
        newVO.setReal_end_date(vo.getEnd_date());
        newVO.setManager(vo.getManager());
        newVO.setWork_type(vo.getWork_type());
        newVO.setContents(vo.getContents());
        newVO.setWork_detail_type(vo.getWork_detail_type());
        newVO.setWork_division(vo.getWork_division());
        newVO.setPrivacy_state(vo.getPrivacy_state());
        newVO.setWeek(vo.getWeek());   
        newVO.setReal_progress(vo.getReal_progress()/100);
        newVO.setComment(vo.getComment());
        
		return jobMapper.registerMyJobByMySelf(newVO);
	}
	
	@Transactional
	@Override
	public int deleteTargetUserAuth(ProjectVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.deleteTargetUserAuth(vo);
	}



	@Override
	public Integer selectMyParentIdByJobInfo(JobVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.selectMyParentIdByJobInfo(vo);
	}

	@Override
	public int registerMySubJobByMySelf(JobVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.registerMySubJobByMySelf(vo);
	}

	@Override
	// job id로 1행 job정보 출력
	public JobVO selectOneMyJobById(int id) {
		return jobMapper.selectOneMyJobById(id);
	}

	@Override
	public List<JobVO> selectSubJobInfoByParentId(int parent) {
		// TODO Auto-generated method stub
		return jobMapper.selectSubJobInfoByParentId(parent);
	}

	@Override
	public int modifyMyJobByJobId(JobVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.modifyMyJobByJobId(vo);
	}

	@Override
	public int modifyMySubJobByJobId(JobVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.modifyMySubJobByJobId(vo);
	}

	//상위작업 삭제 진행
	@Override
	public int removeMyJobByJobId(int jobId) {
		// TODO Auto-generated method stub
		return jobMapper.removeMyJobByJobId(jobId);
	}

	@Override
	public JobVO checkSubJobByParent(int parent) {
		// TODO Auto-generated method stub
		return jobMapper.checkSubJobByParent(parent);
	}
	

	@Override
	public int beforeMyJobCntById(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.beforeMyJobCntById(cri);
	}
	
	@Override
	public int beforeMylastCnt(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.beforeMylastCnt(cri);
	}
	
	@Override
	public int ingMylastCnt(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.ingMylastCnt(cri);
	}

	@Override
	public int ingMyJobCntById(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.ingMyJobCntById(cri);
	}

	@Override
	public int endMyJobCntById(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.endMyJobCntById(cri);
	}
	
	@Override
	public ProjectVO getProjectInfoByProjectId(ProjectVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.getProjectInfoByProjectId(vo);
	}
	
	//내작업 수정
	@Transactional
	@Override
	public int modifyProjectInfo(ProjectVO project) {
		return jobMapper.modifyProjectInfo(project);
	}
	
	@Override
	public JobVO selectOneMyJob_ById(int id) {
		// TODO Auto-generated method stub
		return jobMapper.selectOneMyJob_ById(id);
	}

	
	//상위작업 삭제시 모든 하위작업 삭제
	@Transactional
	@Override
	public int removeSubInfoByParentId(int parent) {
		// TODO Auto-generated method stub
		return jobMapper.removeSubInfoByParentId(parent);
	}
	@Override
	public int addNewProject(ProjectVO vo) {
		
		return jobMapper.addNewProject(vo);
	}

	@Override
	public List<JobVO> getEndMyJobByIdBefore2Months(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.getEndMyJobByIdBefore2Months(cri);
	}


	@Override
	public List<JobVO> getAllWeekReport() {
		// TODO Auto-generated method stub
		return jobMapper.getAllWeekReport();
	}


	@Transactional
	@Override
	public int insertPmAuthWhenProjectChanged(ProjectVO project) {
		// TODO Auto-generated method stub
		return jobMapper.insertPmAuthWhenProjectChanged(project);
	}

	@Transactional
	@Override
	public int deletePmAuthByProjectChanged(ProjectVO project) {
		// TODO Auto-generated method stub
		return jobMapper.deletePmAuthByProjectChanged(project);
	}


	// 형진씨 작업내용===================================================================
	
	@Override
	// 내 부서와 같은 사람들의 주간보고서 가져오기
	public List<Map> selectWeekReportDept(UserVO user) {
		logger.info("JobServiceImpl : Called selectWeekReportDept Job List!");
		return jobMapper.selectWeekReportDept(user);
	}
	
	//내가 참가한 프로젝트 리스트 가져오기
	@Override
	public List<Integer> getMyProjectIdList(UserVO user) {
		logger.info("JobServiceImpl : Called getMyProjectIdList Job List!");
		return jobMapper.getMyProjectIdList(user);
	}
	
	// 나와 같은 프로젝트를 진행한 사람들의 주간보고서 가져오기 
	@Override
	public List<Map> selectWeekReportProject(List<Integer> myProjectIdList) {
		logger.info("JobServiceImpl : Called selectWeekReportProject Job List!");
		return jobMapper.selectWeekReportProject(myProjectIdList);
	}

	@Override
	// 프로젝트의 WBS 가져오기
	public List<Map> selectWbs(int project_id) {
		logger.info("JobServiceImpl : Called selectWbs Job List!");
		return jobMapper.selectWbs(project_id);
	}
	
	@Override
	//WBS의 최상위 작업인 프로젝트의 평균 진행률 가져오기
	public Float selectProjectRealProgress(int project_id) {
		logger.info("JobServiceImpl : Called selectProjectRealProgress Job List!");
		return jobMapper.selectProjectRealProgress(project_id);
		}
	
	@Override
	//프로젝트 참여자 가져오기
	public List<Map> selectProjectMember(int project_id) {
		logger.info("JobServiceImpl : Called selectProjectMember Job List!");
		return jobMapper.selectProjectMember(project_id);
	}

	@Override
	//WBS 삽입,삭제,갱신을 위해 프로젝트 ID와 ORDER ID로 JOB 가져오기
	public List<JobVO> selectByOrderProjectId(Map<String, Object> map) {
		logger.info("JobServiceImpl : Called selectByOrderProjectId Job List!");
		return jobMapper.selectByOrderProjectId(map);
	}

	@Override
	//WBS 내용중 STATUS가 'I'인 작업 추가하기
	public int insertWbsList(List wbsVOInsertList) {
		logger.info("JobServiceImpl : Called insertWbsList Job List!");
		return jobMapper.insertWbsList(wbsVOInsertList);
	}

	@Override
	//WBS 내용중 STATUS가 'D'인 작업 삭제하기
	public int deleteWbsList(List wbsVODeleteList) {
		logger.info("JobServiceImpl : Called deleteWbsList Job List!");
		return jobMapper.deleteWbsList(wbsVODeleteList);
	}

	@Override
	//WBS 내용중 STATUS가 'U'인 작업 갱신하기
	public int updateWbsList(List wbsVOUpdateList) {
		logger.info("JobServiceImpl : Called updateWbsList Job List!");
		return jobMapper.updateWbsList(wbsVOUpdateList);
	}


	@Override
	public int insertMember(List MemberInsertList) {
		return 0;
	}


	@Override
	public int deleteMember(List MemberDeleteList) {
		// TODO Auto-generated method stub
		return jobMapper.deleteMember(MemberDeleteList);
	}


	@Override
	public int updateMember(List MemberUpdateList) {
		return jobMapper.updateMember(MemberUpdateList);
	}


	@Override
	public int updateJobsDateWhenProjectIsChange(ProjectVO project) {
		// TODO Auto-generated method stub
		return jobMapper.updateJobsDateWhenProjectIsChange(project);
	}
	
	@Override
	public List<Map> selectJobByWbsId(int wbs_id) {
		logger.info("JobServiceImpl : Called selectJobByWbsId Job List!");
		return jobMapper.selectJobByWbsId(wbs_id);
	}
	

	@Override
	public int deletePmAuthByProjectChangedByName(ProjectVO project) {
		// TODO Auto-generated method stub
		return jobMapper.deletePmAuthByProjectChangedByName(project);
	}


	@Override
	public MemberVO getProjectAuthWhenProjectUpDateById(ProjectVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.getProjectAuthWhenProjectUpDateById(vo);
	}


	@Override
	public int deleteBeforePmAuth(ProjectVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.deleteBeforePmAuth(vo);
	}


	@Override
	public int changeMyProjectAuth(ProjectVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.changeMyProjectAuth(vo);
	}


	@Override
	public int addProjectMemberAuth(MemberVO vo) {
		// TODO Auto-generated method stub
		return jobMapper.addProjectMemberAuth(vo);
	}


	@Override
	public List<JobVO> getStopMyJobById(CriteriaVO cri) {
		// TODO Auto-generated method stub
		return jobMapper.getStopMyJobById(cri);
	}


	@Override
	public List<JobVO> getJobByProjectId(Map<String, Object>map) {
		// TODO Auto-generated method stub
		return jobMapper.getJobByProjectId(map);
	}


}
