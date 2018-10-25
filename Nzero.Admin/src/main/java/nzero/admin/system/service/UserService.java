package nzero.admin.system.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("userService")
public class UserService extends EgovAbstractServiceImpl{
        
    private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);

    @Resource(name="commonDAO")
    private CommonDAO commonDAO;
    
    public ModelAndView selectUserList(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("UserDAO.selectUserList", paramMap);    	
    }
    
    public ModelAndView insertUser(SimpleData paramMap) throws Exception {
    	
        return commonDAO.insert("UserDAO.insertUser", paramMap);
    }
    
    public ModelAndView updateUser(SimpleData paramMap) throws Exception {
    	
        return commonDAO.update("UserDAO.updateUser", paramMap);
    }
    
    public ModelAndView deleteUser(SimpleData paramMap) throws Exception {
    	
        return commonDAO.delete("UserDAO.deleteUser", paramMap);
    }
    
}
