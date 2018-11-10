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
import nzero.admin.system.service.NoticeService;

@Controller
public class NoticeController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(NoticeController.class);

	@Resource(name = "noticeService")
    private NoticeService noticeService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;

	@RequestMapping(value="/system/notice/openNotice.do")
    public String openNotice(HttpServletRequest request) {
		return "system/noticeList";
    }
	
	@RequestMapping(value="/system/notice/selectNoticeList.do")
	@ResponseBody
	public ModelAndView selectNoticeList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return noticeService.selectNoticeList(paramMap);
	}	
	
	@RequestMapping(value="/system/notice/selectNoticeInfo.do")
	@ResponseBody
	public ModelAndView selectNoticeInfo(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return noticeService.selectNoticeInfo(paramMap);
	}
	
	@RequestMapping(value="/system/notice/insertNoticeInfo.do")
	@ResponseBody
	public ModelAndView insertNoticeInfo(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {
		
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload");
		String uploadPath = pathUpload + "notc" + pathLetter;
		
		SimpleData paramMap = getSimpleData(request);
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String newFileNM = "";
		if(!files.get("file_info").isEmpty()){
			paramMap.setString("attachFileNm", files.get("file_info").getOriginalFilename());
			paramMap.setString("attachFileSize", String.valueOf(files.get("file_info").getSize()));
			newFileNM = paramMap.getString("boardSeq") + "_";
			String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), uploadPath, newFileNM);
			paramMap.setString("attachFileNm", file_name);
		}
		return noticeService.insertNotice(paramMap);
	}
	
	@RequestMapping(value="/system/notice/updateNoticeInfo.do")
	@ResponseBody
	public ModelAndView updateNoticeInfo(MultipartHttpServletRequest multipartRequest, HttpServletRequest request) throws Exception {
		
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload");
		String uploadPath = pathUpload + "notc" + pathLetter;
		
		SimpleData paramMap = getSimpleData(request);
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String newFileNM = "";
		if(!files.get("file_info").isEmpty()){
			paramMap.setString("attachFileNm", files.get("file_info").getOriginalFilename());
			paramMap.setString("attachFileSize", String.valueOf(files.get("file_info").getSize()));
			newFileNM = paramMap.getString("boardSeq") + "_";
			String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), uploadPath, newFileNM);
			paramMap.setString("attachFileNm", file_name);
		}
		return noticeService.updateNotice(paramMap);
	}
	
	@RequestMapping(value="/system/notice/deleteNoticeInfo.do")
	@ResponseBody
	public ModelAndView deleteNoticeInfo(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return noticeService.deleteNotice(paramMap);
	}
}
