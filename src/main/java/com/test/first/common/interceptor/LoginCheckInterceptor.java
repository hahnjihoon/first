package com.test.first.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.test.first.member.model.vo.Member;

//인터셉터는 디스패처서블릿과 컨트롤러 사이에서 구동되는 클래스임
//servlet-context.xml 에 등록해야 함. (반드시)
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	//private Logger logger = LoggerFactory.getLogger(LoggerInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		//컨트롤러 넘어가기 전에 로그인 상태 확인
		
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember != null) {
			logger.info("로그인 상태로 요청 : " 
					+ request.getRequestURI());
		}else {
			logger.info("비로그인 상태로 요청 : " 
					+ request.getRequestURI());
			
			//요청을 돌려보냄 : 컨트롤러로 넘기지 않음
			//Referer 이용 : request 객체에 기록되어 있음
			String referer = request.getHeader("Referer");
			logger.info("Referer : " + referer);
			
			//브라우저이름[전송방식] 확인
			String origin = request.getHeader("Origin");
			logger.info("Origin : " + origin);
			//chrome[GET], ie[POST], firefox[POST] => null
			
			String url = request.getRequestURL().toString();
			logger.info("url : " + url);
			
			String uri = request.getRequestURI();
			logger.info("uri : " + uri);
			
			//크롬 브라우저일 때
			if(origin == null) {
				origin = uri.replace(uri, "");
			}
			
			//되돌려 보낼 때 요청정보는 삭제하고 보냄
			String location = referer.replace(
					origin + request.getContextPath(), "");
			request.setAttribute("loc", location);
			request.setAttribute("message", 
					"로그인해야 이용할 수 있는 서비스입니다.");
			//내보낼 뷰페이지 지정함 : 절대경로 사용해야함
			request.getRequestDispatcher(
					"/WEB-INF/views/common/error.jsp")
				.forward(request, response);
			
			return false;
		}
		
		return super.preHandle(request, response, handler);
		//항상 true 리턴
	}  //preHandle closed...
	
	
}








