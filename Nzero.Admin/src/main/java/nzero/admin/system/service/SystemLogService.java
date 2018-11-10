package nzero.admin.system.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("systemLogService")
public class SystemLogService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SystemLogService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;

	public ModelAndView selectSystemLogList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("SystemLogDAO.selectSystemLogList", paramMap);
    }
}
