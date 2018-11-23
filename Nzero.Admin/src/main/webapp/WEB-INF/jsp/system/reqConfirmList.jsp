<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>

<%@ include file="/include/header.jsp" %>

</head>
<body class="default" style="min-width: 1260px; min-height: 660px;">
<div class="wrap">
	<div class="float_left w100p">
		<div class="cont_tit2">◎ <%=java.net.URLDecoder.decode(menuNm, "UTF-8")%></div>

		<div class="contBtn1">
			<a href="javascript:fn_initClear()"  class="btn_refresh" title="초기화"></a>
			<i></i>
			<a href="javascript:fn_save()" class="btn_save" title="저장"></a>
			<i></i>
			<a href="javascript:fn_search()" class="btn_search" title="조회"></a>
		</div>
	</div>

	<div class="box_search">
		<form id="searchForm" name="searchForm" method="post">
			<fieldset>
				<span class="tit">승인요청 구분</span>
				<select style="width: 154px; height: 25px;" id="sReqType" name="sReqType">
					<option value="">[선택 ]</option>
					<option value="T">임시운행번호등록요청</option>
					<option value="U">권한승인요청</option>
				</select>
	    </fieldset>
		</form>
	</div>

	<div id="grid" class="float_left" style="width: calc(50% - 27px); height: calc(100% - 109px); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px;">
		<table id="gridList"></table>
	</div>

	<div id="form" style="width: calc(50% - 27px); height: calc(100% - 109px); float: left; border: 1px solid #c5c5c5; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
		<form id="detailForm" name="detailForm" method="post">
			<input type="text" style="display: none;" id="reqId" name="reqId" value=""/>
			<input type="text" style="display: none;" id="reqTp" name="reqTp" value=""/>
			<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
			<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>

			<table summary="테이블" class="table1">
				<caption></caption>
				<colgroup>
					<col width="10%" />
					<col width="*%" />
				</colgroup>
				<tbody>
					<tr>
						<th>승인요청구분</th>
						<td><span style="width: 100%; height: 19px;" id="reqTpNm" name="reqTpNm"></span></td>
					</tr>
					<tr>
						<th>요청ID</th>
						<td><span style="width: 100%; height: 19px;" id="userId" name="userId"></span></td>
					</tr>
					<tr>
						<th>등록일자</th>
						<td><span style="width: 100%; height: 19px;" id="regDate" name="regDate"></span></td>
					</tr>
					<tr>
						<th>요청내용</th>
						<td style="width: calc(100%); height: calc(100%);">
							<div id="subform1" style="width: calc(100%); height: calc(100%); float: left; padding: 2px; display:none;">
									<table summary="테이블" style="width: calc(100%);">
										<caption></caption>
										<colgroup>
											<col width="20%" />
											<col width="*%" />
										</colgroup>
										<tbody>
											<tr>
												<th>등급</th>
												<td><span style="width: 100%; height: 19px;" id="classNm" name="classNm"></span></td>
											</tr>
											<tr>
												<th>기관코드</th>
												<td><span style="width: 100%; height: 19px;" id="agencyNm" name="agencyNm"></span></td>
											</tr>
										</tbody>
									</table>
							</div>
							<div id="subform2" style="width: calc(100%); height: calc(100%); float: left; padding: 2px; display:none;">
									<table summary="테이블" style="width: calc(100%);">
										<caption></caption>
										<colgroup>
											<col width="20%" />
											<col width="*%" />
										</colgroup>
										<tbody>
											<tr>
												<th>임시운행등록번호</th>
												<td><span style="width: 100%; height: 19px;" id="tmpRaceNumber" name="tmpRaceNumber"></span></td>
											</tr>
											<tr>
												<th>임시운행기관</th>
												<td><span style="width: 100%; height: 19px;" id="tmpRaceAgency" name="tmpRaceAgency"></span></td>
											</tr>
											<tr>
												<th>보험증서번호</th>
												<td><span style="width: 100%; height: 19px;" id="insLetterNumber" name="insLetterNumber"></span></td>
											</tr>
											<tr>
												<th>보험가입일자</th>
												<td><span style="width: 100%; height: 19px;" id="insInitDate" name="insInitDate"></span></td>
											</tr>
											<tr>
												<th>증서파일</th>
												<td><span style="width: 100%; height: 19px;" id="deedFilename" name="deedFilename"></span></td>
											</tr>
											<tr>
												<th>차량모델</th>
												<td><span style="width: 100%; height: 19px;" id="carModel" name="carModel"></span></td>
											</tr>
											<tr>
												<th>동력원</th>
												<td><span style="width: 100%; height: 19px;" id="powerSource" name="powerSource"></span></td>
											</tr>
										</tbody>
									</table>
							</div>
						</td>
					</tr>
					<tr>
						<th>승인</th>
						<td><select style="width: 100px; height: 25px;" id="apporStatus" name="apporStatus" caption="승인" required="required"></select></td>
					</tr>
					<tr>
						<th>취소사유</th>
						<td><input type="text" style="width: 100%; height: 19px;" id="cnclNote" name="cnclNote" value="" disabled="disabled"/></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
