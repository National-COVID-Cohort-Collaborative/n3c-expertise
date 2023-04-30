<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="pubs" dataSource="jdbc/N3CExpertiseTagLib">
select
    jsonb_pretty(jsonb_agg(pubs))
from
     	(select title,correspondingauthor,pub_date,'' as edit,'' as delete from n3c_pubs.manual_cache
     	) as pubs
;
</sql:query>
{
    "headers": [
        {"value":"title", "label":"Title"},
        {"value":"correspondingauthor", "label":"Author"},
        {"value":"pub_date", "label":"Date"},
        {"value":"edit", "label":""},
        {"value":"delete", "label":""}
    ],
    "rows" : 
<c:forEach items="${pubs.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

			