package nzero.admin.record.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.property.EgovPropertyService;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.util.ExcelUtil;
import nzero.admin.egovframework.cmmn.util.FileUtil;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.record.excel.DevcExcel;
import nzero.admin.record.service.DevcHistService;

@Controller
public class DevcHistController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(DevcHistController.class);

	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;

	@Resource(name = "devcHistService")
    private DevcHistService devcHistService;
	
	@RequestMapping(value="/record/device/openDevcHist.do")
    public String openDevcHist(HttpServletRequest request) {
		return "record/devcHistList";
    }
	
	@RequestMapping(value="/record/device/selectDevcHistList.do")
	@ResponseBody
	public ModelAndView selectDevcList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);

		return devcHistService.selectDevcHistList(paramMap);
	}

	@RequestMapping(value="/record/device/selectDevcHistExcelList.do")
	@ResponseBody
    public ModelAndView selectDevcExcelList(HttpServletRequest request, ModelMap model) throws Exception {
	    SimpleData paramData = getSimpleData(request);
	    	    
	    ModelAndView excelMV = devcHistService.selectDevcExcelList(paramData);
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

	@RequestMapping(value="/record/device/selectDevcHistReport.do")
	@ResponseBody
    public ModelAndView selectDevcHistReport(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "excel" + pathLetter;

		SimpleData paramMap = getSimpleData(request);

	    ModelAndView devcMV = devcHistService.selectDevcHistList(paramMap);
	    Map<String, Object> devcModel = devcMV.getModel();
	    List<Object> devcList = (List) devcModel.get("rows");
	    Map<String, String> devcInfo = (Map<String, String>)devcList.get(0);

	    LOGGER.info(" ########## selectDevcHistReport.do ###########");
	    LOGGER.info(" ########## devcInfo : "+ devcInfo);

		//엑셀파일 이름 변경
		String filenm_org = "excel_devc.xlsx";
		String filenm_new = "excel_devc_"+paramMap.get("sChgId")+".xlsx";
		//업로드 경로
		String filePath_org = pathUpload + filenm_org;
		String filePath_new = pathUpload + filenm_new;

		//경로명 replace
		filePath_new = ExcelUtil.getReplace(filePath_new, "\\\\", "/");
		LOGGER.info(" filePath_new["+filePath_new+"]");

		//엑셀 파일 정보 셋팅
		String result = DevcExcel.devcExcelMake(filePath_new, filenm_new, devcInfo);
		LOGGER.debug("       result["+result+"]");

		if(result.equals("1")) {
			LOGGER.debug(" ########## File_Download ###########");
			try {
				String checkFile = filePath_new; //잘못된 파라미터를 가려내기위해 특수기호 제거
				checkFile = checkFile.replaceAll("\\\\", "");
				checkFile = checkFile.replaceAll("/", "");
				checkFile = checkFile.replaceAll(";", "");
			} catch (RuntimeException e1) {
				LOGGER.info("[Download File] 실패0 : ");
			}
			String filename = filePath_new;
			
			File file = new File(filename);
			LOGGER.debug("################### Download File : File Name ["+filename+"], File Length ["+file.length()+"] ");
			try {
				if(file.exists()){
					FileUtil.download(request, response, file);
				}
			} catch (ServletException e) {
				LOGGER.info("[Download File] 실패1 : ");
			} catch (IOException e) {
				LOGGER.info("[Download File] 실패2 : ");
			}
		}
		model.addAttribute("result", result);

		return devcHistService.selectDevcHistList(paramMap);
    }
	
}
