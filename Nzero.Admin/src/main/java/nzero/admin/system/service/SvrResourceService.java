package nzero.admin.system.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("svrResourceService")
public class SvrResourceService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SvrResourceService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;

	public ModelAndView selectSvrResourceList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("SvrResourceDAO.selectSvrResourceList", paramMap);
    }
}
