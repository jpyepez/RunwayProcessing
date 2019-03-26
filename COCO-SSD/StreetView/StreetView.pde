import processing.video.*;

Movie streetMovie;
float movieScale;
boolean isFirstFrame;
float movieDuration;
boolean isPlaying;

Coco coco;

void setup() {
    size(1, 1);
    surface.setResizable(true);

    // movie setup
    streetMovie = new Movie(this, "street.mp4");
    streetMovie.loop();
    movieDuration = streetMovie.duration();
    movieScale = 0.5;
    isFirstFrame = true;

    // Coco SSD handler
    // initialize with maximum result index
    // e.g. '12' in results.12.bbox...
    coco = new Coco(12);

}

void draw() {
    image(streetMovie, 0, 0, width, height);
    coco.display(streetMovie.time());
}

void movieEvent(Movie movie) {
    movie.read();

    // resize canvas using movie properties
    // set playhead start
    if(isFirstFrame) {
        surface.setSize(int(movie.width * movieScale), int(movie.height * movieScale));
        surface.setLocation(0, 0);
        isFirstFrame = false;
        isPlaying = false;
    }
}

void keyReleased() {
    if(key == ' ') {
        if(!isPlaying) {
            streetMovie.play();
        } else {
            streetMovie.pause();
        }
        isPlaying = !isPlaying;
    }
}