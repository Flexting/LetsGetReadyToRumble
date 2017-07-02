
// Global classes
Config config;
Camera camera;
Car car;

BallDetection ballDetection;
CarDetection carDetection;

Debug debug;
// Global classes end

PImage capture = null;

void setup() {
    frameRate(60);
    size(640, 480);
    surface.setResizable(true);
   
    camera = new Camera();
    config = new Config();
    car = new Car();
    
    ballDetection = new BallDetection();
    carDetection = new CarDetection();
    
    debug = new Debug();
    
    surface.setSize(config.captureWidth, config.captureHeight);
}

void draw() {
    camera.screenCapture();
    image(capture, 0, 0);
    
    //ballDetection.exampleCode();
    carDetection.detectAlgorithm();
    
    car.drive();
    debug.display();
}

void keyPressed() {
    if (key == '=') {
        car.toggleAutonomous();
    }
}