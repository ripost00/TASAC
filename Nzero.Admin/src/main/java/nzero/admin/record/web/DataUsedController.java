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
import nzero.admin.record.service.DataUsedService;

@Controller
public class DataUsedController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(DataUsedController.class);

	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;

	@Resource(name = "dataUsedService")
    private DataUsedService dataUsedService;
	
	@RequestMapping(value="/record/dataused/openDataUsed.do")
    public String openDrvgHist(HttpServletRequest request) {
		return "record/dataUsedList";
    }
	
	@RequestMapping(value="/record/dataused/selectDataUsedList.do")
	@ResponseBody
	public ModelAndView selectDataUsedList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);

		return dataUsedService.selectDataUsedList(paramMap);
	}

	@RequestMapping(value="/record/dataused/selectDataUsedDtlList.do")
	@ResponseBody
	public ModelAndView selectDataUsedDtlList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return dataUsedService.selectDataUsedDtlList(paramMap);
	}

}
