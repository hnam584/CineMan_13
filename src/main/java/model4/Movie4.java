package model4;

public class Movie4 {
    private int id;
    private String movieName;
    private String genre;
    private int duration;
    private String description;

    private Manager4 manager;

    public Movie4() {
    }

    public Movie4(String movieName, String genre, int duration, String description) {
        this.movieName = movieName;
        this.genre = genre;
        this.duration = duration;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Manager4 getManager() {
        return manager;
    }

    public void setManager(Manager4 manager) {
        this.manager = manager;
    }
}
