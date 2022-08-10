package ibs.com.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ibs.com.domain.MemberVO;
import ibs.com.domain.ProjectVO;
import ibs.com.domain.UserVO;
import ibs.com.mapper.ProjectMapper;

@Service("projectService")
public class ProjectServiceImpl implements ProjectService {
///주영==================================================================
	private static final Logger LOGGER = LoggerFactory.getLogger(ProjectServiceImpl.class);
	@Resource(name = "projectMapper")
	private ProjectMapper projectMapper;
	
	@Override
	public List<ProjectVO> selectAllProject(String title) {
		LOGGER.info("ProjectServiceImpl Called selectAllProject !");
		return projectMapper.selectAllProject(title);
	}
	@Override
	public List<ProjectVO> allProject(String team, String project_title) {
		ProjectVO vo = new ProjectVO();
		
		LOGGER.info("조건으로 들어온 team: "+team);
		LOGGER.info("조건으로 들어온 title: "+project_title);
		
	   if(team!=null && team!="" && project_title==null){
			return projectMapper.selectTeam(Integer.parseInt(team));
		}else if(team==null && project_title!=null){
			return projectMapper.selectTitle(project_title);
		}else if(team!=null && team!="" && project_title!=null){
			vo.setTeam(team);
			vo.setProject_title(project_title);
			return projectMapper.selectTeamAndTitle(vo);
		}else
			return projectMapper.selectProject();
		
	}
	
	@Transactional
    @Override
    public int updateGroupIdByEachProject(MemberVO vo) {
        // TODO Auto-generated method stub
        return projectMapper.updateGroupIdByEachProject(vo);
    }

	@Transactional
    @Override
    public int deleteMemberFromProject(MemberVO vo) {
        // TODO Auto-generated method stub
        return projectMapper.deleteMemberFromProject(vo);
    }
	
	@Transactional
	@Override
	public int insertProjectMemberByManager(MemberVO vo) {
		// TODO Auto-generated method stub
		return projectMapper.insertProjectMemberByManager(vo);
	}
	
	@Transactional
	@Override
	public int updateProjectMemberAuth2To4(MemberVO vo) {
		// TODO Auto-generated method stub
		return projectMapper.updateProjectMemberAuth2To4(vo);
	}
	
	@Transactional
	@Override
	public int updateProjectPmByChangedPmAtIbsheet(MemberVO vo) {
		// TODO Auto-generated method stub
		return projectMapper.updateProjectPmByChangedPmAtIbsheet(vo);
	}
	@Override
	public ProjectVO selectByProjectId(int projectId) {
		LOGGER.info("ProjectServiceImpl Called selectByProjectId !");
		return projectMapper.selectByProjectId(projectId);
	}
	@Override
	public List<ProjectVO> selectIngProject() {
		// TODO Auto-generated method stub
		return projectMapper.selectIngProject();
	}
	@Override
	public List<MemberVO> selectIngProjectMember(int id) {
		// TODO Auto-generated method stub
		return projectMapper.selectIngProjectMember(id);
	}
	@Override
	public String getProjectNameByProjectId(int projectId) {
		// TODO Auto-generated method stub
		return projectMapper.getProjectNameByProjectId(projectId);
	}
	@Override
	public List<MemberVO> getProjectMemberNotInJob(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return projectMapper.getProjectMemberNotInJob(map);
	}

}
