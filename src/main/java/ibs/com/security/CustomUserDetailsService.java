package ibs.com.security;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import ibs.com.domain.SecurityVO;
import ibs.com.domain.UserVO;
import ibs.com.mapper.UserMapper;

public class CustomUserDetailsService implements UserDetailsService {

	private static final Logger LOGGER = LoggerFactory.getLogger(CustomUserDetailsService.class);

	@Resource(name = "userMapper")
	private UserMapper userMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		/*
		// 최종적으로 리턴해야할 객체
		SecurityVO securityVO = new SecurityVO();

		// 사용자 정보 select
		UserVO userInfo = userMapper.selectUserById(username);

		// 사용자 정보 없으면 null 처리
		if (userInfo == null) {
			return null;

			// 사용자 정보 있을 경우 로직 전개 (userDetails에 데이터 넣기)
		} else {
			securityVO.setUsername(userInfo.getId());
			securityVO.setPassword(userInfo.getPassword());

			// 사용자 권한 select해서 받아온 List<String> 객체 주입
			securityVO.setAuthorities(userInfo.getAuthList().get(0));
		}

		return securityVO;
		*/
		
		UserVO vo = userMapper.selectUserById(username);
		// LOGGER.info(vo.toString());
		return vo == null ? null : new SecurityVO(vo);
		
	}
}
