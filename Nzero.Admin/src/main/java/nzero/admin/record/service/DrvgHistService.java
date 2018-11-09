package nzero.admin.record.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("drvgHistService")
public class DrvgHistService extends EgovAbstractServiceImpl{
        
    private static final Logger LOGGER = LoggerFactory.getLogger(DrvgHistService.class);

    @Resource(name="commonDAO")
    private CommonDAO commonDAO;
    
    public ModelAndView selectDrvgHistList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DrvgHistDAO.selectDrvgHistList", paramMap);    	
    }

    public ModelAndView selectAutoDrivingList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DrvgHistDAO.selectAutoDrivingList", paramMap);    	
    }

    public ModelAndView selectCtrChangeList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DrvgHistDAO.selectCtrChangeList", paramMap);    	
    }

    public ModelAndView selectCtrChangeDtlList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DrvgHistDAO.selectCtrChangeDtlList", paramMap);    	
    }

    public ModelAndView selectDrvgHistExcelList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DrvgHistDAO.selectDrvgHistExcelList", paramMap);
    }
    
}
