package com.toy.kh.diary.dto;

import java.util.HashMap;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DiaryList {

	private int id;
	private String regDate;
	private String updateDate;
	private int userId;
	private String title;
	private String body;

	private String extra__writer;
	
	public Map<String, Object> extra;
	
	public Map<String, Object> getExtra() {
		return extra;
	}

	public Map<String, Object> getExtraNotNull() {
		if (extra == null) {
			extra = new HashMap<String, Object>();
		}

		return extra;
	}
}
