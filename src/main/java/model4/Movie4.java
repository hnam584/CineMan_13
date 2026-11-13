package model4;

public class Movie4 {
    private String movieId;
    private String movieName;
    private String genre;
    private int duration;
    private String description;

    public Movie4() {}

    public Movie4(String movieId, String movieName, String genre, int duration, String description) {
        this.movieId = movieId;
        this.movieName = movieName;
        this.genre = genre;
        this.duration = duration;
        this.description = description;
    }

    public String getMovieId() { return movieId; }
    public void setMovieId(String movieId) { this.movieId = movieId; }

    public String getMovieName() { return movieName; }
    public void setMovieName(String movieName) { this.movieName = movieName; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}