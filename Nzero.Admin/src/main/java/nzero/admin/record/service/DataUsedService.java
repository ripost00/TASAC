package nzero.admin.record.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("dataUsedService")
public class DataUsedService extends EgovAbstractServiceImpl{
        
    private static final Logger LOGGER = LoggerFactory.getLogger(DataUsedService.class);

    @Resource(name="commonDAO")
    private CommonDAO commonDAO;

    public ModelAndView selectDataUsedList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DataUsedDAO.selectDataUsedList", paramMap);    	
    }

    public ModelAndView selectDataUsedDtlList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DataUsedDAO.selectDataUsedDtlList", paramMap);    	
    }

}
