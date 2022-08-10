package ibs.com.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/resources/egovframework/spring/context-mapper.xml", 
	"file:src/main/resources/egovframework/spring/context-datasource.xml"})
 
public class UserMapperTests {
	
	@Autowired
	private UserMapper mapper;
	
	@Test
	public void test() {
		System.out.println(mapper);
	}
	
	
	@Test
	public void test2() {
		System.out.println(mapper.selectAllUserInfo());
	}
	
	
	@Test
	public void test3() {
		System.out.println(mapper.selectAllPermittedUser());
	}
	
	

}
