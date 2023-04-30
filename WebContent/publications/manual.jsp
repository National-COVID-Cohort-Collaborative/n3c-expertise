<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<jsp:include page="../head.jsp" flush="true" />

<body>

	<jsp:include page="../navbar.jsp" flush="true" />

	<div class="container">
		<h1>Manual Publication Entries</h1>
		<a href="manualAdd.jsp"><i class="fas fa-plus-circle fa-2x text-success"></i></a>
		<div id="conference"></div>
		<jsp:include page="../tables/conference.jsp"/>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
