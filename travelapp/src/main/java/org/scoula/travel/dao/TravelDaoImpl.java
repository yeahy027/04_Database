package org.scoula.travel.dao;

import org.scoula.database.JDBCUtil;
import org.scoula.travel.domain.TravelImageVO;
import org.scoula.travel.domain.TravelVO;

import java.sql.Connection;
import java.util.List;
import java.util.Optional;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TravelDaoImpl implements TravelDao {

    // DBCUtil을 통해 Connection 얻어오기
    Connection conn = JDBCUtil.getConnection();


    /**
     * ResultSet -> TravelVO 객체 매핑 메서드
     *
     * @param rs 데이터베이스 쿼리 결과셋
     * @return 결과셋의 현재 행을 기반으로 생성된 TravelVO 객체
     * @throws SQLException DB 작업 중 오류 발생 시
     */
    private TravelVO map(ResultSet rs) throws SQLException {
        return TravelVO.builder()
                .no(rs.getLong("no"))                    // 여행지 번호
                .district(rs.getString("district"))      // 지역
                .title(rs.getString("title"))            // 제목
                .description(rs.getString("description")) // 설명
                .address(rs.getString("address"))        // 주소
                .phone(rs.getString("phone"))            // 전화번호
                .build();
    }

    /**
     * ResultSet -> TravelImageVO 객체 매핑하 메서드
     *
     * @param rs 데이터베이스 쿼리 결과셋
     * @return 결과셋의 현재 행을 기반으로 생성된 TravelImageVO 객체
     * @throws SQLException DB 작업 중 오류 발생 시
     */
    private TravelImageVO mapImage(ResultSet rs) throws SQLException {
        return TravelImageVO.builder()
                .no(rs.getLong("tino"))              // 이미지 번호
                .filename(rs.getString("filename"))  // 파일명
                .travelNo(rs.getLong("travel_no"))   // 연관된 여행지 번호
                .build();
    }


    /**
     * 새로운 여행지 정보 DB INSERT 메서드
     * @param travel : 등록할 여행지 정보를 담은 TravelVO 객체
     */
    @Override
    public void insert(TravelVO travel) {
        // 여행지 정보 등록 SQL
        String sql = "INSERT INTO tbl_travel(no, district,title,description, address, phone) VALUES(?,?,?,?,?,?)";

        // try-witch-resources
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 파라미터 바인딩
            pstmt.setLong(1, travel.getNo());           // 여행지 번호
            pstmt.setString(2, travel.getDistrict());   // 지역
            pstmt.setString(3, travel.getTitle());      // 제목
            pstmt.setString(4, travel.getDescription()); // 설명
            pstmt.setString(5, travel.getAddress());    // 주소
            pstmt.setString(6, travel.getPhone());      // 전화번호

            // DML 수행
            int count = pstmt.executeUpdate();

        } catch (SQLException e) {
            // SQLException을 RuntimeException으로 래핑하여 처리
            throw new RuntimeException(e);
        }
    }

    /**
     * 여행지 이미지 정보 DB INSERT메서드
     * @param image : 등록할 이미지 정보를 담은 TravelImageVO 객체
     */
    @Override
    public void insertImage(TravelImageVO image) {

        // 여행지 이미지 등록 SQL
        String sql = "INSERT INTO tbl_travel_image(filename, travel_no) VALUES(?,?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 파라미터 바인딩
            pstmt.setString(1, image.getFilename());    // 이미지 파일명
            pstmt.setLong(2, image.getTravelNo());      // 연관된 여행지 번호

            int count = pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 전체 여행지 개수를 조회하는 메서드
     * - 페이징 처리를 위한 총 개수 정보 제공
     * @return 전체 여행지 개수
     */
    @Override
    public int getTotalCount() {

        String sql = "SELECT count(*) FROM tbl_travel";

        // try-with-resources, 여러 객체 등록 가능
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            rs.next(); // 첫 번째 행으로 이동 -> 조회 결과 무조건 1행
            return rs.getInt(1); // 첫 번째 컬럼의 count 값 반환

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 모든 지역(권역) 목록 조회 메서드
     * - 중복 지역 제거
     * - 지역명 오름차순
     * - 지역별 필터링을 위한 기초 데이터 제공
     *
     * @return 중복 제거된 지역명 리스트 (알파벳 순 정렬)
     */
    @Override
    public List<String> getDistricts() {
        List<String> districts = new ArrayList<>();

        String sql = "SELECT DISTINCT(district) FROM tbl_travel ORDER BY district";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                districts.add(rs.getString("district"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return districts;
    }


    /**
     * 모든 여행지 목록 조회 메서드
     * - 지역별, 제목별로 정렬하여 반환
     *
     * @return 전체 여행지 목록
     */
    @Override
    public List<TravelVO> getTravels() {
        List<TravelVO> travels = new ArrayList<>();

        String sql = "SELECT * FROM tbl_travel ORDER BY district, title";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {

                // ResultSet -> TravelVO 객체 매핑 메서드 호출
                TravelVO travel = map(rs);
                travels.add(travel);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return travels;
    }

    /**
     * 페이지별 여행지 목록 조회 메서드
     * - LIMIT을 사용한 페이징 처리
     *
     * @param page 조회 페이지 번호 (1부터 시작)
     * @return 해당 페이지 여행지 목록 (페이지당 10개)
     */
    @Override
    public List<TravelVO> getTravels(int page) {
        List<TravelVO> travels = new ArrayList<>();

        String sql = "SELECT * FROM tbl_travel ORDER BY district, title LIMIT ?,?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            int count = 10;                    // 페이지당 항목 수
            int start = (page - 1) * count;    // 시작 인덱스 계산

            // 페이징 파라미터 바인딩
            pstmt.setInt(1, start);  // OFFSET
            pstmt.setInt(2, count);  // LIMIT

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    TravelVO travel = map(rs);
                    travels.add(travel);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return travels;
    }

    /**
     * 특정 지역 여행지 목록 조회 메서드
     * - getTravles() 메서드 오버로딩
     *
     * @param district 조회할 지역명
     * @return 해당 지역의 여행지 목록
     */
    @Override
    public List<TravelVO> getTravels(String district) {
        List<TravelVO> travels = new ArrayList<TravelVO>();

        String sql = "SELECT * FROM tbl_travel WHERE district = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, district); // 지역명 파라미터 바인딩
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    TravelVO travel = map(rs);
                    travels.add(travel);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return travels;
    }

    /**
     * 특정 여행지의 상세 정보 + 관련 이미지 조회 메서드
     * - LEFT OUTER JOIN을 사용하여 이미지가 없는 여행지도 조회
     * - Optional을 사용하여 결과의 존재 여부 표현
     *
     * @param no 조회할 여행지 번호
     * @return 여행지 상세 정보와 이미지 목록을 포함한 Optional<TravelVO>
     */
    @Override
    public Optional<TravelVO> getTravel(Long no) {
        TravelVO travel = null;

        String sql = """
                SELECT 
                    t.*, ti.no AS tino, 
                    ti.filename, 
                    ti.travel_no
                FROM 
                    tbl_travel t
                 LEFT OUTER JOIN 
                    tbl_travel_image ti ON t.no = ti.travel_no
                WHERE t.no = ?
            """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, no); // 여행지 번호 파라미터 바인딩

            try (ResultSet rs = pstmt.executeQuery()) {


                if (rs.next()) {

                    // 첫 번째 행에서 여행지 기본 정보 매핑
                    travel = map(rs);

                    // 이미지 정보를 저장할 List 생성
                    List<TravelImageVO> images = new ArrayList<>();

                    // 조회 결과에서 이미지 정보만 추출
                    try {
                        do {
                            TravelImageVO image = mapImage(rs);
                            images.add(image);
                        } while (rs.next()); // 다음 행으로 이동
                    } catch (SQLException e) {
                        // 이미지가 없는 경우 발생하는 예외 (무시)
                    }

                    travel.setImages(images); // TravelVO 필드에 이미지 리스트 세팅
                    return Optional.of(travel);
                } else {
                    return Optional.empty(); // 여행지가 없다면 빈 Optional 객체 반환
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
