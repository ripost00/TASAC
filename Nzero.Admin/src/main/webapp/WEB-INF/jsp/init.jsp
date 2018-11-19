<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자율주행 데이터 공유센터</title>

<%@ include file="/include/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/css/sub.css' />" type="text/css"/>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(document).ready(function() {

});
</script>
</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap">
	<div class="box_search" style="height: calc(20%);">
		<div class="float_left" style="width: calc(30%); height: calc(100%); text-align: left; line-height:calc(100%);">
			<div style="width: 250px; height: calc(100%); display:table; vertical-align:middle; margin: 0 auto;">
				<div style="display:table-cell; vertical-align:middle;"><img src="/images/main/dataSelect3.png" border="0"></div>
				<div style="display:table-cell; vertical-align:middle;">
					<p>
						<span id="topArea1" name="topArea1" style="font-size:3em; line-height: 1.3em; font-weight: bold; color: #5064eb;">
						--
						</span>
					</p>
					<p>
						<span style="font-size:1.5em; font-weight: bold; color: #2d2d2d;">
						임시운행 허가대수
						</span>
					</p>
				</div>
			</div>
		</div>
		<div class="float_left" style="width: calc(40%); height: calc(100%); text-align: left; line-height:calc(100%);">
			<div style="width: 460px; height: calc(100%); display:table; vertical-align:middle; margin: 0 auto;">
				<div style="display:table-cell; vertical-align:middle;"><img src="/images/main/dataSelect1.png" border="0"></div>
				<div style="display:table-cell; vertical-align:middle;">
					<p>
						<span id="topArea2" name="topArea2" style="font-size:3em; line-height: 1.3em; font-weight: bold; color: #5064eb;">
						-- / -- / --
						</span>
					</p>
					<p>
						<span style="font-size:1.5em; font-weight: bold; color: #2d2d2d;">
						거리(km): 총 주행 / 자율모드주행 / 일반모드주행
						</span>
					</p>
				</div>
			</div>
		</div>
		<div class="float_left" style="width: calc(30%); height: calc(100%); text-align: left; line-height:calc(100%);">
			<div style="width: 400px; height: calc(100%); display:table; vertical-align:middle; margin: 0 auto;">
				<div style="display:table-cell; vertical-align:middle;"><img src="/images/main/dataSelect4.png" border="0"></div>
				<div style="display:table-cell; vertical-align:middle;">
					<p>
						<span id="topArea3" name="topArea3" style="font-size:3em; line-height: 1.3em; font-weight: bold; color: #5064eb;">
						--
						</span>
						<span style="font-size:3em; line-height: 1.3em; font-weight: bold; color: #5064eb;">
						&nbsp;/&nbsp;
						</span>
						<span id="topArea4" name="topArea4" style="font-size:3em; line-height: 1.3em; font-weight: bold; color: #5064eb;">
						--
						</span>
					</p>
					<p>
						<span style="font-size:1.5em; font-weight: bold; color: #2d2d2d;">
						데이터 건수 / 데이터 용량
						</span>
					</p>
				</div>
			</div>
		</div>
	</div>

	<div id="grid1" class="float_left" style="width: calc(50% - 27px); height: calc(40%); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px;">
		<p><i class="fa fa-dashboard"></i>&nbsp;데이터 사용현황<a href="javascript:fn_search_Data();" style="float:right;">새로고침</a></p>
		<table id="gridListData"></table>
		<br/>
		<table id="gridListDataList"></table>
	</div>

	<div id="grid2" style="width: calc(50% - 27px); height: calc(40%); float: left; border: 1px solid #c5c5c5; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
		<p><i class="fa fa-exclamation-triangle"></i>&nbsp;사고발생<a href="javascript:fn_search_Acc();" style="float:right;">새로고침</a></p>
		<table id="gridListAcc"></table>
		<br/>
		<table id="gridListAccList"></table>
	</div>

	<div id="chart1" class="float_left" style="width: calc(50% - 27px); height: calc(30%); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px; margin-top: 10px;">
		<p><i class="fa fa-bar-chart-o"></i>&nbsp;통계 현황<a href="javascript:fn_mkeChart()" style="float:right;">새로고침</a></p>
		<div id="chart_area" style="width:calc(100%); height:calc(100% - 10px);">
			<table style="width: calc(100%); height:calc(100% - 10px);">
				<tr>
					<td style="width:calc(100%); height:calc(100% - 10px); text-align:center;">데이터가 없습니다.</td>
				</tr>
			</table>
		</div>
	</div>

	<div id="chart2" style="width: calc(50% - 27px); height: calc(30%); float: left; border: 1px solid #c5c5c5; border-radius: 3px; background: #fff; padding: 10px; margin-top: 10px; margin-left: 10px;">
		<p><i class="fa fa-signal"></i>&nbsp;데이터베이스 사용 현황<a href="javascript:fn_mkeDBChart()" style="float:right;">새로고침</a></p>
		<div id="chart_db" style="width:calc(100%); height:calc(100% - 10px);">
			<table style="width: calc(100%); height:calc(100% - 10px);">
				<tr>
					<td style="width:calc(100%); height:calc(100% - 10px); text-align:center;">데이터가 없습니다.</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">

