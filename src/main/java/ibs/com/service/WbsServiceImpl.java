package ibs.com.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import ibs.com.controller.MenuController;
import ibs.com.controller.ProjectController;
import ibs.com.domain.MenuAuthorityVO;
import ibs.com.domain.WbsVO;
import ibs.com.mapper.MenuMapper;
import ibs.com.mapper.WbsMapper;

@Service("wbsService")
public class WbsServiceImpl implements WbsService {

	@Resource(name="wbsMapper")
	private WbsMapper mapper;
	private static final Logger LOGGER = LoggerFactory.getLogger(WbsServiceImpl.class);
	
	
	// 프로젝트 ID로 WBS 조회하기
	@Override
	public List<Map> selectByProjectId(int projectId) {
		LOGGER.info("WbsServiceImpl Called selectByProjectId!");
		return mapper.selectByProjectId(projectId);
	}

	// WBS 내용중 STATUS가 'I'인 작업 추가하기
	@Override
	public int insertWbsList(List wbsVOInsertList) {
		LOGGER.info("WbsServiceImpl Called insertWbsList!");
		return mapper.insertWbsList(wbsVOInsertList);
	}

	// WBS 내용중 STATUS가 'D'인 작업 삭제하기
	@Override
	public int deleteWbsList(List wbsVODeleteList) {
		LOGGER.info("WbsServiceImpl Called deleteWbsList!");
		return mapper.deleteWbsList(wbsVODeleteList);
	}

	// WBS 내용중 STATUS가 'U'인 작업 갱신하기
	@Override
	public int updateWbsList(List wbsVOUpdateList) {
		LOGGER.info("WbsServiceImpl Called updateWbsList!");
		return mapper.updateWbsList(wbsVOUpdateList);
	}
	
	// WBS의 마지막 ID 가져오기
	@Override
	public int selectWbsLastId() {
		LOGGER.info("WbsServiceImpl Called selectWbsLastId!");
		return mapper.selectWbsLastId();
	}
	
	// WBS ID와 일치하는 JOB 가져오기
	@Override
	public List<Map> selectJobByWbsId(int wbsId) {
		LOGGER.info("WbsServiceImpl Called selectJobByWbsId!");
		return mapper.selectJobByWbsId(wbsId);
	}

	// WBS 내용중 STATUS가 'I'인 작업의 담당자 추가하기
	@Override
	public int insertJobList(List jobVOInsertList) {
		LOGGER.info("WbsServiceImpl Called insertJobList!");
		return mapper.insertJobList(jobVOInsertList);
	}

	// WBS 내용중 STATUS가 'D'인 작업의 담당자 삭제하기
	@Override
	public int deleteJobList(List jobVODeleteList) {
		LOGGER.info("WbsServiceImpl Called deleteJobList!");
		return mapper.deleteJobList(jobVODeleteList);
	}

	// WBS 내용중 STATUS가 'U'인 작업의 담당자 갱신하기
	@Override
	public int updateJobList(List jobVOUpdateList) {
		LOGGER.info("WbsServiceImpl Called updateJobList!");
		return mapper.updateJobList(jobVOUpdateList);
	}
	
}
