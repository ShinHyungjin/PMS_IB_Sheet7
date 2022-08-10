package ibs.com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ibs.com.domain.JobVO;
import ibs.com.domain.UserVO;
import ibs.com.domain.WeekReportVO;

public interface WeekReportService {
	
	//내 부서와 같은 사람들의 주간보고서 가져오기
	public List<Map> selectWeekReportDept(UserVO user);

	//내가 참가한 프로젝트 리스트 가져오기
	public List<Integer> getMyProjectIdList(UserVO user);
	//내 부서와 같은 사람들의 과거 주간 보고서 가져오기
	public List<Map> selectWeekReportDeptAndDate(HashMap<String, Object>map);
	public List<Map> selectWeekReportProject(Map<String,Object>map);
	public List<Map> selectNowWeekReportTempDept(UserVO user);
	public List<Map> selectNowWeekReportTempProject(UserVO user);
	//나와 같은 프로젝트를 진행한 사람들의 주간보고서 가져오기
	public List<Map> selectWeekReportProject(List<Integer> myProjectIdList);
	public List<JobVO>getAllWeekReport(Map<String,Object> thisMon_NextSat);
	public List<JobVO>getAllWeekReport1();
	//<!-- 나랑 같은 부서원의 주간보고서 뽑기 -->
	public List<JobVO>getMyDeptWeekReportAtJob(Map<String,Object> conditionOfMyDeptWeekReport);
	
	public int insertJobToWeekReport(JobVO vo);
	//전체 실시간 주간보고서를 날린다.
	public int deleteAllForRealTimeWeekReport();
	//1시간 주간보고서
	public int insertJobToWeekReportTemp(JobVO vo);
	public List<Map> selectNowWeekReportProject(UserVO user);
	//<!-- 팀원이지만 작업이 없는 사람들은 강제로 널값을 집어넣는다-->
	public int insertEmptyMembersJobAtWeekReportTemp(HashMap<String, Object> map);
	public int insertEmptyMembersJobAtWeekReport(HashMap<String, Object> map);
}
