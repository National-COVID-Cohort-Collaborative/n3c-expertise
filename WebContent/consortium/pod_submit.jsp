<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<c:forEach var="option" items="${paramValues.pod}">
	<sql:update dataSource="jdbc/N3CExpertiseTagLib">
	    insert into enclave_cohort.ctsa_hub select institutionid,institutionname,?::int from enclave_cohort.institution_master where institutionid = ?
		<sql:param>${param.id}</sql:param>
		<sql:param>${option}</sql:param>
	</sql:update>
</c:forEach>
<c:redirect url="pod_mapping.jsp" />
