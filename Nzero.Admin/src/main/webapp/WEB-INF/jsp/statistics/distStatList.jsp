<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>

<%@ include file="/include/header.jsp" %>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
// global 변수 선언
var colNames, colModel, sPKColumn, searchData;
// grid column 구조
var colNm_mon_All = ['구분','1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월','총 누적 (km/h)'];
var colNm_mon_Temp = ['임시운행번호','1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월','총 누적 (km/h)'];
var colNm_mon_User = ['기관ID','1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월','총 누적 (km/h)'];
var colModel_mon = [
	{ name: 'trn', width: 120, align: 'center' },
	{ name: 'm01', align: 'center'},{ name: 'm02', align: 'center'},{ name: 'm03', align: 'center'},{ name: 'm04', align: 'center'},
	{ name: 'm05', align: 'center'},{ name: 'm06', align: 'center'},{ name: 'm07', align: 'center'},{ name: 'm08', align: 'center'},
	{ name: 'm09', align: 'center'},{ name: 'm10', align: 'center'},{ name: 'm11', align: 'center'},{ name: 'm12', align: 'center'},
	{ name: 'tot', align: 'center'}
];
var colNm_year = [];
var colModel_year = [];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	// 구글차트 init
	google.charts.load("current", {packages:["corechart"]});
	$('#sKeyword').prop('disabled', true);
	// 날짜 default 설정
	$('#sDate').yearpicker();
	$('#eDate').yearpicker();
	// 현재 검색옵션(구분, 년/월단위, 기간)에 따른 초기 grid 모양 설정
	fn_makeGrid();
	fn_search();
});

// 현재 검색옵션에 따른 db 테이블명 return
function getColNames() {
	var selType = $('#sType').val();
	var selTerm = $('#sTerm').val();
	if(selTerm == 'MON'){
		colNames = colNm_mon_All; //default
		switch(selType) {
			case 'SEL_ALL':
				colNames = colNm_mon_All;
				break;
			case 'SEL_TEMP':
				colNames = colNm_mon_Temp;
				break;
			case 'SEL_USER':
				colNames = colNm_mon_User;
				break;
		}
	}
	else if(selTerm == 'YEAR'){
		colNm_year = [];
		switch(selType) {
			case 'SEL_ALL':
				colNm_year.push('구분');
				break;
			case 'SEL_TEMP':
				colNm_year.push('임시운행번호');
				break;
			case 'SEL_USER':
				colNm_year.push('기관ID');
				break;
		}
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++) colNm_year.push(String(i));
		colNm_year.push('총 누적 (km/h)');
		colNames = colNm_year;
	}
	return colNames;
}

// 현재 검색옵션에 따른 grid column 구조 return
function getColModel() {
	var selTerm = $('#sTerm').val();
	if(selTerm == 'MON'){
		colModel = colModel_mon; //default
	}
	else if(selTerm == 'YEAR'){
		colModel_year = [];
		colModel_year.push({ name: 'trn', width: 120, align: 'center' });
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++) {
			colModel_year.push({ name: String(i), align: 'center'});
		}
		colModel_year.push({ name: 'tot', align: 'center'});
		colModel = colModel_year; //default
	}
	return colModel;
}

// 데이터 조회 시 현재 검색옵션 파라미터 return
function getSearchData() {
	var sDt = $('#sDate').val();
	var eDt = $('#eDate').val();
	var yearArr = '';
	if($('#sTerm').val() == 'YEAR') {
		for(var i=sDt; i<=eDt; i++) {
			yearArr += String(i);
			if(i != eDt) yearArr += ',';
		}
	}
	searchData = {
		sType: $('#sType').val(),
		sKeyword: $('#sKeyword').val(),
		sDate: sDt,
		eDate: eDt,
		yearArr: yearArr
	};
	return searchData;
}

// 년/월 옵션에 따라 요청 request url return
function getSevletUrl() {
	var url;
	if($('#sTerm').val() == 'MON'){
		url = '/statistics/stat/selectDistStatMonList.do';
	}
	else {
		url = '/statistics/stat/selectDistStatYearList.do';
	}
	return url;
}

// 년/월 옵션에 따라 요청 request url (그래프용) return
function getSevletUrlChart() {
	var url;
	if($('#sTerm').val() == 'MON'){
		url = '/statistics/stat/selectDistStatMonListChart.do';
	}
	else {
		url = '/statistics/stat/selectDistStatYearListChart.do';
	}
	return url;
}

