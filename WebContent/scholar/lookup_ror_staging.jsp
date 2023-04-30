<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="../head.jsp" flush="true" />

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="resources/d3.v3.min.js"></script>

<style type="text/css" media="all">
@import "../resources/n3c_login_style.css";
</style>

<style type="text/css">
table.dataTable thead .sorting_asc {
	background-image: none !important;
}
</style>

<body>

	<jsp:include page="../navbar.jsp" flush="true" />

	<div class="container center-box">
		<h2 class="header-text"><img src="../images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C Manuscript Tracking</h2>
		<div class="container">
		<c:choose>
			<c:when test="${empty param.submit}">
				<form action="lookup_ror_staging.jsp">
					Author: <input name="author" value="${param.author}"><br>
					Organization: <input name="org" value="" size="50"><br>
					<input type="submit" name="submit" value="Submit">
				</form>
			</c:when>
			<c:otherwise>
				<sql:query var="names" dataSource="jdbc/N3CExpertiseTagLib">
					select
						organization.id,
						organization.name,
						address.city
					from ror.organization natural join ror.address
					where name ~ ?
					order by 2;
					<sql:param>${param.org}</sql:param>
				</sql:query>
				<h3>Unbound Authors</h3>
				<table class="table table-striped">
					<tr><th>Act</th><th>Act</th><th>Author</th><th>Organization</th><th>ORCiD</th><th>ROR Name</th><th>City</th></tr>
					<c:forEach items="${names.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><a href="lookup_ror_link.jsp?author=${param.author}&ror=${row.id}">link</a></td>
							<td><a href="lookup_ror_link.jsp?author=${param.author}&ror=x">suppress</a></td>
							<td>${param.author}</td>
							<td>${param.org}</td>
							<td>${row.id}</td>
							<td>${row.name}</td>
							<td>${row.city}</td>
						</tr>
					</c:forEach>
				</table>
				<a href="lookup_ror_link.jsp?author=${param.author}&ror=x">suppress</a>
			</c:otherwise>
		</c:choose>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
