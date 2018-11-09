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
	{ label: '파라미터ID',	name: 'paramId',		width: 100 },
  	{ label: '파라미터명',	name: 'paramNm',		width: 200 },
  	{ label: '시스템구분',	name: 'systemTypeView',	width: 150,	align: "center" },
  	{ label: '파라미터설명',name: 'paramDesc',		width: 250 },
  	{ label: '데이터1',		name: 'data1',			width: 100,	align: "center" },
  	{ label: '데이터2',		name: 'data2',			width: 100,	align: "center" },
  	{ label: '데이터3',		name: 'data3',			width: 100,	align: "center" },
  	{ label: '사용여부',	name: 'useYn',			width: 50,	align: "center" },
  	{ label: '등록자',		name: 'regId',			width: 60,	align: "center" },
  	{ label: '등록일시',	name: 'regDateView',	width: 120,	align: "center" },
  	{ label: '수정자',		name: 'updateId',		width: 60,	align: "center" },
  	{ label: '수정일시',	name: 'updateDateView',	width: 120,	align: "center" }
];

$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeGrid("gridList", "/system/param/selectParamList.do", colModel, true
		, function(data) {
			if ($("#rowId").val() == "") $("#rowId").val("1");
			$("#gridList").jqGrid("setSelection", $("#rowId").val());
	    }
		, function(rowid, status, e) {
			fn_searchForm(rowid);
		}
	);

	commonMakeCodeComboBox("sUseYn", "YN_CODE2", true);

	commonMakeCodeComboBox("systemType", "system_type");

	commonMakeCodeComboBox("useYn", "YN_CODE2");

	fn_init();

	fn_search();

	$("#sParamNm").focus();
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

	$("#sParamNm").focus();
}

function fn_search() {
	$("#gridList").jqGrid("clearGridData");
	document.detailForm.reset();

	var searchData = {
		sParamNm: $("#sParamNm").val(),
		sUseYn: $("#sUseYn").val()
	};
	$("#gridList").jqGrid("setGridParam", {datatype: "json", postData : searchData}).trigger("reloadGrid");
}

function fn_searchForm(rowId) {
	var rowData = $("#gridList").jqGrid("getRowData", rowId);

	commonAjax({ "sParamId": rowData.paramId }, "/system/param/selectParamList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;

		var formData = returnData.rows[0];
		$("#saveMode").val("U");
		$("#paramIdDupChk").val("Y");

		$("#paramId").val(formData.paramId);
		$("#paramNm").val(formData.paramNm);
		$("#systemType").val(formData.systemType);
		$("#paramDesc").val(formData.paramDesc);
		$("#data1").val(formData.data1);
		$("#data2").val(formData.data2);
		$("#data3").val(formData.data3);
		$("#useYn").val(formData.useYn);
		$("#regId").val(formData.regId);
		$("#regDate").val(formData.regDate);
		$("#updateId").val(formData.updateId);
		$("#updateDate").val(formData.updateDate);

		$("#paramId").attr("readonly", true);
		$("#paramId").css("background-color", "rgb(235, 235, 228)");
		$("#btnDupChk").hide();
	});
}

function fn_new() {
	$("#gridList").jqGrid("resetSelection");
	document.detailForm.reset();
	$("#paramId").attr("readonly", false);
	$("#paramId").css("background-color", "white");
	$("#btnDupChk").show();

	$("#saveMode").val("I");
	$("#paramIdDupChk").val("N");

	$("#paramId").focus();
}

function fn_save() {
	if (!$("#detailForm").valid()) return;

	if ($("#paramIdDupChk").val() == "N") {
		alert("ID중복체크를 해주십시오");
		return;
	}

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/param/transactionParam.do" , function(returnData, textStatus, jqXHR) {
		alert(returnData.message);
		fn_search();
	});
}

function fn_delete() {
	if (!confirm("<spring:message code='common.delete.msg'/>")) return;

	$("#saveMode").val("D");

	var data = $("#detailForm").serializeArray();

	commonAjax(data ,"/system/param/transactionParam.do" , function(returnData, textStatus, jqXHR) {
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

	var url = "/system/param/selectParamExcelList.do";
	$("#searchForm").attr("action", url);
	$("#searchForm").submit();
}

function fn_dupCheck() {
	if ($("#paramId").val() == "") return;

	commonAjax({ "sParamId": $("#paramId").val() }, "/system/param/selectParamList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) {
			$("#paramIdDupChk").val("Y");
			alert("사용가능한 아이디 입니다.");
		} else {
			$("#paramIdDupChk").val("N");
			alert("중복된 아이디가 존재합니다. 다시 입력해 주십시오.");
			$("#paramId").focus();
		}
	});
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
				<span class="tit">파라미터명</span>
				<input type="text" style="width: 150px; height: 19px;" id="sParamNm" name="sParamNm" value=""/>
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

	<div id="form" class="form_box" style="height: 164px;">
		<form id="detailForm" name="detailForm" method="post">
			<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
			<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
			<input type="text" style="display:none;" id="paramIdDupChk" name="paramIdDupChk" value="N"/>

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
						<th>파라미터ID</th>
						<td>
							<input type="text" style="width: 150px; height: 19px; background-color: rgb(235, 235, 228);" id="paramId" name="paramId" value="" caption="파라미터ID" required="required" readonly="readonly"/>
							<input type="button" style="width: 80px; height: 25px;" id="btnDupChk" name="btnDupChk" onclick="javascript:fn_dupCheck();" value="중복확인"/>
						</td>
						<th>파라미터명</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="paramNm" name="paramNm" value="" caption="파라미터명" required="required"/></td>
						<th>파라미터설명</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="paramDesc" name="paramDesc" value="" caption="파라미터설명"/></td>
					</tr>
					<tr>
						<th>데이터1</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="data1" name="data1" value="" caption="데이터1" required="required"/></td>
						<th>데이터2</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="data2" name="data2" value="" caption="데이터2" required="required"/></td>
						<th>데이터3</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="data3" name="data3" value="" caption="데이터3" required="required"/></td>
					</tr>
					<tr>
						<th>시스템구분</th>
						<td><select style="width: 154px; height: 25px;" id="systemType" name="systemType" caption="시스템구분" required="required"></select></td>
						<th>사용여부</th>
						<td colspan="3"><select style="width: 154px; height: 25px;" id="useYn" name="useYn" caption="사용여부" required="required"></select></td>
					</tr>
					<tr>
						<th>등록자</th>
						<td><input type="text" style="width: 150px; height: 19px;" id="regId" name="regId" value="" disabled="disabled"/></td>
						<th>등록일시</th>
						<td colspan="3"><input type="text" style="width: 300px; height: 19px;" id="regDate" name="regDate" value="" disabled="disabled"/></td>
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