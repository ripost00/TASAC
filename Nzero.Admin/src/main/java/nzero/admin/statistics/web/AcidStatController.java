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
import nzero.admin.statistics.service.AcidStatService;

@Controller
public class AcidStatController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AcidStatController.class);
	
	@Resource(name = "acidStatService")
    private AcidStatService acidStatService;
	

	@RequestMapping(value="/statistics/stat/openAcidStat.do")
    public String openAuth(HttpServletRequest request) {
		return "statistics/acidStatList";
    }

	// 월별 사고통계
	@RequestMapping(value="/statistics/stat/selectAcidStatMonList.do")
	@ResponseBody
	public ModelAndView selectAcidStatMonList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = acidStatService.selectMonTemp(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = acidStatService.selectMonUser(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_ROAD")) {
			mv = acidStatService.selectMonRoad(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_WTHR")) {
			mv = acidStatService.selectMonWhtr(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_TEMP_DIST")) {
			mv = acidStatService.selectMonTempDist(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_USER_DIST")) {
			mv = acidStatService.selectMonUserDist(paramMap);
		}		
		return mv;	
	}
	// 월별 사고통계 그래프	
	@RequestMapping(value="/statistics/stat/selectAcidStatMonListChart.do")
	@ResponseBody
	public ModelAndView selectAcidStatMonListChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = acidStatService.selectMonTempChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = acidStatService.selectMonUserChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_ROAD")) {
			mv = acidStatService.selectMonRoadChart(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_WTHR")) {
			mv = acidStatService.selectMonWhtrChart(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_TEMP_DIST")) {
			mv = acidStatService.selectMonTempDistChart(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_USER_DIST")) {
			mv = acidStatService.selectMonUserDistChart(paramMap);
		}		
		return mv;	
	}
	// 월별 사고통계 엑셀
	@RequestMapping(value="/statistics/stat/selectAcidStatMonExcel.do")
	@ResponseBody
    public ModelAndView selectAcidStatMonExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
		ModelAndView excelMV = null;
		if (paramData.getString("sType").equals("SEL_TEMP")) {
			excelMV = acidStatService.selectMonTemp(paramData);
		}
		if (paramData.getString("sType").equals("SEL_USER")) {
			excelMV = acidStatService.selectMonUser(paramData);
		}
		if (paramData.getString("sType").equals("SEL_ROAD")) {
			excelMV = acidStatService.selectMonRoad(paramData);
		}		
		if (paramData.getString("sType").equals("SEL_WTHR")) {
			excelMV = acidStatService.selectMonWhtr(paramData);
		}		
		if (paramData.getString("sType").equals("SEL_TEMP_DIST")) {
			excelMV = acidStatService.selectMonTempDist(paramData);
		}		
		if (paramData.getString("sType").equals("SEL_USER_DIST")) {
			excelMV = acidStatService.selectMonUserDist(paramData);
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
	
	// 년별 사고통계
	@RequestMapping(value="/statistics/stat/selectAcidStatYearList.do")
	@ResponseBody
	public ModelAndView selectAcidStatYearList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = acidStatService.selectYearTemp(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = acidStatService.selectYearUser(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_ROAD")) {
			mv = acidStatService.selectYearRoad(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_WTHR")) {
			mv = acidStatService.selectYearWhtr(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_TEMP_DIST")) {
			mv = acidStatService.selectYearTempDist(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_USER_DIST")) {
			mv = acidStatService.selectYearUserDist(paramMap);
		}		
		return mv;	
	}
	// 년별 사고통계 그래프
	@RequestMapping(value="/statistics/stat/selectAcidStatYearListChart.do")
	@ResponseBody
	public ModelAndView selectAcidStatYearListChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		ModelAndView mv = null;
		if (paramMap.getString("sType").equals("SEL_TEMP")) {
			mv = acidStatService.selectYearTempChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_USER")) {
			mv = acidStatService.selectYearUserChart(paramMap);
		}
		if (paramMap.getString("sType").equals("SEL_ROAD")) {
			mv = acidStatService.selectYearRoadChart(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_WTHR")) {
			mv = acidStatService.selectYearWhtrChart(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_TEMP_DIST")) {
			mv = acidStatService.selectYearTempDistChart(paramMap);
		}		
		if (paramMap.getString("sType").equals("SEL_USER_DIST")) {
			mv = acidStatService.selectYearUserDistChart(paramMap);
		}		
		return mv;	
	}	
	// 년별 사고통계 엑셀
	@RequestMapping(value="/statistics/stat/selectAcidStatYearExcel.do")
	@ResponseBody
    public ModelAndView selectAcidStatYearExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    ModelAndView excelMV = null;
		if (paramData.getString("sType").equals("SEL_TEMP")) {
			excelMV = acidStatService.selectYearTemp(paramData);
		}
		if (paramData.getString("sType").equals("SEL_USER")) {
			excelMV = acidStatService.selectYearUser(paramData);
		}
		if (paramData.getString("sType").equals("SEL_ROAD")) {
			excelMV = acidStatService.selectYearRoad(paramData);
		}		
		if (paramData.getString("sType").equals("SEL_WHTR")) {
			excelMV = acidStatService.selectYearWhtr(paramData);
		}		
		if (paramData.getString("sType").equals("SEL_TEMP_DIST")) {
			excelMV = acidStatService.selectYearTempDist(paramData);
		}		
		if (paramData.getString("sType").equals("SEL_USER_DIST")) {
			excelMV = acidStatService.selectYearUserDist(paramData);
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
	
}
