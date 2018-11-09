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
import nzero.admin.record.service.UpldHistService;

@Controller
public class UpldHistController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UpldHistController.class);
	
	@Resource(name = "upldHistService")
    private UpldHistService upldHistService;
	
	@RequestMapping(value="/record/uploadhitory/openUpldHist.do")
    public String openUpldHist(HttpServletRequest request) {
		return "record/upldHistList";
    }
	
	@RequestMapping(value="/record/uploadhitory/selectUpldHistList.do")
	@ResponseBody
	public ModelAndView selectUpldList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);

		return upldHistService.selectUpldHistList(paramMap);
	}

	@RequestMapping(value="/record/uploadhitory/selectUpldHistExcelList.do")
	@ResponseBody
    public ModelAndView selectUpldExcelList(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    	    
	    ModelAndView excelMV = upldHistService.selectUpldExcelList(paramData);
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
