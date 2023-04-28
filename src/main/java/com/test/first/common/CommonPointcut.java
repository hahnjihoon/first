package com.test.first.common;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

@Aspect  //aop 를 뜻함
public class CommonPointcut {
	//포인트컷 설정 메소드들만 따로 모아서 작성해 둘 수도 있음
	
	@Pointcut("execution(* com.test.first..*Impl.*(..))")
	public void serviceAllPointcut() {}
	
	@Pointcut("execution(* com.test.first..*Impl.select*(..))")
	public void getPointcut() {}
	
	@Pointcut("execution(* com.test.first..*Impl.insert*(..))")
	public void setPointcut() {}
}
