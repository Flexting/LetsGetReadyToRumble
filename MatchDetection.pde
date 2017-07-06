
class MatchDetection {
    
    int scorebarTop, scorebarBottom;
    
    MatchDetection() {
        scorebarTop = -1;
        scorebarBottom = -1;
    }
    
    boolean findScoreBar() {
        // Find top and bottom of the scorecard
        int top = -1, bottom = -1;
        int x = config.captureWidth/2;
        for (int y = 0; y < config.captureHeight/8; y += 5) {
            int i = config.captureWidth * y + x;
            color pixel = capture.pixels[i];
            float B = brightness(pixel), S = saturation(pixel);
            
            if (top < 0) {
                if (B < 40) {
                    top = y;
                }
                continue;
            }
            else if(B > 50 && B < 250 && S > 50) {
                bottom = y;
                break;
            }
        }
        
        // Don't set if values don't make sense
        if (top < 0 || bottom < top) return false;
        
        // Debug line for box height
        stroke(255, 0, 0);
        noFill();
        line(x, top, x, bottom);
        
        scorebarTop = top;
        scorebarBottom = bottom;
        return true;
    }
    
    void findTeam() {
        //if (car.team != Team.UNKNOWN) return;
        
        if (scorebarTop < 0 || scorebarBottom < scorebarTop)
            if (!findScoreBar())
                return;
        
        int y = (scorebarTop+scorebarBottom)/2;
        Team team = Team.UNKNOWN;
        int inSuccession = 0;
        for (int x = config.captureWidth/5*2; x > 50; x -= 5) {
            int i = config.captureWidth * y + x;
            color pixel = capture.pixels[i];
            float R = red(pixel), G = green(pixel), B = blue(pixel), H = hue(pixel), V = brightness(pixel);
            
            stroke(255,0,0);
            fill(R, G, B);
            ellipse(x, y, 5, 5);
            
            Team current = getPixelTeam(H, V);
            if (current != Team.UNKNOWN && team == current) {
                if (++inSuccession == 5) break;
            } else {
                team = current;
                inSuccession = 0;
            }
        }
        
        car.team = team;
    }
}

Team getPixelTeam(float H, float V) {
    if (V > 150 && H > 10 && H < 20)
        return Team.ORANGE;
    else if (V > 150 & H > 155 && H < 165)
        return Team.BLUE;
    else
        return Team.UNKNOWN;
}