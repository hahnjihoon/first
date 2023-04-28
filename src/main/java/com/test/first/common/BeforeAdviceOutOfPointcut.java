package com.test.first.common;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service  //서비스에 적용하는
@Aspect	//aop 를 뜻함
public class BeforeAdviceOutOfPointcut {
	//따로 작성해 놓은 포인트컷 클래스가 가진 설정을 가져다 사용해 봄
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Before("CommonPointcut.serviceAllPointcut()")
	public void beforeConsole(JoinPoint jp) {
		//모든 *ServiceImpl 클래스가 가진 모든 메소드가 구동되기
		//직전에 실행되는 어드바이스임.
		String methodName = jp.getSignature().getName();
		Object[] args = jp.getArgs();
		
		logger.info("[사전처리] : " + methodName 
				+ "() 메소드 첫번째 전달인자 정보 : "
				+ ((args.length > 0)? args[0].toString() : 0));
	}
}
