package com.test.first.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//인터셉터는 디스패처서블릿과 컨트롤러 사이에서 구동되는 클래스임
//servlet-context.xml 에 등록해야 함. (반드시)
public class LoggerInterceptor extends HandlerInterceptorAdapter {
	//log4j.xml 에 debug 레벨로 로그를 남기도록 설정함
	//LoggerFactory.getLogger 메소드의 매개변수로 현재 클래스의
	//객체를 전달함 : 로그객체 생성함
	private Logger logger = LoggerFactory.getLogger(getClass());
	//private Logger logger = LoggerFactory.getLogger(LoggerInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		//DispatcherServlet 에서 Controller 가기 전에 구동되는 메소드
		//연습으로 debug 레벨일 때 로그 처리하도록 등록해 두었음
		if(logger.isDebugEnabled()) {
			logger.debug("============ START =========");
			logger.debug(request.getRequestURI());
			logger.debug("-----------------------------------------");
		}
		
		return super.preHandle(request, response, handler);
		//항상 true 리턴
	}
	
	@Override
	public void postHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler, 
			ModelAndView modelAndView) throws Exception  {
		//Controller 에서 리턴되어 뷰리졸버로 가기 전에 구동되는 메소드
		
		super.postHandle(request, response, handler, modelAndView);
		
		if(logger.isDebugEnabled()) {
			logger.debug("----------------View-------------------");
		}
		
	} 
	
	@Override
	public void afterCompletion(HttpServletRequest request, 
			HttpServletResponse response, Object handler,
			Exception ex) throws Exception {
		//뷰리졸버가 뷰를 찾아서 실행해서 내보내고 나면 구동되면 메소드
		if(logger.isDebugEnabled()) {
			logger.debug("============== END ===========");
		}
		
		super.afterCompletion(request, response, handler, ex);
	}
}








