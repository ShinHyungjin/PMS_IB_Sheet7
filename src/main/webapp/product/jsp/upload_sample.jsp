<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"
%><%@ page import="java.io.File,java.net.URLDecoder,
								java.text.SimpleDateFormat,java.util.*,
								org.apache.commons.fileupload.*, 
								org.apache.commons.fileupload.disk.*, 
								org.apache.commons.fileupload.servlet.*"
%><%
	// ====================================================================================================
	// ※ 처음 설치시 주의사항 - 아래 항목들을 검토하고 필수변경요소는 반드시 설정 또는 변경해야 합니다.
	//  - 이 파일은 업로드 작업에 대한 템플릿으로 사용자 권한에 따른 업로드/삭제 규정이나 보안에 따른 확장자 제한 등의 조치는 직접 설정해 주셔야 합니다.
	// ====================================================================================================
	// ① [서버함수 인자1 - 필수변경요소] 업로드 루트 경로 지정 - 실제로 파일이 업로드 되어 저장되는 경로
	// ② [서버함수 인자2 - 필수변경요소] 업로드 된 대용량 파일의 임시 경로 지정 - 가용 메모리를 초과하는 대용량 파일의 경우 임시 경로에 일시적으로 파일이 기록되었다가 자동 제거됨
	// ③ [서버함수 인자3 - 옵션][기본값:16MB] 가용 메모리 용량 1MB 로 지정할 경우 1MB 이하의 파일들은 모두 메모리 내에서 직접 처리되며, 초과하는 파일들만 임시적으로 파일 처리됨
	// ④ [서버함수 인자4 - 옵션][기본값:2GB] 최대 파일 크기 제한 - UI 에서 통과된 파일 크기라고 하더라도, 여기서 최종적으로 다시 한번 걸러짐. 되도록 여유있게 잡아야 됨.
	// ⑤ [서버함수 인자5 - 옵션][기본값:utf-8] 업로드 엔코딩 - 업로드 과정에서 웹페이지의 UploadEncoding 값과 서버쪽 수신시 한글 엔코딩 방식이 무엇인지 설정한다. 둘다 반드시 일치해야 됨.
	// ⑥ [서버함수 인자6 - 필수검토요소] 서버에서 제한 하는 파일 확장자
	// ====================================================================================================
	// ⑦ [설치후, 추가 개발 요소] 업로드 설치가 완료된 후에 현업 업무 로직을 추가할 수 있습니다. ( IBUpload_DoUpload 함수 등 내부 로직의 커스터마이징 작업 )
	// ♣1 : [브라우저로부터 받은 업무 성격의 파라메터들의 처리] client 에서 보낸 파라메터 값들에 대한 처리 로직 예제가 들어있습니다.
	// ♣2 : [보안안상 위험한 업로드 확장자 파일의 제한 처리] 서버에서 실행될 위험한 파일들의 제한 예제가 들어있습니다. 추가할 파일이 있으면 나열된 확장자에서 더 추가하고 ibuplaodinfo.js 의 limitFileExtServer 값도 동일하게 설정 필요.
	// ♣3 : [고유 파일명 저장 규칙에 따른 파일 저장의 처리] 업로드 받은 파일들을 한 폴더내에서 고유한 파일로 변경하기 위한 로직 (가능하면 파일명에 한글이 들어가지 않는 것이 운영상 좋습니다.)
	// ♣4 : [브라우저로 응답할 JSON 응답문의 처리 & DB 처리] JSON 형태로 client 에 업무 성격의 파라메터 값들을 보낼 수 있습니다. DB 처리 반영도 가능합니다.
	//====================================================================================================

	// ====================================================================================================
	// ※ [참고사항] JDK 1.6 에서 설계 및 테스트 되었습니다.
	// ====================================================================================================
	try{
		// 파일 저장
		HashMap<String, ?> ibuploadMap = IBUpload_DoUpload(request, response, "myUploadedFiles/");
		if(ibuploadMap!=null) {
			//정상 처리된 경우...
			//결과 json 구조 참고
			/* 
			{"ibupload":
				[
				 {"date":"20180823162727","clientid":"myUpFile0_0_0","size":32927,"name":"banana.png","id":"myUpFile0_0_0","url":"myUploadedFiles\/20180823162727"}
				 ,{"date":"20180823162727","clientid":"myUpFile0_0_1","size":60197,"name":"outlineStyle.png","id":"myUpFile0_0_1","url":"myUploadedFiles\/20180823162727_60119863"}
				 ,{"date":"20180823162727","clientid":"myUpFile0_0_2","size":57281,"name":"headerData.png","id":"myUpFile0_0_2","url":"myUploadedFiles\/20180823162727_53453594"}
				 ]
			}
			*/
			response.setContentType("application/json; charset=utf-8");
			String str = org.json.simple.JSONValue.toJSONString( ibuploadMap );
			out.print(str);	
		}
		
	}catch(Exception ex){
		//오류 발생한 경우		
		//결과 json 구조 참고
		/*
		{"error":"오류 내용...."}
		*/
		response.setContentType("application/json; charset=utf-8");
		Map msg = new HashMap();
		msg.put("error",ex.getMessage());
		out.print(org.json.simple.JSONValue.toJSONString(msg));
	}

