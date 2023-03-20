<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

		<sql:update dataSource="jdbc/N3CExpertiseTagLib">
		    insert into scholar_profile.linkage values(?,?)
		    <sql:param>${param.url}</sql:param>
			<sql:param>${param.doi}</sql:param>
		</sql:update>
<c:redirect url="linkage.jsp" />
