<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

		<sql:update dataSource="jdbc/N3CExpertiseTagLib">
		    insert into n3c_pubs.suppress(doi)
					select
						doi
					from covid_biorxiv.biorxiv_current natural join covid_biorxiv.biorxiv_current_author
					where not exists (select doi from n3c_pubs.suppress where suppress.doi=biorxiv_current.doi)
					  and not exists (select doi from n3c_pubs.match where match.doi=biorxiv_current.doi)
					  and name ~ ('^'||?||'.*[^a-zA-Z]+'||?||'($|[^a-zA-Z])')
					order by name;
					<sql:param>${param.initial}</sql:param>
					<sql:param>${param.author}</sql:param>
		</sql:update>

<c:redirect url="scan.jsp">
<c:param name="author">${param.author}</c:param>
<c:param name="initial">${param.initial}</c:param>
</c:redirect>
