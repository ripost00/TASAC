package nzero.admin.system.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("authMapService")
public class AuthMapService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AuthMapService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	public ModelAndView selectAuthMapList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AuthMapDAO.selectAuthMapList", paramMap);
    }
    
    public ModelAndView deleteAuthMap(SimpleData paramMap) throws Exception {
    	
        return commonDAO.delete("AuthMapDAO.deleteAuthMap", paramMap);
    }
	
	public ModelAndView insertAuthMap(SimpleData paramMap) throws Exception {
    	
        return commonDAO.insert("AuthMapDAO.insertAuthMap", paramMap);
    }

}
