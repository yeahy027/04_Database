package org.scoula.jdbc_ex.test;

import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class AssertJTest {

    @Test
    public void assertJExample() {

        int num1 = 100;
        int num2 = 100;
        String text = "Hello, AssertJ!";
        List<String> fruits = Arrays.asList("apple", "banana", "orange");
        int number = 42;

        // 두 값이 같은지 확인
        assertThat(num1).isEqualTo(num2);

        // 문자열 검증
        assertThat(text)
                .isNotEmpty()
                .startsWith("Hello")
                .endsWith("!")
                .contains("AssertJ");

        // 컬렉션 검증
        assertThat(fruits)
                .hasSize(3)
                .contains("apple", "orange")
                .doesNotContain("grape");

        // 숫자 검증
        assertThat(number)
                .isPositive()
                .isGreaterThan(40)
                .isLessThan(50)
                .isEqualTo(42);
    }
}

