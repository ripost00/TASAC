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
import nzero.admin.system.service.ParamService;

@Controller
public class ParamController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ParamController.class);
	
	@Resource(name = "paramService")
    private ParamService paramService;
	
	@RequestMapping(value="/system/param/openParam.do")
    public String openParam(HttpServletRequest request) {
		return "system/paramList";
    }
	
	@RequestMapping(value="/system/param/selectParamList.do")
	@ResponseBody
	public ModelAndView selectParamList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return paramService.selectParamList(paramMap);
	}
	
	@RequestMapping(value="/system/param/transactionParam.do")
	@ResponseBody
	public ModelAndView transactionParam(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		ModelAndView mv = null;
		if (paramMap.getString("saveMode").equals("I")) {
			mv = paramService.insertParam(paramMap);
		}
		if (paramMap.getString("saveMode").equals("U")) {
			mv = paramService.updateParam(paramMap);
		}
		if (paramMap.getString("saveMode").equals("D")) {
			mv = paramService.deleteParam(paramMap);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/system/param/selectParamExcelList.do")
	@ResponseBody
    public ModelAndView selectParamExcelList(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    	    
	    ModelAndView excelMV = paramService.selectParamList(paramData);
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
