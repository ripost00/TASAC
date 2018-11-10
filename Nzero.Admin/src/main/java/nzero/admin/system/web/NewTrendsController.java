package nzero.admin.system.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.egovframework.cmmn.util.FileUtil;
import nzero.admin.system.service.NewTrendsService;

@Controller
public class NewTrendsController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(NewTrendsController.class);

	@Resource(name = "newTrendsService")
    private NewTrendsService newTrendsService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;

	@RequestMapping(value="/system/newTrends/openNewTrends.do")
    public String openNewTrends(HttpServletRequest request) {
		return "system/newTrendsList";
    }
	
	@RequestMapping(value="/system/newTrends/selectNewTrendsList.do")
	@ResponseBody
	public ModelAndView selectNewTrendsList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return newTrendsService.selectNewTrendsList(paramMap);
	}	
	
	@RequestMapping(value="/system/newTrends/selectNewTrendsInfo.do")
	@ResponseBody
	public ModelAndView selectNewTrendsInfo(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return newTrendsService.selectNewTrendsInfo(paramMap);
	}
	
	@RequestMapping(value="/system/newTrends/insertNewTrendsInfo.do")
	@ResponseBody
	public ModelAndView insertNewTrendsInfo(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {
		
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload");
		String uploadPath = pathUpload + "trnd" + pathLetter;
		
		SimpleData paramMap = getSimpleData(request);
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String newFileNM = "";
		if(!files.get("file_info").isEmpty()){
			paramMap.setString("attachFileNm", files.get("file_info").getOriginalFilename());
			paramMap.setString("attachFileSize", String.valueOf(files.get("file_info").getSize()));
//			newFileNM = paramMap.getString("boardSeq") + "_";
			String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), uploadPath, newFileNM);
			paramMap.setString("attachFileNm", file_name);
		}
		return newTrendsService.insertNewTrends(paramMap);
	}
	
	@RequestMapping(value="/system/newTrends/updateNewTrendsInfo.do")
	@ResponseBody
	public ModelAndView updateNewTrendsInfo(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {
		
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload");
		String uploadPath = pathUpload + "trnd" + pathLetter;
		
		SimpleData paramMap = getSimpleData(request);
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String newFileNM = "";
		if(!files.get("file_info").isEmpty()){
			paramMap.setString("attachFileNm", files.get("file_info").getOriginalFilename());
			paramMap.setString("attachFileSize", String.valueOf(files.get("file_info").getSize()));
//			newFileNM = paramMap.getString("boardSeq") + "_";
			String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), uploadPath, newFileNM);
			paramMap.setString("attachFileNm", file_name);
		}
		return newTrendsService.updateNewTrends(paramMap);
	}
	
	@RequestMapping(value="/system/newTrends/deleteNewTrendsInfo.do")
	@ResponseBody
	public ModelAndView deleteNewTrendsInfo(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return newTrendsService.deleteNewTrends(paramMap);
	}
}
