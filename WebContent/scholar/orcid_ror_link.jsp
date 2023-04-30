<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

		<sql:update dataSource="jdbc/N3CExpertiseTagLib">
		    update scholar_profile.authorship_map set ror_id = ? where orcid = ?
			<sql:param>${param.ror}</sql:param>
		    <sql:param>${param.orcid}</sql:param>
		</sql:update>
<c:redirect url="orcid_ror_map.jsp" />
