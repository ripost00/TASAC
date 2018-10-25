<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Program</title>

<%@ include file="/include/header.jsp" %>
<link rel="stylesheet" href="<c:url value='/js/jstree-3.3.5/dist/themes/default/style.css' />" type="text/css"/>
<script type="text/javascript" src="<c:url value='/js/jstree-3.3.5/dist/jstree.js' />"></script>

<script type="text/javascript">
$(window).resize(function(event) {
	if (this == event.target) {
		fn_init();
	}
});

$(document).ready(function() {
	commonMakeMenuComboBox("sMenuPrntId", true);
	
	commonMakeCodeComboBox("leafYn", "YN_CODE1");
	commonMakeCodeComboBox("useYn", "YN_CODE2");
	
	fn_init();
	
	fn_search();
	
	$("#sMenuPrntId").focus();
});

function fn_init() {

}

function fn_initClear() {
	document.searchForm.reset();
	document.detailForm.reset();
	$("#menuId").attr("readonly", false);
	$("#menuId").css("background-color", "white");
	
	$("#sMenuPrntId").focus();
}

function fn_search(selectNode) {
	$("#jsTree").jstree("destroy").empty();
	document.detailForm.reset();
	$("#menuId").attr("readonly", false);
	$("#menuId").css("background-color", "white");
	
	var searchData = {
		sMenuPrntId: $("#sMenuPrntId").val()
	};
	
	var sNodeId = selectNode == undefined ? 0 : selectNode;
	
	commonAjax(searchData, "/system/menu/selectMenuList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length > 0) {
			fn_makeJSTrees(fn_makeTreeJsonData(returnData.rows), sNodeId);
		}
	});
}

function fn_makeTreeJsonData(jsonData) {
	for (var i=0; i<jsonData.length; i++) {
		if (jsonData[i].parent == null) {
			jsonData[i].parent = "#";
		}
	}
	return jsonData;
}

function fn_makeJSTrees(jsonData, sNodeId) {
	$("#jsTree").jstree({
		core: { data: jsonData },
		themes: { theme: "classic", dots: true, icons: false }
	}).bind("loaded.jstree", function(event, data) {
		$(this).jstree("hide_icons").jstree("open_all");
		$(this).jstree("select_node", '#'+sNodeId, true);
	}).on("select_node.jstree", function(event, data) { // node select event
		fn_searchForm(data.node.id);
	});
}

function fn_searchForm(nodeId) {
	commonAjax({ "sMenuId": nodeId }, "/system/menu/selectMenuList.do", function(returnData, textStatus, jqXHR) {
		if (returnData.rows.length == 0) return;
		
		var formData = returnData.rows[0];
		$("#saveMode").val("U");
		
		$("#menuId").val(formData.menuId);
		$("#menuNm").val(formData.menuNm);
		$("#menuPrntId").val(formData.menuPrntId);      
		$("#dispOrdr").val(formData.dispOrdr);
		$("#menuObject").val(formData.menuObject);
		$("#menuPath").val(formData.menuPath);
		$("#menuDesc").val(formData.menuDesc);
		$("#iconNm").val(formData.iconNm);
		$("#leafYn").val(formData.leafYn);
		$("#menuLevel").val(formData.menuLevel);
		$("#useYn").val(formData.useYn);
		
		$("#menuId").attr("readonly", true);
		$("#menuId").css("background-color", "rgb(235, 235, 228)");
	});
}

function fn_new() {
	var menuId = $("#menuId").val();
	var leafYn = $("#leafYn").val();
	var menuLevel = $("#menuLevel").val();
	
	if (menuLevel == '3') {
		alert("메뉴래밸은 '3 Level'까지만 가능합니다.");
		return;
	}
	
	if (leafYn == 'Y') {
		alert("해당 메뉴는 프로그램이므로 하위 메뉴 추가가 불가능합니다.");
		return;
	}
	
	document.detailForm.reset();
	$("#menuId").attr("readonly", false);
	$("#menuId").css("background-color", "white");
	
	$("#saveMode").val("I");
	$("#userIdDupChk").val("N");
	$("#menuPrntId").val(menuId);
	$("#menuLevel").val(parseInt(menuLevel)+1);
	$("#leafYn").val('Y');
	$("#useYn").val('Y');
	
	$("#menuId").focus();
}

function fn_save() {
	if ($("#menuId").val() == "00000") return;
	
	if (!$("#detailForm").valid()) return;
	
	var data = $("#detailForm").serializeArray();
	
	commonAjax(data ,"/system/menu/transactionMenu.do" , function(returnData, textStatus, jqXHR) {		
		alert(returnData.message);
		fn_search();
	});
}