var oEditors = []; //스마트에디터 오브젝트
var colModel = [
	{ name: 'reqTp', hidden: true },
	{ name: 'reqId', hidden: true },
	{ label: '승인요청구분',	name: 'reqTpNm', align: "center" },
	{ label: '요청ID',	name: 'userId', align: "center" },
	{ label: '등록일시',	name: 'regDate', align: "center" },
	{ label: '상태',	name: 'statusNm', align: "center", formatter:fontColorFormatter }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {

	commonMakeGrid("gridList", "/system/req/selectReqConfirmList.do", colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
		}
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);
	commonMakeCodeComboBox("apporStatus", "appor_status");

	fn_init();
	fn_search();
	$("#sReqType").focus();
});

function fontColorFormatter(cellValue, opts, rowObject){
  switch(rowObject.statusCd){
    case "101":
      return '<span style="color:orange; font-weight:bold;">'+cellValue+'</span>';
    break;
    case "102" :
      return '<span style="color:blue; font-weight:bold;">'+cellValue+'</span>';
    break;
		case "103":
      return '<span style="color:red; font-weight:bold;">'+cellValue+'</span>';
    break;
  }
}

function fn_init() {
	// $("#grid").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList").jqGrid("setGridWidth", $("#grid").width()-2);
	$("#gridList").jqGrid("setGridHeight", $("#grid").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");
	$("#boardContents").val("");
	oEditors.getById["boardContents"].exec("SET_IR", [""]);
	document.detailForm.reset();

	$("#sReqType").focus();
}

function fn_search(selectNode) {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	var searchData = {
		sReqType: $("#sReqType").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);
	var reqTp = rowData.reqTp;

	$("#reqId").val(rowData.reqId);
	$("#reqTp").val(reqTp);

	$('#subform1').css("display", "none");
	$('#subform2').css("display", "none");
	$("#deedFilename").html('');

	commonAjax({ "reqId": rowData.reqId }, "/system/req/selectReqConfirmInfo_"+reqTp+".do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#saveMode").val("U");

		$("#reqTpNm").html(formData.reqTpNm);
		$("#userId").html(formData.userId);
		$("#regDate").html(formData.regDate);
		if(reqTp == 'T') {
			$("#tmpRaceNumber").html(formData.tmpRaceNumber);
			$("#tmpRaceAgency").html(formData.tmpRaceAgency);
			$("#insLetterNumber").html(formData.insLetterNumber);
			$("#insInitDate").html(formData.insInitDate);
			if(formData.deedFilename != undefined && formData.deedFilename != '') {
				$("#deedFilename").html('<a href="/upload/tpsv/'+formData.deedFilename+'" download>'+formData.deedFilename+' 다운로드</a>');
			}
			else {
				$("#deedFilename").html('증서파일 없음');
			}
			$("#carModel").html(formData.carModel);
			$("#powerSource").html(formData.powerSource);

			$('#subform2').css("display", "block");
		}
		else if(reqTp == 'U') {
			$("#classNm").html(formData.classNm);
			$("#agencyNm").html(formData.agencyNm);

			$('#subform1').css("display", "block");
		}
		$("#apporStatus").val(formData.apporStatus);
		$("#cnclNote").val(formData.cnclNote);

		if(formData.apporStatus == '103') $('#cnclNote').prop('disabled', false);
		else $('#cnclNote').prop('disabled', true);
	});
}

function fn_save() {
	if (!$("#detailForm").valid()) return;
	if($("#apporStatus").val() != '103') $('#cnclNote').val('');

	var data =$("#detailForm").serializeArray();

	commonAjax(data, "/system/req/updateReqConfirmInfo_"+$("#reqTp").val()+".do", function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

$("#apporStatus").change(function () {
	if($(this).val() == '103') $('#cnclNote').prop('disabled', false);
	else $('#cnclNote').prop('disabled', true);
});

</script>
