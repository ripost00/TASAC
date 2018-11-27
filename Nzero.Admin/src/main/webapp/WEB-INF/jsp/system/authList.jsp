<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>

<%@ include file="/include/header.jsp" %>

<script type="text/javascript">
var colModel = [
	{ label: '권한ID',	name: 'authId',		width: 100,	align: "center" },
  	{ label: '권한명',	name: 'authNm',		width: 200 },
  	{ label: '권한설명',	name: 'authorDc',	width: 300 },
  	{ label: '정렬순서',	name: 'dispOrdr',	width: 100,	align: "center" },
  	{ label: '사용여부',	name: 'useYn',		width: 100,	align: "center" },
  	{ label: '등록자',	name: '',			width: 60,	align: "center" },
  	{ label: '등록일시',	name: '',			width: 120,	align: "center" },
  	{ label: '수정자',	name: '',			width: 60,	align: "center" },
  	{ label: '수정일시',	name: '',			width: 120,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList", "/system/auth/selectAuthList.do", colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
	    }
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);

	commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);

	commonMakeCodeComboBox("useYn", "YN_CODE2");

	fn_init();

	fn_search();

	$("#sAuthNm").focus();
});

function fn_init() {
	$("#grid").css("height", "calc(100% - "+($("#form").height()+119)+"px)");
	$("#gridList").jqGrid("setGridWidth", $("#grid").width()-2);
	$("#gridList").jqGrid("setGridHeight", $("#grid").height()-30);
}

function fn_initClear() {
	document.searchForm.reset();
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	$("#sAuthNm").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	var searchData = {
		sAuthNm: $("#sAuthNm").val(),
		sUseYn: $("#sUseYn").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	commonAjax({ "sAuthId": rowData.authId }, "/system/auth/selectAuthList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#saveMode").val("U");

		$("#authId").val(formData.authId);
		$("#authNm").val(formData.authNm);
		$("#authorDc").val(formData.authorDc);
		$("#dispOrdr").val(formData.dispOrdr);
		$("#useYn").val(formData.useYn);
	});
}

function fn_new() {
	$("#gridList").jqGrid("resetSelection");
	document.detailForm.reset();

	$("#saveMode").val("I");
	$("#authId").val("신규");

	$("#authNm").focus();
}

function fn_save() {
	if (!$("#detailForm").valid()) return;

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/auth/transactionAuth.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fn_delete() {
	if (!confirm("<spring:message code='common.delete.msg'/>")) return;

	$("#saveMode").val("D");

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/auth/transactionAuth.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fn_excel() {
	var columnsNm = [], datafield = [];
	for (var i=0; i<colModel.length-1; i++) {
		columnsNm[i] = colModel[i].label;
		datafield[i] = colModel[i].name;
	}

	$("#columnsNm").val(columnsNm);
	$("#datafield").val(datafield);
	$("#excelFileNm").val("<%=menuNm%>.xls");

	var url = "/system/auth/selectAuthExcelList.do";
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
			<a href="javascript:fn_initClear()"  class="btn_refresh" title="초기화"></a>
			<i></i>
			<a href="javascript:fn_new()" class="btn_new" title="신규"></a>
			<i></i>
			<a href="javascript:fn_save()" class="btn_save" title="저장"></a>
			<i></i>
			<a href="javascript:fn_delete()" class="btn_del" title="삭제"></a>
			<i></i>
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

			<fieldset>
				<span class="tit">권한명</span>
				<input type="text" style="width: 150px; height: 19px;" id="sAuthNm" name="sAuthNm" value="" onkeypress="if(event.keyCode==13) {fn_search(); return false;}"/>
	    	</fieldset>
	    	<fieldset>
				<span class="tit">사용여부</span>
				<select style="width: 154px; height: 25px;" id="sUseYn" name="sUseYn"></select>
	    	</fieldset>
	    </form>
	</div>

	<div id="grid" class="float_left w100p">
		<table id="gridList"></table>
	</div>

	<div id="form" class="form_box" style="height: 124px;">
		<form id="detailForm" name="detailForm" method="post">
			<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
			<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>

			<table summary="테이블" class="table1">
				<caption></caption>
				<colgroup>
					<col width="10%" />
					<col width="23.3%" />
					<col width="10%" />
					<col width="23.3%" />
					<col width="10%" />
					<col width="*%" />
				</colgroup>
				<tbody>
					<tr>
						<th>권한ID</th>
						<td><input type="text" style="width: 150px; height: 19px; background-color: rgb(235, 235, 228);" id="authId" name="authId" value="" caption="권한ID" required="required" readonly="readonly"/></td>
						<th>권한명</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="authNm" name="authNm" value="" caption="권한명" required="required"/></td>
						<th>권한설명</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="authorDc" name="authorDc" value="" caption="권한설명"/></td>
					</tr>
					<tr>
						<th>정렬순서</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="dispOrdr" name="dispOrdr" value="" caption="정렬순서" required="required"/></td>
						<th>사용여부</th>
						<td colspan="3"><select style="width: 154px; height: 25px;" id="useYn" name="useYn" caption="사용여부" required="required"></select></td>
					</tr>
					<tr>
						<th>등록자</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="createId" name="createId" value="" disabled="disabled"/></td>
						<th>등록일시</th>
						<td colspan="3"><input type="text" style="width: 300px; height: 19px;" id="createDate" name="createDate" value="" disabled="disabled"/></td>
					</tr>
					<tr>
						<th>수정자</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="updateId" name="updateId" value="" disabled="disabled"/></td>
						<th>수정일시</th>
						<td colspan="3"><input type="text" style="width: 300px; height: 19px;" id="updateDate" name="updateDate" value="" disabled="disabled"/></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>
</body>
</html>
