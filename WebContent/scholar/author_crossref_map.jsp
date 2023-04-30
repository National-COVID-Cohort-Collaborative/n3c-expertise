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
					select authorship_map.*, author_map.given, author_map.family, author_map.orcid as orcid_id
					from scholar_profile.authorship_map,scholar_crossref.author_map
					where lower(authorship_map.last_name)=lower(author_map.family)
					  and authorship_map.orcid is null
					order by 4,2,6;
				</sql:query>
				<h3>Unbound Authors</h3>
				<table class="table table-striped">
					<tr><th>ORCiD</th><th>ORCiD</th><th>Author</th><th>First</th><th>Last</th><th>ORCiD</th></tr>
					<c:forEach items="${names.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><a href="author_crossref_link.jsp?author=${row.author}&orcid=${row.orcid_id}">link</a></td>
							<td><a href="author_crossref_link.jsp?author=${row.author}&orcid=x">suppress</a></td>
							<td>${row.author}</td>
							<td>${row.given}</td>
							<td>${row.family}</td>
							<td>${row.orcid_id}</td>
						</tr>
					</c:forEach>
				</table>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
