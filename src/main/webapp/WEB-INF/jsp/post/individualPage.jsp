<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex justify-content-center my-3">
	<div class="contents-box border rounded ">
<c:forEach var="userPage" items="${userPageList}">
		<!-- 프로필 상단 -->
		<div class="individualBox">
		
			<div class="d-flex align-items-center justify-content-around pt-2">
				<!-- 프로필 박스 -->
				<div class="mini_box">
				<!-- 프로필 이미지 -->
				<c:choose>
					<c:when test="${empty userPage.user.profileImgPath}">
						<img alt="프로필" src="/static/img/timeline/profileImg.png" class="roundBox">
					</c:when>
					<c:otherwise>
						<img alt="프로필" src="${userPage.user.profileImgPath}" class="roundBox">
					</c:otherwise>
				</c:choose>
					<!-- 닉네임 -->
					<div class="font-weight-bold">${userPage.user.name}</div>
					
					<!-- 상태메세지 -->
					<div id="introduceText">${userPage.user.statusMessage}</div>
				</div>
				
				<!-- 게시글 개수 -->
				<div class="mini_box">
					<div>게시글</div>
					<div>${userPage.postCount}</div>
				</div>
				
				<!-- 팔로워 -->
				<div class="mini_box">
					<div>팔로워</div>
					<div>
					<a href="/follow/follower_list_view?userId=${userPage.user.id}" class="text-dark font-weight-bold">
						${userPage.followerCount}
					</a>
					</div>
				</div>
				
				<!-- 팔로잉 -->
				<div class="mini_box">
					<div>팔로잉</div>
					<div>
					<a href="/follow/followee_list_view?userId=${userPage.user.id}" class="text-dark font-weight-bold">
						${userPage.followeeCount}
					</a>
					</div>
				</div>
			</div>
		
		</div>
		<!-- 프로필 수정 버튼 -->
		<c:choose>
			<c:when test="${userPage.user.id eq sessionId}">
				<div class="profileEditBtnBox d-flex justify-content-center align-items-center">
					<a href="/user/profile_edit_view?userId=${userPage.user.id}" class="btn btn-dark w-50">프로필 수정</a>			
				</div>
			</c:when>
			<c:otherwise>
			
				<!-- 팔로우 버튼 -->
				<div class="profileEditBtnBox d-flex justify-content-center align-items-center">
				<c:choose>
					<c:when test="${userPage.existFollow eq true}">
						<button class="btn btn-secondary w-50 followBtn" data-user-id="${userPage.user.id}">팔로우 취소</button>
					</c:when>
					<c:otherwise>
						<!-- 팔로우 중 -->
						<button class="btn btn-primary w-50 followBtn" data-user-id="${userPage.user.id}">팔로우</button>
					</c:otherwise>
				</c:choose>
					
				</div>
			</c:otherwise>
		</c:choose>
		<!-- 이미지 박스  -->
		<div class="individualImgBox d-flex flex-wrap py-5">
		<c:forEach var="post" items="${userPage.postList}">
			<c:choose>
				<c:when test="${empty post.imgPath}">
					<a href="/post/post_detail_view?postId=${post.id}" class="emptyImg" data-post-id = "${post.id}"><img alt="기본이미지" src="/static/img/timeline/noimg.gif" class="imgBox"></a>
				</c:when>
				<c:otherwise>
					<a href="/post/post_detail_view?postId=${post.id}" class="emptyImg" data-post-id = "${post.id}"><img alt="기본이미지" src="${post.imgPath}" class="imgBox"></a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</div>
</c:forEach>

	</div>
</div>
<script>
	$(document).ready(function(){
		// 팔로우 버튼
		$('.followBtn').on('click',function(){
			// alert(111);
			let followerId = $(this).data('user-id');
			let userId = ${sessionId};
			//alert(followerId);
			//alert(userId);
						
			$.ajax({
				url:"/follow/"+followerId
				,data:{"followerId":followerId, "userId":userId}
				,success:function(data){
					if(data.code == 1){
						document.location.reload();
					} else {
						alert("실패, 관리자에 문의하세요.");
					}
					
				}
				,error:function(jqXHR, textStatus, errorThrown){
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + textStatus);
				}
			});
		}); //-> 팔로우 버튼 끝
		
	});//->document end
</script>