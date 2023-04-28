package com.test.first.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.first.common.SearchDate;
import com.test.first.member.model.dao.MemberDao;
import com.test.first.member.model.vo.Member;


@Service("memberService")  //xml에 자동등록 = servlet-context.xml
public class MemberServiceImpl implements MemberService {
	//클래스이름맞추고 임플리먼트하라고스프링이정해둠
	
	@Autowired //자동의존성주입 (내부에서 자동으로 객체생성)
	private MemberDao memberDao;

	@Override
	public Member selectLogin(Member member) {
		return memberDao.selectLogin(member);
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public int selectDupCheckId(String userid) {
		return memberDao.selectDupCheckId(userid);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int deleteMember(String userid) {
		return memberDao.deleteMember(userid);
	}

	@Override
	public ArrayList<Member> selectList() {
		return memberDao.selectList();
	}

	@Override
	public Member selectMember(String userid) {
		return memberDao.selectMember(userid);
	}

	@Override
	public int updateLoginOk(Member member) {
		return memberDao.updateLoginOk(member);
	}

	@Override
	public ArrayList<Member> selectSearchUserid(String keyword) {
		return memberDao.selectSearchUserid(keyword);
	}

	@Override
	public ArrayList<Member> selectSearchGender(String keyword) {
		return memberDao.selectSearchGender(keyword);
	}

	@Override
	public ArrayList<Member> selectSearchAge(int age) {
		return memberDao.selectSearchAge(age);
	}

	@Override
	public ArrayList<Member> selectSearchEnrollDate(SearchDate searchDate) {
		return memberDao.selectSearchEnrollDate(searchDate);
	}

	@Override
	public ArrayList<Member> selectSearchLoginOk(String keyword) {
		return memberDao.selectSearchLoginOk(keyword);
	}
	

}
