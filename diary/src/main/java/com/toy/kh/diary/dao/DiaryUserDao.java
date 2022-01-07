package com.toy.kh.diary.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.toy.kh.diary.dto.DiaryUser;

@Mapper
public interface DiaryUserDao {

	DiaryUser getDiaryUserByLoginId(@Param("loginId")String loginId);

	void join(Map<String, Object> param);

	DiaryUser getDiaryUser(@Param("id")int id);

	void modifyDiaryUser(Map<String, Object> param);

}
