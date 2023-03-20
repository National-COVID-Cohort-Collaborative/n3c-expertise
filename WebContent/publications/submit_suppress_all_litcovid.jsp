<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

		<sql:update dataSource="jdbc/N3CExpertiseTagLib">
		    insert into n3c_pubs.suppress(pmid)
					select
						article_title.pmid
					from covid_litcovid.article_title, covid_litcovid.author
					where article_title.pmid=author.pmid
					  and not exists (select pmid from n3c_pubs.suppress where suppress.pmid=article_title.pmid)
					  and not exists (select pmid from n3c_pubs.match where match.pmid=article_title.pmid)
					  and author.last_name = ?
					  and author.fore_name ~ ('^'||?)
					order by last_name,fore_name, article_title;
					<sql:param>${param.author}</sql:param>
					<sql:param>${param.initial}</sql:param>
		</sql:update>

<c:redirect url="scan.jsp">
<c:param name="author">${param.author}</c:param>
<c:param name="initial">${param.initial}</c:param>
</c:redirect>
