<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
	<jsp:include page="../head.jsp" flush="true" />

<style type="text/css" media="all">
	@import "../resources/n3c_login_style.css";
@import "<util:applicationRoot/>/resources/autocomplete.css";
</style>

<body>


	<jsp:include page="../navbar.jsp" flush="true" />
	
	<div class="container center-box shadow-border">
    	<h2 class="header-text"><img src="../images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C Publications</h2>
    	
    	<form name="mode" method='POST' action='manualSubmit.jsp' autocomplete="off" >
   			<div class="form-group row">
    			<label for="title" class="required col-sm-1 col-form-label">Title</label>
    			<div class="col-sm-10">
      				<input name="title" type="text" class="form-control" id="title" value="">
    			</div>
  			</div>
   			<div class="form-group row">
    			<label for="author" class="required col-sm-1 col-form-label">Author</label>
    			<div class="col-sm-10">
      				<input name="author" type="text" class="form-control" id="author" value="">
    			</div>
  			</div>
   			<div class="form-group row">
    			<label for="date" class="required col-sm-1 col-form-label">Date</label>
    			<div class="col-sm-10">
       				<input name="date" type="text" class="form-control" id="date" value="">
    			</div>
  			</div>
            
            <div style="text-align:left;">
            	<button class="btn btn-n3c" type="submit" name="action" value="submit">Submit</button>
            </div>
    	</form>
	</div>
    <jsp:include page="../footer.jsp" flush="true" />
</body>
</html>
