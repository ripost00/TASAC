package nzero.admin.statistics.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("controlStatService")
public class ControlStatService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ControlStatService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	//전체 월별 자율모드 주행거리 --------------------------------------------------------
	public ModelAndView selectMonAll(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectMonAll", paramMap);
    }
	//전체 월별 자율모드 주행거리 그래프
	public ModelAndView selectMonAllChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectMonAllChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//1000km별 제어권전환 횟수 -------------------------------------------------------
	public ModelAndView selectMonCnt(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectMonCnt", paramMap);
    }
	//1000km별 제어권전환 횟수 그래프
	public ModelAndView selectMonCntChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectMonCntChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//차량별 월별 자율모드 주행거리 -------------------------------------------------------
	public ModelAndView selectMonTemp(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectMonTemp", paramMap);
    }
	//차량별 월별 자율모드 주행거리 그래프
	public ModelAndView selectMonTempChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectMonTempChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//기관별 월별 자율모드 주행거리 -------------------------------------------------------
	public ModelAndView selectMonUser(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectMonUser", paramMap);
    }
	//기관별 월별 자율모드 주행거리 그래프
	public ModelAndView selectMonUserChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectMonUserChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//전체 년별 자율모드 주행거리 --------------------------------------------------------
	public ModelAndView selectYearAll(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectYearAll", paramMap);
    }
	//전체 년별 자율모드 주행거리 그래프
	public ModelAndView selectYearAllChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectYearAllChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//1000km별 년별 제어권전환횟수 -------------------------------------------------------
	public ModelAndView selectYearCnt(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectYearCnt", paramMap);
    }
	//1000km별 년별 제어권전환횟수 그래프
	public ModelAndView selectYearCntChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectYearCntChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//차량별 년별 자율모드 주행거리 -------------------------------------------------------
	public ModelAndView selectYearTemp(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectYearTemp", paramMap);
    }
	//차량별 년별 자율모드 주행거리 그래프
	public ModelAndView selectYearTempChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectYearTempChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//기관별 년별 자율모드 주행거리 -------------------------------------------------------
	public ModelAndView selectYearUser(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectYearUser", paramMap);
    }
	//기관별 년별 자율모드 주행거리 그래프
	public ModelAndView selectYearUserChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("ControlStatDAO.selectYearUserChart", paramMap);
    }
	//----------------------------------------------------------------------------

}
