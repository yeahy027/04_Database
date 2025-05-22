package org.scoula.travel.dataimport;

import org.scoula.database.JDBCUtil;
import org.scoula.travel.dao.TravelDao;
import org.scoula.travel.dao.TravelDaoImpl;
import org.scoula.travel.domain.TravelImageVO;

import java.io.File;

/**
 * 이미지 파일 디렉토리를 스캔하여 이미지 정보 DB 일괄 INSERT
 */
public class ImportImageData {

    public static void main(String[] args) {

        TravelDao dao = new TravelDaoImpl();

        // 이미지 디렉토리 지정
        File dir = new File("../travel-image");

        // 디렉토리 내 모든 파일 목록 얻어오기
        File[] files = dir.listFiles();

        // 순회하면서 각 이미지 정보 INSERT
        for (File file : files) {

            String fileName = file.getName(); // 파일명

            // 여행지 번호 추출
            // - 파일명 규칙: "여행지번호-기타정보.확장자"
            // -> "-" split 후 0번 index가 여행지 번호
            long travelNo = Long.parseLong(fileName.split("-")[0]);

            // Builder 패턴으로 TravelImageVO 객체 생성
            TravelImageVO image = TravelImageVO.builder()
                    .filename(fileName)    // 이미지 파일명
                    .travelNo(travelNo)    // 연관된 여행지 번호
                    .build();

            System.out.println(image);
            dao.insertImage(image);
        }

        // 작업 완료 후 Connection close
        JDBCUtil.close();
    }
}