%><%!

	HashMap<String, String> IBUpload_DoUpload(HttpServletRequest request, HttpServletResponse response,String SubDir) throws Exception{
	
		//================================================================================
		// ① [필수변경요소] 업로드 루트 경로 지정 - 실제로 파일이 업로드 되어 저장되는 경로
		//================================================================================
		// ※ 보안상의 이유로 UploadRootDir 가 webRoot 아래로 노출되는 것 보다는 오픈되지 않은 별도의 시스템 내부 폴더로 저장하는 것을 권장합니다.
		//================================================================================
		final String UploadRootDir = "D:/file_uploaded/";

		//================================================================================
		// ② [필수변경요소] 업로드 된 대용량 파일의 임시 경로 지정 - 가용 메모리를 초과하는 대용량 파일의 경우 임시 경로에 일시적으로 파일이 기록되었다가 자동 제거됨
		//================================================================================
		// 예) "D:/tempDir/";  "/usr/temp/";
		//================================================================================
		final String TempDir = "D:/file_uploaded/temp";
		

		//================================================================================
		// ③ [옵션][기본값:16MB] 가용 메모리 용량 1MB 로 지정할 경우 1MB 이하의 파일들은 모두 메모리 내에서 직접 처리되며, 초과하는 파일들만 임시적으로 파일 처리됨
		//================================================================================
		// 메모리 사용량 설정 (클수록 디스크 기록 부담율이 적어짐 - 16 MB
		//================================================================================
		int AvailableMemory = 16 * 1024 * 1024;

		//================================================================================
		// ④ [옵션][기본값:2GB] 최대 파일 크기 제한 - UI 에서 통과된 파일 크기라고 하더라도, 여기서 최종적으로 다시 한번 걸러짐. 되도록 여유있게 잡아야 됨.
		//================================================================================
		// 파일별 최대 용량 제한 - 2 GB
		//================================================================================
		long MaxFileSize = 2 * 1024 * 1024 * 1024; //최대 용량 2.04 GB 를 초과할 수 없음.

		//================================================================================
		// ⑤ [옵션][기본값:utf-8] 업로드 엔코딩 - 업로드 과정에서 웹페이지의 UploadEncoding 값과 서버쪽 수신시 한글 엔코딩 방식이 무엇인지 설정한다. 둘다 반드시 일치해야 됨.
		//================================================================================
		// 브라우저에서 $(sel).IBUpload("UploadEncoding","utf-8") 로 설정했다면 utf-8 로 설정해야 한다.
		// 브라우저에서 $(sel).IBUpload("UploadEncoding","euc-kr") 로 설정했다면 euc-kr 로 설정해야 한다.
		// ( 한글 깨짐 주의 ★★★ ) 브라우저에서 설정한 값과 아래의 값은 반드시 일치해야 됨.
		//================================================================================
		String UploadEncoding = "utf-8";
		//String UploadEncoding = "euc-kr";
		
		
		//================================================================================
		// ⑥ 서버에서 제한 하는 파일 확장자 (대/소문자 구분 없음)
		//================================================================================
// 		권장 제한 확장자 (필요시 더 추가 할 것)
 		 final String[] invalidFileExtention = {"HTML",".HTM",".PHP",".PHP2",".PHP3",".PHP4",".PHP5",".PHTML",".PWML",".INC",".ASP",".ASPX",".ASCX",".JSP",".CFM",".CFC",".PL",".BAT",".EXE",".COM",".DLL",".VBS",".JS",".REG",".CGI",".HTACCESS",".ASIS",".SH",".SHTML",".SHTM",".PHTM",".ADP",".CHM",".CMD",".COM"}; 

		return IBUpload_DoUpload(request, response,	SubDir, UploadRootDir, TempDir, AvailableMemory, MaxFileSize, UploadEncoding, invalidFileExtention);
	}
	//====================================================================================================
	// 이하는 서버파트 IBUpload_DoUpload 함수이며 위에서 언급된 커스터마이징 등 특별한 사유가 없는 한 수정할 필요가 없습니다.
	//====================================================================================================
	HashMap<String, String> IBUpload_DoUpload(
		HttpServletRequest request,
		HttpServletResponse response,
		String SubDir,
		String UploadRootDir,
		String TempDir,
		int AvailableMemory,
		long MaxFileSize,
		String UploadEncoding,
		String[] invalidFileExtention) throws Exception {

		File file;
		DiskFileItemFactory factory;
		ServletFileUpload upload;
		List<FileItem> fileItems = null;
		

		HashMap ibuploadMap = new HashMap();

		String RequestUrl = request.getRequestURL().toString();
		String ContentType = "" + request.getContentType();
		String CommandType = "";
		String FileID = ""; // 클릭해 줄 ID (IE 6 ~ IE 9)
		String DeleteFileList = ""; // 제거할 파일 목록(\n 엔터구분자 조합 문자열)
		String files = ""; // DB 에 저장할 최종 files 값  (예) {name: "관심과집중.mp4", size:"11417124", date:"20160101125959", url: "20160126_180337_82754651"},{name:"오렌지.jpg", size:"1075761", date:"20160101125959", url:"20160126_180801"},
		String files_id = ""; // DB 에 저장할 최종 files 값에 IBUpload Client 에서 부여한 파일 id 도 포함됨  (예) {id:"file1_1", name:"관심과집중.mp4", size:"11417124", date:"20160101125959", url:"20160126_180337_82754651"},{name:"오렌지.jpg", size:"1075761", date:"20160101125959", url: "20160126_180801"},
		boolean isUTF_force = false; // Win10 IE11 버그체크

		String FormNo = ""; // 업로드 요청해 온 폼 번호 (응답시 "formX_Y" 형태로 응답해야 한다. X 가 폼번호, Y 는 파일 순번)
		String TestValue = ""; // ExtendParam 한글 깨짐 실험
		String ParentID = "";
		request.setCharacterEncoding(UploadEncoding);

		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		response.setHeader("Access-Control-Allow-Origin", "*"); // CrossDomain 보안 설정 옵션

		//--------------------------------------------------------------------------------
		// [IE 6 ~ IE 9 파일 오픈 창 지원 & 파일 업로드 처리]
		//--------------------------------------------------------------------------------
		if (ContentType.indexOf("multipart/form-data") == -1) {

			//================================================================================
			// IE9 이하의 파일 업로드를 지원하려면 이 부분이 반드시 있어야 됨.
			//================================================================================
			if (request.getParameter("cmd") != null) {
				CommandType = request.getParameter("cmd");
			}
			// FileOpen 에 대한 처리 ( IE9 이하 )
			if (CommandType.equals("FileOpen")) {
				if (request.getParameter("id") != null) {
					FileID = request.getParameter("id");
				}
				if (request.getParameter("parentid") != null) {
					ParentID = request.getParameter("parentid");
				}
				
				String scr = "<html><head><script>try{ parent.document.getElementById('" 
					+ ParentID.replaceAll("<","&lt;").replaceAll(">","&gt;") 
					+ "_IBUpload_Add"
					+ FileID.replaceAll("<","&lt;").replaceAll(">","&gt;")
					+ "').click(); }catch(e){}</script></head></html>";
				
				java.io.PrintWriter out = response.getWriter();
				out.println(scr);
				
				return null;
			}

			Enumeration<String> e = request.getParameterNames();
			while (e.hasMoreElements()) {
				String name = e.nextElement();
				String fieldValue = "";
				String[] data = request.getParameterValues(name);
				if (data != null) {
					for (String fieldName : data) {
						fieldValue = "";
						if (request.getParameter(fieldName) != null) {
							fieldValue = request.getParameter(fieldName);
						}
						ibuploadMap.put(fieldName, fieldValue);
					}
				}
			}
		} else {

		    // IE 9에서 content type을 제대로 못받는 현상 해결하기 위해 아래 코드를 변경
		    response.setContentType("text/html; charset=utf-8");
		    response.setHeader("Cache-Control", "no-cache");
			
			factory = new DiskFileItemFactory();
			factory.setSizeThreshold(AvailableMemory);
			factory.setRepository(new File(TempDir));
			upload = new ServletFileUpload(factory);
			upload.setSizeMax(MaxFileSize);

			List<Map> jsonFileList = new ArrayList<Map>(); //클라이언트로 전송해야 할 파일 저장 결과 목록
			
			request.setCharacterEncoding(UploadEncoding);
			fileItems = upload.parseRequest(request);
			//--------------------------------------------------------------------------------
			// Win10 IE11 오류 대응
			//--------------------------------------------------------------------------------
			//System.out.println("fileItem Size : " + fileItems.size());
			
			for (FileItem item : fileItems) {
				if (item.isFormField()) { //form 객체 인 경우(파일이 아닌 경우)
					
					String fieldName = item.getFieldName();
					String fieldValue = item.getString(UploadEncoding);
					
					//System.out.println("fieldName : " + fieldName);
					//System.out.println("fieldValue : "  + fieldValue);
					
					if ("_ibupload_ie11_han_check".equals(item.getFieldName())) {

						// Windows10,IE11,10240 에서는 무조건 utf-8 로 전송되는 버그가 있다.
						// Windows8 IE11 은 잘됨
						// 갑자기 패치될 가능성 있음..
						// 10547 해결되었다는 소문이 있으나 10586 에서 안됨.
						// UTF-8 로 보내는 IE11 의 버그라고 한다면 여기서 대응처리
						if ("ea".equals(String.format("%02x", item.getString(UploadEncoding).getBytes()[0]))) {
							UploadEncoding = "utf-8";
							isUTF_force = true;
						}
					} else if ("__formNo".equals(fieldName)) {
						FormNo = fieldValue;
					} else if ("__delList".equals(fieldName)) {
						DeleteFileList = fieldValue; // 서버에서 삭제해야할 파일들
					} else if ("__files".equals(fieldName)) {
						files = fieldValue; // IBUpload 가 갖고 있었던 최근 files 목록
					}			
				}else{ //파일인 경우
					//====================================================================================================
					// ♣2 : 보안상 위험한 업로드 확장자 파일의 제한 처리
					//====================================================================================================
					String fileName = ("" + item.getName()).trim();
					for(int i=0;i<invalidFileExtention.length;i++){
						if(fileName.toUpperCase().endsWith(invalidFileExtention[i])){
							throw new Exception("허용되지 않은 확장자를 포함한 파일이 있습니다.\n\n확장자 : "+invalidFileExtention[i]);
						}
					}
					
				}
			} // end of form data

			//저장할 디렉토리 생성 (없으면 생성함.)
			if( (!new File(UploadRootDir).exists())&&(!new File(UploadRootDir).isDirectory())  ){
				File saveDir = new File(UploadRootDir);
				saveDir.mkdir();
			}
			//temp 디렉토리 생성 (없는 경우에만 생성함)
			if( (!new File(TempDir).exists())&&(!new File(TempDir).isDirectory())  ){
				File saveDir = new File(TempDir);
				saveDir.mkdir();
			}
			//저장할 디렉토리 이하에 sub 디렉토리 생성 
			if( (!new File(UploadRootDir+SubDir).exists())&&(!new File(UploadRootDir+SubDir).isDirectory())  ){
				File saveDir = new File(UploadRootDir+SubDir);
				saveDir.mkdir();
			}


			//--------------------------------------------------------------------------------
			// 파일 업로드 처리 ( type = file 인 경우의 처리 )
			//--------------------------------------------------------------------------------
			// 저장되는 파일 위치 : UploadRootDir / 업로드 파일명
			//--------------------------------------------------------------------------------
			String createFilePath = "";
			String newFileSavePath = "";

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			Random rand = new Random();
			rand.setSeed(System.currentTimeMillis());
			String TodayString = sdf.format(Calendar.getInstance().getTime());

			int UploadCount = 0;
			String oldFieldName = "";
			
			for (FileItem item : fileItems) {
				if (!item.isFormField()) {
					String fieldName = item.getFieldName();
					String fileName = ("" + item.getName()).trim();
					
					
					if (item.getName() == null || "".equals(fileName) || "undefined".equals(fileName) || "null".equals(fileName)) {
					    continue;
					}

					// WIN10-IE11 의 UTF8 한글깨짐에 의한 파일깨짐방지
					if (isUTF_force) {
						fileName = new String(fileName.getBytes("EUC-KR"), "iso-8859-1");
					}
					if (!oldFieldName.equals(fieldName)) {
						UploadCount = 0;
					}
					oldFieldName = item.getFieldName();

					
					
					
					

					boolean isUploadCancel = false; // 첨부중에 업로드 취소한 항목들
					if ((DeleteFileList + "\r\n").indexOf(fieldName + FormNo + "_" + (UploadCount) + "\r\n") > -1) {
						isUploadCancel = true;
					}

					if (!"".equals(fileName)) {

						//====================================================================================================
						// ♣3 : 수신 받은 파일들을 한 폴더내에서 고유한 파일명으로 바꿔주고 client 에 그 결과를 응답한다.
						//====================================================================================================
						// 기본적으로 수신받은 파일명은 아래와 같은 형식으로 저장되고 있습니다.
						// 업무상 파일관리 정책에 따라 바꾸셔도 됩니다.
						//
						// 1. 기존적으로 현재날짜와 시간으로 저장됨.
						// 2. 날짜와 시간까지 동일하게 겹친 파일에 한하여 중복시고유번호를 붙임
						//
						// 파일명 형식 : yyyyMMdd_HHmmss_##### (##### 은 중복시 랜덤 고유번호)
						//
						//====================================================================================================
						
						newFileSavePath = TodayString;
						createFilePath = UploadRootDir+SubDir+ TodayString;

						if (new File(createFilePath).isFile()) { // 중복체크
							for (int i = 1; i < 99999; i++) {
								newFileSavePath = TodayString + "_"
										+ String.format("%08d", rand.nextInt(100000000));
								createFilePath = UploadRootDir+SubDir+ newFileSavePath;
								if (!new File(createFilePath).isFile())
									break;
							}
						}

						if (isUploadCancel == false) {
							file =  new File(createFilePath);
	                        item.write(file) ;
						}
						

						if (isUploadCancel == false) {
							String item_getName = fileName;
							if (item_getName.indexOf("\\") > -1) {
								item_getName = item_getName.substring(item_getName.lastIndexOf("\\") + 1,
										item_getName.length());
							}
							if (item_getName.indexOf("/") > -1) {
                                item_getName = item_getName.substring(item_getName.lastIndexOf("/")+1,item_getName.length());
                            }
							
							//System.out.println("file Real Name=" + item_getName);
							
							//--------------------------------------------------------------------------------
							// Client 로 응답할 JSON 작성
							//--------------------------------------------------------------------------------
							Map<String,Object> jsonFile = new HashMap<String,Object>();
							// 예전 버전에선 다음 구문을 사용하세요.
							//jsonFile.put(fieldName + FormNo + "_" + UploadCount, newFileSavePath);
							jsonFile.put("id",fieldName);  //필수
							jsonFile.put("url", SubDir + newFileSavePath); //필수	
							jsonFile.put("size", item.getSize()); //필수
							
							jsonFile.put("name", item_getName); //선택
							jsonFile.put("date", TodayString);  //선택
							jsonFile.put("clientid", item.getFieldName()); //선택
							jsonFileList.add(jsonFile);

						}
						UploadCount++;
					} // filename is not null
				} // end of if form file
			} // end of for

			//--------------------------------------------------------------------------------
			// 파일 삭제 처리
			//--------------------------------------------------------------------------------
			List<String> deleteItem = Arrays.asList(DeleteFileList.replaceAll("\r", "").split("\n"));
// 			ibuploadMap.put("DeleteFileList", deleteItem);
			for (String item : deleteItem) {
				item = item.trim();
				if (!"".equals(item)) {
					File delFile = new File(IBUpload_RealFilePath(UploadRootDir, item));
					if (delFile.isFile()) { // 존재할 경우 제거
						delFile.delete();
					}
				}
			}

			//====================================================================================================
			//  ♣4 : JSON 결과문을 IBUpload Client 로 응답한다.
			//====================================================================================================
			ibuploadMap.put("ibupload",jsonFileList);  //최종 client로 전달될 메세지

		}
		return ibuploadMap;
	}

	String IBUpload_RealFilePath(String UploadRootDir, String UrlKey) {
		return UploadRootDir + UrlKey;
	}%>
