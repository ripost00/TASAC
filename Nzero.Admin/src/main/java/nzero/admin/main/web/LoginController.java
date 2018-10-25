package nzero.admin.main.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.User;
import nzero.admin.egovframework.cmmn.service.impl.UserVo;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.main.service.LoginService;

@Controller
@SessionAttributes(types=UserVo.class)
public class LoginController extends BaseController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);
	
	@Resource(name = "loginService")
    private LoginService loginService;
	
	@RequestMapping(value="/openLogin.do")
    public String openLogin(HttpServletRequest request) {
		User user = new User(request.getSession());
		user.logout();
		
		return "login";
    }
	
	@RequestMapping(value="/actionLogin.do")
    public String actionLogin(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		SimpleData data = getSimpleData(request);
		
		UserVo userVo = loginService.setUserVo(request, data);
		
		User user = new User(request.getSession());

		user.setSessionId(userVo.getSessionId());
		user.setUserId(userVo.getUserId());
		user.setUserNm(userVo.getUserNm());
		user.setUserPwd(userVo.getUserPwd());
		user.setAuthId(userVo.getAuthId());
		user.setUserIp(userVo.getUserIp());
		
		user.login();
		
		return "redirect:/openMain.do";
	}
	
	@RequestMapping(value="/openMain.do")
    public String openMain () {
		return "main";
    }
	
	@RequestMapping(value="/selectMainMenuList.do")
	@ResponseBody
	public ModelAndView selectMainMenuList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		paramMap.put("authId", (new User(request.getSession())).getAuthId());
		
		return loginService.selectMainMenuList(paramMap);
	}
	
	@RequestMapping(value="/selectMenu.do")
	@ResponseBody
	public ModelAndView selectMenu(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return loginService.selectMenu(paramMap);
	}
	
	@RequestMapping(value="/actionLogout.do")
    public String actionLogout (HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		User user = new User(request.getSession());
		user.logout();
		
		return "redirect:/";
    }
	
	@RequestMapping(value="/openInit.do")
    public String openInit(HttpServletRequest request) {
		return "init";
    }
	
}
