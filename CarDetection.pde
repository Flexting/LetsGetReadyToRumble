
class CarDetection {

    CarDetection() {
      
    }
    
    void detectAlgorithm() {
        windowDetection();
        // hatDetection();    
    }
   
    void hatDetection() {
        noStroke();
        for (int i = 0; i < capture.pixels.length; i += 5) {
            color pixel = capture.pixels[i];
            float R = red(pixel), G = green(pixel), B = blue(pixel);
           
            // Red part of the Propeller hat
            if (R > 100 && G < 20 && B < 20) {
                fill(R, 0, 0);
                ellipse(i % config.captureWidth, i / config.captureWidth, 5, 5);
            } 
            
            // Orange part of the Propeller hat
            if (R > 140 && G > 50 && B < 20) {
                fill(R, G, 0);
                ellipse(i % config.captureWidth, i / config.captureWidth, 5, 5);
            } 
            
            // Green part of the Propeller hat
            if (R < 20 && G > 50 && B < 20) {
                fill(0, G, 0);
                ellipse(i % config.captureWidth, i / config.captureWidth, 5, 5);
            } 
        }
    }
    
    void windowDetection() {
        noStroke();
        
        for (int y = 0; y < config.captureHeight; y++) {
            boolean foundLeft, foundRight;
            foundLeft = false;
            foundRight = false;
            
            // Attack from both left and right to find the window
            for (int x = 0; x < config.captureWidth / 2; x++) {
                
                // Left
                if (!foundLeft) {
                    color pixel = capture.pixels[x + y * config.captureWidth];
                    float R = red(pixel), G = green(pixel), B = blue(pixel);
                    
                    if (R <= 10 && G <= 10 && B <= 10) {
                        fill(0, 255, 0);
                        ellipse(x, y, 5, 5);
                        foundLeft = true;
                    }
                }
                
                // Right
                if (!foundRight) {
                    color pixel = capture.pixels[config.captureWidth - x + y * config.captureWidth];
                    float R = red(pixel), G = green(pixel), B = blue(pixel);
                    
                    if (R <= 10 && G <= 10 && B <= 10) {
                        fill(0, 0, 255);
                        ellipse(x, y, 5, 5);
                        foundRight = true;
                    }
                }
                if (foundLeft && foundRight)
                    x = config.captureWidth;
            } 
        }
    }
}