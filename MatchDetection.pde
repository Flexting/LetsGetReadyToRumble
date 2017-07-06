
class MatchDetection {
    
    MatchDetection() {
        findTeam();
    }
    
    void findTeam() {
        if (car.team != Team.UNKNOWN) return;
        
        int unknown = 0, blue = 0, orange = 0;
        
        for (int x = config.captureWidth/4; x <= config.captureWidth/3; x+=10) {
            for (int y = 10; y <= 80; y+=10)  {
                
                int i = config.captureWidth * y + x;
                color pixel = capture.pixels[i];
                float R = red(pixel), G = green(pixel), B = blue(pixel);
                
                stroke(255,0,0);
                fill(R, G, B);
                ellipse(x, y, 5, 5);
                
                if (R>200 && G<200 && G>100 && B<100)
                    orange++;
                
                else if (R<100 && G<150 && G>50 && B>200)
                    blue++;
                    
                else
                    unknown++;
            }
        }
        
        int max = max(unknown, blue, orange);
        if (max == blue) car.team = Team.BLUE;
        if (max == orange) car.team = Team.ORANGE;
    }
}