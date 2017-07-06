
enum Team {
    UNKNOWN, BLUE, ORANGE   
}

class Car {

    Movement movement;
    Team team;
    boolean autonomous;
    
    float carAlignment = 0;
  
    Car() {
        movement = new Movement();
        team = Team.UNKNOWN;
        autonomous = false;
    }
    
    void toggleAutonomous() {
        autonomous = !autonomous;
        println("Toggled autonomous, now: " + autonomous);
    }
    
    void setAutonomous(boolean auto) {
        autonomous = auto;
    }
  
    void drive() {
        if (autonomous)
            movement.drive(carAlignment);
    }
}