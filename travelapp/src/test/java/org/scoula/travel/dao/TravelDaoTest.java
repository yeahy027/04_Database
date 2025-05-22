package org.scoula.travel.dao;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.scoula.database.JDBCUtil;
import org.scoula.travel.domain.TravelVO;

import java.util.List;
import java.util.Optional;

// Assertions 클래스에서 제공하는 static 메서드 호출 시 클래스명 생략
import static org.junit.jupiter.api.Assertions.*;

class TravelDaoTest {

    private TravelDao dao = new TravelDaoImpl();

    @AfterAll
    static void tearDown() {
        JDBCUtil.close();
    }

    @Test
    @DisplayName("전체 여행지 개수 조회")
    void getTotalCount() {
        int count = dao.getTotalCount();
        assertTrue(count > 0, "여행지 없음");
        System.out.println("여행지 count = " + count);
    }

    @Test
    @DisplayName("모든 지역(권역) 목록 조회")
    void getDistricts() {
        List<String> districts = dao.getDistricts();

        assertNotNull(districts, "null 반환됨");
        assertFalse(districts.isEmpty(), "List가 비어있음");

        System.out.println("=== 지역 목록 ===");
        districts.forEach(System.out::println);
    }

    @Test
    @DisplayName("전체 여행지 목록 조회")
    void getTravels() {
        List<TravelVO> travels = dao.getTravels();

        assertNotNull(travels, "null 반환됨");
        assertFalse(travels.isEmpty(), "여행지 목록 없음");

        System.out.println("=== 전체 여행지 목록 ===");
        travels.forEach(travel -> {
            System.out.println(travel.getDistrict() + " - " + travel.getTitle());
        });
        System.out.println("총 여행지 개수: " + travels.size());
    }

    @Test
    @DisplayName("페이지별 여행지 목록 조회")
    void testGetTravels() {
        int page = 1;

        List<TravelVO> travels = dao.getTravels(page);

        assertNotNull(travels); // 참조하는 객체(List 반환 받음)
        assertFalse(travels.isEmpty()); // List에 데이터 있음
        assertTrue(travels.size() <= 10); // 10개 이하 조회

        System.out.println("=== " + page + "페이지 여행지 목록 ===");
        travels.forEach(travel ->
                System.out.println(
                        travel.getNo() + " : " +
                        travel.getDistrict() + " - " +
                        travel.getTitle())
        );
    }

    @Test
    @DisplayName("특정 지역별 목록 조회")
    void testGetTravels1() {
        String district = "수도권";

        List<TravelVO> travels = dao.getTravels(district);

        assertNotNull(travels);
        assertFalse(travels.isEmpty());

        System.out.println("=== " + district + " 여행지 목록 ===");
        travels.forEach(travel ->
                System.out.println(
                        travel.getNo() + " : " +
                        travel.getTitle())
        );
    }

    /**
     * 특정 여행지 상세 조회 기능 테스트
     */
    @Test
    @DisplayName("특정 여행지 상세 정보 조회")
    void getTravel() {

        Long travelNo = 1L; // 여행지 번호 입력(long 형)

        // 특정 여행지 상세 정보 조회
        Optional<TravelVO> optionalTravel = dao.getTravel(travelNo);

        // Optional 결과 검증
        assertTrue(optionalTravel.isPresent(), "해당 번호의 여행지 정보가 없음");

        TravelVO travel = optionalTravel.get();

        // 상세 정보 출력
        System.out.println("=== 여행지 상세 정보 ===");
        System.out.println("번호: " + travel.getNo());
        System.out.println("지역: " + travel.getDistrict());
        System.out.println("제목: " + travel.getTitle());
        System.out.println("설명: " + travel.getDescription());
        System.out.println("주소: " + travel.getAddress());
        System.out.println("전화번호: " + travel.getPhone());

        // 이미지 정보 확인
        if (travel.getImages() != null && !travel.getImages().isEmpty()) {
            System.out.println("=== 연관 이미지 정보 ===");
            travel.getImages().forEach(image ->
                    System.out.println("- " + image.getFilename()));
        } else {
            System.out.println("연관된 이미지가 없습니다.");
        }
    }
}