#pragma once

#include "il2cpp-config.h"

#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif

#include <stdint.h>

// UnityEngine.Transform
struct Transform_t284553113;
// UnityEngine.Animator
struct Animator_t792326996;
// UnityEngine.ParticleSystem
struct ParticleSystem_t56787138;
// UnityEngine.Texture2D
struct Texture2D_t2509538522;
// UnityEngine.AudioClip
struct AudioClip_t3714538611;
// UnityEngine.AudioSource
struct AudioSource_t3628549054;
// ParallaxScroll
struct ParallaxScroll_t605749092;

#include "UnityEngine_UnityEngine_MonoBehaviour3012272455.h"
#include "UnityEngine_UnityEngine_LayerMask1862190090.h"

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif

// MouseController
struct  MouseController_t3353569793  : public MonoBehaviour_t3012272455
{
public:
	// System.Single MouseController::jetpackForce
	float ___jetpackForce_2;
	// System.Single MouseController::forwardMovementSpeed
	float ___forwardMovementSpeed_3;
	// UnityEngine.Transform MouseController::groundCheckTransform
	Transform_t284553113 * ___groundCheckTransform_4;
	// System.Boolean MouseController::grounded
	bool ___grounded_5;
	// UnityEngine.LayerMask MouseController::groundCheckLayerMask
	LayerMask_t1862190090  ___groundCheckLayerMask_6;
	// UnityEngine.Animator MouseController::animator
	Animator_t792326996 * ___animator_7;
	// UnityEngine.ParticleSystem MouseController::jetpack
	ParticleSystem_t56787138 * ___jetpack_8;
	// System.Boolean MouseController::dead
	bool ___dead_9;
	// System.UInt32 MouseController::coins
	uint32_t ___coins_10;
	// UnityEngine.Texture2D MouseController::coinIconTexture
	Texture2D_t2509538522 * ___coinIconTexture_11;
	// UnityEngine.AudioClip MouseController::coinCollectSound
	AudioClip_t3714538611 * ___coinCollectSound_12;
	// UnityEngine.AudioSource MouseController::jetpackAudio
	AudioSource_t3628549054 * ___jetpackAudio_13;
	// UnityEngine.AudioSource MouseController::footstepsAudio
	AudioSource_t3628549054 * ___footstepsAudio_14;
	// ParallaxScroll MouseController::parallax
	ParallaxScroll_t605749092 * ___parallax_15;

public:
	inline static int32_t get_offset_of_jetpackForce_2() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___jetpackForce_2)); }
	inline float get_jetpackForce_2() const { return ___jetpackForce_2; }
	inline float* get_address_of_jetpackForce_2() { return &___jetpackForce_2; }
	inline void set_jetpackForce_2(float value)
	{
		___jetpackForce_2 = value;
	}

	inline static int32_t get_offset_of_forwardMovementSpeed_3() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___forwardMovementSpeed_3)); }
	inline float get_forwardMovementSpeed_3() const { return ___forwardMovementSpeed_3; }
	inline float* get_address_of_forwardMovementSpeed_3() { return &___forwardMovementSpeed_3; }
	inline void set_forwardMovementSpeed_3(float value)
	{
		___forwardMovementSpeed_3 = value;
	}

	inline static int32_t get_offset_of_groundCheckTransform_4() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___groundCheckTransform_4)); }
	inline Transform_t284553113 * get_groundCheckTransform_4() const { return ___groundCheckTransform_4; }
	inline Transform_t284553113 ** get_address_of_groundCheckTransform_4() { return &___groundCheckTransform_4; }
	inline void set_groundCheckTransform_4(Transform_t284553113 * value)
	{
		___groundCheckTransform_4 = value;
		Il2CppCodeGenWriteBarrier(&___groundCheckTransform_4, value);
	}

	inline static int32_t get_offset_of_grounded_5() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___grounded_5)); }
	inline bool get_grounded_5() const { return ___grounded_5; }
	inline bool* get_address_of_grounded_5() { return &___grounded_5; }
	inline void set_grounded_5(bool value)
	{
		___grounded_5 = value;
	}

	inline static int32_t get_offset_of_groundCheckLayerMask_6() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___groundCheckLayerMask_6)); }
	inline LayerMask_t1862190090  get_groundCheckLayerMask_6() const { return ___groundCheckLayerMask_6; }
	inline LayerMask_t1862190090 * get_address_of_groundCheckLayerMask_6() { return &___groundCheckLayerMask_6; }
	inline void set_groundCheckLayerMask_6(LayerMask_t1862190090  value)
	{
		___groundCheckLayerMask_6 = value;
	}

	inline static int32_t get_offset_of_animator_7() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___animator_7)); }
	inline Animator_t792326996 * get_animator_7() const { return ___animator_7; }
	inline Animator_t792326996 ** get_address_of_animator_7() { return &___animator_7; }
	inline void set_animator_7(Animator_t792326996 * value)
	{
		___animator_7 = value;
		Il2CppCodeGenWriteBarrier(&___animator_7, value);
	}

	inline static int32_t get_offset_of_jetpack_8() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___jetpack_8)); }
	inline ParticleSystem_t56787138 * get_jetpack_8() const { return ___jetpack_8; }
	inline ParticleSystem_t56787138 ** get_address_of_jetpack_8() { return &___jetpack_8; }
	inline void set_jetpack_8(ParticleSystem_t56787138 * value)
	{
		___jetpack_8 = value;
		Il2CppCodeGenWriteBarrier(&___jetpack_8, value);
	}

	inline static int32_t get_offset_of_dead_9() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___dead_9)); }
	inline bool get_dead_9() const { return ___dead_9; }
	inline bool* get_address_of_dead_9() { return &___dead_9; }
	inline void set_dead_9(bool value)
	{
		___dead_9 = value;
	}

	inline static int32_t get_offset_of_coins_10() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___coins_10)); }
	inline uint32_t get_coins_10() const { return ___coins_10; }
	inline uint32_t* get_address_of_coins_10() { return &___coins_10; }
	inline void set_coins_10(uint32_t value)
	{
		___coins_10 = value;
	}

	inline static int32_t get_offset_of_coinIconTexture_11() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___coinIconTexture_11)); }
	inline Texture2D_t2509538522 * get_coinIconTexture_11() const { return ___coinIconTexture_11; }
	inline Texture2D_t2509538522 ** get_address_of_coinIconTexture_11() { return &___coinIconTexture_11; }
	inline void set_coinIconTexture_11(Texture2D_t2509538522 * value)
	{
		___coinIconTexture_11 = value;
		Il2CppCodeGenWriteBarrier(&___coinIconTexture_11, value);
	}

	inline static int32_t get_offset_of_coinCollectSound_12() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___coinCollectSound_12)); }
	inline AudioClip_t3714538611 * get_coinCollectSound_12() const { return ___coinCollectSound_12; }
	inline AudioClip_t3714538611 ** get_address_of_coinCollectSound_12() { return &___coinCollectSound_12; }
	inline void set_coinCollectSound_12(AudioClip_t3714538611 * value)
	{
		___coinCollectSound_12 = value;
		Il2CppCodeGenWriteBarrier(&___coinCollectSound_12, value);
	}

	inline static int32_t get_offset_of_jetpackAudio_13() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___jetpackAudio_13)); }
	inline AudioSource_t3628549054 * get_jetpackAudio_13() const { return ___jetpackAudio_13; }
	inline AudioSource_t3628549054 ** get_address_of_jetpackAudio_13() { return &___jetpackAudio_13; }
	inline void set_jetpackAudio_13(AudioSource_t3628549054 * value)
	{
		___jetpackAudio_13 = value;
		Il2CppCodeGenWriteBarrier(&___jetpackAudio_13, value);
	}

	inline static int32_t get_offset_of_footstepsAudio_14() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___footstepsAudio_14)); }
	inline AudioSource_t3628549054 * get_footstepsAudio_14() const { return ___footstepsAudio_14; }
	inline AudioSource_t3628549054 ** get_address_of_footstepsAudio_14() { return &___footstepsAudio_14; }
	inline void set_footstepsAudio_14(AudioSource_t3628549054 * value)
	{
		___footstepsAudio_14 = value;
		Il2CppCodeGenWriteBarrier(&___footstepsAudio_14, value);
	}

	inline static int32_t get_offset_of_parallax_15() { return static_cast<int32_t>(offsetof(MouseController_t3353569793, ___parallax_15)); }
	inline ParallaxScroll_t605749092 * get_parallax_15() const { return ___parallax_15; }
	inline ParallaxScroll_t605749092 ** get_address_of_parallax_15() { return &___parallax_15; }
	inline void set_parallax_15(ParallaxScroll_t605749092 * value)
	{
		___parallax_15 = value;
		Il2CppCodeGenWriteBarrier(&___parallax_15, value);
	}
};

#ifdef __clang__
#pragma clang diagnostic pop
#endif
