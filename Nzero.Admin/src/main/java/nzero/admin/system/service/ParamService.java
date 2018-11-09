package nzero.admin.system.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("paramService")
public class ParamService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ParamService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	public ModelAndView selectParamList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ParamDAO.selectParamList", paramMap);
    }
	
	public ModelAndView insertParam(SimpleData paramMap) throws Exception {
    	
        return commonDAO.insert("ParamDAO.insertParam", paramMap);
    }
    
    public ModelAndView updateParam(SimpleData paramMap) throws Exception {
    	
        return commonDAO.update("ParamDAO.updateParam", paramMap);
    }
    
    public ModelAndView deleteParam(SimpleData paramMap) throws Exception {
    	
        return commonDAO.delete("ParamDAO.deleteParam", paramMap);
    }

}
