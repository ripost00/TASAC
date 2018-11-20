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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.property.EgovPropertyService;
import nzero.admin.record.excel.IncdExcel;
import nzero.admin.egovframework.cmmn.util.FileUtil;
import nzero.admin.egovframework.cmmn.util.ExcelUtil;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.record.service.IncdHistService;

@Controller
public class IncdHistController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(IncdHistController.class);

	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;

	@Resource(name = "incdHistService")
    private IncdHistService incdHistService;
	
	@RequestMapping(value="/record/incident/openIncdHist.do")
    public String openIncdHist(HttpServletRequest request) {
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

	@RequestMapping(value="/record/incident/selectIncdHistReport.do")
	@ResponseBody
    public ModelAndView selectIncdHistReport(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "excel" + pathLetter;

		SimpleData paramMap = getSimpleData(request);

	    ModelAndView incdMV = incdHistService.selectIncdList(paramMap);
	    Map<String, Object> incdModel = incdMV.getModel();
	    List<Object> incdList = (List) incdModel.get("rows");
	    Map<String, String> incdInfo = (Map<String, String>)incdList.get(0);

	    ModelAndView accCarMV = incdHistService.selectAccCarList(paramMap);
	    Map<String, Object> accCarModel = accCarMV.getModel();
	    List<Object> carList = (List) accCarModel.get("rows");

	    LOGGER.info(" ########## selectIncdHistReport.do ###########");
	    LOGGER.info(" ########## incdList : "+ incdList);
	    LOGGER.info(" ##########  carList : "+ carList);

		//엑셀파일 이름 변경
		String filenm_org = "excel_incd.xlsx";
		String filenm_new = "excel_incd_"+paramMap.get("sAccId")+".xlsx";
		//업로드 경로
		String filePath_org = pathUpload + filenm_org;
		String filePath_new = pathUpload + filenm_new;

		//경로명 replace
		filePath_new = ExcelUtil.getReplace(filePath_new, "\\\\", "/");
		LOGGER.info(" filePath_new["+filePath_new+"]");

		//엑셀 파일 정보 셋팅
		String result = IncdExcel.incdExcelMake(filePath_new, filenm_new, incdInfo, carList);
		LOGGER.debug("     result["+result+"]");

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

		return incdHistService.selectIncdList(paramMap);
    }

}
