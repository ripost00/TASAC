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
	{ label: '기준일ID',		name: 'stndDtKey',				hidden: true },
	{ label: '임시운행기관',	name: 'tmpRaceAgency',			width: 200 },
	{ label: '임시운행등록번호',name: 'tmpRaceNumber',			width: 120,	align: "center" },
	{ label: '기준일자',		name: 'stndDtView',				width: 120,	align: "center" },
	{ label: '등록일시',		name: 'regDateView',			width: 120,	align: "center" },
	{ label: '총주행거리',		name: 'totalDrivingDist',		width: 150,	align: "center" },
	{ label: '자율모드주행거리',name: 'autoDrivingDist',		width: 150,	align: "center" },
	{ label: '일반모드주행거리',name: 'nomalDrivingDist',		width: 150,	align: "center" },
//	{ label: '보험증서번호',	name: 'insLetterNumber',		width: 150,	align: "center" },
	{ label: '보험가입일자',	name: 'insInitDateView',		width: 150,	align: "center" },
	{ label: '등록기한 경과',	name: 'coldiff',		width: 150,	align: "center" }
];

var colModelDtl2 = [
	{ label: '기준월',			name: 'drivingDistMonView',		width: 100,	align: "center" },
	{ label: '자율모드주행거리',name: 'autoDrivingDist',		width: 200,	align: "center" }
];

var colModelDtl3 = [
	{ label: '기준월',			name: 'ctrChangeMonView',		width: 100,	align: "center" },
	{ label: '제어권 전환 횟수',name: 'ctrChangeCnt',			width: 200,	align: "center" }
];

var colModelDtl4 = [
	{ label: '일시(월/일/시)',	name: 'ctrChangeDateView',		width: 120,	align: "center" },
	{ label: '장소',			name: 'ctrChangePlace',			width: 200 },
	{ label: '사유',			name: 'ctrChangeContent',		width: 250 },
	{ label: '비고',			name: 'rmk',					width: 200 }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList1", "/record/driving/selectDrvgHistList.do", colModelMast, true, function(data) {
		if ($("#rowId").val() == "") $("#rowId").val("1");
		$("#gridList1").jqGrid("setSelection", $("#rowId").val());
	}
	, function(rowid, status, e) {
		fn_searchFormMast(rowid);
	});

	commonMakeGrid("gridList2", "/record/driving/selectAutoDrivingList.do", colModelDtl2, true, function(data) {
		$("#gridList2").jqGrid("setSelection", "1");
	});

	commonMakeGrid("gridList3", "/record/driving/selectCtrChangeList.do", colModelDtl3, true, function(data) {
		$("#gridList3").jqGrid("setSelection", "1");
	});

	commonMakeGrid("gridList4", "/record/driving/selectCtrChangeDtlList.do", colModelDtl4, true, function(data) {
		$("#gridList4").jqGrid("setSelection", "1");
	});

	//commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);

	fn_init();

	fn_search();

	$("#sTmpNo").focus();

	//달력 이벤트
	$( "#stdate" ).datepicker();
	$( "#eddate" ).datepicker();

	$("#sTmpNo").keypress(function(e) {
	    if(e.keyCode == 13) fn_search();
	});
	$("#sTmpAg").keypress(function(e) {
	    if(e.keyCode == 13) fn_search();
	});
});

function fn_init() {
//	$("#grid1").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList1").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridList1").jqGrid("setGridHeight", $("#grid1").height()-45);

	$("#gridList2").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridList2").jqGrid("setGridHeight", $("#grid2").height()-45);

	$("#gridList3").jqGrid("setGridWidth", $("#grid3").width()-2);
	$("#gridList3").jqGrid("setGridHeight", $("#grid3").height()-45);

	$("#gridList4").jqGrid("setGridWidth", $("#grid4").width()-2);
	$("#gridList4").jqGrid("setGridHeight", $("#grid4").height()-45);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");
	$("#gridList3").jqGrid("clearGridData");
	$("#gridList4").jqGrid("clearGridData");

	$("#sTmpNo").focus();
}

