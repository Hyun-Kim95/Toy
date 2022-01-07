package com.toy.kh.diary.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.toy.kh.diary.dto.GenFile;

@Mapper
public interface GenFileDao {

	void changeRelId(@Param("id")int id,@Param("relId") int relId);

	List<GenFile> getGenFiles(@Param("relId")int relId);

	GenFile getGenFile(@Param("relId")int relId,@Param("fileNo") int fileNo);

	void saveMeta(Map<String, Object> param);

	GenFile getGenFileById(@Param("id")int id);

	List<GenFile> getGenFilesRelIds(@Param("relIds")List<Integer> relIds);

	void deleteFile(@Param("id")int id);

}