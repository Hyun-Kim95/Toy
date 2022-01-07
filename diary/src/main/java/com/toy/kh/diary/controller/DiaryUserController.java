package com.toy.kh.diary.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.toy.kh.diary.dto.DiaryUser;
import com.toy.kh.diary.service.DiaryUserService;
import com.toy.kh.diary.util.Util;

@Controller
public class DiaryUserController {
	
	@Autowired
	private DiaryUserService diaryUserService;	
	
	@RequestMapping("/diaryUser/modify")	// 본인 정보 수정 페이지
	public String showModify(HttpServletRequest req) {
		DiaryUser diaryUser = (DiaryUser)req.getAttribute("loginedDiaryUser");
		
		if (diaryUser == null) {
			return Util.msgAndBack("존재하지 않는 회원번호 입니다.");
		}
		
		req.setAttribute("diaryUser", diaryUser);

		return "diaryUser/modify";
	}

	@RequestMapping("/diaryUser/doModify")	// 정보 수정
	@ResponseBody
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		// 로그인 비번이 공백으로 들어와도 null로 바꿔주기 위해				
		param.put("loginPw", Util.ifEmpty(param.get("loginPw"), null));
		
		diaryUserService.modifyDiaryUser(param);
		
		return Util.msgAndReplace("회원정보가 수정되었습니다.", "../diaryUser/detail");
	}
	
	@RequestMapping("/diaryUser/detail")
	public String showDetail(HttpServletRequest req) {
		DiaryUser diaryUser = (DiaryUser)req.getAttribute("loginedDiaryUser");
		
		req.setAttribute("diaryUser", diaryUser);

		return "diaryUser/detail";
	}
}
