<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자율주행 데이터 공유센터</title>

<%@ include file="/include/header.jsp" %>

<style type="text/css">
	#content {
		width: auto;
		height: 700px;
	    position: relative;
	    margin: 0px auto;
	    padding: 0px;
	    background: none;
	    -moz-border-radius: 0px;
	    -webkit-border-radius: 0px;
	    border-radius: 0px;
	}
	#content .ui-tabs-nav {
	    position: absolute;
	    left: 0.25em;
	    right: 0.25em;
	    bottom: 0.25em;
	    padding: 0em 0.2em 0.2em;
	    background: transparent; 
	    border-width: 0px;
	    -moz-border-radius: 0px;
	    -webkit-border-radius: 0px;
	    border-radius: 0px;
	}
	#content .ui-tabs-nav li {
	    border-top: none;
	    border-bottom: 1px solid #ccc;
	    -moz-border-radius: 0px 0px 4px 4px;
	    -webkit-border-radius: 0px 0px 4px 4px;
	    border-radius: 0px 0px 4px 4px;
	}
	#content .ui-tabs-nav li.ui-tabs-selected,
	#content .ui-tabs-nav li.ui-state-active {
	    top: -1px;
	}
	#content .ui-tabs-panel {
	    margin: 0em 0.2em 0.2em 0.2em;
	}
	
	/* tab 관련  */
	#tabs { 
		list-style: none;
		position: absolute; 
		bottom: 0px;
		height: 32px;
		margin: 0px 0px 0px -17px;
		padding: 0px;
		background: #eee;
		border-top: 1px solid #a5a5a5; 
		border-bottom: 1px solid #a5a5a5;
		font-size: 11px;
		box-sizing: border-box; /* W3C */
		-o-box-sizing: border-box; /* Opera */
		-ms-box-sizing: border-box; /* Internet Explorer */
		-moz-box-sizing: border-box; /* Firefox */
		-webkit-box-sizing: border-box; /* Safari & Chrome */
	}
	#tabs li { 
		float:left;
		height: 23px; 
		margin-top: -1px;
		padding:7px 10px 0px 10px; 
		background-color:#eee; 
		border-top:1px solid #a5a5a5; 
		border-right:1px solid #a5a5a5;
	}
	#tabs li a { color:#555; text-decoration:none; }
	#tabs li.current { background-color:#fff; border-top:1px solid #fff;}
	#tabs li.current a { color:#222; text-decoration:none; outline: none; }
	#tabs li a.remove { color:#000; margin-left:15px;}
	#content { background-color:transparent;}
	#content p { margin:0px; padding:0px; height:100%;}
	
	#wrapper { border:1px solid #DEDEDE; }
	#wrapper { float:left; margin:0 20px 0 0px;}
	#wrapper { width:98%; margin-top:5px;}
</style>

<script type="text/javascript">
$(window).resize(function(event) {
	if (this == event.target) {
		fn_absolutXY();
	}
});

$(document).ready(function() {
	var tabs = $("#tabs").tabs();
	
	// 탭 클릭
	$(document).on('click','#tabs a.tab', function() {
		var contentId = $(this).attr("id").replace('TAB_', 'CONTENT_');

		$("#content p").hide();
		$("#tabs li").removeClass("current");
		
		$("#" + contentId).show();
		$(this).parent().addClass("current");
	});

	// 탭 REMOVE 클릭
    $(document).on('click','#tabs a.remove', function() {
        var tabid = $(this).parent().find(".tab").attr("id");

        var contentId = tabid.replace('TAB_', 'CONTENT_');

        $("#" + contentId).remove();
        $(this).parent().remove();		//탭삭제

        
        if ($("#tabs li.current").length == 0 && $("#tabs li").length > 0) {
            var firsttab = $("#tabs li:first-child");
            firsttab.addClass("current");
            var firsttabid = $(firsttab).find("a.tab").attr("id").replace('TAB_', 'CONTENT_');
            
            $("#" + firsttabid).show();
        } else if ($("#tabs li.current").length == 0 && $("#tabs li").length == 0) {	//모든탭이 닫히면 첫화면 show
        	$("#content p").show();
        }
    });
	
	fn_absolutXY();
	
	fn_goMain(null, "0");
});

