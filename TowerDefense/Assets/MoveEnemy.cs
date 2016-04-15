using UnityEngine;
using System.Collections;

public class MoveEnemy : MonoBehaviour {
	[HideInInspector]
	public GameObject[] waypoints;
	private int currentWaypoint = 0;
	private float lastWaypointSwitchTime;
	public float speed = 1.0f;

	// Use this for initialization
	void Start () {
		lastWaypointSwitchTime = Time.time;
	}
	
	// Update is called once per frame
	void Update () {
		// 1 
		Vector3 startPosition = waypoints [currentWaypoint].transform.position;
		Vector3 endPosition = waypoints [currentWaypoint + 1].transform.position;
		// 2 
		float pathLength = Vector3.Distance (startPosition, endPosition);
		float totalTimeForPath = pathLength / speed;
		float currentTimeOnPath = Time.time - lastWaypointSwitchTime;
		gameObject.transform.position = Vector3.Lerp (startPosition, endPosition, currentTimeOnPath / totalTimeForPath);
		// 3 
		if (gameObject.transform.position.Equals(endPosition)) {
			if (currentWaypoint < waypoints.Length - 2) {
				// 4 Switch to next waypoint
				currentWaypoint++;
				lastWaypointSwitchTime = Time.time;
			
				RotateIntoMoveDirection();
			} else {
				// 5 Destroy enemy
				Destroy(gameObject);
 
				AudioSource audioSource = gameObject.GetComponent<AudioSource>();
				AudioSource.PlayClipAtPoint(audioSource.clip, transform.position);

				GameManagerBehavior gameManager =
					GameObject.Find("GameManager").GetComponent<GameManagerBehavior>();
				gameManager.Health -= 1;
			}
		}
	}

	private void RotateIntoMoveDirection() {
		//1
		Vector3 newStartPosition = waypoints [currentWaypoint].transform.position;
		Vector3 newEndPosition = waypoints [currentWaypoint + 1].transform.position;
		Vector3 newDirection = (newEndPosition - newStartPosition);
		//2
		float x = newDirection.x;
		float y = newDirection.y;
		float rotationAngle = Mathf.Atan2 (y, x) * 180 / Mathf.PI;
		//3
		GameObject sprite = (GameObject)
			gameObject.transform.FindChild("Sprite").gameObject;
		sprite.transform.rotation = 
			Quaternion.AngleAxis(rotationAngle, Vector3.forward);
	}

	public float distanceToGoal() {
		float distance = 0;
		distance += Vector3.Distance(
			gameObject.transform.position, 
			waypoints [currentWaypoint + 1].transform.position);
		for (int i = currentWaypoint + 1; i < waypoints.Length - 1; i++) {
			Vector3 startPosition = waypoints [i].transform.position;
			Vector3 endPosition = waypoints [i + 1].transform.position;
			distance += Vector3.Distance(startPosition, endPosition);
		}
		return distance;
	}
}
