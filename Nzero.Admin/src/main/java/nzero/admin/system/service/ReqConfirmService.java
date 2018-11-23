package nzero.admin.system.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("reqConfirmService")
public class ReqConfirmService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ReqConfirmService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	public ModelAndView selectReqConfirmList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ReqConfirmDAO.selectReqConfirmList", paramMap);
    }
	
	public ModelAndView selectReqConfirmInfo_T(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ReqConfirmDAO.selectReqConfirmInfo_T", paramMap);
    }
	
	public ModelAndView selectReqConfirmInfo_U(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ReqConfirmDAO.selectReqConfirmInfo_U", paramMap);
    }
    
    public ModelAndView updateReqConfirm_T(SimpleData paramMap) throws Exception {
    	
        return commonDAO.update("ReqConfirmDAO.updateReqConfirm_T", paramMap);
    }
    
    public ModelAndView updateReqConfirm_U(SimpleData paramMap) throws Exception {
    	
        return commonDAO.update("ReqConfirmDAO.updateReqConfirm_U", paramMap);
    }
}