function fn_absolutXY() {
	var body_w = document.body.clientWidth;
	var cont_area_w = body_w - 17;
	var tabs_w = body_w;
	
	if ($("#leftMenu").css("display") != "none") {	//왼쪽 사이드 메뉴 Size 추가 (152px)
		cont_area_w = body_w - 152 - 17;	
		tabs_w = body_w - 152;
	}
	$("#cont_area").css("width", cont_area_w);
	$("#tabs").css("width", tabs_w);
	
	var body_h = document.body.clientHeight;
	var content_h = body_h - 60;
	
	if ($("#tabs").css("display") != "none") {	//하단 탭메뉴 Size 추가 (40px)
		content_h = body_h - 100;
	}
	$("#content").css("height", content_h);
}

function fn_goMain(objId, menuId) {
	for (var i=1; i<=9; i++) {
		$("#tmenu_"+i).removeClass("tmenu_on");
	}
	
	if (menuId == "0") {
		$("#content").empty();
		$("#tabs").empty();
		$("#tabs").hide();
		var body_h = document.body.clientHeight;
		var content_h = body_h - 60;
		content_h = content_h + "px";
		$("#content").css("height", content_h);
		
		fn_goMainPage(); //메인화면 표출
		fn_makeMenu("00000"); //메뉴생성
		fn_hideMenu(false); //메뉴숨김
	} else {
		if (objId != null) {
			$("#"+objId).addClass("tmenu_on");
		}
		
		$("#tabs").show();
		var body_h = document.body.clientHeight;
		var content_h = body_h - 100;
		content_h = content_h + "px";
		$("#content").css("height", content_h);
		
		fn_makeMenu(menuId); //메뉴생성
        fn_hideMenu(true); //메뉴펼침
	}
}

function fn_goMainPage() {
	if ($("#TAB_MENU_MAIN_content").length > 0) return;

	var realMenuId = "MENU_MAIN";
	var targetWorkSpaceUrl = "/openInit.do";
	var tabHeight = "100%";
	var iframe = "<iframe id='Workspace_"+realMenuId+"' name='Workspace_"+realMenuId+"' class='wsp' src='"+targetWorkSpaceUrl+"' frameborder='0' width='100%' height='"+tabHeight+"' style='overflow:auto; margin:0px; padding:0px;'></iframe>";
	$("#content").append("<p class='tab_content' id='TAB_MENU_MAIN_content' name='TAB_MENU_MAIN_content'>" + iframe + "</p>");
}

