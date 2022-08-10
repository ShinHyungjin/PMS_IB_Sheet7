package ibs.com.common;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

/**
 * @Class Name  : IBSheetUtil.java
 * @Description : IBSheet에서 조회, 저장 요청시 그 처리결과를 json 형태로 반환한다.
 * @Modification Information
 *
 *     수정일                               수정자                  수정내용
 *   --------------------------------------------
 *   2014.05.13       강희상                  최초 생성
 *   2016.12.26       shkim          GetSheetData() 등 메서드 추가
 * @author 공통/통합팀 강희상
 * @since 2014. 05. 13
 * @version 1.0
 * @see
 *
 */
 
 
@Component("IBSheetUtil")
public class IBSheetUtil {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(IBSheetUtil.class);
	
	@SuppressWarnings("rawtypes")
	Map<String, Map> itemEtcs = new HashMap<String, Map>();
	Map<String, String> itemEtc = new HashMap<String, String>();

	Object Code;
	String CodeMessage;
	Map<String, String> msg = new HashMap<String, String>();
	Map<String, Integer> total = new HashMap<String, Integer>();
	Object Total;
	Object Data;
	Object Result;

	/**
	 * 생성자
	 */
	public IBSheetUtil(){

	}
	
	/**
	 * 그리드에 표시될 총 레코드 수를 설정한다.
	 * @param total : 총 레코드 수
	 */
	public void setTotal(Object total){
		Total = total;
	}
	
	public void setTotal(String sheetName,int tot){
		total.put(sheetName, tot);
	}
	
	/**
	 * 그리드에 제공할 처리결과 코드를 설정한다.
	 * @param code : 코드
	 */
	public void setCode(Object code){
		Code = code;
	}
	
	public void setCode(String sheetName,Object code){
		if(Result==null){
			Map m = new HashMap();
			Map tmp = new HashMap();
			tmp.put("Code", code);
			m.put(sheetName, tmp);
			Result = m;
		}else{
			Map m = (Map)Result;
			Map tmp = new HashMap();
			tmp.put("Code", code);
			m.put(sheetName, tmp);
			Result = m;
		}
	}
	
	/*
	 * 조회/저장 작업에 대한 판단
	 */
	
	/**
	 * code에 따를 설명을 설정한다.
	 * @param message : 메시지 문자열
	 */
	public void setCodeMessage(String message){
		CodeMessage = message;
	}
	
	
	/**
	 * code에 따를 설명을 설정한다.
	 * @param message : 메시지 문자열
	 */
	public void setCodeMessage(String sheetName,String message){
		msg.put(sheetName, message);
	}
	
	
	
