package nzero.admin.main.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("mainService")
public class MainService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MainService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	public ModelAndView selectTempOperTotCnt(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectTempOperTotCnt", paramMap);
    }

	public ModelAndView selectDrivingInfo(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectDrivingInfo", paramMap);
    }

	public ModelAndView selectDataTotCnt(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectDataTotCnt", paramMap);
    }

	public ModelAndView selectDataTotVolume(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectDataTotVolume", paramMap);
    }

	public ModelAndView selectUpDnStatus(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectUpDnStatus", paramMap);
    }
	
	public ModelAndView selectUploadCnt(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectUploadCnt", paramMap);
    }	
	
	public ModelAndView selectAccStatus(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectAccStatus", paramMap);
    }
	
	public ModelAndView selectAccList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectAccList", paramMap);
    }		
	
	public ModelAndView selectChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectChart", paramMap);
    }	
	
	public ModelAndView selectDBStatus(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("MainDAO.selectDBStatus", paramMap);
    }	
}