function fn_makeMenu(menuPrntId) {
	$("#leftMenu").empty();
	
	commonAjax({ "menuPrntId": menuPrntId }, "/selectMainMenuList.do", function(returnData, textStatus, jqXHR) {
		var records = returnData.rows;
		var menuHtml = "";
		if (menuPrntId == "00000") {
			for (var i=0; i<records.length; i++) {
				menuHtml += '<li><a id="'+records[i].iconNm+'" href="javascript:fn_goMain(\''+records[i].iconNm+'\', \''+records[i].id+'\');" class="'+records[i].iconNm+'"><span></span>'+records[i].menuNm+'</a></li>';
			}
			
			$(".tmenu").append(menuHtml);
		} else {
			var menuLevel = "3";
	    	for (var i=0; i<records.length; i++) {
	    			if (i == 0) {
	        			menuHtml += "<span class='logo'></span><ul class='lmenu'>";
	        		} else {
	        			if (menuLevel > records[i].menuLevel) {
	        				menuHtml += "</ul></ul><ul class='lmenu'>";
	        			}
	        		}
	        		
	        		if (records[i].menuLevel == "2") { //중메뉴
	    				if (i == 0) {
	    					menuHtml += "<li class='lmenu1' id='"+records[i].id+"'><a href='javascript:fn_acdnMenu(\""+records[i].id+"\");'>"+records[i].menuNm+"</a></li><ul class='lmenu2' style='height: 0px; overflow: auto;' id='"+records[i].id+"_menu'>";
	    				} else {
	    					menuHtml += "<li class='lmenu1' id='"+records[i].id+"'><a href='javascript:fn_acdnMenu(\""+records[i].id+"\");'>"+records[i].menuNm+"</a></li><ul class='lmenu2 display_none' style='height: 0px; overflow: auto;' id='"+records[i].id+"_menu'>";
	    				}
	        		} else { //프로그램
	        			menuHtml += "<li class='menu3' id='"+records[i].id+"'><a href='javascript:fn_goMenu(\""+records[i].id+"\", \""+records[i].menuNm+"\");'>"+records[i].menuNm+"</a></li>";
	        		}
	        		
	        		if (i == records.length-1) {
	        			menuHtml += "</ul></ul>";
	        		}
	        		
	        		menuLevel = records[i].menuLevel;
	    	}
	    	
	    	$("#leftMenu").append(menuHtml);
	    	
	    	var menu3Cnt = 0;
	    	var menu3Height = 0;
	    	for (var i=0; i<records.length; i++) {
	    		if (records[i].menuLevel == "2") { //중메뉴
	    			menu3Cnt = 0;
	    		} else { //프로그램
	    			menu3Cnt++;
	    			menu3Cnt = menu3Cnt > 20 ? 20 : menu3Cnt;
	    			menu3Height = menu3Cnt * 24;
	    			$("#" + records[i].menuPrntId + "_menu").css("height", menu3Height+"px");
	    		}
	    	}
		}
	});
}

function fn_acdnMenu(id) {
	$("ul.lmenu2").removeClass().addClass("lmenu2 display_none");
	$("#"+id+"_menu").removeClass().addClass("lmenu2");
}

function fn_goMenu(id, nm) {
	$("li.lmenu3").removeClass().addClass("lmenu3");
	$("#"+id).removeClass().addClass("lmenu3 on");
	fn_openMenu(id, nm);
}

function fn_openMenu(menuId, menuNm) {
	var targetUrl = "", targetPath = "";
	
	commonAjax({ "menuId": menuId }, "/selectMenu.do", function(returnData, textStatus, jqXHR) {
		for (var i=0; i<returnData.rows.length; i++) {
			targetUrl = returnData.rows[i].menuObject;
			targetPath = returnData.rows[i].menuPath;
			
			if (targetUrl == null || targetUrl == "") {
				if (targetPath == null || targetPath == "") {
					return false;
				} else {
					fn_openPage(menuId, menuNm, targetPath);
				}
			} else {
				fn_goPage(menuId, menuNm, targetUrl);
			}
		 }
	});
}

function fn_openPage(menuId, menuNm, targetPath) {
	window.open(targetPath, menuNm);
}

function fn_goPage(menuId, menuNm, targetUrl) {
	var menuId = 'MENU_'+menuId;
	var tabId = "TAB_" + menuId;
	var iframeId = "IFRAME_" + menuId;
	var contentId = "CONTENT_" + menuId;

	var iframe = "";
	var tabUrl;
	if (targetUrl.indexOf("?") > -1) {
		tabUrl = targetUrl+"&menuId="+menuId+"&menuNm="+encodeURI(encodeURIComponent(menuNm));
	} else {
		tabUrl = targetUrl+"?menuId="+menuId+"&menuNm="+encodeURI(encodeURIComponent(menuNm));
	}

	var tabHeight = "100%";

	if ($('#'+menuId).length > 0) {
		$("#tabs li").removeClass("current");
	    $("#content p").hide();
	    
	    $("#"+menuId).show();
	}
	
	$("#" + contentId).remove();
	
	if ($('#tabs li').length < 10) {
		$("#tabs li").removeClass("current"); //탭 모두 선택해제
		$("#content p").hide();				  //열려있는 iframe 모두숨김 
		
		iframe = "<iframe id='"+iframeId+"' name='"+iframeId+"' class='wsp' src='"+tabUrl+"' frameborder='0' width='100%' height='"+tabHeight+"' style='overflow:auto; margin:0px; padding:0px;'></iframe>";
		$("#content").append("<p class='tab_content' id='"+contentId+"' name='"+contentId+"'>" + iframe + "</p>");
		
		$("#" + contentId).show();

		if ($("#" + tabId).length == 0) {
			$("#tabs").append("<li class='current'><a class='tab' id='"+tabId+"' name='"+tabId+"' href='#'>" + menuNm + "</a><a href='#' class='remove'>X</a></li>");
		    $("#tabs").tabs( "refresh" );
		} else {
			$("#" + contentId).show();
			$("#" + tabId).parent().addClass("current");
		}
	} else {
		alert("10개 이상의 창을 열수 없습니다.\n열린창을 닫고 다시 시도해 주세요.");
	}
}

