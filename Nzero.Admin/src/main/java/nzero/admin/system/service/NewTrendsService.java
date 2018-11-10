package nzero.admin.system.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("newTrendsService")
public class NewTrendsService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(NewTrendsService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	public ModelAndView selectNewTrendsList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("NewTrendsDAO.selectNewTrendsList", paramMap);
    }
	
	public ModelAndView selectNewTrendsInfo(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("NewTrendsDAO.selectNewTrendsInfo", paramMap);
    }
	
	public ModelAndView insertNewTrends(SimpleData paramMap) throws Exception {
    	
        return commonDAO.insert("NewTrendsDAO.insertNewTrends", paramMap);
    }
    
    public ModelAndView updateNewTrends(SimpleData paramMap) throws Exception {
    	
        return commonDAO.update("NewTrendsDAO.updateNewTrends", paramMap);
    }
    
    public ModelAndView deleteNewTrends(SimpleData paramMap) throws Exception {
    	
        return commonDAO.delete("NewTrendsDAO.deleteNewTrends", paramMap);
    }
}
