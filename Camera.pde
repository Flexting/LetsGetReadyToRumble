
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;

class Camera {

    private Robot robot;
    private Rectangle region;
    
    Camera() {
        try {
            robot = new Robot();
            region = new Rectangle(config.captureX, config.captureY, config.captureWidth, config.captureHeight);
        } 
        catch (Exception e) {
            println(e.getMessage());
        }
    }
   
    void screenCapture() {
        debug.startTracking("Camera");
        // Screen capture the given area
        BufferedImage Buffcapture = robot.createScreenCapture(region);
        
        // Convert the image into a PImage
        //PImage output = new PImage(Buffcapture.getWidth(), Buffcapture.getHeight(), PConstants.ARGB);
        //Buffcapture.getRGB(0, 0, output.width, output.height, output.pixels, 0, output.width);
        //output.updatePixels();
        //capture = output.copy();
        capture = new PImage(Buffcapture);
        
        debug.stopTracking("Camera");
    }
}