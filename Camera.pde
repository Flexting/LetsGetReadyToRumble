
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
    
    void simplify()
    {
        float[] colourDivider = {10, 2, 2};
        
        for (int i = 0; i < colourDivider.length; i++)
            colourDivider[i] = 255.0/colourDivider[i];
        
        for (int i = 0; i < capture.pixels.length; i++) {
            color pixel = capture.pixels[i];
            float R = red(pixel), G = green(pixel), B = blue(pixel);
            float H = hue(pixel), S = saturation(pixel), Br = brightness(pixel);
            
            R = floor(R / colourDivider[0]) * colourDivider[0];
            G = floor(G / colourDivider[1]) * colourDivider[1];
            B = floor(B / colourDivider[2]) * colourDivider[2];
            
            H = floor(H / colourDivider[0]) * colourDivider[0];
            S = floor(S / colourDivider[1]) * colourDivider[1];
            Br = floor(Br / colourDivider[2]) * colourDivider[2];
            
            if (true) {
                colorMode(HSB, 255, 255, 255);
                capture.pixels[i] = color(H, S, Br);
                capture.pixels[i] = color(H, S, 255);
            }
            else
                capture.pixels[i] = color(R, G, B);
        }
        
    }
}