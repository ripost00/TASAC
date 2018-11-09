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
	{ label: '사고ID',		name: 'accId',						hidden: true },
	{ label: '임시운행등록번호',name: 'tmpRaceNumber',				width: 100,	align: "center" },
	{ label: '임시운행기관',		name: 'tmpRaceAgency',				width: 150 },
	{ label: '사고일시',			name: 'accDateView',				width: 100,	align: "center" },
	{ label: '등록일시',		name: 'regDateView',				width: 100,	align: "center" },
	{ label: '장소',			name: 'place',						width: 200 },
	{ label: '기상상황',		name: 'weatherView',				width: 100,	align: "center" },
	{ label: '도로상황',		name: 'roadSituationView',			width: 100,	align: "center" },
	{ label: '도로유형코드',	name: 'roadTypeCdView',				width: 100,	align: "center" },
	{ label: '주행모드',		name: 'autocarDrivingModeView',		width: 100,	align: "center" },
	{ label: '주행상태',		name: 'autocarDrivingStatusCdView',	width: 60,	align: "center" },
	{ label: '운행속도',		name: 'autocarSpeed',				width: 60,	align: "center" },
	{ label: '승차인원',		name: 'autocarRideNumber',			width: 60,	align: "center" },
	{ label: '적재량',		name: 'autocarLoadVol',				width: 60,	align: "center" },
	{ label: '파손정도',		name: 'autocarDamageView',			width: 60,	align: "center" }
];

var colModelDetl = [
	{ label: '사고ID',	name: 'accId',						hidden: true },
	{ label: '사고차량종류',name: 'acccarCarTypeView',			width: 80,	align: "center" },
	{ label: '주행모드',	name: 'acccarDrivingModeView',		width: 80,	align: "center" },
	{ label: '주행상태',	name: 'acccarDrivingStatusCdView',	width: 80,	align: "center" },
	{ label: '운행속도',	name: 'acccarSpeed',				width: 80,	align: "center" },
	{ label: '승차인원',	name: 'acccarRideNumber',			width: 80,	align: "center" },
	{ label: '적재량',	name: 'acccarLoadVol',				width: 80,	align: "center" },
	{ label: '파손정도',	name: 'acccarDamageView',			width: 80,	align: "center" },
	{ label: '인적피해',	name: 'humanInjuryTypeView',		width: 80,	align: "center" },
	{ label: '성별',		name: 'acccarHumanSexView',			width: 80,	align: "center" },
	{ label: '나이',		name: 'acccarHumanAge',				width: 80,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList1", "/record/incident/selectIncdHistList.do", colModelMast, false, function(data) {
		if ($("#rowId").val() == "") $("#rowId").val("1");
		$("#gridList1").jqGrid("setSelection", $("#rowId").val());
	}
	, function(rowid, status, e) {
		fn_searchFormMast(rowid);
	});

	commonMakeGrid("gridList2", "/record/incident/selectAccCarList.do", colModelDetl, false, function(data) {
		$("#gridList2").jqGrid("setSelection", "1");
	});

	//commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);

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

	$("#gridList2").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridList2").jqGrid("setGridHeight", $("#grid2").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");

	$("#sTmpNo").focus();
}

function fn_search() {
	$("#gridList1").jqGrid("clearGridData");
	$("#gridList2").jqGrid("clearGridData");

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

	commonAjax({ "sAccId": rowData.accId }, "/record/incident/selectIncdHistList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];

		$("#humanInjuryType").val(formData.humanInjuryTypeView);
		$("#autocarHumanSex").val(formData.autocarHumanSexView);
		$("#autocarHumanAge").val(formData.autocarHumanAge);
		$("#accDetailInfo").val(formData.accDetailInfo);

		fn_searchDetl(formData.accId);
	});
}

function fn_searchDetl(accId) {
	$("#gridList2").jqGrid("clearGridData");

	var searchData = {
		sAccId: accId
	};
	$("#gridList2").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
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

	var url = "/record/incident/selectIncdHistExcelList.do";
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
				<span class="tit">임시운행등록번호</span>
				<input type="text" style="width: 150px; height: 19px;" id="sTmpNo" name="sTmpNo" value=""/>
			</fieldset>
			<fieldset>
				<span class="tit">기관명</span>
				<input type="text" style="width: 150px; height: 19px;" id="sTmpAg" name="sTmpAg" value=""/>
			</fieldset>
			<fieldset>
				<span class="tit">사고일시</span>
				<input type="text" style="width: 70px; height: 19px;" id="stdate" name="stdate" value="" /> ~
				<input type="text" style="width: 70px; height: 19px;" id="eddate" name="eddate" value="" />
			</fieldset>
		</form>
	</div>

	<div id="grid1" class="float_left w100p" style="height: calc(50% - 60.5px);">
		<table id="gridList1"></table>
	</div>

	<div class="float_left w100p" style="height: calc(50% - 69px); margin-top: 16px;">
		<p class="float_left w100p mt10" style="font-weight: bold;">▶ 사고차량 정보</p>

		<div id="form1" class="form_box" style="width: 568px; height: calc(100% - 21.5px); margin-top: 0px;">
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
							<th>자율주행차 인적피해</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="humanInjuryType" name="humanInjuryType" value="" caption="인적피해" required="required"/></td>
						</tr>
						<tr>
							<th>자율주행차 성별</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="autocarHumanSex" name="autocarHumanSex" value="" caption="성별" required="required"/></td>
						</tr>
						<tr>
							<th>자율주행차 나이</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="autocarHumanAge" name="autocarHumanAge" value="" caption="나이" required="required"/></td>
						</tr>
						<tr>
							<th>사고상세묘사</th>
							<td><textarea style="width: 300px; height: 45px;" id="accDetailInfo" name="accDetailInfo" caption="사고상세묘사"></textarea></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<div id="grid2" class="float_left" style="float: right; width: calc(100% - 600px); height: 100%;">
			<table id="gridList2"></table>
		</div>
	</div>

</div>
</body>
</html>
