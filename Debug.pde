
class Debug 
{
    
    Debug() {
        
    }
    
    void display() {
        fill(200, 100);
        rect(0, 0, 60, 30);
        
        fill(0);
        text("FPS: " + floor(frameRate), 8, 16);
    }
}
    