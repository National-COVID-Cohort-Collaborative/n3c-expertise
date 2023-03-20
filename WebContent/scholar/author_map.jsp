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
					select foo.given as given1,foo.family as family1,foo.orcid as orcid1,bar.given as given2,bar.family as family2,bar.orcid as orcid2
					from scholar_crossref.author_map as foo, scholar_crossref.author_map as bar
					where substring(foo.given from 1 for 1)=substring(bar.given from 1 for 1)
					  and foo.family=bar.family
					  and foo.orcid is null and bar.orcid is not null
					order by foo.family,foo.given;
				</sql:query>
				<h3>Unbound Articles</h3>
				<table class="table table-striped">
					<tr><th>Given</th><th>Family</th><th>ORCiD</th><th>Given</th><th>Family</th><th>ORCiD</th></tr>
					<c:forEach items="${names.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td>${row.given1}</td>
							<td>${row.family1}</td>
							<td><a href="author_link.jsp?given=${row.given1}&family=${row.family1}&orcid=${row.orcid2}">link</a></td>
							<td>${row.given2}</td>
							<td>${row.family2}</td>
							<td>${row.orcid2}</td>
						</tr>
					</c:forEach>
				</table>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
