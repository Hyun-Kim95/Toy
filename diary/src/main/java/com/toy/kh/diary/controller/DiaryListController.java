package com.toy.kh.diary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.toy.kh.diary.dto.DiaryList;
import com.toy.kh.diary.dto.GenFile;
import com.toy.kh.diary.service.DiaryListService;
import com.toy.kh.diary.service.GenFileService;
import com.toy.kh.diary.util.Util;

@Controller
public class DiaryListController {

	@Autowired
	private DiaryListService diaryListService;
	@Autowired
	private GenFileService genFileService;
	
	@RequestMapping("/diaryList/detail")
	public String showDetail(HttpServletRequest req, Integer id) {
		if (id == null) {
			return Util.msgAndBack("id를 입력해주세요.");
		}
		// 게시물 정보
		DiaryList diaryList = diaryListService.getForPrintDiaryList(id);
		// 첨부파일 리스트
		List<GenFile> files = genFileService.getGenFiles(diaryList.getId());
		
		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		diaryList.getExtraNotNull().put("file", filesMap);
		// jsp에서 사용할 수 있도록 req에 추가
		req.setAttribute("diaryList", diaryList);

		return "diaryList/detail";
	}
	
	@RequestMapping("/diaryList/list")
	public String showList(HttpServletRequest req, String selectedDate, String searchKeywordType, String searchKeyword, @RequestParam(defaultValue = "1") int page) {
		// 검색할 타입(title or body)
		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}
		// 검색창에 아무것도 검색 안하면 전체에서 검색으로 설정함
		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "titleAndBody";
		}
		// 검색이 공백이어도 null로 변경
		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}

		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}

		if (searchKeyword == null) {
			searchKeywordType = null;
		}
		
		if (selectedDate == null || selectedDate.length() == 0) {
			selectedDate = null;
		}
		
		// 페이징을 위해 게시물 수 확인
		int totalItemsCount = diaryListService.getDiariesTotalCount(searchKeywordType, searchKeyword);
		// 한 페이지에 보여줄 게시물 수
		int itemsInAPage = 10;
		// 전체 페이지 수
		int totalPage = (int) Math.ceil(totalItemsCount / (double) itemsInAPage);
		// (선택된 화면 외에 보여질)페이지 버튼 수
		int pageMenuArmSize = 4;
		// 페이지 버튼 가장 왼쪽 숫자
		int pageMenuStart = page - pageMenuArmSize;

		if (pageMenuStart < 1) {
			pageMenuStart = 1;
		}
		// 페이지 버튼 가장 오른쪽 숫자
		int pageMenuEnd = page + pageMenuArmSize;
		if (pageMenuEnd > totalPage) {
			pageMenuEnd = totalPage;
		}
		// 해당 페이지에 있는 게시물들
		List<DiaryList> diaries = diaryListService.getForPrintDiaries(selectedDate ,searchKeywordType, searchKeyword, page, itemsInAPage);
		// 뷰에서 사용함
		req.setAttribute("totalItemsCount", totalItemsCount);
		req.setAttribute("diaries", diaries);
		req.setAttribute("page", page);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pageMenuArmSize", pageMenuArmSize);
		req.setAttribute("pageMenuStart", pageMenuStart);
		req.setAttribute("pageMenuEnd", pageMenuEnd);
		req.setAttribute("selectedDate", selectedDate);

		return "diaryList/list";
	}
	
	@RequestMapping("/diaryList/add")
	public String showAdd(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		return "diaryList/add";
	}

	@RequestMapping("/diaryList/doAdd")
	@ResponseBody
	public String doAdd(@RequestParam Map<String, Object> param, HttpServletRequest req,
			MultipartRequest multipartRequest) {
		int loginedUserId = (int) req.getAttribute("loginedDiaryUserId");

		if (param.get("selectedDate") == null) {
			return Util.msgAndBack("날짜를 입력해주세요.");
		}
		
		if (param.get("title") == null) {
			return Util.msgAndBack("제목을 입력해주세요.");
		}

		if (param.get("body") == null) {
			return Util.msgAndBack("내용을 입력해주세요.");
		}
		
		DiaryList diary = diaryListService.getDiariesByRegDate(param.get("selectedDate").toString());
		
		if (diary != null) {
			return Util.msgAndBack("해당 날짜의 일기가 이미 존재합니다.");
		}

		param.put("userId", loginedUserId);
		
		int newDiaryListId = diaryListService.addDiary(param);
		return Util.msgAndReplace(String.format("%s 날짜의 게시물이 작성되었습니다.", param.get("selectedDate")),
				"../diaryList/detail?id=" + newDiaryListId);
	}
	
	@RequestMapping("/diaryList/doDelete")
	@ResponseBody
	public String doDelete(Integer id, HttpServletRequest req) {

		if (id == null) {
			return Util.msgAndBack("id를 입력해주세요.");
		}

		DiaryList diaryList = diaryListService.getForPrintDiaryList(id);

		if (diaryList == null) {
			return Util.msgAndBack("해당 게시물은 존재하지 않습니다.");
		}

		diaryListService.deleteDiaryList(id);

		return Util.msgAndReplace("게시물이 삭제되었습니다.", "../diaryList/list");
	}
	
	@RequestMapping("/diaryList/modify")
	public String showModify(Integer id, HttpServletRequest req) {
		if (id == null) {
			return Util.msgAndBack("id를 입력해주세요.");
		}

		DiaryList diaryList = diaryListService.getForPrintDiaryList(id);

		List<GenFile> files = genFileService.getGenFiles(diaryList.getId());

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		diaryList.getExtraNotNull().put("file", filesMap);
		req.setAttribute("diaryList", diaryList);
		
		return "diaryList/modify";
	}

	@RequestMapping("/diaryList/doModify")
	@ResponseBody
	public String doModify(@RequestParam Map<String, Object> param, HttpServletRequest req) {

		int id = Util.getAsInt(param.get("id"), 0);

		if (id == 0) {
			return Util.msgAndBack("id를 입력해주세요.");
		}

		if (Util.isEmpty(param.get("title"))) {
			return Util.msgAndBack("title을 입력해주세요.");
		}

		if (Util.isEmpty(param.get("body"))) {
			return Util.msgAndBack("body를 입력해주세요.");
		}

		DiaryList diaryList = diaryListService.getForPrintDiaryList(id);

		if (diaryList == null) {
			return Util.msgAndBack("해당 게시물은 존재하지 않습니다.");
		}
		// 첨부파일 1~10까지 확인하여 삭제체크를 한 첨부파일이 있는지 확인
		for(int i=1;i<=10;i++) {
			// null을 toString 하면 오류 발생해서
			if(param.get("deleteFile__"+param.get("id")+"__"+i) != null && param.get("deleteFile__"+param.get("id")+"__"+i).toString().equals("Y")) {
				GenFile gen = genFileService.getGenFile(Integer.parseInt(param.get("id").toString()), i);
				// 해당파일의 delStatus를 1로 변경
				genFileService.deleteGenFile(gen);
			}
		}
		
		int newDiaryListId = diaryListService.modifyDiaryList(param);
		
		return Util.msgAndReplace(String.format("%s 날짜의 일기가 수정되었습니다.", diaryList.getRegDate()),
				"../diaryList/detail?id=" + newDiaryListId);
	}
}
