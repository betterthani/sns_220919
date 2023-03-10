package com.sns.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.dao.CommentDAO;
import com.sns.comment.model.Comment;
import com.sns.comment.model.CommentView;
import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

@Service
public class CommentBO {
	
	@Autowired
	private CommentDAO commentDAO;
	
	@Autowired
	private UserBO userBO;
	
	// 댓글 쓰기
	public int addCommentByUserIdPostIdContent(int userId, int postId, String content) {
		return commentDAO.insertCommentByUserIdPostIdContent(userId, postId, content);
	}
	
	// 댓글 조회하기(해당 페이지에서만 사용가능하게 변경)
	private List<Comment> getCommentListByPostId(int postId){
		return commentDAO.selectCommentListByPostId(postId);
	}
	
	//뷰 가공 메소드
	// input : 글 번호
	// output : 글번호에 해당하는 댓글목록(+댓글쓴이 정보)을 가져온다.
	public List<CommentView> generateCommentViewListByPostId(int postId) {
		
		// 결과물
		List<CommentView> commentViewList = new ArrayList<>();
		
		// 댓글 목록
		List<Comment> commentList = getCommentListByPostId(postId);
		
		// 반복문 => commentView => 결과물에 넣는다.
		for(Comment comment : commentList) {
			CommentView commentView = new CommentView();
			
			// 댓글
			commentView.setComment(comment);
			
			// 댓글쓴이
			User user = userBO.getUserByUserId(comment.getUserId()); // 남의 dao부르면 안 됨
			commentView.setUser(user);
			
			// commentviewList에 넣기
			commentViewList.add(commentView);
		}
		
		// 결과물 리턴
		return commentViewList;
	}
	
	// 댓글 전체 삭제(회원탈퇴시)
	public void deleteByUserId(int userId) {
		commentDAO.deleteByUserId(userId);
	}
	
	// 댓글 삭제(타임라인)
	public void deleteByPostIdUserId(int postId, int userId) {
		commentDAO.deleteByPostIdUserId(postId, userId);
	}

}
