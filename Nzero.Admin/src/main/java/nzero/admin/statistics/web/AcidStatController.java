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
	
	@RequestMapping(value="/statistics/stat/selectAcidStatMonList.do")
	@ResponseBody
	public ModelAndView selectAcidStatMonList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return acidStatService.selectAcidStatMonList(paramMap);
	}
	@RequestMapping(value="/statistics/stat/selectAcidStatMonListChart.do")
	@ResponseBody
	public ModelAndView selectAcidStatMonListChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return acidStatService.selectAcidStatMonListChart(paramMap);
	}
	
	@RequestMapping(value="/statistics/stat/selectAcidStatYearList.do")
	@ResponseBody
	public ModelAndView selectAcidStatYearList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return acidStatService.selectAcidStatYearList(paramMap);
	}
	@RequestMapping(value="/statistics/stat/selectAcidStatYearListChart.do")
	@ResponseBody
	public ModelAndView selectAcidStatYearListChart(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return acidStatService.selectAcidStatYearListChart(paramMap);
	}
	
	@RequestMapping(value="/statistics/stat/selectAcidStatMonExcel.do")
	@ResponseBody
    public ModelAndView selectAcidStatMonExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);

	    ModelAndView excelMV = acidStatService.selectAcidStatMonList(paramData);
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
	
	@RequestMapping(value="/statistics/stat/selectAcidStatYearExcel.do")
	@ResponseBody
    public ModelAndView selectAcidStatYearExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);

	    ModelAndView excelMV = acidStatService.selectAcidStatYearList(paramData);
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
