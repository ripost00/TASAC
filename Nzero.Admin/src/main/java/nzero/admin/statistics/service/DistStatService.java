package nzero.admin.statistics.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("distStatService")
public class DistStatService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DistStatService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	//전체 월별 자율모드 주행거리 --------------------------------------------------------
	public ModelAndView selectMonAll(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectMonAll", paramMap);
    }
	//전체 월별 자율모드 주행거리 그래프
	public ModelAndView selectMonAllChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectMonAllChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//차량별 월별 자율모드 주행거리 -------------------------------------------------------
	public ModelAndView selectMonTemp(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectMonTemp", paramMap);
    }
	//차량별 월별 자율모드 주행거리 그래프
	public ModelAndView selectMonTempChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectMonTempChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//기관별 월별 자율모드 주행거리 -------------------------------------------------------
	public ModelAndView selectMonUser(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectMonUser", paramMap);
    }
	//기관별 월별 자율모드 주행거리 그래프
	public ModelAndView selectMonUserChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectMonUserChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//전체 년별 자율모드 주행거리 --------------------------------------------------------
	public ModelAndView selectYearAll(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectYearAll", paramMap);
    }
	//전체 년별 자율모드 주행거리 그래프
	public ModelAndView selectYearAllChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectYearAllChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//차량별 년별 자율모드 주행거리 -------------------------------------------------------
	public ModelAndView selectYearTemp(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectYearTemp", paramMap);
    }
	//차량별 년별 자율모드 주행거리 그래프
	public ModelAndView selectYearTempChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectYearTempChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//기관별 년별 자율모드 주행거리 -------------------------------------------------------
	public ModelAndView selectYearUser(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectYearUser", paramMap);
    }
	//기관별 년별 자율모드 주행거리 그래프
	public ModelAndView selectYearUserChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("DistStatDAO.selectYearUserChart", paramMap);
    }
	//----------------------------------------------------------------------------

}
