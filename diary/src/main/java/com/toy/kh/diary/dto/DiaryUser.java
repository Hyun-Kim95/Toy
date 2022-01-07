package com.toy.kh.diary.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DiaryUser {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	@JsonIgnore
	private String loginPw;
	private String name;
	private String nickname;
	private String cellphoneNo;
	private String email;
}
