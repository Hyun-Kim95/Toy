package com.toy.kh.diary.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.toy.kh.diary.dto.GenFile;
import com.toy.kh.diary.dto.ResultData;
import com.toy.kh.diary.service.GenFileService;

@Controller
public class CommonGenFileController {
	// 첨부파일 저장 위치
	@Value("${custom.genFileDirPath}")
	private String genFileDirPath;

	@Autowired
	private GenFileService genFileService;

	@RequestMapping("/common/genFile/doUpload")
	@ResponseBody
	public ResultData doUpload(@RequestParam Map<String, Object> param, MultipartRequest multipartRequest) {
		return genFileService.saveFiles(param, multipartRequest);
	}

	@GetMapping("/common/genFile/doDownload")
	public ResponseEntity<Resource> downloadFile(int id, HttpServletRequest request) throws IOException {
		GenFile genFile = genFileService.getGenFile(id);
		String filePath = genFile.getFilePath(genFileDirPath);

		Resource resource = new InputStreamResource(new FileInputStream(filePath));
		
		String contentType = request.getServletContext().getMimeType(new File(filePath).getAbsolutePath());
		String name = getFileNm(genFile.getOriginFileName());
		// 알려지지 않은 파일 타입이 올 경우를 위해
		if (contentType == null) {
			// 다른 모든 경우를 위한 기본값
			contentType = "application/octet-stream";
		}

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + name + "\"")
				.contentType(MediaType.parseMediaType(contentType)).body(resource);
	}

	// 한글 이름의 파일 다운로드를 위해서
	public String getFileNm(String fileNm) {
		String reFileNm = null;
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < fileNm.length(); i++) {
			char c = fileNm.charAt(i);
			if (c > '~') {
				try {
					sb.append(URLEncoder.encode(Character.toString(c), "UTF-8"));
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				sb.append(c);
			}
		}
		reFileNm = sb.toString();

		return reFileNm;
	}
}
