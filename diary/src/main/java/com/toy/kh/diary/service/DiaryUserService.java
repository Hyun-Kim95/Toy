package com.toy.kh.diary.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.toy.kh.diary.dao.DiaryUserDao;
import com.toy.kh.diary.dto.DiaryUser;
import com.toy.kh.diary.dto.ResultData;
import com.toy.kh.diary.util.Util;

@Service
public class DiaryUserService {
	
	@Autowired
	private DiaryUserDao diaryUserDao;

	public DiaryUser getDiaryUserByLoginId(String loginId) {
		return diaryUserDao.getDiaryUserByLoginId(loginId);
	}

	public ResultData join(Map<String, Object> param) {
		diaryUserDao.join(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return new ResultData("S-1", String.format("%s님 환영합니다.", param.get("nickname")), "id", id);
	}

	public DiaryUser getDiaryUser(int id) {
		return diaryUserDao.getDiaryUser(id);
	}

	public void modifyDiaryUser(Map<String, Object> param) {
		diaryUserDao.modifyDiaryUser(param);
	}
}
