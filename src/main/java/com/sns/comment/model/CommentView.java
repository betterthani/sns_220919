package com.sns.comment.model;

import com.sns.user.model.User;

// 댓글 1개와 매핑(타임라인BO와 연결)
public class CommentView {
	// 댓글 1개
	private Comment comment;
	
	// 댓글 1개에 대한 글쓴이 정보
	private User user;

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
	
	
}
