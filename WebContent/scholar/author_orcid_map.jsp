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
						array(
							select distinct institution
							from
								scholar_profile.authorship as foo,
								scholar_profile.authorship as bar,
								scholar_profile.authorship_map as xxx,
								n3c_admin.registration
							where foo.author=authorship_map.author
							  and foo.id=bar.id
							  and bar.author=xxx.author
							  and xxx.orcid=registration.orcid_id
							 order by 1
						) as reg_authors,
						array(
							select distinct institution
							from
								scholar_profile.authorship as foo,
								scholar_profile.authorship as bar,
								scholar_profile.authorship_map as xxx,
								scholar_crossref.author as cauthor,
								(select distinct doi,institution
								 from (select doi,btrim(unnest(string_to_array(unnest(string_to_array(affiliation, '  ')), ','))) as institution
								 		from scholar_crossref.affiliation) as foo, scholar_crossref.organization_map where institution~label) as affiliation
							where foo.author=authorship_map.author
							  and foo.id=bar.id
							  and bar.author=xxx.author
							  and xxx.orcid=cauthor.orcid
							  and cauthor.doi = affiliation.doi
							 order by 1
						) as cross_authors,
						person.given_names as gn,
						person.family_name as fn,
						person.orcid_id,organization
					from scholar_profile.authorship_map,orcid.person,orcid.employment
					where authorship_map.last_name=person.family_name
					  and authorship_map.first_name=person.given_names
					  and person.id = employment.id
					  and employment.end_year is null
					  and authorship_map.orcid is null
					order by 4,2,6;
				</sql:query>
				<h3>Unbound Authors</h3>
				<table class="table table-striped">
					<tr><th>Act</th><th>Act</th><th>Author</th><th>N3C Orgs</th><th>CrossRef Orgs</th><th>First</th><th>Last</th><th>ORCiD</th><th>Organization</th></tr>
					<c:forEach items="${names.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><a href="author_orcid_link.jsp?author=${row.author}&orcid=${row.orcid_id}">link</a></td>
							<td><a href="author_orcid_link.jsp?author=${row.author}&orcid=x">suppress</a></td>
							<td>${row.author}</td>
							<td>${row.reg_authors}</td>
							<td>${row.cross_authors}</td>
							<td>${row.gn}</td>
							<td>${row.fn}</td>
							<td>${row.orcid_id}</td>
							<td>${row.organization}</td>
						</tr>
					</c:forEach>
				</table>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
