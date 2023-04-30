<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:update var="admins" dataSource="jdbc/N3CExpertiseTagLib">
	delete from n3c_pubs.manual_cache where title=? and correspondingauthor=? and pub_date=?::date
	<sql:param>${param.title}</sql:param>
	<sql:param>${param.author}</sql:param>
	<sql:param>${param.date}</sql:param>
</sql:update>
<c:redirect url="manual.jsp" />
