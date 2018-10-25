package nzero.admin.record.web;

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
import nzero.admin.record.service.IncdHistService;

@Controller
public class IncdHistController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(IncdHistController.class);
	
	@Resource(name = "incdHistService")
    private IncdHistService incdHistService;
	
	@RequestMapping(value="/record/incident/openIncdHist.do")
    public String openUser(HttpServletRequest request) {
		return "record/incdHistList";
    }
	
	@RequestMapping(value="/record/incident/selectIncdHistList.do")
	@ResponseBody
	public ModelAndView selectIncdList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);

		return incdHistService.selectIncdList(paramMap);
	}

	@RequestMapping(value="/record/incident/selectAccCarList.do")
	@ResponseBody
	public ModelAndView selectAccCarList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return incdHistService.selectAccCarList(paramMap);
	}

	@RequestMapping(value="/record/incident/selectIncdHistExcelList.do")
	@ResponseBody
    public ModelAndView selectIncdExcelList(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    	    
	    ModelAndView excelMV = incdHistService.selectIncdExcelList(paramData);
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
