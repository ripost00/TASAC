package nzero.admin.record.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("incdVideoService")
public class IncdVideoService extends EgovAbstractServiceImpl{
        
    private static final Logger LOGGER = LoggerFactory.getLogger(IncdVideoService.class);

    @Resource(name="commonDAO")
    private CommonDAO commonDAO;
    
    public ModelAndView selectIncdList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("IncdHistDAO.selectIncdList", paramMap);    	
    }

    public ModelAndView selectVideoList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("IncdVideoDAO.selectVideoList", paramMap);    	
    }

    public ModelAndView selectIncdExcelList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("IncdHistDAO.selectIncdExcelList", paramMap);
    }
    
}