// 년/월 옵션에 따라 요청 request url (엑셀용) return
function getSevletUrlExcel() {
	var url;
	if($('#sTerm').val() == 'MON'){
		url = '/statistics/stat/selectDistStatMonExcel.do';
	}
	else {
		url = '/statistics/stat/selectDistStatYearExcel.do';
	}
	return url;
}

// 현재 검색옵션에 따른 default grid 생성
function fn_makeGrid() {
	$.jgrid.gridUnload("gridList");
	commonMakeGridParam('gridList', getSevletUrl(), getColNames(), getColModel(), getSearchData(), true
		, function(data) {
			if ($('#rowId').val() == '') $('#rowId').val('1');
			$('#gridList').jqGrid('setSelection', $('#rowId').val());
			}
		, function(rowid, status, e) {
		}
	);
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	// 헤더 colspan 처리
	var colModel = $("#gridList").jqGrid('getGridParam', 'colModel');
	var cs_cnt, cs_text;
	var selTerm = $('#sTerm').val();
	if(selTerm == 'MON'){
		cs_cnt = 12;
		cs_text = '월별 주행거리(km/h)';
	}
	else {
		cs_cnt = 0;
		for(var i=$('#sDate').val(); i<=$('#eDate').val(); i++) {
			cs_cnt++;
		}
		cs_text = '년도별 주행거리(km/h)';
	}
	$("#gridList").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
			groupHeaders:[
				{ startColumnName: colModel[1].name, numberOfColumns: cs_cnt, titleText: cs_text }
		  ]
  });
 	fn_init(); // grid 생성 후 화면 레이아웃 refresh
}

function fn_init() {
	$('#grid').css('height', 'calc(100% - '+($('#form').height()+119)+'px)');
	$('#gridList').jqGrid('setGridWidth', $('#grid').width()-2);
	$('#gridList').jqGrid('setGridHeight', $('#grid').height()-57);
}

// 검색 옵션에 따른 데이터 검색
function fn_search() {
	$('#gridList').jqGrid('clearGridData');
	$('#gridList').jqGrid('setGridParam', {datatype: 'json', postData : getSearchData()}).trigger('reloadGrid');
	fn_init();
	// grid 생성 후 그래프 그리기
	commonAjax(getSearchData(), getSevletUrlChart(), function(returnData, textStatus, jqXHR) {
		var records = returnData.rows;
		if(records.length > 0) {
			$("#chart_area").empty();
			google.charts.setOnLoadCallback(function() { drawChart(records); });
		}
		else {
			$('#chart_area').html("<div id='chart_area' style='width:100%; height:100%;'><table style='width:100%; height:100%;'><tr><td style='width:100%; height:100%; text-align:center;'>데이터가 없습니다.</td></tr></table></div>");
		}
	});
}

// 쿼리 결과를 그래프용 배열데이터로 생성
function getPivotArray(dataArray) {
	//Code from https://techbrij.com
	var result = {}, ret = [];
	var newCols = [];
	for (var i = 0; i < dataArray.length; i++) {
  	if (!result[dataArray[i].sterm]) {
			result[dataArray[i].sterm] = {};
		}
		result[dataArray[i].sterm][dataArray[i].trn] = dataArray[i].acnt;
		//To get column names
		if (newCols.indexOf(dataArray[i].trn) == -1) {
			newCols.push(dataArray[i].trn);
		}
	}
	newCols.sort();
	var item = [];
	//Add Header Row
	item.push('기간');
	item.push.apply(item, newCols);
	ret.push(item);
	//Add content
	for (var key in result) {
		item = [];
		item.push(key);
		for (var i = 0; i < newCols.length; i++) {
			item.push(result[key][newCols[i]] || 0);
		}
		ret.push(item);
	}
	return ret;
}

// draw 그래프
function drawChart(inputData) {
	var arr = eval(inputData);
	if(arr == null) {
		return;
	} else {
		// 그래프용 배열데이터 생성
		var yearWiseData = google.visualization.arrayToDataTable(getPivotArray(arr));
		var chart = new google.visualization.ColumnChart(document.getElementById('chart_area'));
		chart.draw(yearWiseData, {});
	}
}

