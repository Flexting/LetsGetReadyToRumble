
class BallDetection {

    BallDetection() {
      
    }
    
    void exampleCode() {
        for (int i = 0; i < capture.pixels.length; i += 5) {
            color pixel = capture.pixels[i];
            float R = red(pixel), G = green(pixel), B = blue(pixel);
            
            if (R > 200 && G > 200 && B > 200) {
                noStroke();
                fill(R, 0, 0);
                ellipse(i % 640, floor(i / 640), 5, 5);
            }
        }
    }
   
}