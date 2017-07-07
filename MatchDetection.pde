
class MatchDetection {
    
    long scorebarNextUpdate = 0;
    int scorebarTop = -1;
    int scorebarBottom = -1;
    
    MatchDetection() {
    }
    
    boolean findScoreBar() {
        // Find top and bottom of the scorecard
        int top = -1, bottom = -1;
        int x = config.captureWidth/2;
        for (int y = 0; y < config.captureHeight/8; y += 5) {
            int i = config.captureWidth * y + x;
            color pixel = capture.pixels[i];
            float R = red(pixel), G = green(pixel), B = blue(pixel), S = saturation(pixel), V = brightness(pixel);
            
            if (top < 0) {
                if (y > 50) break; // Top too low, scorebar not present
                if (V < 40) {
                    top = y;
                    y += 45; // Jump down 50px
                }
            }
            else if(V > 50 && V < 250 && S > 60) {
                bottom = y;
                break;
            }
        }
        
        // Don't set if values don't make sense
        if (top < 0 || bottom < top) return false;
        
        scorebarTop = top;
        scorebarBottom = bottom;
        scorebarNextUpdate = System.currentTimeMillis() + 1000;
        return true;
    }
    
    void findTeam() {
        //if (car.team != Team.UNKNOWN) return;
        
        boolean update = System.currentTimeMillis() > scorebarNextUpdate;
        if (scorebarTop < 0 || scorebarBottom < scorebarTop || update)
            if (!findScoreBar())
                return;
			
        // Debug line for box height
        stroke(255, 0, 0);
        noFill();
        line(config.captureWidth/2, scorebarTop, config.captureWidth/2, scorebarBottom);
        text(scorebarTop + " - " + scorebarBottom, config.captureWidth/2, scorebarBottom);
        
        int y = (scorebarTop+scorebarBottom)/2;
        Team team = Team.UNKNOWN;
        int count = 0;
        for (int x = config.captureWidth/5*2; x > 50; x -= 5) {
            int i = config.captureWidth * y + x;
            color pixel = capture.pixels[i];
            
            stroke(255,0,0);
            ellipse(x, y, 5, 5);
            
            Team current = getPixelTeam(pixel);
            if (current == Team.UNKNOWN) continue;
            
            if (team == current) {
                if (++count == 5) break;
            } else {
                team = current;
                count = 0;
            }
        }
        
        car.team = team;
    }
}

Team getPixelTeam(color pixel) {
    float H = hue(pixel), V = brightness(pixel);
    if (V > 150) {
        if (H > 10 && H < 20)
            return Team.ORANGE;
        if (H > 155 && H < 165)
            return Team.BLUE;
    }
        
    return Team.UNKNOWN;
}