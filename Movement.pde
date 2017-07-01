import java.awt.Robot;
import java.awt.event.KeyEvent;

enum Acceleration {
    NONE(-1),
    FORWARD(KeyEvent.VK_W),
    BACKWARD(KeyEvent.VK_S);
    
    private int val;
    private Acceleration(int val) {
        this.val = val;
    }
    
    int val() {
        return val;
    }
}

enum Direction {
    NONE(-1),
    LEFT(KeyEvent.VK_A),
    RIGHT(KeyEvent.VK_D);
    
    private int val;
    private Direction(int val) {
        this.val = val;
    }
    
    int val() {
        return val;
    }
}

class Movement {  
    int interval = 0, intervalMod = 5, safeDriveAngle = 10;
    Acceleration acceleration;
    Direction direction;

    Movement() {
        acceleration = Acceleration.NONE;
        direction = Direction.NONE;
    }

    void drive(float direction) {

        if (interval < intervalMod) {
            if (direction > -50 && direction < 50) {
                setAcceleration(Acceleration.FORWARD);

                if (direction > safeDriveAngle) 
                    setDirection(Direction.LEFT);
                else if (direction < -safeDriveAngle) 
                    setDirection(Direction.RIGHT);
                else
                    setDirection(Direction.NONE);
                    
            } else {
                setAcceleration(Acceleration.NONE);
            }
        }
        interval %= intervalMod*2;
    }

    void setDirection(Direction dir) {
        if (direction == dir)
            return;
        
        release(direction.val());
        press(dir.val());
        direction = dir;
    }
    
    void setAcceleration(Acceleration acc) {
        if (acceleration == acc)
            return;
        
        release(acceleration.val());
        press(acc.val());
        acceleration = acc;
    }
    
    void press(int key) {
        if (key < 0) return;
        try {
            Robot robot = new Robot();
            robot.keyPress(key);
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    void release(int key) {
        if (key < 0) return;
        try {
            Robot robot = new Robot();
            robot.keyRelease(key);
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}