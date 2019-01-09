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
	{ label: '게시물번호',	name: 'bSeq',					hidden: true },
	{ label: '업로드ID',		name: 'regId',				width: 120,	align: "center" },
	{ label: '이름',				name: 'userNm',				width: 120,	align: "center" },
	{ label: '기관명',			name: 'agencyName',		width: 200,	align: "center" },
	{ label: '데이터유형',	name: 'bbsNm',				width: 100,	align: "center" },
	{ label: '제목',				name: 'bTitle',				width: 300 },
	{ label: '등록일시',		name: 'regDateView',	width: 120,	align: "center" },
	{ label: '파일명',			name: 'saveNm',				width: 300 },
	{ label: '파일사이즈',	name: 'fileSizeView',			width: 100,	align: "center" },
	// { label: '주행모드',		name: 'drivingModeView',	width: 100,	align: "center" },
	// { label: '기상상황',		name: 'weatherView',			width: 80,	align: "center" },
	// { label: '도로상황',		name: 'roadSituationView',	width: 80,	align: "center" },
	// { label: '도로유형코드',name: 'roadTypeCdView',			width: 100,	align: "center" },
	{ label: '차량ID',			name: 'vehicleId',			width: 100,	align: "center" }
];

var colModelDetl = [
	{ label: '기관명',		name: 'dlId',			width: 300 },
	{ label: '다운횟수',	name: 'cnt',			width: 100,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList1", "/record/dataused/selectDataUsedList.do", colModelMast, true, function(data) {
		if ($("#rowId").val() == "") $("#rowId").val("1");
		$("#gridList1").jqGrid("setSelection", $("#rowId").val());
	}
	, function(rowid, status, e) {
		fn_searchFormMast(rowid);
	});

	commonMakeGrid("gridList2", "/record/dataused/selectDataUsedDtlList.do", colModelDetl, true, function(data) {
		$("#gridList2").jqGrid("setSelection", "1");
	});

	fn_init();

	fn_search();

	$("#sTitle").focus();

	//달력 이벤트
	$( "#stdate" ).datepicker();
	$( "#eddate" ).datepicker();

	$("#sTitle").keypress(function(e) {
	    if(e.keyCode == 13) fn_search();
	});
});

function fn_init() {
//	$("#grid1").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList1").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridList1").jqGrid("setGridHeight", $("#grid1").height()-30);

	$("#gridList2").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridList2").jqGrid("setGridHeight", $("#grid2").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");

	$("#sTitle").focus();
}

function fn_search() {
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");

	var searchData = {
		sTitle: $("#sTitle").val(),
		stdate: $("#stdate").val(),
		eddate: $("#eddate").val()
	};
	$("#gridList1").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchFormMast(rowId) {
	var rowData = $("#gridList1").jqGrid("getRowData", rowId);
	$("#sBSeq").val(rowData.bSeq);

	fn_searchDetl(rowData.bSeq);
}

function fn_searchDetl(bSeq) {
	$("#gridList2").jqGrid("clearGridData");

	var searchData = {
		sBSeq: bSeq
	};
	$("#gridList2").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
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
		</div>
	</div>

	<div class="box_search">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">

			<fieldset>
				<span class="tit">제목</span>
				<input type="text" style="width: 150px; height: 19px;" id="sTitle" name="sTitle" value=""/>
			</fieldset>
			<fieldset>
				<span class="tit">업로드 일시</span>
				<input type="text" style="width: 70px; height: 19px;" id="stdate" name="stdate" value="" /> ~
				<input type="text" style="width: 70px; height: 19px;" id="eddate" name="eddate" value="" />
			</fieldset>
		</form>
	</div>

	<div id="grid1" class="float_left" style="width: calc(70% - 27px); height: calc(100% - 109px); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px;">
		<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
		<table id="gridList1"></table>
	</div>

	<div style="width: calc(30% - 27px); height: calc(100% - 109px); float: left; border: 1px solid #c5c5c5; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
		<div id="grid2" class="float_left" style="float: right; width: 100%; height: 100%;">
			<table id="gridList2"></table>
		</div>
	</div>

</div>
</body>
</html>
