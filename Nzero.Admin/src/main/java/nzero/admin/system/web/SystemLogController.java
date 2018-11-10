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
import nzero.admin.system.service.SystemLogService;

@Controller
public class SystemLogController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SystemLogController.class);
	
	@Resource(name = "systemLogService")
    private SystemLogService systemLogService;
	

	@RequestMapping(value="/system/rsrc/openSystemLog.do")
    public String openAuth(HttpServletRequest request) {
		return "system/systemLogList";
    }

	@RequestMapping(value="/system/rsrc/selectSystemLogList.do")
	@ResponseBody
	public ModelAndView selectSystemLogList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return systemLogService.selectSystemLogList(paramMap);		
	}

	@RequestMapping(value="/system/rsrc/selectSystemLogExcel.do")
	@ResponseBody
    public ModelAndView selectSystemLogExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
		ModelAndView excelMV = systemLogService.selectSystemLogList(paramData);

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
