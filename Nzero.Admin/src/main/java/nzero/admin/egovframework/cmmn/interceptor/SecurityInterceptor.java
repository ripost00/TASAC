package nzero.admin.egovframework.cmmn.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import net.sf.json.JSONObject;
import nzero.admin.egovframework.cmmn.service.impl.UserVo;


@Service("securityInterceptor")
public class SecurityInterceptor extends HandlerInterceptorAdapter {

    private static final Logger LOGGER = LoggerFactory.getLogger(SecurityInterceptor.class);
    
    List<String> urls;
    
    public void setUrls(List urls) {
    	this.urls = urls;
    }

	public boolean preHandle( HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		for (int i=0; i<urls.size(); i++) {
			if (request.getRequestURI().matches(urls.get(i))) {
				return true;
			}
		}
		
        //String uri = request.getRequestURI();

        // ajax 요청인지 일반 요청인지를 구분함 !!
        boolean ajaxFlag = false;
        if ("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) {
        	ajaxFlag = true;
        }

        UserVo userVo = (UserVo) request.getSession().getAttribute("userVo");
        
        if (userVo == null) {
	       	if (ajaxFlag) {
	       		showAjaxMessage("사용자 세션이 종료되었습니다." , response);
	       		return false;
	       	} else {
	       		throw new nzero.admin.egovframework.cmmn.util.SecurityException("사용자 세션이 종료되었습니다.");
	       	}
	    }
		
		return true;
	}

	public void showAjaxMessage(String msg , HttpServletResponse response) throws Exception {

	    Map<String, Object> data = new HashMap<String, Object>();
	    data.put( "interceptorMsg", msg );
	    JSONObject json = new JSONObject();
	    json.putAll( data );

	    response.setContentType("text/html; charset=UTF-8");
	    response.getWriter().print(json.toString());
	    
	}

	public void postHandle( HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

	}

}