package nzero.admin.system.web;

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
import nzero.admin.system.service.GradeService;

@Controller
public class GradeController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(GradeController.class);
	
	@Resource(name = "gradeService")
    private GradeService gradeService;
	
	@RequestMapping(value="/system/grade/openGrade.do")
    public String openGrade(HttpServletRequest request) {
		return "system/gradeList";
    }
	
	@RequestMapping(value="/system/grade/selectGradeList.do")
	@ResponseBody
	public ModelAndView selectGradeList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return gradeService.selectGradeList(paramMap);
	}
	
	@RequestMapping(value="/system/grade/transactionGrade.do")
	@ResponseBody
	public ModelAndView transactionGrade(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		ModelAndView mv = null;
		if (paramMap.getString("saveMode").equals("U")) {
			mv = gradeService.updateGrade(paramMap);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/system/grade/selectGradeExcelList.do")
	@ResponseBody
    public ModelAndView selectGradeExcelList(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    	    
	    ModelAndView excelMV = gradeService.selectGradeList(paramData);
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
