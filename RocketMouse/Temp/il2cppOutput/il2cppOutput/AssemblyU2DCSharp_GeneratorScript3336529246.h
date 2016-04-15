#pragma once

#include "il2cpp-config.h"

#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif

#include <stdint.h>

// UnityEngine.GameObject[]
struct GameObjectU5BU5D_t3499186955;
// System.Collections.Generic.List`1<UnityEngine.GameObject>
struct List_1_t514686775;

#include "UnityEngine_UnityEngine_MonoBehaviour3012272455.h"

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif

// GeneratorScript
struct  GeneratorScript_t3336529246  : public MonoBehaviour_t3012272455
{
public:
	// UnityEngine.GameObject[] GeneratorScript::availableRooms
	GameObjectU5BU5D_t3499186955* ___availableRooms_2;
	// System.Collections.Generic.List`1<UnityEngine.GameObject> GeneratorScript::currentRooms
	List_1_t514686775 * ___currentRooms_3;
	// System.Single GeneratorScript::screenWidthInPoints
	float ___screenWidthInPoints_4;
	// UnityEngine.GameObject[] GeneratorScript::availableObjects
	GameObjectU5BU5D_t3499186955* ___availableObjects_5;
	// System.Collections.Generic.List`1<UnityEngine.GameObject> GeneratorScript::objects
	List_1_t514686775 * ___objects_6;
	// System.Single GeneratorScript::objectsMinDistance
	float ___objectsMinDistance_7;
	// System.Single GeneratorScript::objectsMaxDistance
	float ___objectsMaxDistance_8;
	// System.Single GeneratorScript::objectsMinY
	float ___objectsMinY_9;
	// System.Single GeneratorScript::objectsMaxY
	float ___objectsMaxY_10;
	// System.Single GeneratorScript::objectsMinRotation
	float ___objectsMinRotation_11;
	// System.Single GeneratorScript::objectsMaxRotation
	float ___objectsMaxRotation_12;

public:
	inline static int32_t get_offset_of_availableRooms_2() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___availableRooms_2)); }
	inline GameObjectU5BU5D_t3499186955* get_availableRooms_2() const { return ___availableRooms_2; }
	inline GameObjectU5BU5D_t3499186955** get_address_of_availableRooms_2() { return &___availableRooms_2; }
	inline void set_availableRooms_2(GameObjectU5BU5D_t3499186955* value)
	{
		___availableRooms_2 = value;
		Il2CppCodeGenWriteBarrier(&___availableRooms_2, value);
	}

	inline static int32_t get_offset_of_currentRooms_3() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___currentRooms_3)); }
	inline List_1_t514686775 * get_currentRooms_3() const { return ___currentRooms_3; }
	inline List_1_t514686775 ** get_address_of_currentRooms_3() { return &___currentRooms_3; }
	inline void set_currentRooms_3(List_1_t514686775 * value)
	{
		___currentRooms_3 = value;
		Il2CppCodeGenWriteBarrier(&___currentRooms_3, value);
	}

	inline static int32_t get_offset_of_screenWidthInPoints_4() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___screenWidthInPoints_4)); }
	inline float get_screenWidthInPoints_4() const { return ___screenWidthInPoints_4; }
	inline float* get_address_of_screenWidthInPoints_4() { return &___screenWidthInPoints_4; }
	inline void set_screenWidthInPoints_4(float value)
	{
		___screenWidthInPoints_4 = value;
	}

	inline static int32_t get_offset_of_availableObjects_5() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___availableObjects_5)); }
	inline GameObjectU5BU5D_t3499186955* get_availableObjects_5() const { return ___availableObjects_5; }
	inline GameObjectU5BU5D_t3499186955** get_address_of_availableObjects_5() { return &___availableObjects_5; }
	inline void set_availableObjects_5(GameObjectU5BU5D_t3499186955* value)
	{
		___availableObjects_5 = value;
		Il2CppCodeGenWriteBarrier(&___availableObjects_5, value);
	}

	inline static int32_t get_offset_of_objects_6() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___objects_6)); }
	inline List_1_t514686775 * get_objects_6() const { return ___objects_6; }
	inline List_1_t514686775 ** get_address_of_objects_6() { return &___objects_6; }
	inline void set_objects_6(List_1_t514686775 * value)
	{
		___objects_6 = value;
		Il2CppCodeGenWriteBarrier(&___objects_6, value);
	}

	inline static int32_t get_offset_of_objectsMinDistance_7() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___objectsMinDistance_7)); }
	inline float get_objectsMinDistance_7() const { return ___objectsMinDistance_7; }
	inline float* get_address_of_objectsMinDistance_7() { return &___objectsMinDistance_7; }
	inline void set_objectsMinDistance_7(float value)
	{
		___objectsMinDistance_7 = value;
	}

	inline static int32_t get_offset_of_objectsMaxDistance_8() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___objectsMaxDistance_8)); }
	inline float get_objectsMaxDistance_8() const { return ___objectsMaxDistance_8; }
	inline float* get_address_of_objectsMaxDistance_8() { return &___objectsMaxDistance_8; }
	inline void set_objectsMaxDistance_8(float value)
	{
		___objectsMaxDistance_8 = value;
	}

	inline static int32_t get_offset_of_objectsMinY_9() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___objectsMinY_9)); }
	inline float get_objectsMinY_9() const { return ___objectsMinY_9; }
	inline float* get_address_of_objectsMinY_9() { return &___objectsMinY_9; }
	inline void set_objectsMinY_9(float value)
	{
		___objectsMinY_9 = value;
	}

	inline static int32_t get_offset_of_objectsMaxY_10() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___objectsMaxY_10)); }
	inline float get_objectsMaxY_10() const { return ___objectsMaxY_10; }
	inline float* get_address_of_objectsMaxY_10() { return &___objectsMaxY_10; }
	inline void set_objectsMaxY_10(float value)
	{
		___objectsMaxY_10 = value;
	}

	inline static int32_t get_offset_of_objectsMinRotation_11() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___objectsMinRotation_11)); }
	inline float get_objectsMinRotation_11() const { return ___objectsMinRotation_11; }
	inline float* get_address_of_objectsMinRotation_11() { return &___objectsMinRotation_11; }
	inline void set_objectsMinRotation_11(float value)
	{
		___objectsMinRotation_11 = value;
	}

	inline static int32_t get_offset_of_objectsMaxRotation_12() { return static_cast<int32_t>(offsetof(GeneratorScript_t3336529246, ___objectsMaxRotation_12)); }
	inline float get_objectsMaxRotation_12() const { return ___objectsMaxRotation_12; }
	inline float* get_address_of_objectsMaxRotation_12() { return &___objectsMaxRotation_12; }
	inline void set_objectsMaxRotation_12(float value)
	{
		___objectsMaxRotation_12 = value;
	}
};

#ifdef __clang__
#pragma clang diagnostic pop
#endif
