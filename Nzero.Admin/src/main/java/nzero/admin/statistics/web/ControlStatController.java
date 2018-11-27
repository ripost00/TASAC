package nzero.admin.statistics.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.statistics.service.ControlStatService;

@Controller
public class ControlStatController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ControlStatController.class);
	
	@Resource(name = "controlStatService")
    private ControlStatService controlStatService;
	

	@RequestMapping(value="/statistics/stat/openControlStat.do")
    public String openAuth(HttpServletRequest request) {
		return "statistics/controlStatList";
    }
	
	// 월별 주행거리
	@RequestMapping(value="/statistics/stat/selectControlStatMonList.do")
	@ResponseBody
	public ModelAndView selectControlStatMonList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_ALL")) {
			mv = controlStatService.selectMonAll(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_CNT")) {
			mv = controlStatService.selectMonCnt(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = controlStatService.selectMonTemp(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = controlStatService.selectMonUser(paramMap);
		}
		return mv;		
	}
	// 월별 주행거리 그래프	
	@RequestMapping(value="/statistics/stat/selectControlStatMonListChart.do")
	@ResponseBody
	public ModelAndView selectControlStatMonListChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_ALL")) {
			mv = controlStatService.selectMonAllChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_CNT")) {
			mv = controlStatService.selectMonCntChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = controlStatService.selectMonTempChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = controlStatService.selectMonUserChart(paramMap);
		}
		return mv;	
	}
	// 월별 주행거리 엑셀
	@RequestMapping(value="/statistics/stat/selectControlStatMonExcel.do")
	@ResponseBody
    public ModelAndView selectControlStatMonExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
		ModelAndView excelMV = null;
		if (paramData.getString("sType").equals("SEL_ALL")) {
			excelMV = controlStatService.selectMonAll(paramData);
		}
		if (paramData.getString("sType").equals("SEL_CNT")) {
			excelMV = controlStatService.selectMonCnt(paramData);
		}
		if (paramData.getString("sType").equals("SEL_TEMP")) {
			excelMV = controlStatService.selectMonTemp(paramData);
		}
		if (paramData.getString("sType").equals("SEL_USER")) {
			excelMV = controlStatService.selectMonUser(paramData);
		}	    
	    Map<String, Object> excelModel = excelMV.getModel();
	    List<Object> excelList = (List) excelModel.get("rows");
	    String[] columsNm = paramData.getString("columnsNm").split(",");
	    String[] datafield = paramData.getString("datafield").split(",");
	    
	    model.put("columnsNm", columsNm);
	    model.put("datafield", datafield);
	    model.put("excelList", excelList);
	    model.put("excelFileNm", request.getParameter("excelFileNm"));
	    
	    return new ModelAndView("ExcelDownload", "excel", model);
    }
	//--------------------------------------------------------------------------------------------
	
	// 년별 주행거리
	@RequestMapping(value="/statistics/stat/selectControlStatYearList.do")
	@ResponseBody
	public ModelAndView selectControlStatYearList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_ALL")) {
			mv = controlStatService.selectYearAll(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_CNT")) {
			mv = controlStatService.selectYearCnt(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = controlStatService.selectYearTemp(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = controlStatService.selectYearUser(paramMap);
		}
		return mv;	
	}
	// 년별 주행거리 그래프
	@RequestMapping(value="/statistics/stat/selectControlStatYearListChart.do")
	@ResponseBody
	public ModelAndView selectControlStatYearListChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_ALL")) {
			mv = controlStatService.selectYearAllChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_CNT")) {
			mv = controlStatService.selectYearCntChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = controlStatService.selectYearTempChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = controlStatService.selectYearUserChart(paramMap);
		}
		return mv;	
	}
	// 년별 주행거리 엑셀
	@RequestMapping(value="/statistics/stat/selectControlStatYearExcel.do")
	@ResponseBody
    public ModelAndView selectControlStatYearExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
		ModelAndView excelMV = null;
		if (paramData.getString("sType").equals("SEL_ALL")) {
			excelMV = controlStatService.selectYearAll(paramData);
		}
		if (paramData.getString("sType").equals("SEL_CNT")) {
			excelMV = controlStatService.selectYearCnt(paramData);
		}
		if (paramData.getString("sType").equals("SEL_TEMP")) {
			excelMV = controlStatService.selectYearTemp(paramData);
		}
		if (paramData.getString("sType").equals("SEL_USER")) {
			excelMV = controlStatService.selectYearUser(paramData);
		}	    
	    Map<String, Object> excelModel = excelMV.getModel();
	    List<Object> excelList = (List) excelModel.get("rows");
	    String[] columsNm = paramData.getString("columnsNm").split(",");
	    String[] datafield = paramData.getString("datafield").split(",");
	    
	    model.put("columnsNm", columsNm);
	    model.put("datafield", datafield);
	    model.put("excelList", excelList);
	    model.put("excelFileNm", request.getParameter("excelFileNm"));
	    
	    return new ModelAndView("ExcelDownload", "excel", model);
    }
	//--------------------------------------------------------------------------------------------
	
}
