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
import nzero.admin.system.service.ReqConfirmService;

@Controller
public class ReqConfirmController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ReqConfirmController.class);

	@Resource(name = "reqConfirmService")
    private ReqConfirmService reqConfirmService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;

	@RequestMapping(value="/system/req/openReqConfirm.do")
    public String openReqConfirm(HttpServletRequest request) {
		return "system/reqConfirmList";
    }
	
	@RequestMapping(value="/system/req/selectReqConfirmList.do")
	@ResponseBody
	public ModelAndView selectReqConfirmList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		return reqConfirmService.selectReqConfirmList(paramMap);
	}	
	
	@RequestMapping(value="/system/req/selectReqConfirmInfo_T.do")
	@ResponseBody
	public ModelAndView selectReqConfirmInfo_T(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return reqConfirmService.selectReqConfirmInfo_T(paramMap);
	}
	
	@RequestMapping(value="/system/req/selectReqConfirmInfo_U.do")
	@ResponseBody
	public ModelAndView selectReqConfirmInfo_U(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return reqConfirmService.selectReqConfirmInfo_U(paramMap);
	}
	
	@RequestMapping(value="/system/req/updateReqConfirmInfo_T.do")
	@ResponseBody
	public ModelAndView updateReqConfirmInfo_T(HttpServletRequest request) throws Exception {
		
		SimpleData paramMap = getSimpleData(request);
		
		return reqConfirmService.updateReqConfirm_T(paramMap);
	}
	
	@RequestMapping(value="/system/req/updateReqConfirmInfo_U.do")
	@ResponseBody
	public ModelAndView updateReqConfirmInfo_U(HttpServletRequest request) throws Exception {
		
		SimpleData paramMap = getSimpleData(request);
		
		return reqConfirmService.updateReqConfirm_U(paramMap);
	}
}
