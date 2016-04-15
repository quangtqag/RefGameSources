#pragma once

#include "il2cpp-config.h"

#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif

#include <stdint.h>

// UnityEngine.Sprite
struct Sprite_t4006040370;

#include "UnityEngine_UnityEngine_MonoBehaviour3012272455.h"

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif

// LaserScript
struct  LaserScript_t2082381654  : public MonoBehaviour_t3012272455
{
public:
	// UnityEngine.Sprite LaserScript::laserOnSprite
	Sprite_t4006040370 * ___laserOnSprite_2;
	// UnityEngine.Sprite LaserScript::laserOffSprite
	Sprite_t4006040370 * ___laserOffSprite_3;
	// System.Single LaserScript::interval
	float ___interval_4;
	// System.Single LaserScript::rotationSpeed
	float ___rotationSpeed_5;
	// System.Boolean LaserScript::isLaserOn
	bool ___isLaserOn_6;
	// System.Single LaserScript::timeUntilNextToggle
	float ___timeUntilNextToggle_7;

public:
	inline static int32_t get_offset_of_laserOnSprite_2() { return static_cast<int32_t>(offsetof(LaserScript_t2082381654, ___laserOnSprite_2)); }
	inline Sprite_t4006040370 * get_laserOnSprite_2() const { return ___laserOnSprite_2; }
	inline Sprite_t4006040370 ** get_address_of_laserOnSprite_2() { return &___laserOnSprite_2; }
	inline void set_laserOnSprite_2(Sprite_t4006040370 * value)
	{
		___laserOnSprite_2 = value;
		Il2CppCodeGenWriteBarrier(&___laserOnSprite_2, value);
	}

	inline static int32_t get_offset_of_laserOffSprite_3() { return static_cast<int32_t>(offsetof(LaserScript_t2082381654, ___laserOffSprite_3)); }
	inline Sprite_t4006040370 * get_laserOffSprite_3() const { return ___laserOffSprite_3; }
	inline Sprite_t4006040370 ** get_address_of_laserOffSprite_3() { return &___laserOffSprite_3; }
	inline void set_laserOffSprite_3(Sprite_t4006040370 * value)
	{
		___laserOffSprite_3 = value;
		Il2CppCodeGenWriteBarrier(&___laserOffSprite_3, value);
	}

	inline static int32_t get_offset_of_interval_4() { return static_cast<int32_t>(offsetof(LaserScript_t2082381654, ___interval_4)); }
	inline float get_interval_4() const { return ___interval_4; }
	inline float* get_address_of_interval_4() { return &___interval_4; }
	inline void set_interval_4(float value)
	{
		___interval_4 = value;
	}

	inline static int32_t get_offset_of_rotationSpeed_5() { return static_cast<int32_t>(offsetof(LaserScript_t2082381654, ___rotationSpeed_5)); }
	inline float get_rotationSpeed_5() const { return ___rotationSpeed_5; }
	inline float* get_address_of_rotationSpeed_5() { return &___rotationSpeed_5; }
	inline void set_rotationSpeed_5(float value)
	{
		___rotationSpeed_5 = value;
	}

	inline static int32_t get_offset_of_isLaserOn_6() { return static_cast<int32_t>(offsetof(LaserScript_t2082381654, ___isLaserOn_6)); }
	inline bool get_isLaserOn_6() const { return ___isLaserOn_6; }
	inline bool* get_address_of_isLaserOn_6() { return &___isLaserOn_6; }
	inline void set_isLaserOn_6(bool value)
	{
		___isLaserOn_6 = value;
	}

	inline static int32_t get_offset_of_timeUntilNextToggle_7() { return static_cast<int32_t>(offsetof(LaserScript_t2082381654, ___timeUntilNextToggle_7)); }
	inline float get_timeUntilNextToggle_7() const { return ___timeUntilNextToggle_7; }
	inline float* get_address_of_timeUntilNextToggle_7() { return &___timeUntilNextToggle_7; }
	inline void set_timeUntilNextToggle_7(float value)
	{
		___timeUntilNextToggle_7 = value;
	}
};

#ifdef __clang__
#pragma clang diagnostic pop
#endif
