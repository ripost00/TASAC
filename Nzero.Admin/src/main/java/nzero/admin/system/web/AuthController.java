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
import nzero.admin.system.service.AuthService;

@Controller
public class AuthController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);
	
	@Resource(name = "authService")
    private AuthService authService;
	
	@RequestMapping(value="/system/auth/selectAuthComboBox.do")
	@ResponseBody
	public ModelAndView selectAuthComboBox(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return authService.selectAuthComboBox(paramMap);
	}
	
	@RequestMapping(value="/system/auth/openAuth.do")
    public String openAuth(HttpServletRequest request) {
		return "system/authList";
    }
	
	@RequestMapping(value="/system/auth/selectAuthList.do")
	@ResponseBody
	public ModelAndView selectAuthList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return authService.selectAuthList(paramMap);
	}
	
	@RequestMapping(value="/system/auth/transactionAuth.do")
	@ResponseBody
	public ModelAndView transactionAuth(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		ModelAndView mv = null;
		if (paramMap.getString("saveMode").equals("I")) {
			Integer authId = authService.selectMaxAuthId(paramMap);
			paramMap.put("authId", String.format("%05d", (authId + 1)));
			
			mv = authService.insertAuth(paramMap);
		}
		if (paramMap.getString("saveMode").equals("U")) {
			mv = authService.updateAuth(paramMap);
		}
		if (paramMap.getString("saveMode").equals("D")) {
			mv = authService.deleteAuth(paramMap);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/system/auth/selectAuthExcelList.do")
	@ResponseBody
    public ModelAndView selectAuthExcelList(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    	    
	    ModelAndView excelMV = authService.selectAuthList(paramData);
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
