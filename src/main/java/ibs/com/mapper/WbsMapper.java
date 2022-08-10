package ibs.com.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import ibs.com.domain.MemberVO;
import ibs.com.domain.ProjectVO;
import ibs.com.domain.WbsVO;

@Mapper("wbsMapper")
public interface WbsMapper {

	//===============================================
	/* WBS CRUD */

	// 프로젝트 ID로 WBS 조회하기
	public List<Map> selectByProjectId(int projectId);

	// WBS 내용중 STATUS가 'I'인 작업 추가하기
	public int insertWbsList(List wbsVOInsertList);

	// WBS 내용중 STATUS가 'D'인 작업 삭제하기
	public int deleteWbsList(List wbsVODeleteList);

	// WBS 내용중 STATUS가 'U'인 작업 갱신하기
	public int updateWbsList(List wbsVOUpdateList);
	
	// WBS의 마지막 ID 가져오기
	public int selectWbsLastId();
	
	//===============================================
	/* JOB CRUD */
	// WBS ID와 일치하는 JOB 가져오기
	public List<Map> selectJobByWbsId(int wbsId);
	
	// WBS 내용중 STATUS가 'I'인 작업의 담당자 추가하기
	public int insertJobList(List jobVOInsertList);

	// WBS 내용중 STATUS가 'D'인 작업의 담당자 삭제하기
	public int deleteJobList(List jobVODeleteList);

	// WBS 내용중 STATUS가 'U'인 작업의 담당자 갱신하기
	public int updateJobList(List jobVOUpdateList);

}
