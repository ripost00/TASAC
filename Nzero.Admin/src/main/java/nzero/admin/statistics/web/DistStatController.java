package nzero.admin.statistics.web;

import java.util.Arrays;
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
import nzero.admin.egovframework.cmmn.util.StringUtils;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.statistics.service.DistStatService;

@Controller
public class DistStatController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(DistStatController.class);
	
	@Resource(name = "distStatService")
    private DistStatService distStatService;
	

	@RequestMapping(value="/statistics/stat/openDistStat.do")
    public String openAuth(HttpServletRequest request) {
		return "statistics/distStatList";
    }
	
	// 월별 주행거리
	@RequestMapping(value="/statistics/stat/selectDistStatMonList.do")
	@ResponseBody
	public ModelAndView selectDistStatMonList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_ALL")) {
			mv = distStatService.selectMonAll(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = distStatService.selectMonTemp(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = distStatService.selectMonUser(paramMap);
		}
		return mv;		
	}
	// 월별 주행거리 그래프	
	@RequestMapping(value="/statistics/stat/selectDistStatMonListChart.do")
	@ResponseBody
	public ModelAndView selectDistStatMonListChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_ALL")) {
			mv = distStatService.selectMonAllChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = distStatService.selectMonTempChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = distStatService.selectMonUserChart(paramMap);
		}
		return mv;	
	}
	// 월별 주행거리 엑셀
	@RequestMapping(value="/statistics/stat/selectDistStatMonExcel.do")
	@ResponseBody
    public ModelAndView selectDistStatMonExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
		ModelAndView excelMV = null;
		if (paramData.getString("sType").equals("SEL_ALL")) {
			excelMV = distStatService.selectMonAll(paramData);
		}
		if (paramData.getString("sType").equals("SEL_TEMP")) {
			excelMV = distStatService.selectMonTemp(paramData);
		}
		if (paramData.getString("sType").equals("SEL_USER")) {
			excelMV = distStatService.selectMonUser(paramData);
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
	@RequestMapping(value="/statistics/stat/selectDistStatYearList.do")
	@ResponseBody
	public ModelAndView selectDistStatYearList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
		paramMap.set("yearList", yearList);
		
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_ALL")) {
			mv = distStatService.selectYearAll(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = distStatService.selectYearTemp(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = distStatService.selectYearUser(paramMap);
		}
		return mv;	
	}
	// 년별 주행거리 그래프
	@RequestMapping(value="/statistics/stat/selectDistStatYearListChart.do")
	@ResponseBody
	public ModelAndView selectDistStatYearListChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		List<String> yearList = Arrays.asList(paramMap.getString("yearArr").split("\\s*,\\s*"));
		paramMap.set("yearList", yearList);
		
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_ALL")) {
			mv = distStatService.selectYearAllChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = distStatService.selectYearTempChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = distStatService.selectYearUserChart(paramMap);
		}
		return mv;	
	}
	// 년별 주행거리 엑셀
	@RequestMapping(value="/statistics/stat/selectDistStatYearExcel.do")
	@ResponseBody
    public ModelAndView selectDistStatYearExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
		List<String> yearList = Arrays.asList(paramData.getString("yearArr").split("\\s*,\\s*"));
		paramData.set("yearList", yearList);
		
		ModelAndView excelMV = null;
		if (paramData.getString("sType").equals("SEL_ALL")) {
			excelMV = distStatService.selectYearAll(paramData);
		}
		if (paramData.getString("sType").equals("SEL_TEMP")) {
			excelMV = distStatService.selectYearTemp(paramData);
		}
		if (paramData.getString("sType").equals("SEL_USER")) {
			excelMV = distStatService.selectYearUser(paramData);
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
