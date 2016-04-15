#pragma once

#include "il2cpp-config.h"

#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif

#include <stdint.h>
#include <assert.h>
#include <exception>

// UnityEngine.Collider2D
struct Collider2D_t1890038195;

#include "codegen/il2cpp-codegen.h"
#include "UnityEngine_UnityEngine_Vector23525329788.h"

// System.Void UnityEngine.Physics2D::.cctor()
extern "C"  void Physics2D__cctor_m2087591309 (Il2CppObject * __this /* static, unused */, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// UnityEngine.Collider2D UnityEngine.Physics2D::OverlapCircle(UnityEngine.Vector2,System.Single,System.Int32)
extern "C"  Collider2D_t1890038195 * Physics2D_OverlapCircle_m2476274143 (Il2CppObject * __this /* static, unused */, Vector2_t3525329788  ___point, float ___radius, int32_t ___layerMask, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// UnityEngine.Collider2D UnityEngine.Physics2D::INTERNAL_CALL_OverlapCircle(UnityEngine.Vector2&,System.Single,System.Int32,System.Single,System.Single)
extern "C"  Collider2D_t1890038195 * Physics2D_INTERNAL_CALL_OverlapCircle_m1802552674 (Il2CppObject * __this /* static, unused */, Vector2_t3525329788 * ___point, float ___radius, int32_t ___layerMask, float ___minDepth, float ___maxDepth, const MethodInfo* method) IL2CPP_METHOD_ATTR;
