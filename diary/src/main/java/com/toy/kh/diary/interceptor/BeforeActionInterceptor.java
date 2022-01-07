package com.toy.kh.diary.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.toy.kh.diary.dto.DiaryUser;
import com.toy.kh.diary.service.DiaryUserService;
import com.toy.kh.diary.util.Util;

import lombok.extern.slf4j.Slf4j;

@Component("beforeActionInterceptor") // 컴포넌트 이름 설정
@Slf4j
public class BeforeActionInterceptor implements HandlerInterceptor {
	@Autowired
	private DiaryUserService diaryUserService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		String requestUrl = request.getRequestURI();
		String queryString = request.getQueryString();

		if (queryString != null && queryString.length() > 0) {
			requestUrl += "?" + queryString;
		}

		String[] pathBits = request.getRequestURI().split("/");

		request.setAttribute("requestUrl", requestUrl);

		int loginedDiaryUserId = 0;
		DiaryUser loginedDiaryUser = null;

		HttpSession session = request.getSession();

		if (session.getAttribute("loginedDiaryUserId") != null) {
			loginedDiaryUserId = (int) session.getAttribute("loginedDiaryUserId");
			loginedDiaryUser = diaryUserService.getDiaryUser(loginedDiaryUserId);
		}
		
		// 로그인 여부에 관련된 정보를 request에 담는다.
		boolean isLogined = false;

		if (loginedDiaryUser != null) {
			isLogined = true;
		}

		request.setAttribute("loginedDiaryUserId", loginedDiaryUserId);
		request.setAttribute("isLogined", isLogined);
		request.setAttribute("loginedDiaryUser", loginedDiaryUser);

		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
