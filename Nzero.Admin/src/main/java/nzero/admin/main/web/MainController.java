package nzero.admin.main.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.main.service.MainService;

@Controller
public class MainController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MainController.class);

	@Resource(name = "mainService")
    private MainService mainService;
	
	// 임시등록번호 갯수 =====================================================================
	@RequestMapping(value="/main/dashboard/selectTempOperTotCnt.do")
	@ResponseBody
	public ModelAndView selectTempOperTotCnt(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectTempOperTotCnt(paramMap);
	}
	
	// 주행거리 정보 =====================================================================
	@RequestMapping(value="/main/dashboard/selectDrivingInfo.do")
	@ResponseBody
	public ModelAndView selectDrivingInfo(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectDrivingInfo(paramMap);
	}
	
	// 데이터 건수 =====================================================================
	@RequestMapping(value="/main/dashboard/selectDataTotCnt.do")
	@ResponseBody
	public ModelAndView selectDataTotCnt(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectDataTotCnt(paramMap);
	}
	
	// 데이터 용량 =====================================================================
	@RequestMapping(value="/main/dashboard/selectDataTotVolume.do")
	@ResponseBody
	public ModelAndView selectDataTotVolume(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectDataTotVolume(paramMap);
	}	
	
	// 데이터 이용현황 =====================================================================
	@RequestMapping(value="/main/dashboard/selectUpDnStatus.do")
	@ResponseBody
	public ModelAndView selectUpDnStatus(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectUpDnStatus(paramMap);
	}
	
	@RequestMapping(value="/main/dashboard/selectUploadCnt.do")
	@ResponseBody
	public ModelAndView selectUploadCnt(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectUploadCnt(paramMap);
	}	
	
	// 사고발생 건수 현황 =====================================================================
	@RequestMapping(value="/main/dashboard/selectAccStatus.do")
	@ResponseBody
	public ModelAndView selectAccStatus(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectAccStatus(paramMap);
	}
	
	@RequestMapping(value="/main/dashboard/selectAccList.do")
	@ResponseBody
	public ModelAndView selectAccList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectAccList(paramMap);
	}
	
	// 통계현황 그래프 =====================================================================
	@RequestMapping(value="/main/dashboard/selectChart.do")
	@ResponseBody
	public ModelAndView selectChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectChart(paramMap);
	}	
	
	// DB 현황 =====================================================================
	@RequestMapping(value="/main/dashboard/selectDBStatus.do")
	@ResponseBody
	public ModelAndView selectDBStatus(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return mainService.selectDBStatus(paramMap);
	}		
}
