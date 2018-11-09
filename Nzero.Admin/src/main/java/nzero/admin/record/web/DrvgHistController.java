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
import nzero.admin.record.service.DrvgHistService;

@Controller
public class DrvgHistController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(DrvgHistController.class);
	
	@Resource(name = "drvgHistService")
    private DrvgHistService drvgHistService;
	
	@RequestMapping(value="/record/driving/openDrvgHist.do")
    public String openDrvgHist(HttpServletRequest request) {
		return "record/drvgHistList";
    }
	
	@RequestMapping(value="/record/driving/selectDrvgHistList.do")
	@ResponseBody
	public ModelAndView selectDrvgHistList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);

		return drvgHistService.selectDrvgHistList(paramMap);
	}

	@RequestMapping(value="/record/driving/selectAutoDrivingList.do")
	@ResponseBody
	public ModelAndView selectAutoDrivingList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return drvgHistService.selectAutoDrivingList(paramMap);
	}

	@RequestMapping(value="/record/driving/selectCtrChangeList.do")
	@ResponseBody
	public ModelAndView selectCtrChangeList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return drvgHistService.selectCtrChangeList(paramMap);
	}

	@RequestMapping(value="/record/driving/selectCtrChangeDtlList.do")
	@ResponseBody
	public ModelAndView selectCtrChangeDtlList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return drvgHistService.selectCtrChangeDtlList(paramMap);
	}

	@RequestMapping(value="/record/driving/selectDrvgHistExcelList.do")
	@ResponseBody
    public ModelAndView selectDrvgHistExcelList(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    	    
	    ModelAndView excelMV = drvgHistService.selectDrvgHistExcelList(paramData);
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
