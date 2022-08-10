package ibs.com.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.chrono.ChronoLocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjuster;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import ibs.com.domain.CriteriaVO;
import ibs.com.domain.JobVO;
import ibs.com.domain.MemberVO;
import ibs.com.domain.ProjectDTO;
import ibs.com.domain.ProjectVO;
import ibs.com.domain.UserVO;
import ibs.com.domain.WeekReportVO;
import ibs.com.service.JobService;
import ibs.com.service.ProjectService;
import ibs.com.service.UserService;
import ibs.com.service.WeekReportService;

/**
 * @FileName : ReportController.java
 * @Date : 2021. 9. 7.
 * @작성자 : 신형진
 * @설명 : 주간보고서 컨트롤러
 */

@Controller
@RequestMapping("report")
public class ReportController {
	private static final Logger LOGGER = LoggerFactory.getLogger(ReportController.class);

	// private List<Map> weekReportVOList;

	// private List<Map> projectMemberJobVOList;

	@Resource(name = "userService")
	private UserService userservice;
	@Resource(name = "jobService")
	private JobService jobService;
	@Resource(name = "weekReportService")
	private WeekReportService weekReportService;
	@Resource(name = "projectService")
	private ProjectService projectService;

	// String 형태의 2021-10-11 을 날짜형태로 변환하는 함수
	public static LocalDate changed(String date) {
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		LocalDate test = LocalDate.parse(date, DateTimeFormatter.ISO_DATE);
		return test;
	}

	public static Date stringToDate(String target) throws Exception {

		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");

		Date to = new Date();
		to = transFormat.parse(target);

		return to;

	}

