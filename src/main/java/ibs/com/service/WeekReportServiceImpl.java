package ibs.com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ibs.com.domain.JobVO;
import ibs.com.domain.UserVO;
import ibs.com.domain.WeekReportVO;
import ibs.com.mapper.JobMapper;
import ibs.com.mapper.WeekReportMapper;
import lombok.AllArgsConstructor;

@Service("weekReportService")
@AllArgsConstructor
public class WeekReportServiceImpl implements WeekReportService{

	private static final Logger logger = LoggerFactory.getLogger(WeekReportServiceImpl.class);
	
	@Resource(name = "weekReportMapper")
	private WeekReportMapper weekReportMapper;

	@Override
	// 내 부서와 같은 사람들의 주간보고서 가져오기
	public List<Map> selectWeekReportDept(UserVO user) {
		logger.info("JobServiceImpl : Called selectWeekReportDept Job List!");
		return weekReportMapper.selectWeekReportDept(user);
	}
	
	//내가 참가한 프로젝트 리스트 가져오기
	@Override
	public List<Integer> getMyProjectIdList(UserVO user) {
		logger.info("JobServiceImpl : Called getMyProjectIdList Job List!");
		return weekReportMapper.getMyProjectIdList(user);
	}
	
	// 나와 같은 프로젝트를 진행한 사람들의 주간보고서 가져오기 
	@Override
	public List<Map> selectWeekReportProject(List<Integer> myProjectIdList) {
		logger.info("JobServiceImpl : Called selectWeekReportProject Job List!");
		return weekReportMapper.selectWeekReportProject(myProjectIdList);
	}

	@Override
	public List<JobVO> getAllWeekReport(Map<String,Object> thisMon_NextSat) {
		// TODO Auto-generated method stub
		return weekReportMapper.getAllWeekReport(thisMon_NextSat);
	}

	@Override
	public int insertJobToWeekReport(JobVO vo) {
		// TODO Auto-generated method stub
		return weekReportMapper.insertJobToWeekReport(vo);
	}

	@Override
	public List<JobVO> getAllWeekReport1() {
		// TODO Auto-generated method stub
		return weekReportMapper.getAllWeekReport1();
	}

	@Override
	public List<Map> selectWeekReportProject(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return weekReportMapper.selectWeekReportProject(map);
	}

	@Override
	public List<Map> selectNowWeekReportTempDept(UserVO user) {
		// TODO Auto-generated method stub
		return weekReportMapper.selectNowWeekReportTempDept(user);
	}

	@Override
	public int deleteAllForRealTimeWeekReport() {
		logger.info("실시간 삭제 배치작업 시작!!!===========================================");
		return weekReportMapper.deleteAllForRealTimeWeekReport();
	}

	@Override
	public int insertJobToWeekReportTemp(JobVO vo) {
		// TODO Auto-generated method stub
		return weekReportMapper.insertJobToWeekReportTemp(vo);
	}

	@Override
	public List<Map> selectNowWeekReportProject(UserVO user) {
		// TODO Auto-generated method stub
		return weekReportMapper.selectNowWeekReportProject(user);
	}

	@Override
	public int insertEmptyMembersJobAtWeekReportTemp(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return weekReportMapper.insertEmptyMembersJobAtWeekReportTemp(map);
	}

	@Override
	public int insertEmptyMembersJobAtWeekReport(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return weekReportMapper.insertEmptyMembersJobAtWeekReport(map);
	}

	@Override
	public List<Map> selectNowWeekReportTempProject(UserVO user) {
		// TODO Auto-generated method stub
		return weekReportMapper.selectNowWeekReportTempProject(user);
	}

	@Override
	public List<Map> selectWeekReportDeptAndDate(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return weekReportMapper.selectWeekReportDeptAndDate(map);
	}

	@Override
	public List<JobVO> getMyDeptWeekReportAtJob(Map<String,Object> conditionOfMyDeptWeekReport) {
		// TODO Auto-generated method stub
		return weekReportMapper.getMyDeptWeekReportAtJob(conditionOfMyDeptWeekReport);
	}


}
