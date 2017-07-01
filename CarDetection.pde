
class CarDetection {

    CarDetection() {
      
    }
    
    void detectAlgorithm() {
        hatDetection();    
    }
   
    void hatDetection() {
        for (int i = 0; i < capture.pixels.length; i += 5) {
            color pixel = capture.pixels[i];
            float R = red(pixel), G = green(pixel), B = blue(pixel);
           
            // Red part of the Propeller hat
            if (R > 100 && G < 20 && B < 20) {
                noStroke();
                fill(R, 0, 0);
                ellipse(i % 640, floor(i / 640), 5, 5);
            } 
            
            // Orange part of the Propeller hat
            if (R > 140 && G > 50 && B < 20) {
                noStroke();
                fill(R, G, 0);
                ellipse(i % 640, floor(i / 640), 5, 5);
            } 
            
            // Green part of the Propeller hat
            if (R < 20 && G > 50 && B < 20) {
                noStroke();
                fill(0, G, 0);
                ellipse(i % 640, floor(i / 640), 5, 5);
            } 
        }
    }
}