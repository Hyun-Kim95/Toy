package com.toy.kh.diary.service;

import java.text.ParseException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.toy.kh.diary.dao.DiaryListDao;
import com.toy.kh.diary.dto.DiaryList;
import com.toy.kh.diary.dto.GenFile;
import com.toy.kh.diary.util.Util;

@Service
public class DiaryListService {

	@Autowired
	private DiaryListDao diaryListDao;
	@Autowired
	private GenFileService genFileService;

	public int getDiariesTotalCount(String searchKeywordType, String searchKeyword) {
		return diaryListDao.getDiariesTotalCount(searchKeywordType, searchKeyword);
	}

	public List<DiaryList> getForPrintDiaries(String selectedDate, String searchKeywordType, String searchKeyword,
			int page, int itemsInAPage) {
		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		List<DiaryList> diaries = diaryListDao.getForPrintDiaries(selectedDate, searchKeywordType, searchKeyword,
				limitStart, limitTake);
		List<Integer> diaryIds = diaries.stream().map(diaryList -> diaryList.getId()).collect(Collectors.toList());
		Map<Integer, Map<String, GenFile>> filesMap = genFileService.getFilesMapKeyRelIdAndFileNo(diaryIds);

		for (DiaryList diary : diaries) {
			Map<String, GenFile> mapByFileNo = filesMap.get(diary.getId());

			if (mapByFileNo != null) {
				diary.getExtraNotNull().put("file", mapByFileNo);
			}
		}

		return diaries;
	}

	public int addDiary(Map<String, Object> param) {
		diaryListDao.addDiary(param);

		int id = Util.getAsInt(param.get("id"), 0);
		// 첨부파일의 relId 변경(0 -> article의 Id)
		genFileService.changeInputFileRelIds(param, id);

		return id;
	}

	public DiaryList getForPrintDiaryList(int id) {
		return diaryListDao.getForPrintDiaryList(id);
	}

	public void deleteDiaryList(int id) {
		diaryListDao.deleteDiaryList(id);

		genFileService.deleteGenFiles(id);
	}

	public int modifyDiaryList(Map<String, Object> param) {
		diaryListDao.modifyDiaryList(param);

		int id = Util.getAsInt(param.get("id"), 0);

		return id;
	}

	public List<DiaryList> getDiariesByRegDate(String regDate) {
		return diaryListDao.getDiariesByRegDate(regDate, regDate);

	}

	public String[] getDiariesMissing() throws ParseException {
		String past = Util.getPastMonthStr();
		String[] ans = new String[31];
		String day = Util.getPastDateStr(1);
		List<DiaryList> chk = diaryListDao.getDiariesByRegDate(day,past);
		// 사이의 날짜에는 양끝 날짜가 포함이 안돼서 +2를 해줌
		int i = 0;
		// foreach 문의 마지막 체크용
		int j = 0;
		if(chk.size() != Util.getBetween(day, past)+2) {
			String cmp = null;
			for (DiaryList diaryList : chk) {
				j++;
				if(j == chk.size()) {
					String[] bf = Util.getBetweenDate(diaryList.getRegDate(), Util.getPastDateStr(1));
					for (String string : bf) {
						ans[i] = string;
						i++;
					}
				}
				
				if (cmp == null) {
					cmp = diaryList.getRegDate();
					continue;
				}
				
				if(Util.getBetween(diaryList.getRegDate(), cmp) != 1) {
					String[] bf = Util.getBetweenDate(cmp, diaryList.getRegDate());
					for (String string : bf) {
						ans[i] = string;
						i++;
					}
				}
				cmp = diaryList.getRegDate();
			}
		}
		return ans;
	}
}
