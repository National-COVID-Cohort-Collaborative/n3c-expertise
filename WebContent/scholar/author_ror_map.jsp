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
				<sql:query var="names" dataSource="jdbc/N3CExpertiseTagLib">
					select
						foo.*,
						bar.first_name as fn,
						bar.last_name as ln,
						bar.ror_id as ror
					from scholar_profile.authorship_map as foo,aws_n3c_admin.gsuite_view as bar
					where foo.ror_id is null
					  and lower(foo.last_name)=lower(bar.last_name)
					  and lower(substring(foo.first_name from 1 for 1))=lower(substring(bar.first_name from 1 for 1));
				</sql:query>
				<h3>Unbound Authors</h3>
				<table class="table table-striped">
					<tr><th>Act</th><th>Act</th><th>Author</th><th>First</th><th>Last</th><th>N3C First</th><th>N3C Last</th><th>ROR ID</th></tr>
					<c:forEach items="${names.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><a href="author_ror_link.jsp?author=${row.author}&ror=${row.ror}">link</a></td>
							<td><a href="author_ror_link.jsp?author=${row.author}&ror=x">suppress</a></td>
							<td>${row.author}</td>
							<td>${row.first_name}</td>
							<td>${row.last_name}</td>
							<td>${row.fn}</td>
							<td>${row.ln}</td>
							<td>${row.ror}</td>
						</tr>
					</c:forEach>
				</table>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
