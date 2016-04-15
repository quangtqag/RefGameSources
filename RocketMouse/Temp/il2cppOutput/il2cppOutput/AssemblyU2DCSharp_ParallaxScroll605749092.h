#pragma once

#include "il2cpp-config.h"

#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif

#include <stdint.h>

// UnityEngine.Renderer
struct Renderer_t1092684080;

#include "UnityEngine_UnityEngine_MonoBehaviour3012272455.h"

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif

// ParallaxScroll
struct  ParallaxScroll_t605749092  : public MonoBehaviour_t3012272455
{
public:
	// UnityEngine.Renderer ParallaxScroll::background
	Renderer_t1092684080 * ___background_2;
	// UnityEngine.Renderer ParallaxScroll::foreground
	Renderer_t1092684080 * ___foreground_3;
	// System.Single ParallaxScroll::backgroundSpeed
	float ___backgroundSpeed_4;
	// System.Single ParallaxScroll::foregroundSpeed
	float ___foregroundSpeed_5;
	// System.Single ParallaxScroll::offset
	float ___offset_6;

public:
	inline static int32_t get_offset_of_background_2() { return static_cast<int32_t>(offsetof(ParallaxScroll_t605749092, ___background_2)); }
	inline Renderer_t1092684080 * get_background_2() const { return ___background_2; }
	inline Renderer_t1092684080 ** get_address_of_background_2() { return &___background_2; }
	inline void set_background_2(Renderer_t1092684080 * value)
	{
		___background_2 = value;
		Il2CppCodeGenWriteBarrier(&___background_2, value);
	}

	inline static int32_t get_offset_of_foreground_3() { return static_cast<int32_t>(offsetof(ParallaxScroll_t605749092, ___foreground_3)); }
	inline Renderer_t1092684080 * get_foreground_3() const { return ___foreground_3; }
	inline Renderer_t1092684080 ** get_address_of_foreground_3() { return &___foreground_3; }
	inline void set_foreground_3(Renderer_t1092684080 * value)
	{
		___foreground_3 = value;
		Il2CppCodeGenWriteBarrier(&___foreground_3, value);
	}

	inline static int32_t get_offset_of_backgroundSpeed_4() { return static_cast<int32_t>(offsetof(ParallaxScroll_t605749092, ___backgroundSpeed_4)); }
	inline float get_backgroundSpeed_4() const { return ___backgroundSpeed_4; }
	inline float* get_address_of_backgroundSpeed_4() { return &___backgroundSpeed_4; }
	inline void set_backgroundSpeed_4(float value)
	{
		___backgroundSpeed_4 = value;
	}

	inline static int32_t get_offset_of_foregroundSpeed_5() { return static_cast<int32_t>(offsetof(ParallaxScroll_t605749092, ___foregroundSpeed_5)); }
	inline float get_foregroundSpeed_5() const { return ___foregroundSpeed_5; }
	inline float* get_address_of_foregroundSpeed_5() { return &___foregroundSpeed_5; }
	inline void set_foregroundSpeed_5(float value)
	{
		___foregroundSpeed_5 = value;
	}

	inline static int32_t get_offset_of_offset_6() { return static_cast<int32_t>(offsetof(ParallaxScroll_t605749092, ___offset_6)); }
	inline float get_offset_6() const { return ___offset_6; }
	inline float* get_address_of_offset_6() { return &___offset_6; }
	inline void set_offset_6(float value)
	{
		___offset_6 = value;
	}
};

#ifdef __clang__
#pragma clang diagnostic pop
#endif
