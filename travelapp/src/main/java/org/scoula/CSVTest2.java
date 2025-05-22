package org.scoula;

import com.opencsv.bean.CsvToBeanBuilder;
import org.scoula.travel.domain.TravelVO;

import java.io.FileReader;
import java.util.List;

/**
 * OpenCSV의 Bean 매핑 기능을 사용한 CSV 파일 읽기 예제 클래스
 */
public class CSVTest2 {

    public static void main(String[] args) throws Exception {

        // CsvToBeanBuilder를 사용하여 CSV 데이터를 TravelVO 객체 리스트로 변환
        // - 빌더 패턴을 통한 체이닝 방식으로 설정
        List<TravelVO> travels = new CsvToBeanBuilder<TravelVO>(new FileReader("travel.csv"))
                .withType(TravelVO.class)  // 변환할 대상 클래스 타입 지정
                .build()                   // CsvToBean 객체 생성
                .parse();                  // CSV 파싱 실행 및 객체 리스트 반환

        travels.forEach(travel -> {
            System.out.println(travel);
        });

        // travels.forEach(System.out::println);
    }
}