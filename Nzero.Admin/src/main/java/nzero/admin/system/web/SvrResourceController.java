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
import nzero.admin.system.service.SvrResourceService;

@Controller
public class SvrResourceController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SvrResourceController.class);
	
	@Resource(name = "svrResourceService")
    private SvrResourceService svrResourceService;
	

	@RequestMapping(value="/system/rsrc/openSvrResource.do")
    public String openAuth(HttpServletRequest request) {
		return "system/svrResourceList";
    }

	@RequestMapping(value="/system/rsrc/selectSvrResourceList.do")
	@ResponseBody
	public ModelAndView selectSvrResourceList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return svrResourceService.selectSvrResourceList(paramMap);		
	}

	@RequestMapping(value="/system/rsrc/selectSvrResourceExcel.do")
	@ResponseBody
    public ModelAndView selectSvrResourceExcel(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
		ModelAndView excelMV = svrResourceService.selectSvrResourceList(paramData);

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
