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
						authorship_map.*,
						organization,
						organization.id,
						organization.name
					from scholar_profile.authorship_map, orcid.employment, ror.organization
					where authorship_map.orcid=employment.orcid_id
					  and end_year is null
					  and ror_id is null
					  and organization~name
					  and name!~'[[()\\]'
					order by 4,2;
				</sql:query>
				<h3>Unbound Authors</h3>
				<table class="table table-striped">
					<tr><th>Act</th><th>Act</th><th>Author</th><th>ORCiD</th><th>ORCiD Orgs</th><th>ROR ID</th><th>ROR Name</tr>
					<c:forEach items="${names.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><a href="orcid_ror_link.jsp?ror=${row.id}&orcid=${row.orcid}">link</a></td>
							<td><a href="orcid_ror_link.jsp?ror=x&orcid=${row.orcid}">suppress</a></td>
							<td>${row.author}</td>
							<td>${row.orcid}</td>
							<td>${row.organization}</td>
							<td>${row.id}</td>
							<td>${row.name}</td>
						</tr>
					</c:forEach>
				</table>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
