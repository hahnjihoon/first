package com.test.first.notice.controller;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.test.first.common.SearchDate;
import com.test.first.member.model.vo.Member;
import com.test.first.notice.model.service.NoticeService;
import com.test.first.notice.model.vo.Notice;

@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	//뷰페이지이동처리
	
	//새공지글 등록페이지로이동
	@RequestMapping("movewrite.do")
	public String moveWritePage() {
		return "notice/noticeWriterForm";
	}
	
	//수정페이지로이동
	@RequestMapping("upmove.do")
	public String moveUpdatePage(@RequestParam("noticeno") int noticeno, Model model) {
		Notice notice = noticeService.selectNotice(noticeno);
		if(notice != null) {
			model.addAttribute("notice", notice);
			return "notice/noticeUpdateForm";
		}else {
			model.addAttribute("message", noticeno+"번 글 수정페이지이동 실패");
			return "common/error";
		}
	}
	
	
	
	@RequestMapping(value="ntop3.do", method=RequestMethod.POST)
	@ResponseBody
	public String noticeNewTop3Method(HttpServletResponse response) throws UnsupportedEncodingException {
		//최근등록공지글 3개조회먼저해오기
		ArrayList<Notice> list = noticeService.selectNewTop3();
		
		//전소용 json객체 준비
		JSONObject sendJson = new JSONObject();
		//list옮길 json배열 준비
		JSONArray jarr = new JSONArray();
		
		//list를 jarr로 옮기기(복사)
		for(Notice notice : list) {
			//notice 필드값 저장용 json객체 만들고
			JSONObject job = new JSONObject();
			
			//json객체저장할때 put, 대부분map구조니까 json이
			job.put("noticeno", notice.getNoticeno());
			job.put("noticetitle", URLEncoder.encode(notice.getNoticetitle(), "utf-8"));
			//한글은 인코딩 디코딩해야된다 여기서인코딩 저기받는뷰?에서 디코딩
			job.put("noticedate", notice.getNoticedate().toString());  //스트링으로안바꾸면null로됨 날짜만
			
			jarr.add(job); //배열에저장
		}
		//전송용객체에 jarr을 담음
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString(); //제이슨객체를 제이슨문자열형태로 보냄
		//뷰리졸버에게 리턴됨
		
	}
	
	
	
	//공지사항 전체글 목록 조회
	@RequestMapping("nlist.do")
	public String noticeListMethod(Model model) {
		ArrayList<Notice> list = noticeService.selectAll();
		
		if(list.size()>0) {
			model.addAttribute("list", list);
			return "notice/noticeListView";
			
		}else {
			model.addAttribute("message", "등록된 공지가 없다");
			return "common/error";
		}
		
	}
	
	
	//공지글상세보기요청처리용
	@RequestMapping("ndetail.do")
	public String noticeDetailMethod(@RequestParam("noticeno") int noticeno, Model model, HttpSession session) {
		Notice notice = noticeService.selectNotice(noticeno);
		
		if(notice != null) {
			model.addAttribute("notice", notice);
			
			Member loginMember = (Member)session.getAttribute("loginMember");
			if(loginMember !=null && loginMember.getAdmin().equals("Y")) {
				//관리자가 상세보기 요청했을때
				return "notice/noticeAdminDetailView";
			}else {
				//관리자가 아닌 클라이언트가 상세보기 요청했을때
				return "notice/noticeDetailView";
			}
			
			
		}else {
			model.addAttribute("messeage", notice+"번 공지글 상세보기 실패");
			return "common/error";
		}
		
	}
	
	
	//첨부파일 다운로드 요청처리
	@RequestMapping("nfdown.do")
	public ModelAndView fileDownMethod(HttpServletRequest request,
			@RequestParam("ofile") String originFileName,
			@RequestParam("rfile") String renameFileName, ModelAndView mv) {
		
		//공지사항 첨부파일 저장 폴더 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		
		//저장폴더에서 읽을 파일에대해 경로추가하면서 파일객체생성
		File renameFile = new File(savePath + "\\" + renameFileName);
		
		//다운을위해 내보내는 파일객체 생성(원본파일)
		File originFile = new File(originFileName);
		
		mv.setViewName("filedown"); //동록된 파일다운로드 처리용 뷰클래스
		mv.addObject("renameFile", renameFile); //전달할 파일객체 저장
		mv.addObject("originFile", originFile);
		
		return mv;
	}
	
	
	//파일업로드 기능이 있는 공지글 등록 요청처리
	@RequestMapping(value="ninsert.do", method=RequestMethod.POST)
	public String noticeInsertMethod(Notice notice, HttpServletRequest request, Model model,
			@RequestParam(name="upfile", required=false) MultipartFile mfile) {
		
		//업로드된파일저장할 폴더지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		
		//첨부파일있을때만 업로드된파일지정폴더로옮기기
		if(!mfile.isEmpty()) {
			String fileName=mfile.getOriginalFilename();
			
			//이름바꾸기처리 : 년월일시분초.확장자
			if(fileName != null && fileName.length() > 0) {
				
				//바꿀파일명에대한문자열 만들기
				//공지글 등록요청시점의 날짜정보이용
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				
				//변경할파일이름만들기
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				
				//확장자붙여
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".")+1);
				
				//파일객체만들기
				File originFile = new File(savePath+"\\"+fileName);
				File renameFile = new File(savePath+"\\"+renameFileName);
				
				//업로드 파일저장시키고 바로이름바꾸기실행
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장실패");
					return "common/error";
				}
				
				notice.setOriginal_filepath(fileName);
				notice.setRename_filepath(renameFileName);				
			}
			
		} //첨부파일있을때만?
		
		if(noticeService.inserNotice(notice)>0) { //새공지등록성공시
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", "새공지글 등록실패");
			return "common/error";
		}
		
	}
	
	
	
	//공지삭제처리
	@RequestMapping("ndel.do")
	public String noticeDeleteMethod(@RequestParam("noticeno") int noticeno, 
			@RequestParam(name="rfile", required=false) String renameFileName, 
			HttpServletRequest request, Model model) {
		if(noticeService.deleteNotice(noticeno) > 0) {
			//첨부된파일이있는글일때는 저장폴더에있는 파일도삭제
			if(renameFileName != null) {
				new File(request.getSession().getServletContext().getRealPath("resources/notice_upfiles")+"\\"+renameFileName).delete();
			}
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", noticeno + "번 글 삭제실패");
			return "common/error";
		}
		
	}
	
	
	//공지글 수정처리용
	@RequestMapping(value="nupdate.do", method=RequestMethod.POST)
	public String noticeUpdateMethod(Notice notice, HttpServletRequest request, Model model,
			@RequestParam(name="delFlag", required=false) String delFlag, @RequestParam(name="upfile", required=false) MultipartFile mfile) {
		//업로드된파일저장폴더 지정하기
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		
		//첨부파일 수정처리
		//원래첨부파일이 있을때 삭제선택한경우
		if(notice.getOriginal_filepath() != null && delFlag != null && delFlag.equals("yes")) {
			//저장폴더에서일단지움
			new File(savePath+"\\"+notice.getRename_filepath()).delete();
			
			//notice저장정보도 지움
			notice.setOriginal_filepath(null);
			notice.setRename_filepath(null);
		}
		
		//새로운 첨부있을때
		if(!mfile.isEmpty()) {
			//저장폴더의 이전파일을 삭제
			if(notice.getOriginal_filepath() != null) {
				
				//저장폴더에서일단지움
				new File(savePath+"\\"+notice.getRename_filepath()).delete();
				
				//notice저장정보도 지움
				notice.setOriginal_filepath(null);
				notice.setRename_filepath(null);
				
			}
			
			//이전첨부파일이 없는경우 - - - - - - - - - - - - - - - - - - -
			String fileName=mfile.getOriginalFilename();
				
			//이름바꾸기처리 : 년월일시분초.확장자
			if(fileName != null && fileName.length() > 0) {
				
				//바꿀파일명에대한문자열 만들기
				//공지글 등록요청시점의 날짜정보이용
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				
				//변경할파일이름만들기
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				
				//확장자붙여
				renameFileName+="."+fileName.substring(fileName.lastIndexOf(".")+1);
				
				//파일객체만들기
				File originFile = new File(savePath+"\\"+fileName);
				File renameFile = new File(savePath+"\\"+renameFileName);
				
				//업로드 파일저장시키고 바로이름바꾸기실행
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장실패");
					return "common/error";
				}
				
				notice.setOriginal_filepath(fileName);
				notice.setRename_filepath(renameFileName);				
			} //이름바꾸기해서 저장처리
			
		} //새로첨부된파일있다면
		
		//---------------------------------------------------------------
		
		//서비스 메소드 실행시키고 결과받아서 성공실패 페이지 내보내기
		if(noticeService.updateNotice(notice) > 0) {
			return "redirect:nlist.do";
		}else {
			model.addAttribute("message", notice.getNoticeno()+" 번 공지 수정실패");
			return "common/error";
		}
	}
	
	
	//공지사항 제목 검색
	@RequestMapping(value="nsearchTitle.do", method=RequestMethod.POST)
	public String noticeSearchTitleMethod(@RequestParam("keyword") String keyword, Model model) {
		ArrayList<Notice> list = noticeService.selectSearchTitle(keyword);
		
		if(list.size()>0) {
			model.addAttribute("list", list);
			return "notice/noticeListView";
		}else {
			model.addAttribute("message", keyword+"로 검색된 공지정보없음");
			return "common/error";
		}
		
	}
	
	//공지사항 작성자 검색
	@RequestMapping(value="nsearchWriter.do", method=RequestMethod.POST)
	public String noticeSearchWriterMethod(@RequestParam("keyword") String keyword, Model model) {
		ArrayList<Notice> list = noticeService.selectSearchWriter(keyword);
		
		if(list.size()>0) {
			model.addAttribute("list", list);
			return "notice/noticeListView";
		}else {
			model.addAttribute("message", keyword+"로 검색된 공지정보없음");
			return "common/error";
		}
	}
	
	//공지사항 날짜 검색
	@RequestMapping(value="nsearchDate.do", method=RequestMethod.POST)
	public String noticeSearchDateMethod(SearchDate date, Model model) {
		ArrayList<Notice> list = noticeService.selectSearchDate(date);
		
		if(list.size()>0) {
			model.addAttribute("list", list);
			return "notice/noticeListView";
		}else {
			model.addAttribute("message", "해당날짜로 등록된 공지정보없음");
			return "common/error";
		}
	}
	
	
	
	
	
	
}









