package nzero.admin.record.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("downHistService")
public class DownHistService extends EgovAbstractServiceImpl{
        
    private static final Logger LOGGER = LoggerFactory.getLogger(DownHistService.class);

    @Resource(name="commonDAO")
    private CommonDAO commonDAO;
    
    public ModelAndView selectDownHistList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DownHistDAO.selectDownHistList", paramMap);    	
    }

    public ModelAndView selectDownExcelList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DownHistDAO.selectDownExcelList", paramMap);
    }
    
}
