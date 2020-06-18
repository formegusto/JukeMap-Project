package com.jukemap.biz.common;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class ServicePointcut {
	@Pointcut("execution(* com.jukemap.view.juke.*.*(..))")
	public void serviceJukePointcut() {}
	@Pointcut("execution(* com.jukemap.view.user.*.*(..))")
	public void serviceUserPointcut() {}
}
