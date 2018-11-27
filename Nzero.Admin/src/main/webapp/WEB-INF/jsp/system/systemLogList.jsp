<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>

<%@ include file="/include/header.jsp" %>

<script src="/js/jquery-ui-1.12.1.custom/datepicker-ko.js"></script> <!-- jQuery 달력 -->
<script type="text/javascript">
var colModelMast = [
	{ label: '발생일자', name: 'issueDate',   width: 120,	align: "center" },
	{ label: '로그ID',	 name: 'logId',				width: 100, align: "center" },
	{ label: '요청자ID',	name: 'requesterId', width: 100, align: "center" },
	{ label: '서비스명', name: 'serviceNm',		width: 300},
	{ label: '메소드명', name: 'methodNm',    width: 200},
	{ label: '처리구분', name: 'processCd',		width: 100,	align: "center" },
	{ label: '처리시간', name: 'processTime',	width: 100,	align: "center" },
	{ label: '요청자IP', name: 'requesterIp', width: 120, align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	//달력 이벤트
	$( "#stdate" ).datepicker().datepicker("setDate", -1);
	$( "#eddate" ).datepicker().datepicker("setDate", new Date());

	commonMakeGrid("gridList", "/system/rsrc/selectSystemLogList.do", colModelMast, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
		}
		, function(rowid, status, e) {
		}
	);
	fn_init();
	fn_search();
	$("#sKeyword").focus();
});

function fn_init() {
	$('#grid').css('height', 'calc(100% - 109px)');
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	$('#gridList').jqGrid('setGridHeight', $('#grid').height()-2);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");

	$("#sKeyword").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");

	var searchData = {
		sKeyword: $("#sKeyword").val(),
		stdate: $("#stdate").val(),
		eddate: $("#eddate").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_excel() {
	var columnsNm = [], datafield = [];
	for (var i=0; i<colModelMast.length-1; i++) {
		columnsNm[i] = colModelMast[i].label;
		datafield[i] = colModelMast[i].name;
	}

	$("#columnsNm").val(columnsNm);
	$("#datafield").val(datafield);
	$("#excelFileNm").val("<%=menuNm%>.xls");

	var url = "/system/rsrc/selectSystemLogExcel.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

</script>
</head>

<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap">
	<div class="float_left w100p">
		<div class="cont_tit2">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

		<div class="contBtn1">
			<a href="javascript:fn_initClear()" class="btn_refresh" title="초기화"></a>
			<i></i>
			<a href="javascript:fn_search()" class="btn_search" title="조회"></a>
			<i></i>
			<a href="javascript:fn_excel()" class="btn_excel" title="엑셀"></a>
		</div>
	</div>

	<div class="box_search">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">

			<fieldset>
				<span class="tit">서비스명</span>
				<input type="text" style="width: 150px; height: 19px;" id="sKeyword" name="sKeyword" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
			</fieldset>
			<fieldset style="width: 400px;">
				<span class="tit">발생일시</span>
				<input type="text" style="width: 100px; height: 19px;" id="stdate" name="stdate" value="" /> ~
				<input type="text" style="width: 100px; height: 19px;" id="eddate" name="eddate" value="" />
			</fieldset>
		</form>
	</div>

	<div id="grid" class="float_left w100p">
		<table id="gridList"></table>
	</div>

</div>
</body>
</html>
