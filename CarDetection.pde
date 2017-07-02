
class CarDetection {

    CarDetection() {
      
    }
    
    void detectAlgorithm() {
         //windowDetection();
         //hatDetection();   
        debug.startTracking("Arrow Dect");
        arrowDetection();
        debug.stopTracking("Arrow Dect");
    }
   
    void hatDetection() {
        ArrayList<PVector> redHatPoints = new ArrayList<PVector>();
        PVector mid = new PVector(0, 0);
        
        noStroke();
        for (int i = 0; i < capture.pixels.length; i += 5) {
            color pixel = capture.pixels[i];
            float R = red(pixel), G = green(pixel), B = blue(pixel);
           
            // Red part of the Propeller hat
            if (hue(pixel) == 0 && R > 100 && R < 240 && G < 20 && B < 20) {
                fill(255-R, 0, 0);
                ellipse(i % config.captureWidth, i / config.captureWidth, 5, 5);
                redHatPoints.add( new PVector(i % config.captureWidth, i / config.captureWidth) );
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
        
        for (int i = 0; i < redHatPoints.size(); i++) 
            mid.add(redHatPoints.get(i));
            
        mid.div(redHatPoints.size());
        noFill();
        stroke(255);
        ellipse(mid.x, mid.y, 60, 60);
        line(config.captureWidth / 2, 0, config.captureWidth / 2, config.captureHeight);
        
        car.carAlignment = config.captureWidth/2 - mid.x;
    }
    
    void windowDetection() {
        ArrayList<PVector> points = new ArrayList<PVector>();
        noStroke();
        
        for (int y = 0; y < config.captureHeight; y++) {
            boolean foundLeft, foundRight;
            foundLeft = false;
            foundRight = false;
            
            // Attack from both left and right to find the window
            for (int x = 0; x < config.captureWidth; x++) {
                
                // Left
                if (!foundLeft) {
                    color pixel = capture.pixels[x + y * config.captureWidth];
                    float R = red(pixel), G = green(pixel), B = blue(pixel);
                    
                    if (R <= 5 && G <= 5 && B <= 5) {
                        fill(0, 255, 0);
                        ellipse(x, y, 5, 5);
                        foundLeft = true;
                        points.add(new PVector(x, y));
                    }
                }
                
                // Right
                if (!foundRight) {
                    color pixel = capture.pixels[config.captureWidth - 1 - x + y * config.captureWidth];
                    float R = red(pixel), G = green(pixel), B = blue(pixel);
                    
                    if (R <= 5 && G <= 5 && B <= 5) {
                        fill(0, 0, 255);
                        ellipse(config.captureWidth - 1 - x, y, 5, 5);
                        foundRight = true;
                        points.add(new PVector(config.captureWidth - 1 - x, y));
                    }
                }
                
                if (foundLeft && foundRight)
                    x = config.captureWidth;
            } 
        }
        
        for (int x = 0; x < config.captureWidth; x++) {
            boolean foundTop, foundBottom;
            foundTop = false;
            foundBottom = false;
            
            // Attack from both left and right to find the window
            for (int y = 0; y < config.captureHeight; y++) {
                
                // Left
                if (!foundTop) {
                    color pixel = capture.pixels[x + y * config.captureWidth];
                    float R = red(pixel), G = green(pixel), B = blue(pixel);
                    
                    if (R <= 5 && G <= 5 && B <= 5) {
                        fill(0, 255, 255);
                        ellipse(x, y, 5, 5);
                        foundTop = true;
                        points.add(new PVector(x, y));
                    }
                }
                
                // Right
                if (!foundBottom) {
                    color pixel = capture.pixels[x + (config.captureHeight - 1 - y) * config.captureWidth];
                    float R = red(pixel), G = green(pixel), B = blue(pixel);
                    
                    if (R <= 5 && G <= 5 && B <= 5) {
                        fill(255, 0, 255);
                        ellipse(x, config.captureHeight - 1 - y, 5, 5);
                        foundBottom = true;
                        points.add(new PVector(x, config.captureHeight - 1 - y));
                    }
                }
                
                if (foundTop && foundBottom)
                    y = config.captureHeight;
            } 
        }
        
        PVector mid = new PVector(0, 0);
        for (int i = 0; i < points.size(); i++)
            mid.add(points.get(i));
            
        mid.div(points.size());
        
        noFill();
        stroke(255);
        ellipse(mid.x, mid.y, 60, 60);
    }
    
    void arrowDetection() {
        ArrayList<PVector> arrowPoints = new ArrayList<PVector>();
        
        noStroke();
        boolean[][] used = new boolean[config.captureWidth][config.captureHeight];
        for (int y = 5; y < config.captureHeight - 5; y+= 5) {
            for (int x = 5; x < config.captureWidth - 5; x+= 5) {
                if (used[x][y]) continue; // Ignore already checked cells
                if (y < config.captureHeight / 2) continue; // Ignore top area
                //if (Math.abs(x - config.captureWidth/2) < config.captureWidth/8) continue; // Ignore middle
                
                int i = config.captureWidth * y + x;
                color pixel = capture.pixels[i];
                float R = red(pixel), G = green(pixel), B = blue(pixel);
                float Min, Max;
                
                Min = min(R, G, B);
                Max = max(R, G, B);
                
                if (Min < 200) continue; // Ignore dark
                if (Max - Min > 5) continue; // Shade of white
                
                if (getAreaSize(x, y, used, 50) < 50) {
                    fill(R, G, 0);
                    ellipse(x, y, 5, 5);
                    arrowPoints.add(new PVector(x, y));
                    text("Notice me senpai", x, y);
                }
            }
        }
        
        PVector mid = new PVector(0, 0);
        for (PVector vec : arrowPoints)
            mid.add(vec);
        mid.div(arrowPoints.size());
        car.carAlignment = config.captureWidth/2 - mid.x;
    }
    
    boolean isSimilar(color main, color... others) {
        int variance = 5;
        for (color other : others) {
            float red = Math.abs(red(main) - red(other));
            float green = Math.abs(green(main) - green(other));
            float blue = Math.abs(blue(main) - blue(other));
            if (red > variance || green > variance || blue > variance)
                return false;
        }
        return true;
    }
    
    int getAreaSize(int x, int y, boolean[][] used, int limit) {
        if (limit < 0) return 0;
        used[x][y] = true;
        int count = 1;
        int i = config.captureWidth * y + x;
        color pixel = capture.pixels[i];
        
        if (x >= 5 && !used[x-5][y]) {
            color left = capture.pixels[config.captureWidth * y + (x-5)];
            if (isSimilar(pixel, left))
                count += getAreaSize(x-5, y, used, limit-count);
        }
        if (y >= 5 && !used[x][y-5]) {
            color up = capture.pixels[config.captureWidth * (y-5) + x];
            if (isSimilar(pixel, up))
                count += getAreaSize(x, y-5, used, limit-count);
        }
        if (x < config.captureWidth - 5 && !used[x+5][y]) {
            color right = capture.pixels[config.captureWidth * y + (x+5)];
            if (isSimilar(pixel, right))
                count += getAreaSize(x+5, y, used, limit-count);
        }
        if (y < config.captureHeight - 5 && !used[x][y+5]) {
            color down = capture.pixels[config.captureWidth * (y+5) + x];
            if (isSimilar(pixel, down))
                count += getAreaSize(x, y+5, used, limit-count);
        }
        return count;
    }
}