function fn_delete() {
	if ($("#menuId").val() == "00000") return;
	
	if (!confirm("<spring:message code='common.delete.msg'/>")) return;
	
	var node = $("#jsTree").jstree("get_children_dom", $("#jsTree").jstree("get_selected"));
	if (node != undefined && node.length > 0) {
		alert("하위 메뉴가 있어서 삭제할 수 없습니다.");
		return;
	}
	
	$("#saveMode").val("D");
	
	var data = $("#detailForm").serializeArray();
	
	commonAjax(data ,"/system/menu/transactionMenu.do" , function(returnData, textStatus, jqXHR) {		
		alert(returnData.message);
		fn_search();
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
		</div>
	</div>
	
	<div class="box_search">
		<form id="searchForm" name="searchForm" method="post">
			<fieldset>
				<span class="tit">대메뉴</span>
				<select style="width: 154px; height: 25px;" id="sMenuPrntId" name="sMenuPrntId"></select>
	    	</fieldset>
		</form>
	</div>
	
	<div id="tree" class="float_left" style="width: calc(50% - 27px); height: calc(100% - 109px); border: 1px solid #c5c5c5;  border-radius: 3px; background: #fff; padding: 10px;">
		<div id="jsTree" style="overflow: auto; width: 100%; height: 100%;"></div>
	</div>
	
	<div id="form" style="width: calc(50% - 27px); height: calc(100% - 109px); float: left; border: 1px solid #c5c5c5; border-radius: 3px; background: #fff; padding: 10px; margin-left: 10px;">
		<form id="detailForm" name="detailForm" method="post">
			<input type="text" style="display: none;" id="saveMode" name="saveMode" value="I"/>
			<input type="text" style="display: none;" id="rowId" name="rowId" value=""/>
			
			<table summary="테이블" class="table1">
				<caption></caption>
				<colgroup>
					<col width="30%" />
					<col width="*%" />
				</colgroup>
				<tbody>
					<tr>
						<th>메뉴ID</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="menuId" name="menuId" value="" caption="메뉴ID" required="required"/></td>
					</tr>
					<tr>
						<th>메뉴명</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="menuNm" name="menuNm" value="" caption="메뉴명" required="required"/></td>
					</tr>
					<tr>
						<th>상위메뉴ID</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="menuPrntId" name="menuPrntId" value="" caption="상위메뉴ID" required="required"/></td>
					</tr>
					<tr>
						<th>메뉴순서</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="dispOrdr" name="dispOrdr" value="" caption="메뉴순서" required="required"/></td>
					</tr>
					<tr>
						<th>메뉴대상</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="menuObject" name="menuObject" value="" caption="메뉴대상"/></td>
					</tr>
					<tr>
						<th>메뉴경로(팝업)</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="menuPath" name="menuPath" value="" caption="메뉴경로"/></td>
					</tr>
					<tr>
						<th>메뉴설명</th>
						<td><textarea style="width: 298px; height: 100px; resize: none;" id="menuDesc" name="menuDesc" value="" caption="메뉴설명"></textarea></td>
					</tr>
					<tr>
						<th>대메뉴아이콘</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="iconNm" name="iconNm" value="" caption="대메뉴아이콘"/></td>
					</tr>
					<tr>
						<th>프로그램여부</th>
						<td><select style="width: 304px; height: 25px;" id="leafYn" name="leafYn" caption="프로그램여부" required="required"></select></td>
					</tr>
					<tr>
						<th>메뉴레벨</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="menuLevel" name="menuLevel" value="" caption="메뉴레벨"/></td>
					</tr>
					<tr>
						<th>사용여부</th>
						<td><select style="width: 304px; height: 25px;" id="useYn" name="useYn" caption="사용여부" required="required"></select></td>
					</tr>
					<tr>
						<th>등록자</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="createId" name="createId" value="" disabled="disabled"/></td>
					</tr>
					<tr>
						<th>등록일시</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="createDate" name="createDate" value="" disabled="disabled"/></td>
					</tr>
					<tr>
						<th>수정자</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="updateId" name="updateId" value="" disabled="disabled"/></td>
					</tr>
					<tr>
						<th>수정일시</th>
						<td><input type="text" style="width: 300px; height: 19px;" id="updateDate" name="updateDate" value="" disabled="disabled"/></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>
</body>
</html>