	/**
	 * 기타정보를 설정한다.
	 * @param key_name : 키이름
	 * @param key_value : 키값
	 */
	public void setEtc(String key_name, String key_value){
		itemEtc.put(key_name, key_value);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void setEtc(String sheetName,String key_name, String key_value){
		Object o = itemEtcs.get(sheetName);
		if(o!=null){
			Map etc = (Map)o;
			etc.put(key_name, key_value);
			itemEtcs.put(sheetName, etc);
		}else{
			Map etc = new HashMap();
			etc.put(key_name, key_value);
			itemEtcs.put(sheetName, etc);
		}
	}
	
	public String makeOrderBy(String iborderby){
		String orderbyStr = "";
		String[] colArr = null;
		String[] sortArr = null;
		
		String[] ColandSort = iborderby.split("\\^");
		if(ColandSort[0].indexOf("|")>-1){
			colArr = ColandSort[0].split("\\|");
			sortArr = ColandSort[1].split("\\|");
			for(int i=0;i<colArr.length;i++){
				orderbyStr += ","+colArr[i]+ " " +sortArr[i];
			}
			orderbyStr = orderbyStr.substring(1);
		}else{
			orderbyStr = " "+ColandSort[0]+ " " +ColandSort[1];			
		}
		return orderbyStr;
	}
	
	
	
	
	
	
	/**
	 * doSearch에 대한 결과를 설정한다.
	 * @param data : json 포맷
	 */
	public void setData(Object data){
		Data = data;
	}
	
	
	/**
	 * doSearch에 대한 결과를 설정한다.
	 * @param data : json 포맷
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void setData(String sheetName,Object data){
		if(Data==null){
			Map m = new HashMap();
			m.put(sheetName, data);
			Data = m;
		}else if(Data instanceof java.util.Map) {
			Map m = (Map)Data;
			m.put(sheetName, data);
			Data = m;
		}
	}
	
	
	
	/**
	 * doSave에 대한 결과를 설정한다	
	 * @param result
	 */
	public void setResult(Object result){
		Result = result;
	}

	
	public ModelMap getSearchJSON(){
		ModelMap model = new ModelMap();
		return getSearchJSON(model);
	}

	
	/**
	 * IBSheet에 전달된 결과 데이터를 반환한다
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public ModelMap getSearchJSON(ModelMap model){
		//여러개 시트 
		if(Data instanceof java.util.Map){
			Map m = (Map)Data;
			Iterator it = m.keySet().iterator();
			
			while(it.hasNext()){
				String key = (String)it.next();
				Map rtnMap = new HashMap();
				if(itemEtcs.get(key)!=null) rtnMap.put("Etc",itemEtcs.get(key) );
				if(msg.get(key)!=null) rtnMap.put("Message", msg.get(key));
				if(total.get(key)!=null) rtnMap.put("Total",total.get(key));
				rtnMap.put("Data", m.get(key));
				model.addAttribute(key,rtnMap);
			}
		}else{
			if(Total!=null){
				model.addAttribute("Total",Total);
			}
			//단건 시트
			if(itemEtc.size() > 0) model.addAttribute("Etc", itemEtc);
			model.addAttribute("Message", CodeMessage);
			model.addAttribute("Data", Data);
		}
		return model;
	}
	public ModelMap getSaveJSON(){
		ModelMap model = new ModelMap();
		return getSaveJSON(model);
	}
	public ModelMap getSaveJSON(ModelMap model){
		
		if(Result instanceof java.util.Map){
			Map m = (Map)Result;
			Iterator it = m.keySet().iterator();
			
			while(it.hasNext()){
				String key = (String)it.next();
				Map rtnMap = new HashMap();
				if(itemEtcs.get(key)!=null) rtnMap.put("Etc",itemEtcs.get(key) );
				if(msg.get(key)!=null) rtnMap.put("Message", msg.get(key));
				rtnMap.put("Result", m.get(key));
				model.addAttribute(key,rtnMap);
			}
		}else{
			
			Map<String, Object> itemResult = new HashMap<String, Object>();
			
			itemResult.put("Code",  Code);
			itemResult.put("Message", CodeMessage);
			model.addAttribute("Result", itemResult);
			if(itemEtc.size() > 0) model.addAttribute("Etc", itemEtc);
		}
		return model;
	}

	/*
	 * 멀티체크 컬럼의 데이터를 맵에 옮겨 담는다.
	 */
	public Map<String,Object> setMultiCheckData(Map<String,Object> rowmap,String saveName){
		
		if(rowmap.get(saveName)!=null){
			String multicheck =	(String)rowmap.get(saveName);
			String[] items = multicheck.split("\\|",-1);
			for(int i=0;i<items.length;i++){
				String[] item = items[i].split(":",-1);
				if("1".equals(item[1])){
					rowmap.put(item[0],item[1]);
				}
			}
		}
		return rowmap;
	}
	
	
	/**
	 * IBSheet에서 전달된 데이터를 Map에 담는다. 
	 * @param commandMap
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> getSheetData(String sheetName,Map reqMap) throws Exception{
		List<Map> rtnList = new ArrayList();
		boolean isMulti = true;
		try{
			String sheetSaveName = (String)reqMap.get(sheetName+"_SAVENAME");
			String[] arrSaveName = sheetSaveName.split("\\|",-1);
			String[] arrSaveName2 = new String[arrSaveName.length];
			
			if(isMulti){
				for(int i=0;i<arrSaveName.length;i++){
					arrSaveName2[i] = arrSaveName[i];
					arrSaveName[i] = sheetName+"_"+arrSaveName[i];
				}
			}
			
			
			Map<String,String[]> data = new HashMap();
			
			//저장 건수
			if(reqMap.get(arrSaveName[0])==null){
				return rtnList;
			}
			String tempData = reqMap.get(arrSaveName[0])+"";
			
			
 			int itemCnt = (tempData.split("‡",-1)).length;
			
			
			//넘어온 데이터를 배열에 담는다.
			for(int i=0;i<arrSaveName.length;i++){
				//저장 건수
				data.put(arrSaveName[i],  (reqMap.get(arrSaveName[i])+"").split("‡",-1));
			}
			
			
			
			//데이터를 피벗시킴
			Map<String,String> row = null;
			for(int ic=0;ic<itemCnt;ic++){
				row = new HashMap();
				for(int i=0;i<arrSaveName.length;i++){
					String[] t = (String[])data.get(arrSaveName[i]);
					if(isMulti){
						row.put(arrSaveName2[i]  ,t[ic]);
					}else{
						row.put(arrSaveName[i]  ,t[ic]);
					}
				}
				rtnList.add(row);
			}
			
			
		}catch(NullPointerException ex){
			throw new Exception("error occur From IBSheetUtil(getSheetData) :\n"+ex.getMessage());
		}
		return rtnList;
	}
	
	//Role = "I|U|D"
	@SuppressWarnings({ "unchecked", "unused" })
	public boolean checkStatus(HttpServletRequest req,String Role){
		Enumeration<String> en =req.getParameterNames();
		while(en.hasMoreElements()){
			String key = en.nextElement();
			if(key.indexOf("_SAVENAME")>-1){
				String savename = req.getParameter(key);
				String[] savenames = savename.split("\\|",-1);
				for(int i=0;i<savenames.length;i++){
					if((savenames[i].toLowerCase()).indexOf("status")>-1){
						String rowStatus = req.getParameter(savenames[i]);
						
					}
				}
				
			}
		}
		
		
		return true;
	}
	
	
	/**
	 * IBSheet에서 전달된 데이터를 Map에 담는다. 
	 * @param commandMap
	 * @return
	 */
	/* 사용안함
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Map> getParam(Map commandMap){
		List<Map> itemList = new ArrayList<Map>();

		//SYS_SAVENAME 정보를 가져온다.
		String SYS_SAVENAME = (String)commandMap.get("SYS_SAVENAME");
		String[] arrSaveName = SYS_SAVENAME.split("\\|");
		
		//SYS_SAVENAME에 없는 필드명을 가져온다.
		StringBuffer ETC_NAME = new StringBuffer();
		ETC_NAME.append("SYS_");
		
		boolean bCheck = false;
		
		final Enumeration<String> strEnum = Collections.enumeration(commandMap.keySet());
		while(strEnum.hasMoreElements()) {
			String strElement = strEnum.nextElement();
			if(!"SYS_SAVENAME".equals(strElement) && !"-".equals(strElement)){
				bCheck = false;
				for(int i=0;i<arrSaveName.length;i++){
					if(strElement.equals(arrSaveName[i])){
						bCheck = true;
						break;
					}
				}
				if(!bCheck){
					ETC_NAME.append("|").append(strElement);
				}
			}
		}
		String[] arrEtcName = null;
		if(ETC_NAME.length()>0 && !"SYS_".equals(ETC_NAME.toString())) arrEtcName = ETC_NAME.toString().split("\\|");
		
		//반환할 레코드 목록 작성
    	if(commandMap.get("STATUS") instanceof String[]){
    		//배열
    		HashMap<String, Object> items = new HashMap<String, Object>();
    		
    		for(int i=0;i<arrSaveName.length;i++){
    			items.put(arrSaveName[i], (String[])commandMap.get(arrSaveName[i]));
    		}

    		int rows = ((String[])items.get("STATUS")).length;
    		for(int i=0;i<rows;i++){
    			Map<String, String> item = new HashMap<String, String>();
    			for(int j=0;j<arrSaveName.length;j++){
    				item.put(arrSaveName[j], ((String[])items.get(arrSaveName[j]))[i]);
    			}

       	    	//사용자 추가 변수 처리
       			if(arrEtcName!=null){
	    			HashMap<String, Object> etcItems = new HashMap<String, Object>();
	        		for(int j=1;j<arrEtcName.length;j++){
	        			if(arrEtcName != null) {
		        			etcItems.put(arrEtcName[j], (String)commandMap.get(arrEtcName[j]));	
	        			}
	        		}
	       			for(int j=1;j<arrEtcName.length;j++){
	       				if(arrEtcName != null) {
		       				item.put(arrEtcName[j], ((String)etcItems.get(arrEtcName[j])));	       					
	       				}
	       			}
       			}
       			
    			itemList.add(item);
    		}
    	}else{
    		//단건
    		HashMap<String, Object> items = new HashMap<String, Object>();
    		for(int i=0;i<arrSaveName.length;i++){
    			if(arrSaveName != null) {
        			items.put(arrSaveName[i], (String)commandMap.get(arrSaveName[i]));	
    			}
    		}
   			Map<String, String> item = new HashMap<String, String>();
   			for(int j=0;j<arrSaveName.length;j++){
   				if(arrSaveName != null) {
   	   				item.put(arrSaveName[j], ((String)items.get(arrSaveName[j])));	
   				}
   			}
   		
   	    	//사용자 추가 변수 처리
   			if(arrEtcName!=null){
   				HashMap<String, Object> etcItems = new HashMap<String, Object>();
    			for(int i=1;i<arrEtcName.length;i++){
    				if(arrEtcName != null) {
        				etcItems.put(arrEtcName[i], (String)commandMap.get(arrEtcName[i]));	
    				}
    			}
   				for(int j=1;j<arrEtcName.length;j++){
   					if(arrEtcName != null) {
   	   					item.put(arrEtcName[j], ((String)etcItems.get(arrEtcName[j])));	
   					}
   				}
   			}

   			itemList.add(item);
    	}

    	return itemList;
	}
	*/
	
	
   @SuppressWarnings("rawtypes")
   public static void mapPrint(Map mp) throws Exception{

    	String key = "";
    	Iterator it = mp.keySet().iterator();
    	while(it.hasNext()){
    		key = (String)it.next();
    		System.out.println("Map Print>>>>>   key:"+key+" value:"+mp.get(key)+" type:"+mp.get(key).getClass().getName());
    	}
    	System.out.println("\n\n\n\n");

    }
   
    public static void enumPrint(Enumeration<String> en) throws Exception{
    	String key = "";
    	while(en.hasMoreElements()){
    		key = en.nextElement();
    		System.out.println("Enum Print>>>>>   "+key);
    	}
    }
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelMap sessionClose(){
		Map resultMap = new HashMap();
		resultMap.put("Code", "-300");
		resultMap.put("Message", "세션이 종료 되었습니다.");
		
		ModelMap model = new ModelMap();
		model.addAttribute("Result",resultMap);
		return model;
	}
	
	/**
	 * IBSheet에서 전달된 ORDER BY PARAM(camel,멤버변수명) 정보를 DB컬럼명 스타일로 변환한다.
	 * @param str
	 * @return value
	 */

	public String camelToDbStyle(String str)
	{
		String regex = "([a-z])([A-Z])";
		String replacement = "$1_$2";
        String value = "";

        value = str.replaceAll(regex, replacement).toUpperCase();

        return value;

	}
	
	/**
	 * IBSheet init 정보를 생성한다.
	 * @param data, initType
	 * @return itemList
	 */
	public String jsonString(List<Map<String, Object>> data, String initType){		
		StringBuffer itemList = new StringBuffer();
		StringBuffer etcList = new StringBuffer();

		int index=0;

		for (Map<String, Object> map : data){

			if(initType.equals("Cols")){
				if(index == 0) itemList.append("[\r\n");
				else itemList.append(",\r\n");
			}
			
			String[] etcItem;
			String[] etcData;
			
			int itemIndex = 0;
			int totalIndex = 0;
			
			for(Map.Entry<String, Object> entry : map.entrySet()){
				if(totalIndex == 0)itemList.append("{");
				
				if(!entry.getValue().equals("null") && !entry.getValue().equals("")){
					String key = entry.getKey();
					Object value = entry.getValue();
					
					/* etcData 생성 */
					if(key.equals("EtcData") && initType.equals("Cfg")){
						etcItem = ((String) value).split("‡");
						
						for(int i=0; i<etcItem.length; i++){
							etcData = etcItem[i].split("=");
							if(i == 0) etcList.append(etcData[0] + ":" + '"'+etcData[1]+'"');
							else etcList.append(", " + etcData[0] + ":" + '"'+etcData[1]+'"');
						}
					}
					/* etcData 생성 끝 */
					
					if(!key.equals("EtcData")){
						if(itemIndex == 0) itemList.append(key + ":" + '"'+value+'"');
						else itemList.append(", "+key + ":" + '"'+value+'"');
					}
					
					itemIndex++;
				}
				totalIndex++;
								
				if(map.size() == totalIndex){
					//etcData가 있으면 마지막에 추가
					if(!etcList.toString().equals("") && initType.equals("Cfg")){
						if(totalIndex == 0) itemList.append(etcList);
						else itemList.append(", "+etcList);
					}
					
					itemList.append("}");
				}
			}
			index++;
			
			if(initType.equals("Cols")){
				if(data.size() == index) itemList.append("\r\n]");
			}
		}

		return itemList.toString();
	}
	
	
	//임시(사용안함)
	public String getInitInfo(Object obj){
		StringBuffer initInfo = new StringBuffer();
		
		String itemList = "";
		String[] item;
		int index  = 0;
		
		itemList = obj.toString().replaceAll("\\{", "");
		itemList = itemList.replaceAll("\\}", "");
		itemList = itemList.replaceAll("\\[", "");
		itemList = itemList.replaceAll("\\]", "");
		
		item = itemList.split(",");

		for(int i=0; i<item.length; i++){
			
			index = item[i].indexOf("=");
			
			item[i] = item[i].substring(index+1,item[i].length());
					
			//첫번째 행이면
			if(i % 2 == 0 && i == 0){
				initInfo.append(item[i]+":");
			}else if(i % 2 == 0 && i != 0){
				initInfo.append(", "+item[i]+":");
			}else{
				initInfo.append(item[i]);
			}
		}
		
		return initInfo.toString();
	}
	
	//임시(사용안함)
	public String makeCols(String initColumns){
		String columnStr = "";
		String[] colArr = null;
		
		colArr = initColumns.split("\\|");
	
		
		for(int i=0;i<colArr.length;i++){
			if(i == 0){
				columnStr = camelToDbStyle(colArr[i]);
			}else{
				columnStr += ","+camelToDbStyle(colArr[i]);
			}
		}
		
		return columnStr;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getCount(List listData){
		List<Map<String, Object>> list = listData; 

		Map map = (HashMap)list.get(0);
		//System.out.println("map:"+map.toString());
		return Integer.parseInt(String.valueOf(map.get("CNT")));
	}
	
	/* 
	 * 날짜 포맷함수 (예시)
	 * dd.MM.yy => 30:06:09
	 * yyyy.MM.dd G 'at' hh:mm:ss z => 2009.06:30 AD at 08:29:36 PDT
	 * EEE, MMM d, ''yy => Tue, Jun 30, '09
	 * h:Lmm a => 8:29 PM
	 * H:mm => 8:29
	 * H:mm:ss:SSS => 8:29:36:249
	 * K:mm a,z => 8:29 AM,PDT
	 * yyyy.MMMMM.dd GGG hh:mm aaa => 2009 June.30 AD 08:29 AM
	 */
	public String getDateFormat(String format) {
		
		SimpleDateFormat sdf = new SimpleDateFormat ( format, Locale.KOREA );
		Date currentTime = new Date ();
		String mTime = sdf.format ( currentTime );
		
		return mTime;
	}
	
    // 날짜가 yyyymmdd 형식으로 입력되었을 경우 Date로 변경하는 메서드
    public String getDateFormat(String format, String strDate)
    {
    	SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyyMMdd", Locale.KOREA );
    	//Date로 변경하기 위해 날짜 형식을 yyyy-mm-dd로 변경
    	SimpleDateFormat afterFormat = new SimpleDateFormat( format, Locale.KOREA );
    	Date tempDate = null;
    		    
    	//yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만듬
    	try {
			tempDate = beforeFormat.parse(strDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			System.out.println("ParseException Occured");
		}
    		   
    	//Date를 yyyy-mm-dd 형식으로 변경하여 String으로 반환
    	strDate = afterFormat.format(tempDate);
        
        return strDate;
    }
    
    //현재 시간에 날짜 더하기
    public String addDateFormat(String format, String strDate, int day) {
    	DateFormat df = new SimpleDateFormat( format, Locale.KOREA );
    	String tempDate = "";
    	
    	try {
			Date date = df.parse(strDate);
			
			//날짜 더하기
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			cal.add(Calendar.DATE, day);
			
			tempDate = df.format(cal.getTime());
			
		} catch (ParseException e) {
			/* FIX */
			System.out.println("ParseException Occured");
		}
    	return tempDate;
    }
    
    //UTC 시간 가지고 오기
    public String getDateFormat_UTC(String format) {
    	Date date = new Date();
    	
    	SimpleDateFormat sdf = new SimpleDateFormat(format);
    	sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
    	
    	String gmt = sdf.format(date);
    	
    	return gmt;
    }
    
    public String createWritngEnnc(int idx, String writngEnnc){
    	String[] strArr = writngEnnc.split("\\,");
    	String convertStr = "";
    	
    	for(int i=0; i<strArr.length; i++) {
    		if(idx == i) {
    			//convertStr += String.join(",","1");
    			strArr[idx] = "1";
    			break;
    		}
    	}
    	
    	convertStr += String.join("",strArr);
    	
    	//System.out.println("convertStr==>"+convertStr);
    	
    	return convertStr;
    }
    
    public String convertArry(String writngEnnc){
    	String[] strArr = writngEnnc.split("\\,");
    	
    	return String.join("",strArr);
    }
}