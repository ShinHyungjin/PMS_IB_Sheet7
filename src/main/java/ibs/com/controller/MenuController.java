package ibs.com.controller;

import java.security.Principal; 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ibs.com.domain.CriteriaVO;
import ibs.com.domain.MenuAuthorityVO;
import ibs.com.service.JobService;
import ibs.com.service.MenuService;

/**
 * @FileName : MenuController.java
 * @Date : 2021. 8. 24. 
 * @작성자 : 윤주영
 * @설명 : 메뉴 컨트롤러
 */


@Controller
public class MenuController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MenuController.class);
	@Resource(name="jobService")
	private JobService jobService;
	
	@Resource(name="menuService")
	private MenuService menuService;
	
	@PreAuthorize("hasRole('ROLE_MANAGER')")
	@RequestMapping(value="authority/settings",method=RequestMethod.GET)
	public void moveAuthoritySavePage(Principal loginUser,Model model,CriteriaVO cri){
		LOGGER.info("권한 설정 테스트");
		String loginUserId=loginUser.getName();
		model.addAttribute("userid", loginUserId);
		model.addAttribute("beforelastCnt",jobService.beforeMylastCnt(cri));
	    model.addAttribute("inglastCnt",jobService.ingMylastCnt(cri));
	/*	List<HashMap> list=menuService.getGroupAuthByManager(loginUserId);*/
		//System.out.println();
		/*
		List<HashMap> list=menuService.getGroupAuthByManager(loginUserId);
	
		LOGGER.info(loginUserId);
		
		model.addAttribute("list",list);*/
		
		
	}
	
	@RequestMapping(value="authority/save" ,method=RequestMethod.POST)
	public String saveAuthority(Principal loginUser,@RequestParam String[] nickname,@RequestParam int[] authority,@RequestParam String group,Model model){
		LOGGER.info("======================권한 설정 POST 테스트=========================");
		//System.out.println("안넘어오니?");
		List<Integer>menuArr=new ArrayList(); 
		List<Integer>authArr=new ArrayList(); 
		
		//메뉴이름
		for(String test : nickname){
		//	System.out.print("메뉴들 출력: "+test+" ");
			menuArr.add(Integer.parseInt(test));
		}
		//권한
		for(int test1 : authority){
			//System.out.print("메뉴에 대한 권한 출력: "+test1+" ");
			authArr.add(test1);
		}
		//해당 유저 아이디
	//	System.out.println("적용 대상의 그룹: "+ group);
		
			int testGroup=Integer.parseInt(group);
			//System.out.println("그룹 아이디: "+testGroup);
			
		//PM이 자기 그룹에 대한 메뉴 접근권한 설정시==================================================
		//1.선행되는 행동은 저장을 눌렀을때 해당 컨트롤러에 들어와서 해당 로직이 실행된다.
		String loginUserId=loginUser.getName();	
		//2.먼저 이전의 PM,그룹 에 대한 파라미터를 받아서 이전의 권한 DB값이 존재하는지 확인한다.
		//System.out.println("존재하는지 탐색 시작");
		MenuAuthorityVO vo1 = new MenuAuthorityVO();
		vo1.setGroup_id(testGroup);
		vo1.setUser_id(loginUserId);
		
		int list=menuService.getGroupAuthByManager(vo1);

				//3.존재하면 모두 삭제 
				if(list>0){
					MenuAuthorityVO vo = new MenuAuthorityVO();
					vo.setGroup_id(testGroup);
					vo.setUser_id(loginUserId);
					//System.out.println("존재하니깐 삭제작업 시작");
					menuService.deleteGroupAuthByManager(vo);
				}
	
				//4.이후 새롭게 저장되는 정보값들을 다시 Insert 해준다.
				//5.결국 delete-insert 순서의 갱신 로직이다.	
				
					//입력받은 메뉴접근 권한 db에 적용해주는 부분 임시구현(추후 리팩토링 필요)============================
					//System.out.println("존재안한다! 갱싱작업 시작");
					int result = 0;
					MenuAuthorityVO vo = new MenuAuthorityVO();
					for(int i=0; i<4; i++){
						vo.setMenu_id(menuArr.get(i));
						vo.setPermission_check(authArr.get(i));
						vo.setGroup_id(testGroup);
						menuService.insertInfo(vo);
			
											}
						//System.out.println(vo);
				
		
		return "/authority/";
		
		
	}
	
	@RequestMapping(value="/authority/test")
	public void tsttest(){
		
	}
	


	
}
