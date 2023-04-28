package com.test.first.member.model.service;

import java.util.ArrayList;

import com.test.first.common.SearchDate;
import com.test.first.member.model.vo.Member;

//스프링프레임워크에서!!
//모델파트에서 서비스는 반드시 인터페이스로 만들어라 정해둠
//이 인터페이스를 상속받는 후손클래스를 만들어서 메소드오버라이딩하도록
public interface MemberService {
	Member selectLogin(Member member);
	int insertMember(Member member);
	int selectDupCheckId(String userid); //회원가입시 아이디중복체크메소드
	int updateMember(Member member);
	int deleteMember(String userid);
	ArrayList<Member> selectList();
	Member selectMember(String userid);
	int updateLoginOk(Member member);
	ArrayList<Member> selectSearchUserid(String keyword);
	ArrayList<Member> selectSearchGender(String keyword);
	ArrayList<Member> selectSearchAge(int age);
	ArrayList<Member> selectSearchEnrollDate(SearchDate searchDate);
	ArrayList<Member> selectSearchLoginOk(String keyword);
	
}