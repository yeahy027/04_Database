package org.scoula.travel.app;

import org.scoula.database.JDBCUtil;
import org.scoula.travel.dao.TravelDao;
import org.scoula.travel.dao.TravelDaoImpl;
import org.scoula.travel.service.TravelService;
import org.scoula.travel.service.TravelServiceImpl;

import java.util.Scanner;

public class TravelApp {
    private TravelService service;
    private MenuItem[] menu;
    Scanner sc = new Scanner(System.in);

    public TravelApp() {
        TravelDao dao = new TravelDaoImpl();
        service = new TravelServiceImpl(dao);
        menu = new MenuItem[] {
                new MenuItem("전체목록", service::printTravels),
                new MenuItem("페이지목록", service::printTravelsByPage),
                new MenuItem("권역별목록", service::printTravelsByDistrict),
                new MenuItem("상세보기", service::printTravel),
                new MenuItem("종료", this::exit),
        };
    }

    public static void main(String[] args) {
        TravelApp app = new TravelApp();
        app.run();
    }

    public void exit() {
        sc.close();
        JDBCUtil.close();
        System.exit(0);
    }

    public void printMenu() {
        System.out.println("========================================================");
        for (int i = 0; i < menu.length; i++) {
            MenuItem menuItem = menu[i];
            System.out.printf("%d) %s ", i + 1, menuItem.getTitle());
        }
        System.out.println();
        System.out.println("========================================================");
    }

    public int getMenuIndex() {
        System.out.println("선택: ");
        String line = sc.nextLine();

        int ix = Integer.parseInt(line) - 1;
        return ix;
    }

    public void run() {
        while (true) {
            printMenu(); // 메뉴 출력
            int ix = getMenuIndex(); // 사용자 선택 입력 받기

            // Command 패턴 : 선택된 메뉴의 명령 객체 획득 및 실행
            Runnable command = menu[ix].getCommand();
            command.run(); // 해당 명령 실행
        }
    }
}
