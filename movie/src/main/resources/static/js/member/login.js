$(function() {
	// 로그인 시도 시
	$('#signInForm').on('submit', function() {
		// 에러메시지 가리기
		$('.error_message').hide();
		
		// 아이디를 입력하지 않은 경우
		if($('[name="id"]').val().trim() == '') {
			$('#idErrorMsg').show();
	    	return false;
		}
		
		// 비밀번호를 입력하지 않은 경우
		if($('[name="pw"]').val().trim() == '') {
			$('#pwErrorMsg').show();
	    	return false;
		}
		
	});
	
	
	
});