	public static Map<String, Float> thisWeekPlan_NextWeekPlan(String start, String end) throws Exception {
		// System.out.println("계산해야 할 시작시간: "+start);
		// System.out.println("계산해야 할 종료시간: "+end);
		// 금주 계획, 차주 계획, 주말제외한 평일수
		int thisWeekPlan = 0;
		int nextWeekPlan = 0;
		int weekDays = 0;
		long byThisWeekSatudayWeekDays = 0; // 시작일~ 금주까지의 평일수
		long byNextWeekSatudayWeekDays = 0; // 시작일~ 다음주까지의 평일수
		Date start_date_forWeekDays = new Date();
		Date end_date_forWeekDays = new Date();

		start_date_forWeekDays = stringToDate(start);
		end_date_forWeekDays = stringToDate(end);

		LocalDate real_Start_Date = null;
		real_Start_Date = changed(start);
		LocalDate real_End_Date = null;
		real_End_Date = changed(end);
		// System.out.println("LocalDate 타입의 시작일: "+real_Start_Date+"\n
		// LocalDate 타입의 종료일: "+real_End_Date);

		weekDays = calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
		// System.out.println("주말 제외한 평일의 수는?: "+weekDays);
		Map<String, Object> createThisMon_NextSat = new HashMap<String, Object>();
		createThisMon_NextSat = createWhatsDay();
		byNextWeekSatudayWeekDays = calculateWeekDays(start_date_forWeekDays,
				stringToDate(createThisMon_NextSat.get("next_week_saturday").toString()));

		// System.out.println("금주 월요일:
		// "+createThisMon_NextSat.get("this_week_monday"));
		// System.out.println("금주 토요일:
		// "+createThisMon_NextSat.get("this_week_saturday"));
		// System.out.println("차주 월요일:
		// "+createThisMon_NextSat.get("next_week_monday"));
		// System.out.println("차주 토요일:
		// "+createThisMon_NextSat.get("next_week_saturday"));

		// System.out.println("금주계획 비교TEST:
		// "+real_Start_Date.isAfter((LocalDate)
		// createThisMon_NextSat.get("this_week_saturday")));
		// System.out.println("차주계획 비교TEST: "+real_End_Date.isAfter((LocalDate)
		// createThisMon_NextSat.get("this_week_saturday")));

		// 금주 계획 계산
		// 1. 종료일이 금주 금요일보다 클때 ex) 종료일:10-28 , 금주
		// 금요일:10-28=========================================================================
		if (real_End_Date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_saturday"))) {
			// System.out.println("[금주계산] 종료일이 금주 금요일보다 크다");
			thisWeekPlan = (int) byThisWeekSatudayWeekDays;

			// 1.2 시작일이 금주 월요일보다 작을때 ex) 시작일:10-24 , 금주 월요일:10-25
			if (real_Start_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_monday"))) {
				thisWeekPlan = calculateWeekDays(start_date_forWeekDays,
						stringToDate(createThisMon_NextSat.get("this_week_saturday").toString())).intValue();
				if (real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_monday"))) {
					thisWeekPlan = (int) calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
				}
				// System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
			}
			// 1.3 시작일이 금주 토요일보다 느릴때 ex) 시작일:10-26 , 금주 월요일:10-25
			else if (real_Start_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))) {
				// System.out.println("[금주계산] 시작일이 금주 토요일보다 작다");
				thisWeekPlan = calculateWeekDays(start_date_forWeekDays,
						stringToDate(createThisMon_NextSat.get("this_week_saturday").toString())).intValue();
				// System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
			}
		} // End 1. 종료일이 금주 금요일보다 늦다

		// 2.종료일이 금주 금요일보다 빠르다. ex) 종료일:10-26 , 금주 금요일:10-28
		else if (real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))) {
			// System.out.print("[금주계산] 종료일이 금주 토요일보다 작을때.");
			thisWeekPlan = calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
			// 2.1 before는 시간단위가지 계산하기 때문에 같은 날짜라도 다르게 나오는 예외케이스가 존재하기 때문에 혹시나
			// 같은 일 일 경우는 시간단위로는 계산안한다.(종료일이 금주 금요일이면)
			// 2.2 시작일이 금주 월요일보다 작을때ex) 시작일:10-24 , 금주 월요일:10-25
			if (real_Start_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_monday"))) {
				// System.out.println(" 시작일이 금주 월요일보다 작을면.");
				thisWeekPlan = calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();

			}
			// 2.3 시작일이 금주 월요일보다 클때 ex) 시작일:10-26 , 금주 월요일:10-25
			else if (real_Start_Date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_monday"))) {
				// System.out.println("시작일이 금주 월요일보다 크면.");
				thisWeekPlan = calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
			}

		}

		// 차주 계획 계산
		// 1. 종료일이 금주 토요일보다 크면
		if (real_End_Date.isAfter((LocalDate) createThisMon_NextSat.get("this_week_saturday"))) {
			// System.out.println("[차주계산] 종료일이 금주 금요일보다 클때");
			nextWeekPlan = (int) byNextWeekSatudayWeekDays;
			// System.out.println(nextWeekPlan);
			// 1.1 종료일이 차주 월요일보다 클때
			if (real_End_Date.isAfter((LocalDate) createThisMon_NextSat.get("next_week_monday"))) {
				nextWeekPlan = (int) byNextWeekSatudayWeekDays;
				// 1.1.1 종료일이 차주 토요일보다 작을때
				if (real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_saturday"))) {
					nextWeekPlan = (int) calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
				}
				// 1.1.2 종료일이 차주 토요일을 넘을때
				else if (real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("next_week_monday"))) {
					nextWeekPlan = 0;
				}

			}
			// 1.2 종료일이 차주 월요일과 같을때
			else if (real_End_Date.isEqual((LocalDate) createThisMon_NextSat.get("next_week_monday"))) {
				nextWeekPlan = (int) calculateWeekDays(start_date_forWeekDays, end_date_forWeekDays).intValue();
			}

		}
		// 2. 종료일이 금주 토요일보다 작으면
		else if (real_End_Date.isBefore((LocalDate) createThisMon_NextSat.get("this_week_saturday"))) {
			// System.out.println("[차주계산] 종료일이 금주 금요일보다 작을때");

			nextWeekPlan = 0;

		}
		// System.out.println("이번주 계획량은? : "+thisWeekPlan);
		// System.out.println("다음주 계획량은? : "+nextWeekPlan);

		float thisWeekPlanProgress = (float) thisWeekPlan / (float) weekDays;
		float nextWeekPlanProgress = (float) nextWeekPlan / (float) weekDays;

		// System.out.println(thisWeekPlanProgress);
		// System.out.println(nextWeekPlanProgress);

		if (nextWeekPlanProgress <= 0) {
			nextWeekPlanProgress = 0.0f;
		}
		if (thisWeekPlanProgress <= 0) {
			thisWeekPlanProgress = 0.0f;
		}

		Map<String, Float> map = new HashMap<String, Float>();
		map.put("thisWeekPlanProgress", thisWeekPlanProgress);
		map.put("nextWeekPlanProgress", nextWeekPlanProgress);

		return map;

	}

	public Date createToday() {
		LocalDate date = LocalDate.now();

		Date testDate = java.sql.Date.valueOf(date);

		return testDate;

	}

	// 전주 토요일,금주 월요일,금주 토요일,차주 월요일, 차주 토요일 뽑아오는 함수
	public static Map<String, Object> createWhatsDay() {
		Map<String, Object> day = new HashMap<>();
		int nowDay = LocalDate.now().getDayOfWeek().getValue();

		LocalDate last_week_saturday = null; // 저번주 토요일
		LocalDate last_week_sunday = null;
		LocalDate this_week_monday = null; // 이번주 월요일
		LocalDate this_week_saturday = null; // 이번주 토요일
		LocalDate next_week_monday = null; // 다움주 월요일
		LocalDate next_week_friday = null; // 다움주 금요일
		LocalDate next_week_saturday = null; // 다움주 토요일

		switch (nowDay) {
		case 1: // 찍힌 날짜가 월요일 이라면
			last_week_saturday = LocalDate.now().minusDays(2); // 저번주 토요일
			last_week_sunday = LocalDate.now().minusDays(1);
			this_week_monday = LocalDate.now(); // 금주 월요일
			this_week_saturday = LocalDate.now().plusDays(5); // 금주 토요일
			next_week_monday = LocalDate.now().plusDays(7); // 차주 월요일
			next_week_friday = LocalDate.now().plusDays(11); // 차주 금요일
			next_week_saturday = LocalDate.now().plusDays(12); // 차주 토요일
			break;
		case 2: // 찍힌 날짜가 화요일 이라면
			last_week_saturday = LocalDate.now().minusDays(3);
			last_week_sunday = LocalDate.now().minusDays(2);
			this_week_monday = LocalDate.now().minusDays(1);
			this_week_saturday = LocalDate.now().plusDays(4);
			next_week_monday = LocalDate.now().plusDays(6);
			next_week_friday = LocalDate.now().plusDays(10);
			next_week_saturday = LocalDate.now().plusDays(11);
			break;
		case 3: // 찍힌 날짜가 수요일 이라면
			last_week_saturday = LocalDate.now().minusDays(4);
			last_week_sunday = LocalDate.now().minusDays(3);
			this_week_monday = LocalDate.now().minusDays(2);
			this_week_saturday = LocalDate.now().plusDays(3);
			next_week_monday = LocalDate.now().plusDays(5);
			next_week_friday = LocalDate.now().plusDays(9);
			next_week_saturday = LocalDate.now().plusDays(10);
			break;
		case 4: // 찍힌 날짜가 목요일 이라면
			last_week_saturday = LocalDate.now().minusDays(5);
			last_week_sunday = LocalDate.now().minusDays(4);
			this_week_monday = LocalDate.now().minusDays(3);
			this_week_saturday = LocalDate.now().plusDays(2);
			next_week_monday = LocalDate.now().plusDays(4);
			next_week_friday = LocalDate.now().plusDays(8);
			next_week_saturday = LocalDate.now().plusDays(9);
			break;
		case 5: // 찍힌 날짜가 굼요일 이라면
			last_week_saturday = LocalDate.now().minusDays(6);
			last_week_sunday = LocalDate.now().minusDays(5);
			this_week_monday = LocalDate.now().minusDays(4);
			this_week_saturday = LocalDate.now().plusDays(1);
			next_week_monday = LocalDate.now().plusDays(3);
			next_week_friday = LocalDate.now().plusDays(7);
			next_week_saturday = LocalDate.now().plusDays(8);
			break;
		case 6: // 찍힌 날짜가 토요일 이라면
			last_week_saturday = LocalDate.now().minusDays(7);
			last_week_sunday = LocalDate.now().minusDays(6);
			this_week_monday = LocalDate.now().minusDays(5);
			this_week_saturday = LocalDate.now();
			next_week_monday = LocalDate.now().plusDays(2);
			next_week_friday = LocalDate.now().plusDays(6);
			next_week_saturday = LocalDate.now().plusDays(7);
			break;
		case 7: // 찍힌 날짜가 일요일 이라면
			last_week_saturday = LocalDate.now().minusDays(8);
			last_week_sunday = LocalDate.now().minusDays(7);
			this_week_monday = LocalDate.now().minusDays(6);
			this_week_saturday = LocalDate.now().minusDays(1);
			next_week_monday = LocalDate.now().plusDays(1);
			next_week_friday = LocalDate.now().plusDays(5);
			next_week_saturday = LocalDate.now().plusDays(6);
			break;
		default:
			break;
		}
		day.put("this_week_monday", this_week_monday);
		day.put("this_week_saturday", this_week_saturday);
		day.put("next_week_monday", next_week_monday);
		day.put("next_week_saturday", next_week_saturday);
		day.put("last_week_saturday", last_week_saturday);
		day.put("last_week_sunday", last_week_sunday);
		return day;
	}

	// 들어온 주차의 토요일을 구하는 함수
	public static LocalDate createWhatSaturday(LocalDate date) {

		int receiveDay = 0;
		receiveDay = date.getDayOfWeek().getValue();
		LocalDate saturdayDate = null;
		switch (receiveDay) {
		case 1: // 찍힌 날짜가 월요일 이라면
			saturdayDate = date.minusDays(5);

			break;
		case 2: // 찍힌 날짜가 화요일 이라면
			saturdayDate = date.minusDays(4);
			break;
		case 3: // 찍힌 날짜가 수요일 이라면
			saturdayDate = date.minusDays(3);
			break;
		case 4: // 찍힌 날짜가 목요일 이라면
			saturdayDate = date.minusDays(2);
			break;
		case 5: // 찍힌 날짜가 굼요일 이라면
			saturdayDate = date.minusDays(1);
			break;
		case 6: // 찍힌 날짜가 토요일 이라면
			saturdayDate = date.now();
			break;
		default:
			break;
		}

		return saturdayDate;
	}

	public static Long countWeekDays(LocalDate start, LocalDate end) {

		LocalDate startDate = start;
		LocalDate endDate = end;

		Period betweenResult = Period.between(startDate, endDate);
		int result = betweenResult.getDays();
		long cnt = 0;

		for (int i = 0; i <= result; i++) {
			DayOfWeek week = startDate.getDayOfWeek();
			int day = week.getValue();
			if (day != 6 && day != 7) {
				cnt++;
			}
			startDate = startDate.plusDays(1);
		}
		return cnt;
	}

	// 주어진 기간의 총 평일수를 구하는 함수
	public static Long calculateWeekDays(Date StartDate, Date EndDate) {
		// System.out.println("함수로 들어온 시작일: "+StartDate);
		// System.out.println("함수로 들어온 종료일: "+EndDate);
		Calendar startDate = Calendar.getInstance(); // 작업 시작일 (START_DATE)
		Calendar endDate = Calendar.getInstance(); // 작업 종료일 (END_DATE)
		Calendar addDate = Calendar.getInstance(); // 시작일~종료일 사이의 주말을 제외하기 위한
													// 계산용 날짜

		long workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)

		startDate.setTime(StartDate);
		addDate.setTime(StartDate);
		endDate.setTime(EndDate);

		// 주말을 제외한 총 기간 구하기
		while (!addDate.after(endDate)) {
			int day = addDate.get(Calendar.DAY_OF_WEEK);
			if ((day != Calendar.SATURDAY) && (day != Calendar.SUNDAY)) {
				workingDays++; // 평일 수
			}
			addDate.add(Calendar.DATE, 1);
		}
		// LOGGER.info("주말 제외 총 기간 : " + workingDays);

		return workingDays;
	}

	// String 형태의 2021-10-11 을 날짜형태로 변환하는 함수
	public static LocalDate Changed(String date) {
		SimpleDateFormat weekSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		LocalDate test = null;
		test = LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
		return test;
	}

	// 프로젝트별 실시간 보고서를 위한 계산식 만들어주는 메서드
	public List<Map> CreateThisWeekPlanAndNextWeekPlanByProject(Map<String, Object> projectIdAndWeekDate)
			throws ParseException, java.text.ParseException {
		// System.out.println("프로젝트 검색을 위한 날짜와 프로젝트 이름이 들어왔어:
		// "+projectIdAndWeekDate);
		int projectId = Integer.parseInt(projectIdAndWeekDate.get("project_id").toString());
		// System.out.println("프로젝트 id: "+ projectId);
		// System.out.println("금주 월요일:
		// "+projectIdAndWeekDate.get("this_week_monday"));
		// System.out.println("차주 토요일:
		// "+projectIdAndWeekDate.get("next_week_saturday"));
		// 프로젝트 id로 프로젝트 이름을 가져오기
		String realProjectName = null;
		realProjectName = projectService.getProjectNameByProjectId(projectId);

		List<Map> createOntime = new ArrayList<>();

		LocalDate change_this_Week_SatDate = null;
		LocalDate change_next_Week_SatDate = null;
		LocalDate change_this_From_next_To_weekDay = null;

		LocalDate change_thisMon = null;
		LocalDate change_thisFri = null;
		LocalDate change_thisSat = null;

		LocalDate change_nextMon = null;
		LocalDate change_nextFri = null;
		LocalDate change_nextSat = null;

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DateTimeFormatter weekSimpleDateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// job에 week=1 이고 real_end_date가 선택된 날짜보다 크고 해당 프로젝트의 id값으로 존재하는 데이터가
		// 있는지 찾는다.
		List<JobVO> list = jobService.getJobByProjectId(projectIdAndWeekDate);
		List<MemberVO> notInJobUser = null;

		// job에 어느 데이터도 없다면???
		if (list.size() == 0) {
			// System.out.println("프로젝트 멤버가 job 테이블에 어느 누구도 없다. 임의의 값을 이제
			// 만들어주자.");
			notInJobUser = userservice.getProjectMemberNotInJob(projectIdAndWeekDate);
			// System.out.println(projectId+" 프로젝트이며 job에 없는 프로젝트 멤버리스트:
			// "+notInJobUser);
			for (int i = 0; i < notInJobUser.size(); i++) {
				Map<String, Object> test = new HashMap<>();
				test.put("name", notInJobUser.get(i).getUser_id());
				test.put("week_date", createToday());
				test.put("project_id", realProjectName);
				test.put("user_id", userservice.selectUserName(notInJobUser.get(i).getUser_id()).getName().toString());
				test.put("parent", 0);
				test.put("job_id", 0);
				createOntime.add(test);
			}

		} else {
			for (int i = 0; i < list.size(); i++) {
				long workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)
				long byThisWeekSatudayWeekDays = 0; // 시작일~ 금주까지의 평일수
				long byNextWeekSatudayWeekDays = 0; // 시작일~ 다음주까지의 평일수

				LocalDate change_start_date = Changed(list.get(i).getReal_start_date().toString());
				LocalDate change_end_date = Changed(list.get(i).getReal_end_date().toString());

				Map<String, Object> createThisMon_NextSat = createWhatsDay();
				LocalDate this_Monday = (LocalDate) createThisMon_NextSat.get("this_week_monday");
				LocalDate this_Saturday = (LocalDate) createThisMon_NextSat.get("this_week_saturday");
				LocalDate next_Monday = (LocalDate) createThisMon_NextSat.get("next_week_monday");
				LocalDate next_Saturday = (LocalDate) createThisMon_NextSat.get("next_week_saturday");

				// System.out.println("실제 시작일:
				// "+list.get(i).getReal_start_date());
				// System.out.println("실제 종료일:
				// "+list.get(i).getReal_end_date());

				// 주말을 제외한 총 기간 구하기
				workingDays = countWeekDays(change_start_date, change_end_date);

				LocalDate thisWeekSat = LocalDate.now().with(DayOfWeek.SATURDAY);
				byThisWeekSatudayWeekDays = countWeekDays(change_start_date, thisWeekSat);

				LocalDate nextWeekSat = thisWeekSat.plusDays(7);
				byNextWeekSatudayWeekDays = countWeekDays(change_start_date, nextWeekSat);

				// 금주 계획, 차주 계획
				int thisWeekPlan = 0;
				int nextWeekPlan = 0;

				// 금주 계획 계산
				// 1. 종료일이 금주 금요일보다 클때 ex) 종료일:10-28 , 금주
				// 금요일:10-28=========================================================================
				if (change_end_date.isAfter(this_Saturday)) {
					// System.out.println("[금주계산] 종료일이 금주 금요일보다 크다");
					thisWeekPlan = (int) byThisWeekSatudayWeekDays;

					// 1.2 시작일이 금주 월요일보다 작을때 ex) 시작일:10-24 , 금주 월요일:10-25
					if (change_start_date.isBefore(next_Monday)) {
						thisWeekPlan = (int) countWeekDays(change_start_date, this_Saturday).intValue();
						if (change_end_date.isBefore(next_Monday)) {
							thisWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();
						}
						// System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
					}
					// 1.3 시작일이 금주 토요일보다 느릴때 ex) 시작일:10-26 , 금주 월요일:10-25
					else if (change_start_date.isBefore(this_Saturday)) {
						// System.out.println("[금주계산] 시작일이 금주 토요일보다 작다");
						thisWeekPlan = countWeekDays(change_start_date, this_Saturday).intValue();
						// System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
					}
				} // End 1. 종료일이 금주 금요일보다 늦다

				// 2.종료일이 금주 금요일보다 빠르다. ex) 종료일:10-26 , 금주 금요일:10-28
				else if (change_end_date.isBefore(this_Saturday)) {
					// System.out.print("[금주계산] 종료일이 금주 토요일보다 작을때.");
					thisWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();
					// 2.1 before는 시간단위가지 계산하기 때문에 같은 날짜라도 다르게 나오는 예외케이스가 존재하기
					// 때문에 혹시나 같은 일 일 경우는 시간단위로는 계산안한다.(종료일이 금주 금요일이면)
					// 2.2 시작일이 금주 월요일보다 작을때ex) 시작일:10-24 , 금주 월요일:10-25
					if (change_start_date.isBefore(this_Monday)) {
						// System.out.println(" 시작일이 금주 월요일보다 작을면.");
						thisWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();

					}
					// 2.3 시작일이 금주 월요일보다 클때 ex) 시작일:10-26 , 금주 월요일:10-25
					else if (change_start_date.isAfter(this_Monday)) {
						// System.out.println("시작일이 금주 월요일보다 크면.");
						thisWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();

					}

				}

				// 차주 계획 계산
				// 1. 종료일이 금주 토요일보다 크면
				if (change_end_date.isAfter(this_Saturday)) {
					// System.out.println("[차주계산] 종료일이 금주 금요일보다 클때");
					nextWeekPlan = (int) byNextWeekSatudayWeekDays;
					// 1.1 종료일이 차주 월요일보다 클때
					if (change_end_date.isAfter(next_Monday)) {
						// System.out.println("[차주계산] 종료일이 차주 월요일보다 클때");
						nextWeekPlan = (int) byNextWeekSatudayWeekDays;
						// 1.1.1 종료일이 차주 토요일보다 작을때
						if (change_end_date.isBefore(next_Saturday)) {
							// System.out.println("[차주계산] 종료일이 차주 토요일보다 작을때");
							nextWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();
						}
						// 1.1.2 종료일이 차주 토요일을 넘을때
						else if (change_end_date.isAfter(next_Saturday)) {
							nextWeekPlan = (int) byNextWeekSatudayWeekDays;
						}
					}
					// 1.2 종료일이 차주 월요일과 같을때
					else if (change_end_date.isEqual(next_Monday)) {
						nextWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();
					}
				}
				// 2. 종료일이 금주 토요일보다 작으면
				else if (change_end_date.isBefore(this_Saturday)) {
					// System.out.println("[차주계산] 종료일이 금주 금요일보다 작을때");
					nextWeekPlan = 0;
				}

				// System.out.println("thisWeekPlan: "+thisWeekPlan);
				// System.out.println("nextWeekPlan: "+nextWeekPlan);
				// System.out.println("workingDays: "+workingDays);
				// 금주 계획은 이번주 작업량/전체 작업량, 차주 계획은 다음주 작업량/전체 작업량
				float thisWeekPlanProgress = thisWeekPlan / (float) workingDays;
				float nextWeekPlanProgress = nextWeekPlan / (float) workingDays;

				if (nextWeekPlanProgress <= 0) {
					nextWeekPlanProgress = 0.0f;
				}
				if (thisWeekPlanProgress <= 0) {
					thisWeekPlanProgress = 0.0f;
				}
				Map<String, Object> map = new HashMap<>();

				JobVO vo = new JobVO();
				Map<String, Object> thisMon_NextSat = createWhatsDay();
				// System.out.println(list.get(i).getWeek_date());
				// System.out.println("금주계획: "+thisWeekPlanProgress);
				// System.out.println("업무 수행 내역 상세: "+list.get(i).getName());
				// System.out.println("해당 키의 부모: "+list.get(i).getParent());
				map.put("this_week_plan", thisWeekPlanProgress);
				map.put("next_week_plan", nextWeekPlanProgress);
				map.put("project_id", list.get(i).getProject().getProject_title());
				map.put("privacy_state", list.get(i).getPrivacy_state());
				map.put("job_name", list.get(i).getName());
				map.put("user_id", list.get(i).getManager());
				map.put("start_date", list.get(i).getReal_start_date());
				map.put("end_date", list.get(i).getReal_end_date());
				map.put("comment", list.get(i).getComment());
				map.put("contents", list.get(i).getContents());
				map.put("work_type", list.get(i).getWork_type());
				map.put("work_detail_type", list.get(i).getWork_detail_type());
				map.put("work_division", list.get(i).getWork_division());
				map.put("name", list.get(i).getManager());
				map.put("real_progress", list.get(i).getReal_progress());
				map.put("parent", list.get(i).getParent());
				// map.put("department", departmentName);
				map.put("job_id", list.get(i).getId());
				map.put("week_date", createToday());
				map.put("this_week_performence", list.get(i).getReal_progress());
				map.put("user_id", userservice.selectUserName(list.get(i).getManager()).getName().toString());
				createOntime.add(map);

			} // End for

			List<MemberVO> emptyProjectMemberList = projectService.getProjectMemberNotInJob(projectIdAndWeekDate);

			for (int i = 0; i < emptyProjectMemberList.size(); i++) {
				Map<String, Object> forEmptyMap = new HashMap<>();
				forEmptyMap.put("name", emptyProjectMemberList.get(i).getUser_id());
				forEmptyMap.put("week_date", createToday());
				forEmptyMap.put("job_id", 0);
				forEmptyMap.put("project_id", realProjectName);
				forEmptyMap.put("user_id",
						userservice.selectUserName(emptyProjectMemberList.get(i).getUser_id()).getName().toString());
				forEmptyMap.put("parent", 0);
				createOntime.add(forEmptyMap);
			}

		} // End else

		// System.out.println("최종 가공 처리된 배열들: "+createOntime);

		// System.out.println("프로젝트 보고서가 계산이 됬니? "+createOntime);
		// 1.job이 있는 List<Map>배열과 job이 없는 List<Map> 배열에서 유저들의 직급을 꺼내와서 직급별로 다시
		// 새로운 new List<Map>에 넣어준뒤에 최종적으로 return 해준다.
		// 2.현재 createOntime에 job 있는 없는 애들 모두 들어가져있다. 여기서 다시 직급별로 sort를 해줘야한다.
		return createOntime;

	}

	// 내 부서의 실시간 보고서를 위한 계산식 만들어주는 메서드(이번월~다음주 금까지 포함된 job을 가져온다. 기준은 일 토)
	public List<Map> CreateThisWeekPlanAndNextWeekPlanByDept(Map<String, Object> conditionOfMyDeptWeekReport)
			throws Exception {
		List<JobVO> list = weekReportService.getMyDeptWeekReportAtJob(conditionOfMyDeptWeekReport);
		List<JobVO> list_Temp = weekReportService.getMyDeptWeekReportAtJob(conditionOfMyDeptWeekReport);
		List<JobVO> newCreate = new ArrayList<>();
		// System.out.println("=======================================================변경전=======================================================");
		// System.out.println(list_Temp.size());
		// for(int i=0; i<list.size(); i++){
		// System.out.println(list_Temp.get(i).getId()+" :
		// "+list_Temp.get(i).getThis_week_plan()+" :
		// "+list_Temp.get(i).getNext_week_plan());
		// }

		/*
		 * int[] subCountTemp = new int[list_Temp.size()]; float[]
		 * this_week_plan_Temp = new float[list_Temp.size()]; float[]
		 * next_week_plan_Temp = new float[list_Temp.size()]; for(int i=0;
		 * i<list_Temp.size(); i++){ for(int j=0; j<list_Temp.size(); j++){
		 * if(list_Temp.get(i).getId()==list_Temp.get(j).getParent()){
		 * subCountTemp[i]++;
		 * this_week_plan_Temp[i]+=thisWeekPlan_NextWeekPlan(list_Temp.get(j).
		 * getReal_start_date(),list_Temp.get(j).getReal_end_date())
		 * .get("thisWeekPlanProgress");
		 * next_week_plan_Temp[i]+=thisWeekPlan_NextWeekPlan(list_Temp.get(j).
		 * getReal_start_date(),list_Temp.get(j).getReal_end_date())
		 * .get("nextWeekPlanProgress"); } } }
		 * 
		 * // System.out.println("자식값이 있는 부모아이디 찾기"); for(int i=0;
		 * i<subCountTemp.length; i++){ if(subCountTemp[i]>=1){
		 * //System.out.println(list_Temp.get(i).getId()); JobVO vo = new
		 * JobVO(); vo.setId(list.get(i).getId());
		 * vo.setContents(list.get(i).getContents());
		 * vo.setName(list.get(i).getName());
		 * vo.setProject(list.get(i).getProject());
		 * vo.setReal_start_date(list.get(i).getReal_start_date());
		 * vo.setReal_end_date(list.get(i).getReal_end_date());
		 * vo.setComment(list.get(i).getComment());
		 * vo.setWork_type(list.get(i).getWork_type());
		 * vo.setWork_detail_type(list.get(i).getWork_detail_type());
		 * vo.setWork_division(list.get(i).getWork_division());
		 * vo.setManager(list.get(i).getManager());
		 * vo.setReal_progress(list.get(i).getReal_progress());
		 * vo.setParent(list.get(i).getParent());
		 * vo.setDepartment(list.get(i).getDepartment());
		 * vo.setWeek_date(createToday().toString());
		 * vo.setThis_week_plan(this_week_plan_Temp[i]/(float)subCountTemp[i]);
		 * vo.setNext_week_plan(next_week_plan_Temp[i]/(float)subCountTemp[i]);
		 * list_Temp.set(i,vo); } }
		 * 
		 * //System.out.println("변궁 후: "); for(int i=0; i<list_Temp.size();
		 * i++){
		 * //System.out.println(list_Temp.get(i).getId()+" : "+list_Temp.get(i).
		 * getThis_week_plan()+" : "+list_Temp.get(i).getNext_week_plan()); }
		 */

		// job에 없는 나의 팀원들을
		// 1.내 부서 인원의 이름을 뽑자
		// System.out.println(list.get(0).getManager());
		String userId = null;
		userId = list.get(0).getManager();

		// 2.이름으로 유저 부서 봅자
		// System.out.println(userservice.selectUserInfoById(list.get(0).getManager()).getDepartment());
		String department = null;
		department = userservice.selectUserInfoById(list.get(0).getManager()).getDepartment();
		// 3.job에 등록되지 않은 유저를 찾아보자 등록되었으면 WEEK=0인 유저들도 같이 뽑아온다
		// System.out.println("아무것도 등록된 작업이 없는 유저리스트:
		// "+userservice.getDeptMemberNotInJob(userservice.selectUserInfoById(list.get(0).getManager()).getDepartment()));
		List<UserVO> notInJobMember = userservice.getDeptMemberNotInJob(conditionOfMyDeptWeekReport);
		// System.out.println("부서: "+notInJobMember);
		String departmentName = userservice.getMyDeptNameByCode(department);

		// Job에 없는 부서원들의 정보는 보고서에서 이름만 나오게 배열에 이름만 넣어준다.
		List<String> forCreateEmptyJob = new ArrayList<>();
		for (int i = 0; i < notInJobMember.size(); i++) {
			forCreateEmptyJob.add(notInJobMember.get(i).getId());
		}

		List<Map> createOntime = new ArrayList<>();

		LocalDate change_this_Week_SatDate = null;
		LocalDate change_next_Week_SatDate = null;
		LocalDate change_this_From_next_To_weekDay = null;

		LocalDate change_thisMon = null;
		LocalDate change_thisFri = null;
		LocalDate change_thisSat = null;

		LocalDate change_nextMon = null;
		LocalDate change_nextFri = null;
		LocalDate change_nextSat = null;

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		for (int i = 0; i < list.size(); i++) {
			long workingDays = 0; // 시작일 ~ 종료일 사이의 평일수 (=TOTAL_DATE)
			long workingDays1 = 0;
			long byThisWeekSatudayWeekDays = 0; // 시작일~ 금주까지의 평일수
			long byNextWeekSatudayWeekDays1 = 0;
			long byNextWeekSatudayWeekDays = 0; // 시작일~ 다음주까지의 평일수

			LocalDate change_start_date = null;
			change_start_date = Changed(list.get(i).getReal_start_date().toString());
			LocalDate change_end_date = null;
			change_end_date = Changed(list.get(i).getReal_end_date().toString());
			byNextWeekSatudayWeekDays = countWeekDays(change_start_date, change_end_date);

			// 주말을 제외한 총 기간 구하기
			workingDays = countWeekDays(change_start_date, change_end_date);

			LocalDate monday = LocalDate.now().with(DayOfWeek.MONDAY);

			LocalDate thisWeekSat = LocalDate.now().with(DayOfWeek.SATURDAY);
			byThisWeekSatudayWeekDays = countWeekDays(change_start_date, thisWeekSat);

			LocalDate nextWeekSat = thisWeekSat.plusDays(7);
			byNextWeekSatudayWeekDays = countWeekDays(change_start_date, nextWeekSat);

			// 금주 계획, 차주 계획
			int thisWeekPlan = 0;
			int nextWeekPlan = 0;

			Map<String, Object> createThisMon_NextSat = null;
			createThisMon_NextSat = createWhatsDay();
			LocalDate this_Monday = (LocalDate) createThisMon_NextSat.get("this_week_monday");
			LocalDate this_Saturday = (LocalDate) createThisMon_NextSat.get("this_week_saturday");
			LocalDate next_Monday = (LocalDate) createThisMon_NextSat.get("next_week_monday");
			LocalDate next_Saturday = (LocalDate) createThisMon_NextSat.get("next_week_saturday");

			// 내부서
			// 금주 계획 계산
			// 1. 종료일이 금주 금요일보다 클때 ex) 종료일:10-28 , 금주
			// 금요일:10-28=========================================================================
			if (change_end_date.isAfter(this_Saturday)) {
				// System.out.println("[금주계산] 종료일이 금주 금요일보다 크다");
				thisWeekPlan = (int) byThisWeekSatudayWeekDays;

				// 1.2 시작일이 금주 월요일보다 작을때 ex) 시작일:10-24 , 금주 월요일:10-25
				if (change_start_date.isBefore(next_Monday)) {
					thisWeekPlan = (int) countWeekDays(change_start_date, this_Saturday).intValue();
					if (change_end_date.isBefore(next_Monday)) {
						thisWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();
					}
					// System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
				}
				// 1.3 시작일이 금주 토요일보다 느릴때 ex) 시작일:10-26 , 금주 월요일:10-25
				else if (change_start_date.isBefore(this_Saturday)) {
					// System.out.println("[금주계산] 시작일이 금주 토요일보다 작다");
					thisWeekPlan = countWeekDays(change_start_date, this_Saturday).intValue();
					// System.out.println("[금주계산] 이번주 계획: "+thisWeekPlan);
				}
			} // End 1. 종료일이 금주 금요일보다 늦다

			// 2.종료일이 금주 금요일보다 빠르다. ex) 종료일:10-26 , 금주 금요일:10-28
			else if (change_end_date.isBefore(this_Saturday)) {
				// System.out.print("[금주계산] 종료일이 금주 토요일보다 작을때.");
				thisWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();
				// 2.1 before는 시간단위가지 계산하기 때문에 같은 날짜라도 다르게 나오는 예외케이스가 존재하기 때문에
				// 혹시나 같은 일 일 경우는 시간단위로는 계산안한다.(종료일이 금주 금요일이면)
				// 2.2 시작일이 금주 월요일보다 작을때ex) 시작일:10-24 , 금주 월요일:10-25
				if (change_start_date.isBefore(this_Monday)) {
					// System.out.println(" 시작일이 금주 월요일보다 작을면.");
					thisWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();

				}
				// 2.3 시작일이 금주 월요일보다 클때 ex) 시작일:10-26 , 금주 월요일:10-25
				else if (change_start_date.isAfter(this_Monday)) {
					// System.out.println("시작일이 금주 월요일보다 크면.");
					thisWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();

				}

			}

			// 차주 계획 계산
			// 1. 종료일이 금주 토요일보다 크면
			if (change_end_date.isAfter(this_Saturday)) {
				// System.out.println("[차주계산] 종료일이 금주 금요일보다 클때");
				nextWeekPlan = (int) byNextWeekSatudayWeekDays;
				// 1.1 종료일이 차주 월요일보다 클때
				if (change_end_date.isAfter(next_Monday)) {
					// System.out.println("[차주계산] 종료일이 차주 월요일보다 클때");
					nextWeekPlan = (int) byNextWeekSatudayWeekDays;
					// 1.1.1 종료일이 차주 토요일보다 작을때
					if (change_end_date.isBefore(next_Saturday)) {
						// System.out.println("[차주계산] 종료일이 차주 토요일보다 작을때");
						nextWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();
					}
					// 1.1.2 종료일이 차주 토요일을 넘을때
					else if (change_end_date.isAfter(next_Saturday)) {
						nextWeekPlan = (int) byNextWeekSatudayWeekDays;
					}
				}
				// 1.2 종료일이 차주 월요일과 같을때
				else if (change_end_date.isEqual(next_Monday)) {
					nextWeekPlan = (int) countWeekDays(change_start_date, change_end_date).intValue();
				}
			}
			// 2. 종료일이 금주 토요일보다 작으면
			else if (change_end_date.isBefore(this_Saturday)) {
				// System.out.println("[차주계산] 종료일이 금주 금요일보다 작을때");
				nextWeekPlan = 0;
			}
			// 금주 계획은 이번주 작업량/전체 작업량, 차주 계획은 다음주 작업량/전체 작업량
			float thisWeekPlanProgress = thisWeekPlan / (float) workingDays;
			float nextWeekPlanProgress = nextWeekPlan / (float) workingDays;

			if (nextWeekPlanProgress <= 0) {
				nextWeekPlanProgress = 0.0f;
			}
			if (thisWeekPlanProgress <= 0) {
				thisWeekPlanProgress = 0.0f;
			}

			Map<String, Object> map = new HashMap<>();

			JobVO vo = new JobVO();
			Map<String, Object> thisMon_NextSat = createWhatsDay();

			map.put("job_id", list.get(i).getId());
			map.put("contents", list.get(i).getContents());
			map.put("this_week_plan", thisWeekPlan_NextWeekPlan(list.get(i).getReal_start_date().toString(),
					list.get(i).getReal_end_date().toString()).get("thisWeekPlanProgress"));
			map.put("next_week_plan", thisWeekPlan_NextWeekPlan(list.get(i).getReal_start_date().toString(),
					list.get(i).getReal_end_date().toString()).get("nextWeekPlanProgress"));
			map.put("project_id", list.get(i).getProject().getProject_title());
			map.put("job_name", list.get(i).getName());
			map.put("start_date", list.get(i).getReal_start_date());
			map.put("end_date", list.get(i).getReal_end_date());
			map.put("comment", list.get(i).getComment());
			map.put("privacy_state", list.get(i).getPrivacy_state());
			map.put("work_type", list.get(i).getWork_type());
			map.put("work_detail_type", list.get(i).getWork_detail_type());
			map.put("work_division", list.get(i).getWork_division());
			map.put("name", list.get(i).getManager());
			map.put("real_progress", list.get(i).getReal_progress());
			map.put("parent", list.get(i).getParent());
			map.put("department", departmentName);
			map.put("week_date", createToday());
			map.put("this_week_performence", list.get(i).getReal_progress());
			map.put("user_id", userservice.selectUserName(list.get(i).getManager()).getName().toString());
			map.put("this_week_monday", thisMon_NextSat.get("this_week_monday").toString());
			map.put("this_week_saturday", thisMon_NextSat.get("this_week_saturday").toString());
			map.put("next_week_monday", thisMon_NextSat.get("next_week_monday").toString());
			map.put("next_week_saturday", thisMon_NextSat.get("next_week_saturday").toString());
			map.put("child_id", null);
			createOntime.add(map);

		}

		/*
		 * for(int i=0; i<forCreateEmptyJob.size(); i++){ Map<String,Object> map
		 * = new HashMap<>(); map.put("name", forCreateEmptyJob.get(i));
		 * map.put("week_date", createToday()); map.put("user_id",
		 * userservice.selectUserName(forCreateEmptyJob.get(i)).getName().
		 * toString()); map.put("job_id", 0); map.put("parent", 0);
		 * createOntime.add(map);
		 * 
		 * }
		 */

		// 1.job이 있는 List<Map>배열과 job이 없는 List<Map> 배열에서 유저들의 직급을 꺼내와서 직급별로 다시
		// 새로운 new List<Map>에 넣어준뒤에 최종적으로 return 해준다.
		// 2.현재 createOntime에 job 있는 없는 애들 모두 들어가져있다. 여기서 다시 직급별로 sort를 해줘야한다.
		return createOntime;

	}

	@RequestMapping(value = "/sheet/team", method = RequestMethod.POST)
	@ResponseBody
	public ProjectDTO project(Model model, HttpServletRequest request, String title, Principal loginUser,
			String weekReportDate, CriteriaVO cri) throws Exception {
		System.out.println("projectListAll-------------------------------------");
		String userid = loginUser.getName();
		if (userid == null) {
			userid = "";
		}
		cri.setProject_title(title);

		ProjectDTO project = new ProjectDTO();
		// db에서 데이터 조회(VO의 리스트)
		List<ProjectVO> projectList = projectService.selectAllProject(title);
		// db에서 가져온 데이터를 data 필드에 넣어줌
		project.setData(projectList);
		System.out.println("project : " + project);
		return project;
	}

	// 내 부서별 보고서 출력
	// 리펙토링 중...
	@RequestMapping(value = "/team")
	public String showWeekReportDepartment(Principal loginUser, String title, Model model, String weekReportDate,
			CriteriaVO cri) throws Exception {
		String loginUserId = loginUser.getName();
		String User = loginUser.getName();
		if (User == null) {
			User = "";
		}
		cri.setUserid(User);
		cri.setProject_title(title);
		model.addAttribute("beforelastCnt", jobService.beforeMylastCnt(cri));
		model.addAttribute("inglastCnt", jobService.ingMylastCnt(cri));

		DateTimeFormatter weekSimpleDateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		// json 데이터를 IB Sheet7에서 받을때는 { DATA : [ {key:value, ...}
		// {key:value,...} ]}로 이어져야 하기 때문에 JSONArray로 담는다
		// ib.common.js을 쓴다면 바로 정해진 Header의 Savename에 맞게 매핑된다는데 현 시스템은 JSONArray
		// 데이터를 JSP에서 JSONObject로 만든다
		JSONObject weekReportDeptJson = new JSONObject();
		JSONObject calendarDate = new JSONObject(); // 주간보고서의 DatePicker에 표현될
													// 날짜를 저장할 JSON
		JSONArray weekReportDeptJsonArray = new JSONArray();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = new JSONObject();
		ObjectMapper objectMapper = new ObjectMapper();

		// 현재 로그인 한 유저정보를 DB에서 가져온다
		UserVO user = userservice.selectUserInfoById(loginUserId);

		List<Map> weekReportVOList = new ArrayList<>();
		List<WeekReportVO> weekReportVO = new ArrayList<WeekReportVO>();
		Map<String, Object> createThisMon_NextSat = createWhatsDay();
		LocalDate last_Saturday = (LocalDate) createThisMon_NextSat.get("last_week_saturday");
		LocalDate last_Sunday = (LocalDate) createThisMon_NextSat.get("last_week_sunday");
		LocalDate this_Monday = (LocalDate) createThisMon_NextSat.get("this_week_monday");
		LocalDate this_Saturday = (LocalDate) createThisMon_NextSat.get("this_week_saturday");
		LocalDate next_Monday = (LocalDate) createThisMon_NextSat.get("next_week_monday");
		LocalDate next_Saturday = (LocalDate) createThisMon_NextSat.get("next_week_saturday");
		LocalDate input = null;

		// ajax로 넘어온 날짜가 있다면 그 날짜가 속한 주의 토요일을, 없다면 저번주 토요일을 기준일로 정한다
		if (weekReportDate != null) {
			try {
				// ======================================로직================================
				LocalDate today_date = LocalDate.now();
				LocalDate receiveDate = Changed(weekReportDate);

				Map<String, Object> conditionOfMyDeptWeekReport = new HashMap<String, Object>();
				conditionOfMyDeptWeekReport.put("this_week_monday", this_Monday.toString());
				conditionOfMyDeptWeekReport.put("next_week_saturday", next_Saturday.toString());
				conditionOfMyDeptWeekReport.put("department", user.getDepartment());

				// 가져온 유저정보로 같은 부서소속원들의 WeekReport를 가져온다
				// 들어온 날짜정보가 널이 아니며 받은 데이터가 저번주 토요일보타 크면 실시간으로 가져온다.
				if (receiveDate.compareTo(last_Sunday) > 0) {
					LOGGER.info("찍힌 날짜가 저번주 토요일보다 크다. 실시간 보고서 출력");
					// 만약 해당 부서에 이번주 월~다음주 금까지 해당하는 작업들이 없으면 업습니다.jsp 페이지를 띄운다.
					if (weekReportService.getMyDeptWeekReportAtJob(conditionOfMyDeptWeekReport).size() == 0) {
						calendarDate.put("calendarDate", weekSimpleDateFormat.format(LocalDate.now()));
						// System.out.println("리펙토링 테스트
						// 합니다."+weekSimpleDateFormat.format(LocalDate.now()));
						model.addAttribute("calendarDate", calendarDate);
						model.addAttribute("weekReportDeptJson", null);
						return "/report/team";
					}
					calendarDate.put("calendarDate", weekSimpleDateFormat.format(LocalDate.now()));
					weekReportVOList = CreateThisWeekPlanAndNextWeekPlanByDept(conditionOfMyDeptWeekReport);

					// 들어온 날짜가 저번주 토요일보다 작으면
				} else {
					LOGGER.info("찍힌 날짜가 저번주 토요일보다 작다. 과거 보고서 출력");
					HashMap<String, Object> map = new HashMap<>();
					calendarDate.put("calendarDate", weekSimpleDateFormat.format(receiveDate.with(DayOfWeek.SATURDAY)));
					map.put("department", user.getDepartment());
					map.put("week_date", weekSimpleDateFormat.format(receiveDate.with(DayOfWeek.SATURDAY)));
					weekReportVOList = weekReportService.selectWeekReportDeptAndDate(map);

				}

			} catch (java.text.ParseException e) {
				e.printStackTrace();
			}
		} else if (weekReportDate == null) { // 날짜가 NULL값으로 들어오면 오늘날짜를 DEFAULT를
												// 기준으로 이번주 월 다음주 토 를 찾아서 해당
												// 조건식을 출려간다.

			LOGGER.info("Null 찍혔으므로 기본 Default 값은 현재시간(실시간) 출력");
			Map<String, Object> conditionOfMyDeptWeekReport = new HashMap<String, Object>();
			conditionOfMyDeptWeekReport.put("this_week_monday", this_Monday.toString());
			conditionOfMyDeptWeekReport.put("next_week_saturday", next_Saturday.toString());
			conditionOfMyDeptWeekReport.put("department", user.getDepartment());
			calendarDate.put("calendarDate", weekSimpleDateFormat.format(LocalDate.now()));

			if (weekReportService.getMyDeptWeekReportAtJob(conditionOfMyDeptWeekReport).size() == 0) {
				model.addAttribute("calendarDate", calendarDate);
				model.addAttribute("weekReportDeptJson", null);

				return "/report/team";
			}
			weekReportVOList = CreateThisWeekPlanAndNextWeekPlanByDept(conditionOfMyDeptWeekReport);
		}

		// DB에서 가져온 같은 부서원들의 WeekReport를 넘겨받은 ajaxCalendar(=기준일)에 준한 데이터로 재분류한다
		Map map;
		WeekReportVO vo = new WeekReportVO();

		for (int i = 0; i < weekReportVOList.size(); i++) {
			objectMapper.setDateFormat(simpleDateFormat);
			map = weekReportVOList.get(i);

			String jsonString = objectMapper.writeValueAsString(weekReportVOList.get(i));
			jsonObj = (JSONObject) jsonParser.parse(jsonString);
			weekReportDeptJsonArray.add(jsonObj);

			map.remove("project_id");
			map.remove("department");

			String jsonString2 = objectMapper.writeValueAsString(map);
			vo = objectMapper.readValue(jsonString2, WeekReportVO.class);
			weekReportVO.add(vo);

		}
		// weekReportDeptJsonArray에 담겨진 데이터가 없다는것은 기준일에 일치하는 WeekReport가 없다는 것..
		// 때문에 null을 반환하여 jsp에서 오류로 작동하지 않게 한다
		if (weekReportDeptJsonArray.size() != 0) {
			LocalDate now = LocalDate.now();
			weekReportDeptJson.put("DATA", weekReportDeptJsonArray);

			// weekReportDeptJson.put("sheet_name", now);
		} else {
			weekReportDeptJson = null;
		}
		model.addAttribute("calendarDate", calendarDate);
		model.addAttribute("beforelastCnt", jobService.beforeMylastCnt(cri));
		model.addAttribute("inglastCnt", jobService.ingMylastCnt(cri));
		model.addAttribute("weekReportDeptJson", weekReportDeptJson);
		model.addAttribute("WeekReportVOList", weekReportVO);

		return "report/team";
	}

	// 나와 같은 프로젝트에 참여하는 사용자들의 주간보고서 가져오기
	@RequestMapping(value = "/project")
	public String showWeekReportProject(Principal loginUser, String title, Model model, String weekReportDate,
			String type, CriteriaVO cri) throws ParseException, java.text.ParseException {
		LOGGER.info("ReportController : /report/project 호출");
		String loginUserId = loginUser.getName();
		String User = loginUser.getName();
		if (User == null) {
			User = "";
		}
		cri.setUserid(User);
		cri.setProject_title(title);
		model.addAttribute("beforelastCnt", jobService.beforeMylastCnt(cri));
		model.addAttribute("inglastCnt", jobService.ingMylastCnt(cri));

		Calendar ajaxCalendar = null; // DatePicker로 선택한 날짜가 속한 주의 토요일을 저장하기 위한
										// 캘린더
		Calendar weekDate = null; // DatePicker의 날짜와 부합하는 주간보고서만을 가져오기 위한 계산용 날짜

		Date getWeekReportDate = null; // 주간보고서 화면에서 DatePicker로 받은
										// weekReportDate를 기준일로 기능하기 위한 저장객체

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd"); // objectMapper의
																				// DateFormat
		SimpleDateFormat weekSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); // DatePicker에
																					// 반환하거나,
																					// ajaxCalendar의
																					// setTime을
																					// 위한
																					// DateFormat

		// json 데이터를 IB Sheet7에서 받을때는 { DATA : [ {key:value, ...}
		// {key:value,...} ]}로 이어져야 하기 때문에 JSONArray로 담는다
		// ib.common.js을 쓴다면 바로 정해진 Header의 Savename에 맞게 매핑된다는데 현 시스템은 JSONArray
		// 데이터를 JSP에서 JSONObject로 만든다
		JSONArray weekReportProjectJsonArray = new JSONArray();
		JSONObject calendarDate = new JSONObject(); // 주간보고서의 DatePicker에 표현될
													// 날짜를 저장할 JSON
		JSONObject weekReportProjectJson = new JSONObject();

		// 현재 로그인 한 유저정보를 DB에서 가져온다
		UserVO user = userservice.selectUserInfoById(loginUserId);
		cri.setUserid(loginUserId);
		cri.setProject_title(title);

		LOGGER.info("로그인 유저 : " + loginUserId);
		List<Map> weekReportVOList = new ArrayList<>();
		// 현재 로그인 한 유저의 참여 프로젝트 리스트를 가져오기
		List<Integer> myProjectIdList = jobService.getMyProjectIdList(user);
		List<WeekReportVO> weekReportVO = new ArrayList<WeekReportVO>();

		LOGGER.info("=================================================================");
		// ajax로 넘어온 날짜가 있다면 그 날짜가 속한 주의 토요일을, 없다면 저번주 토요일을 기준일로 정한다
		if (weekReportDate != null) {

			ajaxCalendar = Calendar.getInstance();
			Map<String, Object> thisMonday_NextSaturday = createWhatsDay();
			LocalDate receiveDate = Changed(weekReportDate);
			// 가져온 유저정보로 같은 부서소속원들의 WeekReport를 가져온다
			// 들어온 날짜정보가 널이 아니며 받은 데이터가 저번주 토요일보타 크면
			if (receiveDate.compareTo((LocalDate) thisMonday_NextSaturday.get("last_week_saturday")) > 0) {

				// 이번주 월~차주 토요일까지 작업들
				Map<String, Object> map = new HashMap<>();
				map.put("project_id", type);
				map.put("weekReportDate", weekReportDate);
				map.put("this_week_monday", thisMonday_NextSaturday.get("this_week_monday").toString());
				map.put("next_week_saturday", thisMonday_NextSaturday.get("next_week_saturday").toString());
				map.put("department", user.getDepartment());
				weekReportVOList = CreateThisWeekPlanAndNextWeekPlanByProject(map);

				// System.out.println(weekReportVOList);

			} else if (receiveDate.compareTo((LocalDate) thisMonday_NextSaturday.get("last_week_saturday")) < 0) {
				// 2. 과거날짜 클릭 시 과거날짜가 속한 토요일 출력
				ajaxCalendar.setTime(java.sql.Date.valueOf(receiveDate));
				ajaxCalendar.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);

				HashMap<String, Object> map = new HashMap<>();
				map.put("project_id", type);
				map.put("week_date", weekSimpleDateFormat.format(ajaxCalendar.getTime()));
				weekReportVOList = weekReportService.selectWeekReportProject(map);
				// System.out.println(weekReportVOList);

			}
			// 과거일의 토요일 클릭 시 클릭한날짜로 출력
			else {
				HashMap<String, Object> map = new HashMap<>();
				map.put("project_id", type);
				map.put("week_date", receiveDate.toString());
				weekReportVOList = weekReportService.selectWeekReportProject(map);

				// 2. 과거 토요일 클릭 시 토요일 날짜 출력
				ajaxCalendar.setTime(java.sql.Date.valueOf(receiveDate));

			}
			getWeekReportDate = weekSimpleDateFormat.parse(weekReportDate);

		} else if (weekReportDate == null) {
			// 1.초기 진입 시 날짜 출력(오늘 날짜)
			weekReportVOList = weekReportService.selectNowWeekReportTempProject(user);

			ajaxCalendar = Calendar.getInstance(Locale.KOREA);
			calendarDate.put("calendarDate", weekSimpleDateFormat.format(ajaxCalendar.getTime()));
			model.addAttribute("calendarDate", calendarDate);
			return "report/project";
		}

		// 참여중인 프로젝트가 없는경우 아래의 JOB을 가져오는 작업이 필요없다
		if (myProjectIdList.size() == 0) {
			calendarDate.put("calendarDate", weekSimpleDateFormat.format(ajaxCalendar.getTime()));
			model.addAttribute("calendarDate", calendarDate);
			return "report/project";
		}

		for (int project_id : myProjectIdList) {
		}

		// DB에서 가져온 같은 부서원들의 WeekReport를 넘겨받은 ajaxCalendar(=기준일)에 준한 데이터로 재분류한다
		for (int i = 0; i < weekReportVOList.size(); i++) {
			ObjectMapper objectMapper = new ObjectMapper();
			objectMapper.setDateFormat(simpleDateFormat);

			try {
				// DB에 저장된 WeekReport의 저장 날짜인 week_date와 기준일과 비교하여 일치하는 내용들만
				// JSONArray에 포함시킨다
				weekDate = Calendar.getInstance();
				weekDate.setTime((Date) weekReportVOList.get(i).get("week_date"));

				// weekReportVOList에 담겨진 Map은 <Object,Object> 이므로 Object to JSON
				// 파싱 작업이 필요하다
				String jsonString = objectMapper.writeValueAsString(weekReportVOList.get(i));
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObj = (JSONObject) jsonParser.parse(jsonString);

				weekReportProjectJsonArray.add(jsonObj);

				Map map = weekReportVOList.get(i);
				map.remove("project_id");
				map.remove("department");

				String jsonString2 = objectMapper.writeValueAsString(map);

				WeekReportVO vo = objectMapper.readValue(jsonString2, WeekReportVO.class);
				weekReportVO.add(vo);

			} catch (JsonProcessingException | ParseException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// weekReportDeptJsonArray에 담겨진 데이터가 없다는것은 기준일에 일치하 는 WeekReport가 없다는
		// 것.. 때문에 null을 반환하여 jsp에서 오류로 작동하지 않게 한다
		if (weekReportProjectJsonArray.size() != 0) {
			weekReportProjectJson.put("DATA", weekReportProjectJsonArray);
			weekReportProjectJson.put("sheet_name", weekSimpleDateFormat.format(ajaxCalendar.getTime()));
			calendarDate.put("calendarDate", weekSimpleDateFormat.format(ajaxCalendar.getTime()));
			weekReportProjectJson.put("user_name", user.getName());
		} else {
			weekReportProjectJson = null;
		}

		calendarDate.put("calendarDate", weekSimpleDateFormat.format(ajaxCalendar.getTime()));
		model.addAttribute("calendarDate", calendarDate);
		model.addAttribute("beforelastCnt", jobService.beforeMylastCnt(cri));
		model.addAttribute("inglastCnt", jobService.ingMylastCnt(cri));
		model.addAttribute("weekReportProjectJson", weekReportProjectJson);
		model.addAttribute("weekReportVOList", weekReportVOList);
		model.addAttribute("type", type);
		LOGGER.info("====프로젝트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ");

		return "report/project";
	}
}