function fn_excel() {
	var datafield = [];
	var yearArr = '';
	var tempCol = getColModel();
	var sDt = $('#sDate').val();
	var eDt = $('#eDate').val();

	for (var i=0; i<tempCol.length; i++) {
		datafield[i] = tempCol[i].name;
	}
	if($('#sTerm').val() == 'YEAR') {
		for(var i=sDt; i<=eDt; i++) {
			yearArr += String(i);
			if(i != eDt) yearArr += ',';
		}
	}

	$('#columnsNm').val(getColNames());
	$('#datafield').val(datafield);
	$('#excelFileNm').val('주행거리통계'+'_'+$("#sType option:selected").text()+'_'+$("#sTerm option:selected").text()+'.xls');

	$('#yearArr').val(yearArr);

	$('#searchForm').attr('action', getSevletUrlExcel());
	$('#searchForm').submit();
}

</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap">
	<div class="float_left w100p">
		<div class="cont_tit2">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

		<div class="contBtn1">
			<a href="javascript:fn_search()" class="btn_search" title="조회"></a>
			<i></i>
			<a href="javascript:fn_excel()" class="btn_excel" title="엑셀"></a>
		</div>
	</div>

	<div class="box_search">
		<form id="searchForm" name="searchForm" method="post">
			<input type="hidden" id="columnsNm" name="columnsNm" value="">
			<input type="hidden" id="datafield" name="datafield" value="">
			<input type="hidden" id="excelFileNm" name="excelFileNm" value="">
			<input type="hidden" id="yearArr" name="yearArr" value="">

			<fieldset style="width: 420px;">
				<span class="tit" style="float: left;">구분</span>
				<select style="float: left; margin-left: 2px; width: 170px; height: 25px;" id="sType" name="sType" >
					<option value="SEL_ALL">전체 자율모드 주행거리</option>
					<option value="SEL_TEMP">차량별 자율모드 주행거리</option>
					<option value="SEL_USER">기관별 자율모드 주행거리</option>
				</select>
				<input type="text" style="float:left; margin-left: 2px; width: 150px; height: 19px;" id="sKeyword" name="sKeyword" value=""/>
			</fieldset>
			<fieldset style="width: 400px;">
				<span class="tit" style="float: left;">기간</span>
				<select style="float: left; margin-left: 2px; width: 60px; height: 25px;" id="sTerm" name="sTerm" >
					<option value="MON">월별</option>
					<option value="YEAR">년도별</option>
				</select>
				<input type="text" class="yearpicker" style="float: left; margin-left: 2px; width: 100px; height: 19px;" id="sDate" name="sDate" value="" readonly />
				<span style="float: left;">&nbsp;~&nbsp;</span>
				<input type="text" class="yearpicker" style="float: left; margin-left: 2px; width: 100px; height: 19px;" id="eDate" name="eDate" value="" readonly disabled />
			</fieldset>
		</form>
	</div>

	<div id="grid" class="float_left w100p">
		<table id="gridList"></table>
	</div>

	<div id="form" class="form_box" style="height: 124px;">
		<div id="chart_area" style="width:100%; height:100%;">
			<table style="width:100%; height:100%;">
				<tr>
					<td style="width:100%; height:100%; text-align:center;">데이터가 없습니다.</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">

$("#sType").change(function () {
	if($(this).val() == 'SEL_ALL') $('#sKeyword').prop('disabled', true);
	else $('#sKeyword').prop('disabled', false);
	fn_makeGrid();
});
$("#sTerm").change(function () {
	if($(this).val() == 'MON') $('#eDate').prop('disabled', true);
	else if($(this).val() == 'YEAR') {
		if($("#sDate").val() > $("#eDate").val()) $("#sDate").val($("#eDate").val());
		$('#eDate').prop('disabled', false);
	}
	fn_makeGrid();
});
$("#sDate").bind("change", function() {
	if($("#sTerm").val() == 'YEAR') {
		if($(this).val() > $("#eDate").val()) $(this).val($("#eDate").val());
		fn_makeGrid();
	}
});
$("#eDate").bind("change", function() {
	if($("#sTerm").val() == 'YEAR') {
		if($(this).val() < $("#sDate").val()) $(this).val($("#sDate").val());
		fn_makeGrid();
	}
});

</script>
