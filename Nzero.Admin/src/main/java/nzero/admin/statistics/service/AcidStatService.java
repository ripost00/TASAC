package nzero.admin.statistics.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import nzero.admin.egovframework.cmmn.model.SimpleData;
import nzero.admin.egovframework.cmmn.service.impl.CommonDAO;

@Service("acidStatService")
public class AcidStatService extends EgovAbstractServiceImpl {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AcidStatService.class);
	
	@Resource(name="commonDAO")
    private CommonDAO commonDAO;
	
	
	//차량 월별 사고건수 
	public ModelAndView selectMonTemp(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonTemp", paramMap);
    }
	//차량 월별 사고건수 그래프
	public ModelAndView selectMonTempChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonTempChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//차량 월별 사고당 주행거리 
	public ModelAndView selectMonTempDist(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonTempDist", paramMap);
    }
	//차량 월별 사고당 주행거리 그래프
	public ModelAndView selectMonTempDistChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonTempDistChart", paramMap);
    }
	//----------------------------------------------------------------------------

	//기관별 월별 사고건수
	public ModelAndView selectMonUser(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonUser", paramMap);
    }
	//기관별 월별 사고건수 그래프
	public ModelAndView selectMonUserChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonUserChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//기관별 월별 사고당 주행거리
	public ModelAndView selectMonUserDist(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonUserDist", paramMap);
    }
	//기관별 월별 사고당 주행거리 그래프
	public ModelAndView selectMonUserDistChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonUserDistChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//도로별 월별 사고건수
	public ModelAndView selectMonRoad(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonRoad", paramMap);
    }
	//차량별 월별 사고건수 그래프
	public ModelAndView selectMonRoadChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonRoadChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//기상별 월별 사고건수
	public ModelAndView selectMonWhtr(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonWhtr", paramMap);
    }
	//기상별 월별 사고건수 그래프
	public ModelAndView selectMonWhtrChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectMonWhtrChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	// ==========================================================================================================================
		
	//차량 년별 사고건수 
	public ModelAndView selectYearTemp(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearTemp", paramMap);
    }
	//차량 년별 사고건수 그래프
	public ModelAndView selectYearTempChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearTempChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//차량 년별 사고당 주행거리 
	public ModelAndView selectYearTempDist(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearTempDist", paramMap);
    }
	//차량 년별 사고당 주행거리 그래프
	public ModelAndView selectYearTempDistChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearTempDistChart", paramMap);
    }
	//----------------------------------------------------------------------------

	//기관별 년별 사고건수
	public ModelAndView selectYearUser(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearUser", paramMap);
    }
	//기관별 년별 사고건수 그래프
	public ModelAndView selectYearUserChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearUserChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//기관별 년별 사고당 주행거리
	public ModelAndView selectYearUserDist(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearUserDist", paramMap);
    }
	//기관별 년별 사고당 주행거리 그래프
	public ModelAndView selectYearUserDistChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearUserDistChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//도로별 년별 사고건수
	public ModelAndView selectYearRoad(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearRoad", paramMap);
    }
	//차량별 년별 사고건수 그래프
	public ModelAndView selectYearRoadChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearRoadChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	//기상별 년별 사고건수
	public ModelAndView selectYearWhtr(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearWhtr", paramMap);
    }
	//기상별 년별 사고건수 그래프
	public ModelAndView selectYearWhtrChart(SimpleData paramMap) throws Exception {
        return commonDAO.selectModel("AcidStatDAO.selectYearWhtrChart", paramMap);
    }
	//----------------------------------------------------------------------------
	
	

}
