<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
	String menuNm = (request.getParameter("menuNm") == null ? "" : request.getParameter("menuNm"));
	menuNm = new String(menuNm.getBytes("8859_1"),"UTF-8");  
%>

<link rel="stylesheet" href="<c:url value='/js/jquery-ui-1.12.1.custom/jquery-ui.css' />" type="text/css"/>
<link rel="stylesheet" href="<c:url value='/js/jqGrid_JS_5.3.1/css/ui.jqgrid.css' />" type="text/css"/>
<link rel="stylesheet" href="<c:url value='/css/yearpicker.css' />" type="text/css"/>
<link rel="stylesheet" href="<c:url value='/css/layout.css' />" type="text/css"/>

<script type="text/javascript" src="<c:url value='/js/jquery-3.3.1.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.12.1.custom/jquery-ui.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jqGrid_JS_5.3.1/js/i18n/grid.locale-kr.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jqGrid_JS_5.3.1/js/jquery.jqGrid.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-validation-1.17.0/dist/jquery.validate.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-validation-1.17.0/dist/additional-methods.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery-validation-1.17.0/dist/localization/messages_ko.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/yearpicker.js' />" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/common.js' />" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	jQuery.validator.setDefaults({
		onkeyup : false,
		onclick : false,
		onfocusout : false,
		showErrors : function(errorMap, errorList) {
			if (errorList[0] != undefined) {
				var caption = $(errorList[0].element).attr('caption')
						|| $(errorList[0].element).attr('name');
				alert('[ ' + caption + ' ]는(은) ' + errorList[0].message);
				$(errorList[0].element).focus();
			}
		}
	});
});
</script>

<!-- loading Bar 표시-->
<div id="lodingBar" style="position: absolute; z-index: 100000; width: 100%; height: 100%; background: rgba(0,0,0,0.0); display: none;">
	<div style="text-align: center; margin-top: 25%;"><img src="<c:url value="/images/common/loading.gif"/>" /></div>
	<div style="width: 100%; margin-top: 20px; text-align: center; font-weight: bold; color: black;">L o a d i n g . . .</div>
</div>