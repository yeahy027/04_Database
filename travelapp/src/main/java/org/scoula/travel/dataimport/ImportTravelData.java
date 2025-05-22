package org.scoula.travel.dataimport;

import com.opencsv.bean.CsvToBeanBuilder;
import com.opencsv.exceptions.CsvValidationException;
import org.scoula.database.JDBCUtil;
import org.scoula.travel.dao.TravelDao;
import org.scoula.travel.dao.TravelDaoImpl;
import org.scoula.travel.domain.TravelVO;

import java.io.FileReader;
import java.io.IOException;
import java.util.List;

/**
 * CSV 파일에서 여행지 데이터를 읽어와 DB 일괄 INSERT
 */
public class ImportTravelData {


    public static void main(String[] args) throws CsvValidationException, IOException {

        // TravelDao 구현체 생성
        TravelDao dao = new TravelDaoImpl();

        // CsvToBeanBuilder를 이용하여 CSV 파일을 TravelVO 객체 리스트로 변환 (빌더패턴 사용)
        List<TravelVO> travels = new CsvToBeanBuilder<TravelVO>(new FileReader("travel.csv"))
                .withType(TravelVO.class)  // 변환할 대상 클래스 타입 지정
                .build()                   // CsvToBean 객체 생성
                .parse();                  // CSV 파싱 실행 및 객체 리스트 반환


        // 변환된 여행지 객체들을 순회하며 INSERT 수행
        travels.forEach(travel -> {

            System.out.println(travel);
            dao.insert(travel);
        });

        // 작업 완료 후 Connection close
        JDBCUtil.close();
    }
}
