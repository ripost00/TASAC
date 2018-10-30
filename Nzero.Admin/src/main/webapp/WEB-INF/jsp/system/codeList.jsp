<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>

<%@ include file="/include/header.jsp" %>

<script type="text/javascript">
var colModelMast = [
	{ label: '공통코드',	name: 'codeCd',			width: 100,	align: "center" },
  	{ label: '공통코드명',	name: 'codeNm',			width: 200 },
  	{ label: '설명',		name: 'note',			width: 200 },
  	{ label: '참조1설명',	name: 'refVal1Desc',	width: 200 },
  	{ label: '참조2설명',	name: 'refVal2Desc',	width: 200 },
  	{ label: '참조3설명',	name: 'refVal3Desc',	width: 200 },
  	{ label: '참조4설명',	name: 'refVal4Desc',	width: 200 },
  	{ label: '사용여부',	name: 'useYn',			width: 100,	align: "center" },
  	{ label: '등록자',	name: '',				width: 60,	align: "center" },
  	{ label: '등록일시',	name: '',				width: 120,	align: "center" },
  	{ label: '수정자',	name: '',				width: 60,	align: "center" },
  	{ label: '수정일시',	name: '',				width: 120,	align: "center" }
];

var colModelDetl = [
	{ label: '공통코드',	name: 'codeCd',			hidden: true },
	{ label: '상세코드',	name: 'codeDetlCd',		width: 100,	align: "center" },
  	{ label: '상세코드명',	name: 'codeDetlNm',		width: 200 },
  	{ label: '참조1',		name: 'refVal1',		width: 200 },
  	{ label: '참조2',		name: 'refVal2',		width: 200 },
  	{ label: '참조3',		name: 'refVal3',		width: 200 },
//  	{ label: '참조4',		name: 'refVal4',		width: 200 },
  	{ label: '정렬순서',	name: 'dispOrdr',		width: 100,	align: "center" },
  	{ label: '사용여부',	name: 'useYn',			width: 100,	align: "center" },
  	{ label: '등록자',	name: '',				width: 60,	align: "center" },
  	{ label: '등록일시',	name: '',				width: 120,	align: "center" },
  	{ label: '수정자',	name: '',				width: 60,	align: "center" },
  	{ label: '수정일시',	name: '',				width: 120,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList1", "/system/code/selectCodeMastList.do", colModelMast, false
		, function(data) {
			if ($("#rowId1").val() == "") $("#rowId1").val("1");
			$("#gridList1").jqGrid("setSelection", $("#rowId1").val());
	    }
		, function(rowid, status, e) {
			fn_searchFormMast(rowid);
		}
	);
	
	commonMakeGrid("gridList2", "/system/code/selectCodeDetlList.do", colModelDetl, false
		, function(data) {
			$("#gridList2").jqGrid("setSelection", "1");
	    }
		, function(rowid, status, e) {
			fn_searchFormDetl(rowid);
		}
	);
	
	commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);
	
	commonMakeCodeComboBox("useYn", "YN_CODE2");
	commonMakeCodeComboBox("useYnDetl", "YN_CODE2");
	
	fn_init();

	fn_search();

	$("#sCodeCd").focus();
});

