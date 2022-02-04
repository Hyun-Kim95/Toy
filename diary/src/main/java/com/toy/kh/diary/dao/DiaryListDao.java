package com.toy.kh.diary.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.toy.kh.diary.dto.DiaryList;

@Mapper
public interface DiaryListDao {

	int getDiariesTotalCount(@Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword);

	List<DiaryList> getForPrintDiaries(@Param("selectedDate")String selectedDate, @Param("searchKeywordType") String searchKeywordType,
			@Param("searchKeyword") String searchKeyword, @Param("limitStart") int limitStart,
			@Param("limitTake") int limitTake);

	void addDiary(Map<String, Object> param);

	DiaryList getForPrintDiaryList(@Param("id")int id);

	DiaryList getDiaryList(@Param("id")int id);

	void modifyDiaryList(Map<String, Object> param);

	void deleteDiaryList(@Param("id")int id);

	DiaryList getDiariesByRegDate(@Param("regDate")String regDate);
}
