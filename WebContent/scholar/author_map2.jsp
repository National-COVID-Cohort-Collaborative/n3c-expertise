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
					select foo.given,foo.family,foo.orcid,bar.first_name,bar.last_name,bar.orcid_id
					from scholar_crossref.author_map as foo, n3c_admin.registration as bar
					where substring(foo.given from 1 for 1)=substring(bar.first_name from 1 for 1)
					  and foo.family=bar.last_name and foo.orcid is null and bar.orcid_id is not null
					  and bar.orcid_id != ''
					  order by foo.family,foo.given;
				</sql:query>
				<h3>Unbound Articles</h3>
				<table class="table table-striped">
					<tr><th>Given</th><th>Family</th><th>ORCiD</th><th>Given</th><th>Family</th><th>ORCiD</th></tr>
					<c:forEach items="${names.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td>${row.given}</td>
							<td>${row.family}</td>
							<td><a href="author_link2.jsp?given=${row.given}&family=${row.family}&orcid=${row.orcid_id}">link</a></td>
							<td>${row.first_name}</td>
							<td>${row.last_name}</td>
							<td>${row.orcid_id}</td>
						</tr>
					</c:forEach>
				</table>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
