package nzero.admin.system.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("noticeService")
public class NoticeService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(NoticeService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	public ModelAndView selectNoticeList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("NoticeDAO.selectNoticeList", paramMap);
    }
	
	public ModelAndView selectNoticeInfo(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("NoticeDAO.selectNoticeInfo", paramMap);
    }
	
	public ModelAndView insertNotice(SimpleData paramMap) throws Exception {
    	
        return commonDAO.insert("NoticeDAO.insertNotice", paramMap);
    }
    
    public ModelAndView updateNotice(SimpleData paramMap) throws Exception {
    	
        return commonDAO.update("NoticeDAO.updateNotice", paramMap);
    }
    
    public ModelAndView deleteNotice(SimpleData paramMap) throws Exception {
    	
        return commonDAO.delete("NoticeDAO.deleteNotice", paramMap);
    }
}
