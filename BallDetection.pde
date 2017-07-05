
class BallDetection {

    BallDetection() {
      
    }
    
    void longRangeBallDetection() {
        ArrayList<PVector> points = new ArrayList<PVector>();
        PVector mid = new PVector(0, 0);
        
        stroke(255);
        
        for (int x = 0; x < width; x += 40)
            line(x, 0, x, height);
        for (int y = 0; y < height; y += 40)
            line(0, y, width, y);
        
        int interval = 2;
        
        
        
        for (int y = 0; y < config.captureHeight; y += interval) {
            for (int x = 0; x < config.captureWidth; x += interval) {
                color pixel = capture.pixels[x + y * config.captureWidth];
                float R = red(pixel), G = green(pixel), B = blue(pixel);
                
                PVector current, center;
                center = new PVector(width/2, height/2);
                current = new PVector(floor(x/40.0)*40, floor(y/40.0)*40);
                
                if (PVector.dist(current, center) < 100) {
                    if (R > 250 && G > 250 && B > 250) {
                        noStroke();
                        fill(R, 0, 0);
                        ellipse(x, y, 5, 5);
                        points.add(current);
                        mid.add(current);
                    }
                }
            }
        }
        
        mid.div(points.size());
        noFill();
        stroke(255, 0, 0);
        ellipse(mid.x + 20, mid.y + 20, 30, 30);
        
    }
   
}