function fn_search() {
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");
	$("#gridList3").jqGrid("clearGridData");
	$("#gridList4").jqGrid("clearGridData");

	var searchData = {
		sTmpNo: $("#sTmpNo").val(),
		sTmpAg: $("#sTmpAg").val(),
		stdate: $("#stdate").val(),
		eddate: $("#eddate").val()
	};
	$("#gridList1").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchFormMast(rowId) {
	var rowData = $("#gridList1").jqGrid("getRowData", rowId);
	$("#sStdDt").val(rowData.stndDtKey);
	$("#sDrvNo").val(rowData.tmpRaceNumber);

	commonAjax({ "sStdDt": rowData.stndDtKey, "sTmpNo": rowData.tmpRaceNumber }, "/record/driving/selectDrvgHistList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];

		fn_searchDtl2(formData.stndDtKey, formData.tmpRaceNumber);
		fn_searchDtl3(formData.stndDtKey, formData.tmpRaceNumber);
		fn_searchDtl4(formData.stndDtKey, formData.tmpRaceNumber);
	});
}

function fn_searchDtl2(stdDt, tmpNo) {
	$("#gridList2").jqGrid("clearGridData");

	var searchData = {
		sStdDt: stdDt,
		sTmpNo: tmpNo
	};
	$("#gridList2").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchDtl3(stdDt, tmpNo) {
	$("#gridList3").jqGrid("clearGridData");

	var searchData = {
		sStdDt: stdDt,
		sTmpNo: tmpNo
	};
	$("#gridList3").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchDtl4(stdDt, tmpNo) {
	$("#gridList4").jqGrid("clearGridData");

	var searchData = {
		sStdDt: stdDt,
		sTmpNo: tmpNo
	};
	$("#gridList4").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_excel() {
	var columnsNm = [], datafield = [];
	for (var i=0; i<colModelMast.length; i++) {
		columnsNm[i] = colModelMast[i].label;
		datafield[i] = colModelMast[i].name;
	}

	$("#columnsNm").val(columnsNm);
	$("#datafield").val(datafield);
	$("#excelFileNm").val("<%=menuNm%>.xls");

	var url = "/record/driving/selectDrvgHistExcelList.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

function fn_report() {
	var url = "/record/driving/selectDrvgHistReport.do";
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
			<a href="javascript:fn_report()" class="btn_template_down" title="보고서 출력"></a>
			<i></i>
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
			<input type="hidden" id="sStdDt" name="sStdDt" value="">
			<input type="hidden" id="sDrvNo" name="sDrvNo" value="">

			<fieldset>
				<span class="tit">임시운행등록번호</span>
				<input type="text" style="width: 150px; height: 19px;" id="sTmpNo" name="sTmpNo" value=""/>
			</fieldset>
			<fieldset>
				<span class="tit">기관명</span>
				<input type="text" style="width: 150px; height: 19px;" id="sTmpAg" name="sTmpAg" value=""/>
			</fieldset>
			<fieldset>
				<span class="tit">기준일시</span>
				<input type="text" style="width: 70px; height: 19px;" id="stdate" name="stdate" value="" /> ~
				<input type="text" style="width: 70px; height: 19px;" id="eddate" name="eddate" value="" />
			</fieldset>
		</form>
	</div>

	<div id="grid1" class="float_left" style="width: calc(100%); height: calc(50%);">
		<form id="detailForm" name="detailForm" method="post">
		<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
		<p class="float_left w100p" style="font-weight: bold;">▶ 운행정보</p>
		<div id="grid_1" class="float_left" style="width: calc(100%); height: calc(100%);">
			<table id="gridList1"></table>
		</div>
		</form>
	</div>

	<div id="grid2" class="float_left" style="width: calc(25% - 27px); height: calc(36%); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px; margin-top: 10px;">
		<p class="float_left w100p" style="font-weight: bold;">▶ 월별 자율모드주행거리</p>
		<div id="grid_2" class="float_left bottom" style="width: calc(100%); height: calc(100%);">
			<table id="gridList2"></table>
		</div>
	</div>

	<div id="grid3" class="float_left" style="width: calc(25% - 27px); height: calc(36%); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px; margin-top: 10px; margin-left: 10px;">
		<p class="float_left w100p" style="font-weight: bold;">▶ 월별 제어권 전환 횟수</p>
		<div id="grid_3" class="float_left bottom" style="width: calc(100%); height: calc(100%);">
			<table id="gridList3"></table>
		</div>
	</div>

	<div id="grid4" class="float_left" style="width: calc(50% - 33px); height: calc(36%); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px; margin-top: 10px; margin-left: 10px;">
		<p class="float_left w100p" style="font-weight: bold;">▶ 제어권 전환 상세정보</p>
		<div id="grid_4" class="float_left" style="width: calc(100%); height: calc(100%);">
			<table id="gridList4"></table>
		</div>
	</div>
</div>
</body>
</html>