function fn_hideMenu(bOpen) {
	var obj = $("#leftMenu");
	var body_w = document.body.clientWidth;
	var cont_area_w = 0;
	var tabs_w = body_w - 152;
	
	if (bOpen == undefined) {
		if (obj.css("display") != "none") { //메뉴숨김
			bOpen = false;
		} else { //메뉴펼침
			bOpen = true;
		}
	}
	
	if ($("#tabs").css("display") == "none" && bOpen) {
		return;
	}
	
	if (bOpen) { //메뉴펼침
		obj.show();
		
		cont_area_w = body_w - 152 - 17;
		$("#cont_area").css("width", cont_area_w);
		tabs_w = body_w - 152;
		$("#tabs").css("width", tabs_w);
		$("#leftMenuImg").attr("src", "/images/left/ico_mhide.png");
	} else { //메뉴숨김
		obj.hide();
		
		cont_area_w = body_w - 17;
		$("#cont_area").css("width", cont_area_w);
		tabs_w = body_w;
		$("#tabs").css("width", tabs_w);
		$("#leftMenuImg").attr("src", "/images/left/ico_mshow.png");
	}
}

function fn_openUserInfo() {
    alert("사용자가 직접 개인정보 수정하는 팝업 페이지 호출");
}

function fn_logout() {
	if (confirm("로그아웃 하시겠습니까?")) {
		location.href = "/actionLogout.do";
	}
}
</script>
</head>
<body>
	<!-- header -->
	<div id="header">
		<!-- user -->
		<div class="user">
			<p><img src="/images/header/top1_ico1.png" alt="" /><a href="javascript:fn_openUserInfo();">${userVo.userNm}</a>님</p>
			<strong><a href="javascript:fn_logout();">로그아웃</a></strong>
		</div>
		<!-- //user -->
		
		<!-- tmenu -->
		<ul class="tmenu"></ul>
		<!-- //tmenu -->
		
		<!-- r_menu -->
		<div class="r_menu">
			<div class="top_select test">
				<span>관계플랫폼사이트</span><a href="#" title="" class="top_btn1"><img src="/images/header/top1_ico3.png" /></a>
				<ul class="display_none">
					<li><a href="#">사이트1</a></li>
					<li><a href="#">사이트1</a></li>
					<li><a href="#">사이트1</a></li>
					<li><a href="#">사이트1</a></li>
				</ul>
			</div>
		</div>
		<!-- //r_menu -->
	</div>
	<!-- //header --> 
	
	<!-- wrap -->
	<div id="wrap">
		<!-- lmenu_area -->
		<div class="lmenu_area" id="leftMenu"></div>
		
		<div style="float: left;">
			<a href="javascript:fn_hideMenu();"><img id="leftMenuImg" src="/images/left/ico_mhide.png"/></a>
		</div>
		<!-- //lmenu_area -->
		
		<!-- cont_area -->
		<div id="cont_area">
			<div class="contents">
				<div id="content"></div>
			</div>
			
			<!-- bt_tab -->
			<div class="bt_tab display_none" id="tabs"></div>
			<!-- //bt_tab -->
		</div>
		<!-- //cont_area -->
	</div>
	<!-- //wrap -->
</body>
</html>