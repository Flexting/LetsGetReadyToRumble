class Car {

    Movement movement;
    boolean autonomous;
  
    Car() {
        movement = new Movement();
        autonomous = true;
    }
    
    void toggleAutonomous() {
        autonomous = !autonomous;
    }
    
    void setAutonomous(boolean auto) {
        autonomous = auto;
    }
  
}