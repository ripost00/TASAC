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
	{ label: '변경ID',					name: 'changeId',							hidden: true },
	{ label: '임시운행등록번호',name: 'tmpRaceNumber',				width: 100,	align: "center" },
	{ label: '임시운행기관',		name: 'tmpRaceAgency',				width: 150 },
	{ label: '변경일시',				name: 'modifyDateView',				width: 100,	align: "center" },
	{ label: '등록일시',				name: 'regDateView',					width: 100,	align: "center" },
	{ label: '주행모드변경',		name: 'drivingModeChangeView',width: 120,	align: "center" },
	{ label: '작동속도범위변경',name: 'spdRangeChangeView',		width: 120,	align: "center" },
	{ label: '구조 및 장치변경',name: 'deviceChangeView',			width: 120,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList1", "/record/device/selectDevcHistList.do", colModelMast, false, function(data) {
		if ($("#rowId").val() == "") $("#rowId").val("1");
		$("#gridList1").jqGrid("setSelection", $("#rowId").val());
	}
	, function(rowid, status, e) {
		fn_searchFormMast(rowid);
	});

	fn_init();

	fn_search();

	$("#sTmpNo").focus();

	//달력 이벤트
	$( "#stdate" ).datepicker();
	$( "#eddate" ).datepicker();

});

function fn_init() {
//	$("#grid1").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList1").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridList1").jqGrid("setGridHeight", $("#grid1").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList1").jqGrid("clearGridData");

	$("#sTmpNo").focus();
}

function fn_search() {
	$("#gridList1").jqGrid("clearGridData");

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
	$("#sChgId").val(rowData.changeId);

	commonAjax({ "sChgId": rowData.changeId, "sTmpNo": rowData.tmpRaceNumber }, "/record/device/selectDevcHistList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];

		$("#modifyDate").val(formData.modifyDateView);
		$("#drivingModeChangeYn").val(formData.drivingModeChangeView);
		$("#dmBeforeSpec").val(formData.dmBeforeSpec);
		$("#dmAfterSpec").val(formData.dmAfterSpec);
		$("#spdRangeChangeYn").val(formData.spdRangeChangeView);
		$("#srcBeforeSpec").val(formData.srcBeforeSpec);
		$("#srcAfterSpec").val(formData.srcAfterSpec);
		$("#deviceChangeYn").val(formData.deviceChangeView);
		$("#dcBeforeSpec").val(formData.dcBeforeSpec);
		$("#dcAfterSpec").val(formData.dcAfterSpec);
		$("#changeInfo").val(formData.changeInfo);

	});
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

	var url = "/record/device/selectDevcHistExcelList.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

function fn_report() {
	var url = "/record/device/selectDevcHistReport.do";
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
			<input type="hidden" id="sChgId" name="sChgId" value="">

			<fieldset>
				<span class="tit">임시운행등록번호</span>
				<input type="text" style="width: 150px; height: 19px;" id="sTmpNo" name="sTmpNo" value=""/>
			</fieldset>
			<fieldset>
				<span class="tit">기관명</span>
				<input type="text" style="width: 150px; height: 19px;" id="sTmpAg" name="sTmpAg" value=""/>
			</fieldset>
			<fieldset>
				<span class="tit">변경일시</span>
				<input type="text" style="width: 70px; height: 19px;" id="stdate" name="stdate" value="" /> ~
				<input type="text" style="width: 70px; height: 19px;" id="eddate" name="eddate" value="" />
			</fieldset>
		</form>
	</div>

	<div id="grid1" class="float_left" style="width: calc(50% - 27px); height: calc(100% - 109px); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px;">
		<table id="gridList1"></table>
	</div>

	<div style="width: calc(50% - 27px); height: calc(100% - 109px); float: left; border: 1px solid #c5c5c5; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
		<p class="float_left w100p mt10" style="font-weight: bold;">▶ 사고차량장치 및 기능변경 정보</p>

		<div style="overflow: auto; width: 100%; height: 100%;">
			<form id="detailForm" name="detailForm" method="post">
				<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>

				<table summary="테이블" class="table1">
					<caption></caption>
					<colgroup>
						<col width="30%" />
						<col width="*%" />
					</colgroup>
					<tbody>
						<tr>
							<th>변경일자</th>
							<td><input type="text" style="width: 100%; height: 19px;" id="modifyDate" name="modifyDate" value="" caption="변경일자" required="required"/></td>
						</tr>
						<tr>
							<th>주행모드</th>
							<td><input type="text" style="width: 100%; height: 19px;" id="drivingModeChangeYn" name="drivingModeChangeYn" value="" caption="주행모드" required="required"/></td>
						</tr>
						<tr>
							<th>변경전</th>
							<td><textarea style="width: 100%; height: 50px;" id="dmBeforeSpec" name="dmBeforeSpec" caption="변경전"></textarea></td>
						</tr>
						<tr>
							<th>변경후</th>
							<td><textarea style="width: 100%; height: 50px;" id="dmAfterSpec" name="dmAfterSpec" caption="변경후"></textarea></td>
						</tr>
						<tr>
							<th>작동 및 속도범위</th>
							<td><input type="text" style="width: 100%; height: 19px;" id="spdRangeChangeYn" name="spdRangeChangeYn" value="" caption="작동 및 속도범위" required="required"/></td>
						</tr>
						<tr>
							<th>변경전</th>
							<td><textarea style="width: 100%; height: 50px;" id="srcBeforeSpec" name="srcBeforeSpec" caption="변경전"></textarea></td>
						</tr>
						<tr>
							<th>변경후</th>
							<td><textarea style="width: 100%; height: 50px;" id="srcAfterSpec" name="srcAfterSpec" caption="변경후"></textarea></td>
						</tr>
						<tr>
							<th>구조 및 장치 변경</th>
							<td><input type="text" style="width: 100%; height: 19px;" id="deviceChangeYn" name="deviceChangeYn" value="" caption="구조 및 장치 변경" required="required"/></td>
						</tr>
						<tr>
							<th>변경전</th>
							<td><textarea style="width: 100%; height: 50px;" id="dcBeforeSpec" name="dcBeforeSpec" caption="변경전"></textarea></td>
						</tr>
						<tr>
							<th>변경후</th>
							<td><textarea style="width: 100%; height: 50px;" id="dcAfterSpec" name="dcAfterSpec" caption="변경후"></textarea></td>
						</tr>
						<tr>
							<th>변경 내용기술</th>
							<td><textarea style="width: 100%; height: 100px;" id="changeInfo" name="changeInfo" caption="변경 내용기술"></textarea></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

	</div>

</div>
</body>
</html>
