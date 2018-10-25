package nzero.admin.statistics.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("acidStatService")
public class AcidStatService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AcidStatService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	public ModelAndView selectAcidStatMonList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectAcidStatMonList", paramMap);
    }
	public ModelAndView selectAcidStatMonListChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectAcidStatMonListChart", paramMap);
    }
	
	public ModelAndView selectAcidStatYearList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectAcidStatYearList", paramMap);
    }
	public ModelAndView selectAcidStatYearListChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectAcidStatYearListChart", paramMap);
    }

}