function fn_init() {
	$("#gridList1").jqGrid("setGridWidth", $("#grid1").width()-2);
	$("#gridList1").jqGrid("setGridHeight", $("#grid1").height()-30);
	
	$("#gridList2").jqGrid("setGridWidth", $("#grid2").width()-2);
	$("#gridList2").jqGrid("setGridHeight", $("#grid2").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList1").jqGrid("clearGridData");
	document.detailForm1.reset();
	$("#gridList2").jqGrid("clearGridData");
	document.detailForm2.reset();
	
	$("#sCodeCd").focus();
}

function fn_search() {
	$("#gridList1").jqGrid("clearGridData");
	document.detailForm1.reset();
	$("#gridList2").jqGrid("clearGridData");
	document.detailForm2.reset();
	
	var searchData = {
		sCodeCd: $("#sCodeCd").val(),
		sCodeNm: $("#sCodeNm").val(),
		sUseYn: $("#sUseYn").val()
	};
	$("#gridList1").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchFormMast(rowId) {
	var rowData = $("#gridList1").jqGrid("getRowData", rowId);
	
	commonAjax({ "sCodeCd": rowData.codeCd }, "/system/code/selectCodeMastList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		
		var formData = returnData.rows[0];
		$("#saveMode1").val("U");
		
		$("#codeCd").val(formData.codeCd);
		$("#codeNm").val(formData.codeNm);
		$("#codeDesc").val(formData.codeDesc);
		$("#refVal1Desc").val(formData.refVal1Desc);
		$("#refVal2Desc").val(formData.refVal2Desc);
		$("#refVal3Desc").val(formData.refVal3Desc);
		$("#refVal4Desc").val(formData.refVal4Desc);
		$("#note").val(formData.note);
		$("#useYn").val(formData.useYn);
		
		fn_searchDetl(formData.codeCd);
	});
}

function fn_searchDetl(codeCd) {
	$("#gridList2").jqGrid("clearGridData");
	document.detailForm2.reset();
	
	var searchData = {
		codeCdDetl: codeCd
	};
	$("#gridList2").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchFormDetl(rowId) {
	var rowData = $("#gridList2").jqGrid("getRowData", rowId);
	
	commonAjax({ "codeCdDetl": rowData.codeCd, "codeDetlCd": rowData.codeDetlCd }, "/system/code/selectCodeDetlList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		
		var formData = returnData.rows[0];
		$("#saveMode2").val("U");
		
		$("#codeCdDetl").val(formData.codeCd);
		$("#codeDetlCd").val(formData.codeDetlCd);
		$("#codeDetlNm").val(formData.codeDetlNm);
		$("#refVal1").val(formData.refVal1);
		$("#refVal2").val(formData.refVal2);
		$("#refVal3").val(formData.refVal3);
//		$("#refVal4").val(formData.refVal4);
		$("#dispOrdr").val(formData.dispOrdr);
		$("#useYnDetl").val(formData.useYn);
	});
}

function fn_newMast() {
	$("#gridList1").jqGrid("resetSelection");
	document.detailForm1.reset();
	$("#gridList2").jqGrid("resetSelection");
	document.detailForm2.reset();
	
	$("#saveMode1").val("I");
	
	$("#codeCd").focus();
}

function fn_saveMast() {
	if (!$("#detailForm1").valid()) return;
	
	var data = $("#detailForm1").serializeArray();
	
	commonAjax(data ,"/system/code/transactionCodeMast.do" , function(returnData, textStatus, jqXHR) {		
		alert(returnData.message);
		fn_search();
	});
}

function fn_deleteMast() {
	if (!confirm("<spring:message code='common.delete.msg'/>")) return;
	
	$("#saveMode1").val("D");
	
	var data = $("#detailForm1").serializeArray();
	
	commonAjax(data ,"/system/code/transactionCodeMast.do" , function(returnData, textStatus, jqXHR) {		
		alert(returnData.message);
		fn_search();
	});
}

function fn_newDetl() {
	if ($("#codeCd").val() == "") return;
	
	$("#gridList2").jqGrid("resetSelection");
	document.detailForm2.reset();
	
	$("#saveMode2").val("I");
	$("#codeCdDetl").val($("#codeCd").val());
	
	$("#codeDetlCd").focus();
}

function fn_saveDetl() {
	if ($("#codeCd").val() == "") return;
	
	if (!$("#detailForm2").valid()) return;
	
	var data = $("#detailForm2").serializeArray();
	
	commonAjax(data ,"/system/code/transactionCodeDetl.do" , function(returnData, textStatus, jqXHR) {		
		alert(returnData.message);
		fn_searchDetl($("#codeCd").val());
	});
}

function fn_deleteDetl() {
	if ($("#codeCd").val() == "") return;
	
	if (!confirm("<spring:message code='common.delete.msg'/>")) return;
	
	$("#saveMode2").val("D");
	
	var data = $("#detailForm2").serializeArray();
	
	commonAjax(data ,"/system/code/transactionCodeDetl.do" , function(returnData, textStatus, jqXHR) {		
		alert(returnData.message);
		fn_searchDetl($("#codeCd").val());
	});
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
				<span class="tit">공통코드</span>
				<input type="text" style="width: 150px; height: 19px;" id="sCodeCd" name="sCodeCd" value=""/>
	    	</fieldset>
	    	<fieldset>
				<span class="tit">공통코드명</span>
				<input type="text" style="width: 150px; height: 19px;" id="sCodeNm" name="sCodeNm" value=""/>
	    	</fieldset>
	    	<fieldset>
				<span class="tit">사용여부</span>
				<select style="width: 154px; height: 25px;" id="sUseYn" name="sUseYn"></select>
	    	</fieldset>
	    </form>
	</div>
	
	<div class="float_left w100p" style="height: calc(50% - 60.5px);">
		<p class="float_left w100p" style="font-weight: bold;">▶ 공통코드</p>
		
		<div id="grid1" class="float_left" style="width: calc(100% - 600px); height: 100%;">
			<table id="gridList1"></table>
		</div>
		
		<div id="form1" class="form_box" style="float: right; width: 568px; height: calc(100% - 30px); margin-top: 0px;">
			<form id="detailForm1" name="detailForm1" method="post">				
				<input type="text" style="display: none;" id="saveMode1" name="saveMode1" value="I"/>
				<input type="text" style="display: none;" id="rowId1" name="rowId1" value=""/>
				
				<table summary="테이블" class="table1">
					<caption></caption>
					<colgroup>
						<col width="30%" />
						<col width="*%" />
					</colgroup>
					<tbody>
						<tr>
							<td colspan="2" style="border-top: none; border-left:  none; border-right: none;">
								<div class="contBtn1" style="top: 104px; right: 29px;">
									<a href="javascript:fn_newMast()" class="btn_new" title="신규"></a>
									<i></i>
									<a href="javascript:fn_saveMast()" class="btn_save" title="저장"></a>
									<i></i>
									<a href="javascript:fn_deleteMast()" class="btn_del" title="삭제"></a>
								</div>
							</td>
						</tr>
						<tr>
							<th>공통코드</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="codeCd" name="codeCd" value="" caption="공통코드" required="required"/></td>
						</tr>
						<tr>
							<th>공통코드명</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="codeNm" name="codeNm" value="" caption="공통코드명" required="required"/></td>
						</tr>
						<tr>
							<th>설명</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="codeDesc" name="codeDesc" value="" caption="설명"/></td>
						</tr>
						<tr>
							<th>참조1설명</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="refVal1Desc" name="refVal1Desc" value="" caption="참조1설명"/></td>
						</tr>
						<tr>
							<th>참조2설명</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="refVal2Desc" name="refVal2Desc" value="" caption="참조2설명"/></td>
						</tr>
						<tr>
							<th>참조3설명</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="refVal3Desc" name="refVal3Desc" value="" caption="참조3설명"/></td>
						</tr>
						<tr>
							<th>참조4설명</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="refVal4Desc" name="refVal4Desc" value="" caption="참조4설명"/></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="note" name="note" value="" caption="비고"/></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td><select style="width: 304px; height: 25px;" id="useYn" name="useYn" caption="사용여부" required="required"></select></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	
	<div class="float_left w100p" style="height: calc(50% - 69px); margin-top: 16px;">
		<p class="float_left w100p mt10" style="font-weight: bold;">▶ 상세코드</p>
		
		<div id="grid2" class="float_left" style="width: calc(100% - 600px); height: 100%;">
			<table id="gridList2"></table>
		</div>
		
		<div id="form2" class="form_box" style="float: right; width: 568px; height: calc(100% - 21.5px); margin-top: 0px;">
			<form id="detailForm2" name="detailForm2" method="post">				
				<input type="text" style="display: none;" id="saveMode2" name="saveMode2" value="I"/>
				<input type="text" style="display: none;" id="rowId2" name="rowId2" value=""/>
				<input type="text" style="display: none;" id="codeCdDetl" name="codeCdDetl" value=""/>
				
				<table summary="테이블" class="table1">
					<caption></caption>
					<colgroup>
						<col width="30%" />
						<col width="*%" />
					</colgroup>
					<tbody>
						<tr>
							<td colspan="2" style="border-top: none; border-left:  none; border-right: none;">
								<div class="contBtn1" style="top: calc(50% + 70px); top: -webkit-calc(50% + 70px); right: 29px;">
									<a href="javascript:fn_newDetl()" class="btn_new" title="신규"></a>
									<i></i>
									<a href="javascript:fn_saveDetl()" class="btn_save" title="저장"></a>
									<i></i>
									<a href="javascript:fn_deleteDetl()" class="btn_del" title="삭제"></a>
								</div>
							</td>
						</tr>
						<tr>
							<th>상세코드</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="codeDetlCd" name="codeDetlCd" value="" caption="상세코드" required="required"/></td>
						</tr>
						<tr>
							<th>상세코드명</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="codeDetlNm" name="codeDetlNm" value="" caption="상세코드명" required="required"/></td>
						</tr>
						<tr>
							<th>참조1</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="refVal1" name="refVal1" value="" caption="참조1"/></td>
						</tr>
						<tr>
							<th>참조2</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="refVal2" name="refVal2" value="" caption="참조2"/></td>
						</tr>
						<tr>
							<th>참조3</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="refVal3" name="refVal3" value="" caption="참조3"/></td>
						</tr>
						<!-- 
						<tr>
							<th>참조4</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="refVal4" name="refVal4" value="" caption="참조4"/></td>
						</tr>
						 -->
						<tr>
							<th>정렬순서</th>
							<td><input type="text" style="width: 300px; height: 19px;" id="dispOrdr" name="dispOrdr" value="" caption="정렬순서" required="required"/></td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td><select style="width: 304px; height: 25px;" id="useYnDetl" name="useYnDetl" caption="사용여부" required="required"></select></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>