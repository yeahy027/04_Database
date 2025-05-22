package org.scoula;

import com.opencsv.CSVReader;

import java.io.FileReader;

/**
 * OpenCSV 라이브러리를 사용한 CSV 파일 읽기 예제
 */
public class CSVTest1 {

    public static void main(String[] args) throws Exception {

        // CSVReader 객체 생성
        // - FileReader를 통해 "travel.csv" 파일을 읽어올 준비
        CSVReader csvReader = new CSVReader(new FileReader("travel.csv"));

        // CSV의 각 행을 읽어와 저장할 문자열 배열 변수 선언
        String[] line;

        // CSV 파일의 모든 행을 순차적으로 읽기
        // - readNext() : 다음 한 행을 읽어옴. 다음 행이 없으면 null 반환

        while ((line = csvReader.readNext()) != null) {

            // 읽어온 행의 모든 컬럼을 쉼표로 연결하여 출력
            // - String String.join("구분자", String[]):
            //   String 배열의 요소들을 지정된 구분자로 연결해 하나의 문자열로 반환
            System.out.println(String.join(",", line));
        }

        // CSVReader는 AutoCloseable을 구현하지 않으므로 수동 닫기 필요
        // (실제 프로덕션 코드에서는 try-with-resources 또는 finally 블록에서 close() 호출 권장)
        csvReader.close();
    }
}