
class BallDetection {
    PVector lastLocation;
    
    BallDetection() {
        lastLocation = new PVector(config.captureWidth/2, config.captureHeight/2);
    }
    
    void longRangeBallDetection() {
        ArrayList<PVector> points = new ArrayList<PVector>();
        PVector mid = new PVector(0, 0);
        int regionW, regionH;
        
        regionW = 200;
        regionH = 400;
        
        stroke(255, 100);
        /*
        for (int x = 0; x < width; x += 40)
            line(x, 0, x, height);
        for (int y = 0; y < height; y += 40)
            line(0, y, width, y);
            */
        noFill();
        //rect(lastLocation.x - regionW/2, lastLocation.y - regionH/2, regionW, regionH);
        
        
        int interval = 2;
        for (int y = -regionH/2; y < regionH/22; y += interval) {
            for (int x = -regionW/2; x < regionW/2; x += interval) {
                PVector current;
                current = new PVector(lastLocation.x + x, lastLocation.y + y);
                
                if (current.x >= 0 && current.x < config.captureWidth && current.y >= 0 && current.y < config.captureHeight) {
                    color pixel, pLeft, pRight;
                    float R, G, B, RR, GR, BR;
                    
                    pLeft = capture.pixels[floor(current.x - interval) + floor(current.y) * config.captureWidth];
                    pixel = capture.pixels[floor(current.x) + floor(current.y) * config.captureWidth];
                    pRight = capture.pixels[floor(current.x + interval) + floor(current.y) * config.captureWidth];
                    
                    R = red(pixel); G = green(pixel); B = blue(pixel);
                    RR = red(pRight); GR = green(pRight); BR = blue(pRight);
                    
                    if (R > 250 && G > 250 && B > 250 && !(hue(pRight) > 150 && hue(pRight) <= 165 || hue(pRight) < 25 || hue(pRight) == 0 && brightness(pRight) > 240)) {
                        noStroke();
                        fill(R, 0, 0);
                        ellipse(current.x, current.y, 5, 5);
                        points.add(current);
                        mid.add(current);
                    }
                }
            }
        }
        
        mid.div(points.size());
        noFill();
        stroke(255, 0, 0);
        ellipse(mid.x, mid.y, 30, 30);
        
        //lastLocation = mid;
    }
   
}