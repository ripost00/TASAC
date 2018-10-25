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
import nzero.admin.system.service.CodeService;

@Controller
public class CodeController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CodeController.class);
	
	@Resource(name = "codeService")
    private CodeService codeService;
	
	@RequestMapping(value="/system/code/selectCodeComboBox.do")
	@ResponseBody
	public ModelAndView selectCodeComboBox(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return codeService.selectCodeComboBox(paramMap);
	}
	
	@RequestMapping(value="/system/code/openCode.do")
    public String openCode(HttpServletRequest request) {
		return "system/codeList";
    }
	
	@RequestMapping(value="/system/code/selectCodeMastList.do")
	@ResponseBody
	public ModelAndView selectCodeMastList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return codeService.selectCodeMastList(paramMap);
	}
	
	@RequestMapping(value="/system/code/transactionCodeMast.do")
	@ResponseBody
	public ModelAndView transactionCodeMast(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		ModelAndView mv = null;
		if (paramMap.getString("saveMode1").equals("I")) {
			mv = codeService.insertCodeMast(paramMap);
		}
		if (paramMap.getString("saveMode1").equals("U")) {
			mv = codeService.updateCodeMast(paramMap);
		}
		if (paramMap.getString("saveMode1").equals("D")) {
			mv = codeService.deleteCodeMast(paramMap);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/system/code/selectCodeDetlList.do")
	@ResponseBody
	public ModelAndView selectCodeDetlList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return codeService.selectCodeDetlList(paramMap);
	}
	
	@RequestMapping(value="/system/code/transactionCodeDetl.do")
	@ResponseBody
	public ModelAndView transactionCodeDetl(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		ModelAndView mv = null;
		if (paramMap.getString("saveMode2").equals("I")) {
			mv = codeService.insertCodeDetl(paramMap);
		}
		if (paramMap.getString("saveMode2").equals("U")) {
			mv = codeService.updateCodeDetl(paramMap);
		}
		if (paramMap.getString("saveMode2").equals("D")) {
			mv = codeService.deleteCodeDetl(paramMap);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/system/code/selectCodeExcelList.do")
	@ResponseBody
    public ModelAndView selectCodeExcelList(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    	    
	    ModelAndView excelMV = codeService.selectCodeExcelList(paramData);
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
