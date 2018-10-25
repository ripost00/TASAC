package nzero.admin.system.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.web.BaseController;
import nzero.admin.system.service.MenuService;

@Controller
public class MenuController extends BaseController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MenuController.class);
	
	@Resource(name = "menuService")
    private MenuService menuService;
	
	@RequestMapping(value="/system/menu/selectMenuComboBox.do")
	@ResponseBody
	public ModelAndView selectMenuComboBox(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return menuService.selectMenuComboBox(paramMap);
	}

	@RequestMapping(value="/system/menu/openMenu.do")
    public String openMenu(HttpServletRequest request) {
		return "system/menuList";
    }
	
	@RequestMapping(value="/system/menu/selectMenuList.do")
	@ResponseBody
	public ModelAndView selectMenuList(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		return menuService.selectMenuList(paramMap);
	}
	
	@RequestMapping(value="/system/menu/transactionMenu.do")
	@ResponseBody
	public ModelAndView transactionMenu(HttpServletRequest request) throws Exception {
		SimpleData paramMap = getSimpleData(request);
		
		ModelAndView mv = null;
		if (paramMap.getString("saveMode").equals("I")) {
			mv = menuService.insertMenu(paramMap);
		}
		if (paramMap.getString("saveMode").equals("U")) {
			mv = menuService.updateMenu(paramMap);		
		}
		if (paramMap.getString("saveMode").equals("D")) {
			mv = menuService.deleteMenu(paramMap);
		}
		
		return mv;
	}
	
}