var sec = 0; // interval

var colModel_data = [
	{ label: '다운로드', name: 'bu', align: "center" },
  { label: '업로드', name: 'bd', align: "center" },
  { label: '다운로드', name: 'nu', align: "center" },
  { label: '업로드', name: 'nd', align: "center" }
];
var colModel_data_list = [
	{ label: '순번', name: 'rnum', align: "center" },
  { label: '사용자ID',	name: 'regId', align: "center" },
  { label: '업로드건수', name: 'upCnt', align: "center" }
];
var colModel_acc = [
	{ label: '자율모드', name: 'bu', align: "center" },
  { label: '일반모드', name: 'bd', align: "center" },
  { label: '자율모드', name: 'nu', align: "center" },
  { label: '일반모드', name: 'nd', align: "center" }
];
var colModel_acc_list = [
	{ label: '순번', name: 'rnum', align: "center" },
  { label: '기관',	name: 'regId', align: "center" },
  { label: '사고발생건수', name: 'upCnt', align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_operCnt();
		fn_drivingInfo();
		fn_dataInfo();

		fn_init_Data();
		fn_init_Acc();
		fn_mkeChart();
		fn_mkeDBChart();
	}
});

$(document).ready(function() {
	// 구글차트 init
	google.charts.load("current", {packages:["corechart"]});

	fn_operCnt();
	fn_drivingInfo();
	fn_dataInfo();

	fn_mkeGrid_Data();
	fn_mkeGrid_Acc();

	fn_mkeChart();
	fn_mkeDBChart();

	// refresh
	timer_manager();
});

function timer_manager() {

	if(sec === 30) {
		sec = 0;
		fn_operCnt();
		fn_drivingInfo();
		fn_dataInfo();

		fn_search_Data();
		fn_search_Acc();

		fn_mkeChart();
		fn_mkeDBChart();
	}
	else {
		sec += 1;
	}
	// 10초 간격 재호출
	setTimeout(timer_manager,1000);
}

function fn_operCnt() {
	commonAjax({}, "/main/dashboard/selectTempOperTotCnt.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		$("#topArea1").html(returnData.rows[0]);
	});
}

function fn_drivingInfo() {
	commonAjax({}, "/main/dashboard/selectDrivingInfo.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		var rd = returnData.rows[0];
		var text = rd.totalView + ' / ' + rd.autoView + ' / ' + rd.nomalView;
		$("#topArea2").html(text);
	});
}

function fn_dataInfo() {
	commonAjax({}, "/main/dashboard/selectDataTotCnt.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		$("#topArea3").html(returnData.rows[0]+'건');
	});
	commonAjax({}, "/main/dashboard/selectDataTotVolume.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		$("#topArea4").html(returnData.rows[0]+'GB');
	});
}

function fn_mkeGrid_Data() {
	// 카운트
	commonMakeGrid("gridListData", "/main/dashboard/selectUpDnStatus.do", colModel_data, true
		, function(data) {
			}
		, function(rowid, status, e) {
		}
	);
	$("#gridListData").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
			groupHeaders:[
				{ startColumnName: colModel_data[0].name, numberOfColumns: 2, titleText: '지난 주' },
				{ startColumnName: colModel_data[2].name, numberOfColumns: 2, titleText: '이번 주' }
		  ]
  });
	// 리스트
	commonMakeGrid("gridListDataList", "/main/dashboard/selectUploadCnt.do", colModel_data_list, true
		, function(data) {
			}
		, function(rowid, status, e) {
		}
	);
	fn_init_Data();
	fn_search_Data();
}
function fn_mkeGrid_Acc() {
	// 카운트
	commonMakeGrid("gridListAcc", "/main/dashboard/selectAccStatus.do", colModel_acc, true
		, function(data) {
			}
		, function(rowid, status, e) {
		}
	);
	$("#gridListAcc").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
			groupHeaders:[
				{ startColumnName: colModel_data[0].name, numberOfColumns: 2, titleText: '지난 주' },
				{ startColumnName: colModel_data[2].name, numberOfColumns: 2, titleText: '이번 주' }
		  ]
  });
	// 리스트
	commonMakeGrid("gridListAccList", "/main/dashboard/selectAccList.do", colModel_acc_list, true
		, function(data) {
			}
		, function(rowid, status, e) {
		}
	);
	fn_init_Acc();
	fn_search_Acc();
}

