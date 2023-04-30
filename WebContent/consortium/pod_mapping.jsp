<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="../head.jsp" flush="true" />


<body>

	<jsp:include page="../navbar.jsp" flush="true" />

	<div class="container center-box">
		<h2 class="header-text"><img src="../images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">CTSA Pod Binding</h2>
		<div class="container">
				<sql:query var="names" dataSource="jdbc/N3CExpertiseTagLib">
					select institutionid,institutionname,clinorgtype
					from enclave_cohort.institution_master
					where clinorgtype ~'CTSA'
					and institutionid not in (select ror_id from enclave_cohort.ctsa_hub)
					order by 2;
				</sql:query>

								<form action="pod_submit.jsp" method="post" >
										<input type="submit" name="submit" value="Save">
										ID: <input name="id">
				<table class="table table-striped">
					<tr><th>Pod</th><th>ID</th><th>Name</th><th>Type</th></tr>
					<c:forEach items="${names.rows}" var="row" varStatus="rowCounter">
						<tr>
							<td><input type="checkbox" name="pod" value="${row.institutionid}"></td>
							<td>${row.institutionid}</td>
							<td>${row.institutionname}</td>
							<td>${row.clinorgtype}</td>
						</tr>
					</c:forEach>
				</table>
				</form>
		</div>
		<jsp:include page="../footer.jsp" flush="true" />
	</div>
</body>
</html>
