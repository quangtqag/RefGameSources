#pragma once

#include "il2cpp-config.h"

#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif

#include <stdint.h>

// UnityEngine.GameObject
struct GameObject_t4012695102;

#include "UnityEngine_UnityEngine_MonoBehaviour3012272455.h"

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif

// CameraFollow
struct  CameraFollow_t3148844886  : public MonoBehaviour_t3012272455
{
public:
	// UnityEngine.GameObject CameraFollow::targetObject
	GameObject_t4012695102 * ___targetObject_2;
	// System.Single CameraFollow::distanceToTarget
	float ___distanceToTarget_3;

public:
	inline static int32_t get_offset_of_targetObject_2() { return static_cast<int32_t>(offsetof(CameraFollow_t3148844886, ___targetObject_2)); }
	inline GameObject_t4012695102 * get_targetObject_2() const { return ___targetObject_2; }
	inline GameObject_t4012695102 ** get_address_of_targetObject_2() { return &___targetObject_2; }
	inline void set_targetObject_2(GameObject_t4012695102 * value)
	{
		___targetObject_2 = value;
		Il2CppCodeGenWriteBarrier(&___targetObject_2, value);
	}

	inline static int32_t get_offset_of_distanceToTarget_3() { return static_cast<int32_t>(offsetof(CameraFollow_t3148844886, ___distanceToTarget_3)); }
	inline float get_distanceToTarget_3() const { return ___distanceToTarget_3; }
	inline float* get_address_of_distanceToTarget_3() { return &___distanceToTarget_3; }
	inline void set_distanceToTarget_3(float value)
	{
		___distanceToTarget_3 = value;
	}
};

#ifdef __clang__
#pragma clang diagnostic pop
#endif
