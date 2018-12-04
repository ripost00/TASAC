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
import nzero.admin.system.service.ConnectLogService;

@Controller
public class ConnectLogController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ConnectLogController.class);
	
	@Resource(name = "connectLogService")
    private ConnectLogService connectLogService;
	

	@RequestMapping(value="/system/connlog/openConnectLog.do")
    public String openAuth(HttpServletRequest request) {
		return "system/connectLogList";
    }

	@RequestMapping(value="/system/connlog/selectConnectLogList.do")
	@ResponseBody
	public ModelAndView selectConnectLogList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return connectLogService.selectConnectLogList(paramMap);		
	}

	@RequestMapping(value="/system/connlog/selectConnectLogExcel.do")
	@ResponseBody
    public ModelAndView selectConnectLogExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
		ModelAndView excelMV = connectLogService.selectConnectLogList(paramData);

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
