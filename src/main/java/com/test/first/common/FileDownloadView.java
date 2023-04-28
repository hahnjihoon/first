package com.test.first.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component("filedown")  //notice, board 파일다운처리용 view클래스
public class FileDownloadView extends AbstractView {
	//스프링에서는 뷰클래스를 만들려면 AbatractView를 상속받아서 오버라이딩한 메소드안에 기능을 구현해야된다
	
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		//파일다운처리용코드
		
		//컨트롤러에서 뷰리졸버를 거쳐 전달된 model정보를 추출
		File renameFile = (File)model.get("renameFile");  //Object로 리턴됨 =파일로바꿔줘야됨
		File downFile = (File)model.get("originFile");
		
		//한글파일명 인코딩처리를위해 파일명만 추출함
		String fileName = downFile.getName();
		
		//클라이언트로 전송하기위한 설정
		response.setContentType("text/plain; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=\"" 
													+ new String(fileName.getBytes("UTF-8"), "ISO-8859-1")
													+ "\"");
		response.setContentLength((int)renameFile.length());
		
		//입출력 스트림 생성: 저장폴더의 renameFile은 read() > response통해서 내보냄 write() | print() = 스프링이제공
		OutputStream out = response.getOutputStream();
		FileInputStream fin = null;
		
		try {
			fin = new FileInputStream(renameFile);
			FileCopyUtils.copy(fin, out);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(fin != null) {
				try {
					fin.close();
				}catch(Exception e){
					e.printStackTrace();
				}
				
			}
		}
		
	}

	
	
	

	
	
}





