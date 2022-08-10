package ibs.com.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ibs.com.domain.AuthVO;
import ibs.com.domain.CriteriaVO;
import ibs.com.domain.UserVO;
import ibs.com.service.JobService;
import ibs.com.service.UserService;

/**
 * @FileName : AdminController.java
 * @Date : 2021. 8. 24.
 * @작성자 : 류슬희, 신형진
 * @설명 : 시스템관리 컨트롤러
 */

@Controller
@RequestMapping("admin")
public class AdminController {
	private static final Logger LOGGER = LoggerFactory.getLogger(AdminController.class);

	@Resource(name = "userService")
	private UserService userService;
	@Resource(name="jobService")
	private JobService jobService;

	// 슬희 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 시스템 관리-사용자관리를 누르자 마자 또는 사용자관리에서 '승인 대기' 탭을 눌렀을 때 동작한다
	@RequestMapping(value = "/check")
	public void check(Principal loginUser,Model model,String title, CriteriaVO cri) {
		LOGGER.info("시스템관리 - 사용자 관리_승인대기 호출");
		List<UserVO> userVOList = userService.selectAllUnpermittedUser();
		String User=loginUser.getName();
        if(User==null){
            User="";
        }
        cri.setUserid(User);
        cri.setProject_title(title);
		
		model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
	    for (UserVO vo : userVOList) {
			LOGGER.info("userVOList : " + vo);
		}
		model.addAttribute("userVOList", userVOList);
	}

	// 시스템 관리-사용자관리를 누르자 마자 또는 사용자관리에서 '승인 대기' 탭을 눌렀을 때 동작한다
	@RequestMapping(value = "/permitionSave", method=RequestMethod.POST)
	@ResponseBody
	public String permitionSave(Model model, @RequestParam(value="userIdList[]") List<String> userIdList) {
		LOGGER.info("시스템관리 - 사용자 관리_승인저장 호출");
		
		List<UserVO> unPermittedUserVOList = new ArrayList<UserVO>();
		
		for(String userId : userIdList) {
			LOGGER.info("userId : " + userId);
			
			UserVO vo = new UserVO();
			vo.setId(userId);
			
			unPermittedUserVOList.add(vo);
		}
		
		int result = userService.updatePermitionSave(unPermittedUserVOList);
		String msg = "";
		if (result != 0) {
			LOGGER.info("승인 처리 완료");
			msg = "승인 처리 완료";
		} else {
			LOGGER.info("승인 처리 실패");
			msg = "승인 처리 실패";
		}
		
		List<UserVO> userVOList = userService.selectAllUnpermittedUser();
		model.addAttribute("userVOList", userVOList);
		
		return "{\"msg\" : "+msg+"}";		
	}
	
	
	@RequestMapping(value = "/del")
	public void del(Principal loginUser,Model model,String title,CriteriaVO cri) {
		LOGGER.info("시스템관리 - 사용자 관리_승인대기 호출");
		List<UserVO> userVOList = userService.selectAllDelUser();
		String User=loginUser.getName();
        if(User==null){
            User="";
        }
        cri.setUserid(User);
        cri.setProject_title(title);
		for (UserVO vo : userVOList) {
			LOGGER.info("userVOList : " + vo);
		}
		model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
		model.addAttribute("userVOList", userVOList);
	}
	
		@RequestMapping(value = "/resetSubmit", method=RequestMethod.POST)
		@ResponseBody
		public String resetSubmit(Model model, @RequestParam(value="userIdList[]") List<String> userIdList) {
			LOGGER.info("시스템관리 - 사용자 관리_비밀번호 초기화 호출");
			List<UserVO> resetUserVOList = new ArrayList<UserVO>();
			
			for(String userId : userIdList) {
				LOGGER.info("userId : " + userId);
				
				UserVO vo = new UserVO();
				vo.setId(userId);
				
				resetUserVOList.add(vo);
			}
			
			int result = userService.resetPassword(resetUserVOList);
			String msg = "";
			if (result != 0) {
				LOGGER.info("초기화 완료");
				msg = "초기화 처리 완료";
			} else {
				LOGGER.info("초기화 처리 실패");
				msg = "초기화 처리 실패";
			}
			
			List<UserVO> userVOList = userService.selectAllDelUser();
			model.addAttribute("userVOList", userVOList);
			
			return "{\"msg\" : "+msg+"}";	
			
		}

	
	@RequestMapping(value = "/Rollback", method=RequestMethod.POST)
	@ResponseBody
	public String Rollback(Model model, @RequestParam(value="userIdList[]") List<String> userIdList) {
		LOGGER.info("시스템관리 - 사용자 관리_복구저장 호출");
		
		List<UserVO> delUserVOList = new ArrayList<UserVO>();
		
		for(String userId : userIdList) {
			LOGGER.info("userId : " + userId);
			
			UserVO vo = new UserVO();
			vo.setId(userId);
			
			delUserVOList.add(vo);
		}
		
		int result = userService.permitionRollbackSubmit(delUserVOList);
		String msg = "";
		if (result != 0) {
			LOGGER.info("복구 처리 완료");
			msg = "복구 처리 완료";
		} else {
			LOGGER.info("삭제 처리 실패");
			msg = "복구 처리 실패";
		}
		
		List<UserVO> userVOList = userService.selectAllDelUser();
		model.addAttribute("userVOList", userVOList);
		
		return "{\"msg\" : "+msg+"}";		
	}
	
