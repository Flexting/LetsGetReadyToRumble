
// Global classes
Config config;
Camera camera;
Car car;

BallDetection ballDetection;
CarDetection carDetection;
// Global classes end

PImage capture = null;

void setup() {
    frameRate(60);
    size(600, 480);
   
    camera = new Camera();
    config = new Config();
    car = new Car();
    
    ballDetection = new BallDetection();
    carDetection = new CarDetection();
}

void draw() {
    camera.screenCapture();
    image(capture, 0, 0);
    
    capture.loadPixels();
    ballDetection.exampleCode();
    carDetection.exampleCode();
}

void keyPressed() {
    if (key == '=') {
        car.toggleAutonomous();
    }
}