package ibs.com.mapper;

import ibs.com.domain.AuthVO;


public interface UserAuthMapper {
	
	//슬희ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public void Auth(AuthVO auth);
	
	//가입 승인
	public int check(AuthVO authVo);
}
