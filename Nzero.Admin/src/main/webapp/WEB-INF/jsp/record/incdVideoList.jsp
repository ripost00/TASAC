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
	// { label: '기상상황',		name: 'weatherView',				width: 100,	align: "center" },
	// { label: '도로상황',		name: 'roadSituationView',			width: 100,	align: "center" },
	// { label: '도로유형코드',	name: 'roadTypeCdView',				width: 100,	align: "center" },
	{ label: '주행모드',		name: 'autocarDrivingModeView',		width: 100,	align: "center" },
	{ label: '주행상태',		name: 'autocarDrivingStatusCdView',	width: 60,	align: "center" }
	// { label: '운행속도',		name: 'autocarSpeed',				width: 60,	align: "center" },
	// { label: '승차인원',		name: 'autocarRideNumber',			width: 60,	align: "center" },
	// { label: '적재량',		name: 'autocarLoadVol',				width: 60,	align: "center" },
	// { label: '파손정도',		name: 'autocarDamageView',			width: 60,	align: "center" }
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

	commonAjax({ "sAccId": rowData.accId, "sDrvNo": rowData.tmpRaceNumber }, "/record/video/selectAccVideoList.do", function(returnData, textStatus, jqXHR) {

		if (returnData.rows.length == 0) {
			$("#movie1").attr("src", "");
			$("#movie1").get(0).play();
			$("#movie2").attr("src", "");
			$("#movie2").get(0).play();
			$("#movie3").attr("src", "");
			$("#movie3").get(0).play();
			$("#movie4").attr("src", "");
			$("#movie4").get(0).play();
		}

		for(var i=0; i < 4; i++) {
			var cnt = i+1;
			var path = "/upload/incd/";
			if(returnData.rows[i] == null) {
				$("#movie"+cnt).attr("src", "");
				$("#movie"+cnt).get(0).play();
			} else {
				var formData = returnData.rows[i];
				var move_file = path + formData.drivingVideoFile;

				$("#movie"+cnt).attr("src", move_file);
				$("#movie"+cnt).get(0).play();
			}
//$("#movie"+cnt).get(0).stop();
//$("#movie"+cnt).get(0).currentTime();

		}
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

	var url = "/record/video/selectIncdVideoExcelList.do";
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

	<div id="grid1" class="float_left" style="width: calc(50% - 27px); height: calc(100% - 109px); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px;">
		<table id="gridList1"></table>
	</div>

	<div style="width: calc(50% - 27px); height: calc(100% - 109px); float: left; border: 1px solid #c5c5c5; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
		<div style="overflow: auto; width: 100%; height: 100%;">
			<table width="100%" height="100%" class="table1">
				<tr align="center">
					<td>
						<video id="movie1" src="" width="400" height="320" muted controls autoplay preload="auto">
							<source src="" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
							<source src="" type='video/ogg; codecs="theora, vorbis"'>
							<source src="" type='video/webm; codecs="vp8, vorbis"'>
							<source src="" type='video/avi; codecs="MEncoder'>
							<p> 현재 사용하고 있는 브라우저는 비디오 태그를 지원하지 않습니다.(대체 콘텐츠) </p>
						</video>
					</td>
					<td>
						<video id="movie2" src="" width="400" height="320" muted controls autoplay preload="auto">
							<source src="" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
							<source src="" type='video/ogg; codecs="theora, vorbis"'>
							<source src="" type='video/webm; codecs="vp8, vorbis"'>
							<source src="" type='video/avi; codecs="MEncoder'>
							<p> 현재 사용하고 있는 브라우저는 비디오 태그를 지원하지 않습니다.(대체 콘텐츠) </p>
						</video>
					</td>
				</tr>
				<tr align="center">
					<td>
						<video id="movie3" src="" width="400" height="320" muted controls autoplay preload="auto">
							<source src="" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
							<source src="" type='video/ogg; codecs="theora, vorbis"'>
							<source src="" type='video/webm; codecs="vp8, vorbis"'>
							<source src="" type='video/avi; codecs="MEncoder'>
							<p> 현재 사용하고 있는 브라우저는 비디오 태그를 지원하지 않습니다.(대체 콘텐츠) </p>
						</video>
					</td>
					<td>
						<video id="movie4" src="" width="400" height="320" muted controls autoplay preload="auto">
							<source src="" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"'>
							<source src="" type='video/ogg; codecs="theora, vorbis"'>
							<source src="" type='video/webm; codecs="vp8, vorbis"'>
							<source src="" type='video/avi; codecs="MEncoder'>
							<p> 현재 사용하고 있는 브라우저는 비디오 태그를 지원하지 않습니다.(대체 콘텐츠) </p>
						</video>
					</td>
				</tr>
			</table>
		</div>
	</div>

</div>
</body>
</html>