	// 시스템 관리-사용자관리 삭제
		@RequestMapping(value = "/permitionDelect", method=RequestMethod.POST)
		@ResponseBody
		public String permitionDelect(Model model, @RequestParam(value="userIdList[]") List<String> userIdList) {
			
			List<UserVO> allUserVOList = new ArrayList<UserVO>();
			
			for(String userId : userIdList) {
				LOGGER.info("userId : " + userId);
				
				UserVO vo = new UserVO();
				vo.setId(userId);
				
				allUserVOList.add(vo);
			}
			
			int result = userService.permitionDelectSubmit(allUserVOList);
			String msg = "";
			if (result != 0) {
				LOGGER.info("삭제 처리 완료");
				msg = "삭제 처리 완료";
			} else {
				LOGGER.info("삭제 처리 실패");
				msg = "삭제 처리 실패";
			}
			
			List<UserVO> userVOList = userService.selectAllPermittedUser();
			model.addAttribute("userVOList", userVOList);
			
			return "{\"msg\" : "+msg+"}";		
		}

	// 형진ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	// 시스템관리-사용자관리 화면 진입시 동작하는 부분으로, '회원 목록' 버튼 클릭 시 동작한다


	// user.jsp에서 넘겨받은 정보들로 vo를 만들고, 이를 update 한다
	@RequestMapping(value = "/userUpdate", method = RequestMethod.POST)
	@ResponseBody
	public String userUpdate(Model model, String id, String rank, String department, String authority) {
		LOGGER.info("시스템관리 - 사용자 정보 수정 후 userUpdate 호출");
		LOGGER.info("id : " + id + "\trank : " + rank + "\tdepartment : " + department + "\tauthority : " + authority);
		List<AuthVO> authList = new ArrayList<AuthVO>();

		AuthVO authVO = new AuthVO();
		authVO.setId(id);
		authVO.setAuthority(authority);

		authList.add(authVO);

		UserVO userVO = new UserVO();
		userVO.setId(id);
		userVO.setRank(rank);
		userVO.setDepartment(department);
		userVO.setAuthList(authList);

		LOGGER.info("UserVO : " + userVO.toString());
		LOGGER.info("userVO.AuthList : " + userVO.getAuthList().get(0).toString());

		int result = userService.updateUserInfo(userVO);
		if (result != 0) {
			LOGGER.info("유저 정보 수정완료");
			return "{msg : 성공}";
		} else {
			LOGGER.info("유저 정보 수정실패");
			return "{msg : 실패}";
		}
	}
	//=====주영 ==> 검색 및 조회
	@RequestMapping(value = "/user")
	public void user(Principal loginUser,Model model,String title, String department,String name,CriteriaVO cri)throws Exception {
		LOGGER.info("시스템관리 - 사용자 관리_회원목록 호출");
		String User=loginUser.getName();
        if(User==null){
            User="";
        }
			//System.out.println("부서 검색조건:  "+department);
			model.addAttribute("department", department);
			//System.out.println("department" + department);
			//System.out.println("이름 검색조건:  "+name);
	
			List<UserVO> userVOList = 	userService.resultToSearchUserList(department, name);
	
		for (UserVO vo : userVOList) {
			LOGGER.info("userVOList : " + vo);
		}
		cri.setUserid(User);
        cri.setProject_title(title);
		model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
		model.addAttribute("userVOList", userVOList);
		//System.out.println("userVOList : " + userVOList);
	}
}