package com.test.first;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration  //컨트롤러테스트할때사용 어노테이션, web환경에서 사용되는 bean=class 들을 자동생성하여등록해주는 어노테이션
@ContextConfiguration(locations= {
		"classpath:root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/spring-security.xml"
})
public class TestMemberController {
	//로그출력객체
	private static final Logger logger = LoggerFactory.getLogger(TestMemberController.class);
	
	//테스트용 클래스에서 사용할 필드선언
	@Autowired
	private WebApplicationContext wac;
	//현재 실행중인 애플리케이션의 구성을 제공하는 인터페이스
	
	private MockMvc mockMvc;
	//클라이언트역할 요청내용을controller에서 받아서처리하는 것과 같음
	//테스트를 수행하기 위한 클래스 : 클라이언트역할
	
	@Before
	public void setup() {
		//테스트에 사용할 MockMvc 객체생성처리 (여기서해줘야됨)
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
		
		logger.info("setup();메소드 실행");
	}
	
	
//	@Test
	@Ignore //테스트에서제외시킬때사용
	public void testLogin() {
		try {
			this.mockMvc.perform(post("/login.do").param("userid", "user01").param("userpwd", "1111")).andDo(print()).andExpect(status().isOk());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@Test  //테스트용메소드를 표시하는 어노테이션
	public void testMemberEnroll() {
		logger.info("회원가입 테스트");
		try {
			this.mockMvc.perform(post("/enroll.do").param("userid", "user04")
					.param("userpwd", "pass04")
					.param("username", "테스터")
					.param("gender", "F")
					.param("age", "34")
					.param("phone", "01055520440")
					.param("email", "user04@test.org")
					.param("hobby", "game,reading")
					.param("etc", "junit테스트실험"))
			.andDo(print())  //처리된 내용출력
			.andExpect(status().isOk());  //응답상태값이 에러가없는 정상상태인지 검증(정상=200)
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
}
