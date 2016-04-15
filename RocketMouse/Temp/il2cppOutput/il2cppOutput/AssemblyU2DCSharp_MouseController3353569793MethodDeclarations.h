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

// MouseController
struct MouseController_t3353569793;
// UnityEngine.Collider2D
struct Collider2D_t1890038195;

#include "codegen/il2cpp-codegen.h"
#include "UnityEngine_UnityEngine_Collider2D1890038195.h"

// System.Void MouseController::.ctor()
extern "C"  void MouseController__ctor_m2529496714 (MouseController_t3353569793 * __this, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::AdjustFootstepsAndJetpackSound(System.Boolean)
extern "C"  void MouseController_AdjustFootstepsAndJetpackSound_m4273758619 (MouseController_t3353569793 * __this, bool ___jetpackActive, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::DisplayRestartButton()
extern "C"  void MouseController_DisplayRestartButton_m1019804729 (MouseController_t3353569793 * __this, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::OnGUI()
extern "C"  void MouseController_OnGUI_m2024895364 (MouseController_t3353569793 * __this, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::DisplayCoinsCount()
extern "C"  void MouseController_DisplayCoinsCount_m2785976823 (MouseController_t3353569793 * __this, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::CollectCoin(UnityEngine.Collider2D)
extern "C"  void MouseController_CollectCoin_m251798758 (MouseController_t3353569793 * __this, Collider2D_t1890038195 * ___coinCollider, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::OnTriggerEnter2D(UnityEngine.Collider2D)
extern "C"  void MouseController_OnTriggerEnter2D_m1136233006 (MouseController_t3353569793 * __this, Collider2D_t1890038195 * ___collider, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::HitByLaser(UnityEngine.Collider2D)
extern "C"  void MouseController_HitByLaser_m2147238014 (MouseController_t3353569793 * __this, Collider2D_t1890038195 * ___laserCollider, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::FixedUpdate()
extern "C"  void MouseController_FixedUpdate_m2691193989 (MouseController_t3353569793 * __this, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::Start()
extern "C"  void MouseController_Start_m1476634506 (MouseController_t3353569793 * __this, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::Update()
extern "C"  void MouseController_Update_m2831848899 (MouseController_t3353569793 * __this, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::UpdateGroundedStatus()
extern "C"  void MouseController_UpdateGroundedStatus_m2640263259 (MouseController_t3353569793 * __this, const MethodInfo* method) IL2CPP_METHOD_ATTR;
// System.Void MouseController::AdjustJetpack(System.Boolean)
extern "C"  void MouseController_AdjustJetpack_m3691593666 (MouseController_t3353569793 * __this, bool ___jetpackActive, const MethodInfo* method) IL2CPP_METHOD_ATTR;
