
class Debug 
{
    
    Debug() {
        
    }
    
    void display() {
        int y = 0;
        fill(200, 100);
        rect(0, 0, 120, 60);
        
        fill(0);
        y += 16;
        text("FPS: " + floor(frameRate), 8, y);
        y += 16;
        text("Car Alignment: " + floor(car.carAlignment), 8, y);
    }
}
    