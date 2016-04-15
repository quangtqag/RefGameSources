struct ClassRegistrationContext;
void InvokeRegisterStaticallyLinkedModuleClasses(ClassRegistrationContext& context)
{
	// Do nothing (we're in stripping mode)
}

void RegisterStaticallyLinkedModulesGranular()
{
	void RegisterModule_Animation();
	RegisterModule_Animation();

	void RegisterModule_Audio();
	RegisterModule_Audio();

	void RegisterModule_ParticleSystem();
	RegisterModule_ParticleSystem();

	void RegisterModule_Physics();
	RegisterModule_Physics();

	void RegisterModule_Physics2D();
	RegisterModule_Physics2D();

	void RegisterModule_TextRendering();
	RegisterModule_TextRendering();

	void RegisterModule_IMGUI();
	RegisterModule_IMGUI();

}

void RegisterAllClasses()
{
	//Total: 70 classes
	//0. Renderer
	void RegisterClass_Renderer();
	RegisterClass_Renderer();

	//1. Component
	void RegisterClass_Component();
	RegisterClass_Component();

	//2. EditorExtension
	void RegisterClass_EditorExtension();
	RegisterClass_EditorExtension();

	//3. GUILayer
	void RegisterClass_GUILayer();
	RegisterClass_GUILayer();

	//4. Behaviour
	void RegisterClass_Behaviour();
	RegisterClass_Behaviour();

	//5. Texture
	void RegisterClass_Texture();
	RegisterClass_Texture();

	//6. NamedObject
	void RegisterClass_NamedObject();
	RegisterClass_NamedObject();

	//7. Texture2D
	void RegisterClass_Texture2D();
	RegisterClass_Texture2D();

	//8. RenderTexture
	void RegisterClass_RenderTexture();
	RegisterClass_RenderTexture();

	//9. NetworkView
	void RegisterClass_NetworkView();
	RegisterClass_NetworkView();

	//10. RectTransform
	void RegisterClass_RectTransform();
	RegisterClass_RectTransform();

	//11. Transform
	void RegisterClass_Transform();
	RegisterClass_Transform();

	//12. Material
	void RegisterClass_Material();
	RegisterClass_Material();

	//13. SpriteRenderer
	void RegisterClass_SpriteRenderer();
	RegisterClass_SpriteRenderer();

	//14. Camera
	void RegisterClass_Camera();
	RegisterClass_Camera();

	//15. MonoBehaviour
	void RegisterClass_MonoBehaviour();
	RegisterClass_MonoBehaviour();

	//16. GameObject
	void RegisterClass_GameObject();
	RegisterClass_GameObject();

	//17. ParticleSystem
	void RegisterClass_ParticleSystem();
	RegisterClass_ParticleSystem();

	//18. Collider
	void RegisterClass_Collider();
	RegisterClass_Collider();

	//19. Rigidbody2D
	void RegisterClass_Rigidbody2D();
	RegisterClass_Rigidbody2D();

	//20. AudioClip
	void RegisterClass_AudioClip();
	RegisterClass_AudioClip();

	//21. SampleClip
	void RegisterClass_SampleClip();
	RegisterClass_SampleClip();

	//22. AudioSource
	void RegisterClass_AudioSource();
	RegisterClass_AudioSource();

	//23. AudioBehaviour
	void RegisterClass_AudioBehaviour();
	RegisterClass_AudioBehaviour();

	//24. Animator
	void RegisterClass_Animator();
	RegisterClass_Animator();

	//25. DirectorPlayer
	void RegisterClass_DirectorPlayer();
	RegisterClass_DirectorPlayer();

	//26. Font
	void RegisterClass_Font();
	RegisterClass_Font();

	//27. Sprite
	void RegisterClass_Sprite();
	RegisterClass_Sprite();

	//28. Collider2D
	void RegisterClass_Collider2D();
	RegisterClass_Collider2D();

	//29. PreloadData
	void RegisterClass_PreloadData();
	RegisterClass_PreloadData();

	//30. Cubemap
	void RegisterClass_Cubemap();
	RegisterClass_Cubemap();

	//31. Texture3D
	void RegisterClass_Texture3D();
	RegisterClass_Texture3D();

	//32. Mesh
	void RegisterClass_Mesh();
	RegisterClass_Mesh();

	//33. LevelGameManager
	void RegisterClass_LevelGameManager();
	RegisterClass_LevelGameManager();

	//34. GameManager
	void RegisterClass_GameManager();
	RegisterClass_GameManager();

	//35. TimeManager
	void RegisterClass_TimeManager();
	RegisterClass_TimeManager();

	//36. GlobalGameManager
	void RegisterClass_GlobalGameManager();
	RegisterClass_GlobalGameManager();

	//37. AudioManager
	void RegisterClass_AudioManager();
	RegisterClass_AudioManager();

	//38. InputManager
	void RegisterClass_InputManager();
	RegisterClass_InputManager();

	//39. Physics2DSettings
	void RegisterClass_Physics2DSettings();
	RegisterClass_Physics2DSettings();

	//40. MeshRenderer
	void RegisterClass_MeshRenderer();
	RegisterClass_MeshRenderer();

	//41. GraphicsSettings
	void RegisterClass_GraphicsSettings();
	RegisterClass_GraphicsSettings();

	//42. MeshFilter
	void RegisterClass_MeshFilter();
	RegisterClass_MeshFilter();

	//43. QualitySettings
	void RegisterClass_QualitySettings();
	RegisterClass_QualitySettings();

	//44. Shader
	void RegisterClass_Shader();
	RegisterClass_Shader();

	//45. TextAsset
	void RegisterClass_TextAsset();
	RegisterClass_TextAsset();

	//46. PhysicsManager
	void RegisterClass_PhysicsManager();
	RegisterClass_PhysicsManager();

	//47. CircleCollider2D
	void RegisterClass_CircleCollider2D();
	RegisterClass_CircleCollider2D();

	//48. BoxCollider2D
	void RegisterClass_BoxCollider2D();
	RegisterClass_BoxCollider2D();

	//49. MeshCollider
	void RegisterClass_MeshCollider();
	RegisterClass_MeshCollider();

	//50. AnimationClip
	void RegisterClass_AnimationClip();
	RegisterClass_AnimationClip();

	//51. Motion
	void RegisterClass_Motion();
	RegisterClass_Motion();

	//52. TagManager
	void RegisterClass_TagManager();
	RegisterClass_TagManager();

	//53. AudioListener
	void RegisterClass_AudioListener();
	RegisterClass_AudioListener();

	//54. AnimatorController
	void RegisterClass_AnimatorController();
	RegisterClass_AnimatorController();

	//55. RuntimeAnimatorController
	void RegisterClass_RuntimeAnimatorController();
	RegisterClass_RuntimeAnimatorController();

	//56. ScriptMapper
	void RegisterClass_ScriptMapper();
	RegisterClass_ScriptMapper();

	//57. DelayedCallManager
	void RegisterClass_DelayedCallManager();
	RegisterClass_DelayedCallManager();

	//58. RenderSettings
	void RegisterClass_RenderSettings();
	RegisterClass_RenderSettings();

	//59. MonoScript
	void RegisterClass_MonoScript();
	RegisterClass_MonoScript();

	//60. MonoManager
	void RegisterClass_MonoManager();
	RegisterClass_MonoManager();

	//61. FlareLayer
	void RegisterClass_FlareLayer();
	RegisterClass_FlareLayer();

	//62. PlayerSettings
	void RegisterClass_PlayerSettings();
	RegisterClass_PlayerSettings();

	//63. BuildSettings
	void RegisterClass_BuildSettings();
	RegisterClass_BuildSettings();

	//64. ResourceManager
	void RegisterClass_ResourceManager();
	RegisterClass_ResourceManager();

	//65. NetworkManager
	void RegisterClass_NetworkManager();
	RegisterClass_NetworkManager();

	//66. MasterServerInterface
	void RegisterClass_MasterServerInterface();
	RegisterClass_MasterServerInterface();

	//67. LightmapSettings
	void RegisterClass_LightmapSettings();
	RegisterClass_LightmapSettings();

	//68. ParticleSystemRenderer
	void RegisterClass_ParticleSystemRenderer();
	RegisterClass_ParticleSystemRenderer();

	//69. RuntimeInitializeOnLoadManager
	void RegisterClass_RuntimeInitializeOnLoadManager();
	RegisterClass_RuntimeInitializeOnLoadManager();

}
