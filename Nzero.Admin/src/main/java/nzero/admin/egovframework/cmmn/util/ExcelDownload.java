package nzero.admin.egovframework.cmmn.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractExcelView;

@Component("ExcelDownload")
public class ExcelDownload extends AbstractExcelView {
	
	public ExcelDownload() {
		setContentType("application/download; charset=utf-8");
	}

	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		HSSFWorkbook xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		XSSFWorkbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상
        String downFileNm = "시트제목";
        HSSFSheet sheet =  xlsWb.createSheet(downFileNm);
        
        Map<String, CellStyle> styles = createStyles(xlsWb);// 스타일 가져오기
        
        Row headerRow = sheet.createRow(1);
        headerRow.setHeightInPoints(40);
        Cell headerCell;
        
        List<Object> list = (List<Object>)model.get("excelList");
        String[] columnsNm = (String[]) model.get("columnsNm");
        String[] datafield = (String[]) model.get("datafield");
        
    	// 헤더에 데이터 필드를 그려준다.
        Map<String, String> getMap = new HashMap();
        
        for (int i=0; i<columnsNm.length; i++) {
        	headerCell = headerRow.createCell(i);
   	     	headerCell.setCellStyle(styles.get("header"));
  		    headerCell.setCellValue(columnsNm[i]);
  		    sheet.setColumnWidth(i, 5000);
        }

		HSSFRow row = (HSSFRow) sheet.createRow((short)2);
		HSSFCell valcell = (HSSFCell) row.createCell(0);
		getMap = null;
		
		for(int b=0; b < list.size(); b++){ 
        	getMap = (Map)list.get(b);      
        	//int k=0;	
        	String[] Arr1=null;
        	String[] Arr2=null;
        	for(Entry<String, String> entry : getMap.entrySet())
        	{
        		//컬럼명과 리스트 입력위치매칭                
            	String key=entry.getKey();
        	    String val= String.valueOf(entry.getValue());
        	    
        	    for(int i = 0; i < datafield.length; i++){
        	    	
        	    	if(key.equals(datafield[i])){
        	    		valcell = getCell(sheet, 2+b, i);
        	    		Arr1 = val.split("/");	
        	    		Arr2 = val.split(",");
        	    		
	               	    if (val == "null") {
	               	    	valcell.setCellStyle(styles.get("cell"));
	            	    	setText(valcell, "");
	            	    } else {
	            	    	if (isNumber(Arr1[0]) || isNumber(Arr2[0])) {
	            	    		valcell.setCellStyle(styles.get("number"));
	            	    		setText(valcell, val);
	            	    	} else {
	            	    		valcell.setCellStyle(styles.get("cell"));
	            	    		setText(valcell, val);
	            	    	}
	            	    }
        	    	}
				}	            	    	    
      		    //k++;
	       	}
       	}
		
		try {
			String fileName = (String)model.get("excelFileNm");
			if (fileName == null && fileName.trim().length() == 0) { // 파일 이름이 안넘어 왔을 경우 
				fileName="엑셀화일.xls";
			}
			
			fileName = new String(fileName.getBytes("euc-kr"), "8859_1");
			resp.setContentType("application/vnd.ms-excel;charset=utf-8");
			resp.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\";");
			
			xlsWb.write(resp.getOutputStream());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
			 resp.getOutputStream().close();
		}
	}
	
   	public static boolean isNumber(String str){ // 숫자인지 체크한다.
        boolean result = false; 
         
        try {
            Float.parseFloat(str) ;
            result = true ;
        } catch(Exception e){
        	
        }
         
        return result ;
    }
	
    private static Map<String, CellStyle> createStyles(Workbook wb){
        Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
        CellStyle style;
        Font titleFont = wb.createFont();
        titleFont.setFontHeightInPoints((short)18);
        titleFont.setBold(true);
        titleFont.setFontName("맑은 고딕");
        style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setFont(titleFont);
        styles.put("title", style);

        Font monthFont = wb.createFont();
        monthFont.setFontHeightInPoints((short)11);
        monthFont.setColor(IndexedColors.WHITE.getIndex());
        monthFont.setFontName("맑은 고딕");
        style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setBorderRight(BorderStyle.THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(BorderStyle.THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(BorderStyle.THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(BorderStyle.THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        style.setFont(monthFont);
        style.setWrapText(true);
        styles.put("header", style);

        Font cellFont = wb.createFont();
        cellFont.setFontHeightInPoints((short)10);
        cellFont.setColor(IndexedColors.BLACK.getIndex());
        cellFont.setFontName("맑은 고딕");
        
        style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setBorderRight(BorderStyle.THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(BorderStyle.THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(BorderStyle.THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(BorderStyle.THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        style.setFont(cellFont);
        styles.put("cell", style);

        style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
        styles.put("formula", style);

        style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setFillForegroundColor(IndexedColors.GREY_40_PERCENT.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        style.setDataFormat(wb.createDataFormat().getFormat("0.00"));
        styles.put("formula_2", style);
        
        style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.RIGHT);
        style.setBorderRight(BorderStyle.THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(BorderStyle.THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(BorderStyle.THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderBottom(BorderStyle.THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        style.setFont(cellFont);
        styles.put("number", style);

        return styles;
    }
	
}
