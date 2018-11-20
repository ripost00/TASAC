package nzero.admin.egovframework.cmmn.util;

import java.io.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.*;
import org.apache.poi.util.IOUtils;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class ExcelUtil {

	private  static Log log = LogFactory.getLog(ExcelUtil.class);

	/**
	* 엑셀 cell의 값 처리한다.
	* 
	* @param cell 입력 cell
	* @throws IOException
	*/
	public static String getType(XSSFCell cell){
		String value =  "";
		if(cell != null){
			switch (cell.getCellType()) {
				case XSSFCell.CELL_TYPE_FORMULA:
					value = Util.nvl(cell.getNumericCellValue()+"");
					break;
				case XSSFCell.CELL_TYPE_NUMERIC:
					value = String.valueOf(new Double(cell.getNumericCellValue()).intValue());//실수형 데이터가 정수형으로 나오도록
					break;
				case XSSFCell.CELL_TYPE_STRING:
					value = Util.nvl(cell.getStringCellValue());
					break;
				case XSSFCell.CELL_TYPE_BLANK:
					value = Util.nvl(cell.getBooleanCellValue()+"");
					break;
				case XSSFCell.CELL_TYPE_ERROR:
					value = Util.nvl(cell.getErrorCellValue()+"");
					break;
				default:value = Util.nvl(cell.getStringCellValue());
				break;
			}
		}
		log.debug("cell_value : " + value);
		return value;
	}

	/**
     * <pre>
     * str에서 rep에 해당하는 String을 tok로 replace한다.
	 * "select * from TEST", "*", "USER"
	 * -> "select USER from TEST"
     * </pre>
     *
     * @param str 변경할 문자열.
     * @param rep 변경할 문자.
     * @param tok 변경될 문자.
     * @return 변경된 문자열.
     */
    public static String getReplace(String str, String rep, String tok) {
        String retStr = "";
        if(str == null) return "";
        if(str.equals("")) return "";

        for(int i=0, j=0; (j = str.indexOf(rep,i)) > -1; i=j+rep.length()) {
            retStr += (str.substring(i,j) + tok);
        }
        return (str.indexOf(rep) == -1) ? str : retStr + str.substring(str.lastIndexOf(rep)+rep.length(),str.length());
    }

}
