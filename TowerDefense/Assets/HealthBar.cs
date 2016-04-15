using UnityEngine;
using System.Collections;

public class HealthBar : MonoBehaviour {

	public float maxHealth = 100;
	public float currentHealth = 100;
	private float originalScale;

	// Use this for initialization
	void Start () {
		originalScale = gameObject.transform.localScale.x;	
	}
	
	// Update is called once per frame
	void Update () {
		Vector3 tmpScale = gameObject.transform.localScale;
		tmpScale.x = currentHealth / maxHealth * originalScale;
		gameObject.transform.localScale = tmpScale;	
	}
}
