using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour {
    public Rigidbody2D target;
    
	void LateUpdate () {
        var pos = transform.position;
        pos.y = target.position.y;
        transform.position = pos;
	}
}
