
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;

class Camera {

    Camera() {
      
    }
   
    void screenCapture() {
        // Screen captures and converts the buffered image into a PImage 'capture'
        PImage output = null;
      
        try {
            // Scren capture the given area
            BufferedImage Buffcapture = new Robot().createScreenCapture( new Rectangle(config.captureX, config.captureY, config.captureWidth, config.captureHeight) ); 
            // Convert the image into a PImage
            output = new PImage(Buffcapture.getWidth(), Buffcapture.getHeight(), PConstants.ARGB);
            Buffcapture.getRGB(0, 0, output.width, output.height, output.pixels, 0, output.width);
            output.updatePixels();
            capture = output.copy();
        }
        catch(Exception e) {
            System.err.println("Can't create image from buffer");
            e.printStackTrace();
        }
    }
}