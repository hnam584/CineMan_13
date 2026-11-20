package model4;

/**
 * Lớp thống kê phim (không có bảng riêng, dữ liệu dẫn xuất).
 * Kế thừa Movie4 theo thiết kế.
 */
public class MovieStatistic4 extends Movie4 {
    private int numberOfMovies;

    public int getNumberOfMovies() {
        return numberOfMovies;
    }

    public void setNumberOfMovies(int numberOfMovies) {
        this.numberOfMovies = numberOfMovies;
    }
}
