using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CarMotorController : MonoBehaviour {
    public float max_speed = 100;
    public float acceleration = 10;
    public float turn_force = 2;

    private Rigidbody2D rb2d;
    public Vector2 velocity;

    private void Start() {
        rb2d = GetComponent<Rigidbody2D>();
    }

    private void FixedUpdate() {
        var accel = Input.GetAxis("Vertical");
        var turn = Input.GetAxis("Horizontal");
        if(rb2d.velocity.y < max_speed)
            rb2d.AddForce(transform.up * accel * acceleration);

        rb2d.AddTorque(turn * turn_force);
        velocity = rb2d.velocity;
    }
}
