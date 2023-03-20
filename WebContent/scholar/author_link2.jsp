<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

		<sql:update dataSource="jdbc/N3CExpertiseTagLib">
		    update scholar_crossref.author_map set orcid = ? where given = ? and family = ?
		    <sql:param>${param.orcid}</sql:param>
			<sql:param>${param.given}</sql:param>
			<sql:param>${param.family}</sql:param>
		</sql:update>
<c:redirect url="author_map2.jsp" />