function fn_search_Data() {
	$("#gridListData").jqGrid("clearGridData");
	$('#gridListData').jqGrid('setGridParam', {datatype: 'json', postData : ''}).trigger('reloadGrid');
	$("#gridListDataList").jqGrid("clearGridData");
	$('#gridListDataList').jqGrid('setGridParam', {datatype: 'json', postData : ''}).trigger('reloadGrid');
}
function fn_search_Acc() {
	$("#gridListAcc").jqGrid("clearGridData");
	$('#gridListAcc').jqGrid('setGridParam', {datatype: 'json', postData : ''}).trigger('reloadGrid');
	$("#gridListAccList").jqGrid("clearGridData");
	$('#gridListAccList').jqGrid('setGridParam', {datatype: 'json', postData : ''}).trigger('reloadGrid');
}

function fn_init_Data() {
	$("#gridListData").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridListData").jqGrid("setGridHeight", '26px');
	$("#gridListDataList").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridListDataList").jqGrid("setGridHeight", $("#grid1").height()-145);
}

function fn_init_Acc() {
	$("#gridListAcc").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridListAcc").jqGrid("setGridHeight", '26px');
	$("#gridListAccList").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridListAccList").jqGrid("setGridHeight", $("#grid2").height()-145);
}

function fn_mkeChart() {
	commonAjax('', "/main/dashboard/selectChart.do", function(returnData, textStatus, jqXHR) {
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

function drawChart(inputData) {
	var arr = eval(inputData);
	if(arr == null) {
		return;
	} else {
		var chartData = new google.visualization.DataTable();
		chartData.addColumn('string', '기준월');
		chartData.addColumn('number', '업로드건수');
		chartData.addColumn('number', '다운로드건수');
		chartData.addColumn('number', '자율모드사고건수');
		chartData.addRows(arr.length);

		for(var i = 0; i < arr.length; i++) {

			var ana_m = arr[i].m;
			var upCnt = arr[i].upCnt;
			var dnCnt = arr[i].dnCnt;
			var accCnt = arr[i].accCnt;

			chartData.setValue(i, 0, ana_m);
			chartData.setValue(i, 1, upCnt);
			chartData.setValue(i, 2, dnCnt);
			chartData.setValue(i, 3, accCnt);

			var ana_m = null;
			var upCnt = null;
			var dnCnt = null;
			var accCnt = null;
		} //for문끝

		var options = {
			legend: 'top',
			legendTextStyle: {color:'#000',fontName: 'NanumGothic',fontSize: '12'},

			lineWidth: 5,
			colors: ['#009933', '#e7711b', '#6633ff'],
			// backgroundColor: '#334',
			chartArea: {eft:100, width:'90%'}
		}
	};

	var chart = new google.visualization.LineChart(document.getElementById('chart_area'));
	chart.draw(chartData, options);

	arr = null;
	chartData = null;
	options = null;
	chart = null;
}

function fn_mkeDBChart() {
	commonAjax('', "/main/dashboard/selectDBStatus.do", function(returnData, textStatus, jqXHR) {
		var records = returnData.rows;
		if(records.length > 0) {
			$("#chart_db").empty();
			google.charts.setOnLoadCallback(function() { drawDBChart(records); });
		}
		else {
			$('#chart_db').html("<div id='chart_db' style='width:100%; height:100%;'><table style='width:100%; height:100%;'><tr><td style='width:100%; height:100%; text-align:center;'>데이터가 없습니다.</td></tr></table></div>");
		}
	});
}

function drawDBChart(inputData) {
	var arr = eval(inputData);
	if(arr == null) {
		return;
	} else {
		var chartData = new google.visualization.DataTable();
		chartData.addColumn('string', 'Tablespace');
		chartData.addColumn('number', '사용(GB)');
		chartData.addColumn('number', 'Free(GB)');
		chartData.addRows(arr.length);

		for(var i = 0; i < arr.length; i++) {

			var tablespaceName = arr[i].tablespaceName;
			var used = arr[i].used;
			var free = arr[i].free;
			var accCnt = arr[i].accCnt;

			chartData.setValue(i, 0, tablespaceName);
			chartData.setValue(i, 1, used);
			chartData.setValue(i, 2, free);

			var tablespaceName = null;
			var used = null;
			var free = null;
		} //for문끝

		var options_fullStacked = {
			isStacked: 'percent',
			legend: {position: 'top', maxLines: 3},
			hAxis: {
			 minValue: 0,
			 ticks: [0, .3, .6, .9, 1],
		 	},
			colors: ['#990000', '#1b4ee7'],
		 	chartArea: {left:160, width:'85%'}
		};
	};

	var chartDb = new google.visualization.BarChart(document.getElementById('chart_db'));
	chartDb.draw(chartData, options_fullStacked);

	arr = null;
	chartData = null;
	options_fullStacked = null;
	chartDb = null;
}

</script>
