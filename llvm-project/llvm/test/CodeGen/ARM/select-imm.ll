; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm-eabi | FileCheck %s --check-prefix=ARM
; RUN: llc < %s -mtriple=arm-eabi -mcpu=arm1156t2-s -mattr=+thumb2 | FileCheck %s --check-prefix=ARMT2
; RUN: llc < %s -mtriple=thumb-eabi -mcpu=cortex-m0 | FileCheck %s --check-prefix=THUMB1
; RUN: llc < %s -mtriple=thumb-eabi -mcpu=arm1156t2-s -mattr=+thumb2 | FileCheck %s --check-prefix=THUMB2
; RUN: llc < %s -mtriple=thumbv8m.base-eabi | FileCheck %s --check-prefix=V8MBASE

define i32 @t1(i32 %c) nounwind readnone {
; ARM-LABEL: t1:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    mov r1, #101
; ARM-NEXT:    cmp r0, #1
; ARM-NEXT:    orr r1, r1, #256
; ARM-NEXT:    movgt r1, #123
; ARM-NEXT:    mov r0, r1
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t1:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    movw r1, #357
; ARMT2-NEXT:    cmp r0, #1
; ARMT2-NEXT:    movwgt r1, #123
; ARMT2-NEXT:    mov r0, r1
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t1:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    cmp r0, #1
; THUMB1-NEXT:    bgt .LBB0_2
; THUMB1-NEXT:  @ %bb.1: @ %entry
; THUMB1-NEXT:    movs r0, #255
; THUMB1-NEXT:    adds r0, #102
; THUMB1-NEXT:    bx lr
; THUMB1-NEXT:  .LBB0_2:
; THUMB1-NEXT:    movs r0, #123
; THUMB1-NEXT:    bx lr
;
; THUMB2-LABEL: t1:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    movw r1, #357
; THUMB2-NEXT:    cmp r0, #1
; THUMB2-NEXT:    it gt
; THUMB2-NEXT:    movgt r1, #123
; THUMB2-NEXT:    mov r0, r1
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t1:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    cmp r0, #1
; V8MBASE-NEXT:    bgt .LBB0_2
; V8MBASE-NEXT:  @ %bb.1: @ %entry
; V8MBASE-NEXT:    movw r0, #357
; V8MBASE-NEXT:    bx lr
; V8MBASE-NEXT:  .LBB0_2:
; V8MBASE-NEXT:    movs r0, #123
; V8MBASE-NEXT:    bx lr
entry:
  %0 = icmp sgt i32 %c, 1
  %1 = select i1 %0, i32 123, i32 357
  ret i32 %1
}

define i32 @t2(i32 %c) nounwind readnone {
; ARM-LABEL: t2:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    mov r1, #101
; ARM-NEXT:    cmp r0, #1
; ARM-NEXT:    orr r1, r1, #256
; ARM-NEXT:    movle r1, #123
; ARM-NEXT:    mov r0, r1
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t2:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    mov r1, #123
; ARMT2-NEXT:    cmp r0, #1
; ARMT2-NEXT:    movwgt r1, #357
; ARMT2-NEXT:    mov r0, r1
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t2:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    cmp r0, #1
; THUMB1-NEXT:    bgt .LBB1_2
; THUMB1-NEXT:  @ %bb.1: @ %entry
; THUMB1-NEXT:    movs r0, #123
; THUMB1-NEXT:    bx lr
; THUMB1-NEXT:  .LBB1_2:
; THUMB1-NEXT:    movs r0, #255
; THUMB1-NEXT:    adds r0, #102
; THUMB1-NEXT:    bx lr
;
; THUMB2-LABEL: t2:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    movs r1, #123
; THUMB2-NEXT:    cmp r0, #1
; THUMB2-NEXT:    it gt
; THUMB2-NEXT:    movwgt r1, #357
; THUMB2-NEXT:    mov r0, r1
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t2:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    mov r1, r0
; V8MBASE-NEXT:    movw r0, #357
; V8MBASE-NEXT:    cmp r1, #1
; V8MBASE-NEXT:    bgt .LBB1_2
; V8MBASE-NEXT:  @ %bb.1: @ %entry
; V8MBASE-NEXT:    movs r0, #123
; V8MBASE-NEXT:  .LBB1_2: @ %entry
; V8MBASE-NEXT:    bx lr
entry:
  %0 = icmp sgt i32 %c, 1
  %1 = select i1 %0, i32 357, i32 123
  ret i32 %1
}

define i32 @t3(i32 %a) nounwind readnone {
; ARM-LABEL: t3:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    sub r0, r0, #160
; ARM-NEXT:    rsbs r1, r0, #0
; ARM-NEXT:    adc r0, r0, r1
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t3:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    sub r0, r0, #160
; ARMT2-NEXT:    clz r0, r0
; ARMT2-NEXT:    lsr r0, r0, #5
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t3:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    subs r0, #160
; THUMB1-NEXT:    rsbs r1, r0, #0
; THUMB1-NEXT:    adcs r0, r1
; THUMB1-NEXT:    bx lr
;
; THUMB2-LABEL: t3:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    subs r0, #160
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t3:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    subs r0, #160
; V8MBASE-NEXT:    rsbs r1, r0, #0
; V8MBASE-NEXT:    adcs r0, r1
; V8MBASE-NEXT:    bx lr
entry:
  %0 = icmp eq i32 %a, 160
  %1 = zext i1 %0 to i32
  ret i32 %1
}

define i32 @t4(i32 %a, i32 %b, i32 %x) nounwind {
; ARM-LABEL: t4:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    mvn r3, #170
; ARM-NEXT:    cmp r0, r1
; ARM-NEXT:    sub r3, r3, #11141120
; ARM-NEXT:    movge r3, r2
; ARM-NEXT:    mov r0, r3
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t4:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    cmp r0, r1
; ARMT2-NEXT:    movwlt r2, #65365
; ARMT2-NEXT:    movtlt r2, #65365
; ARMT2-NEXT:    mov r0, r2
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t4:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    cmp r0, r1
; THUMB1-NEXT:    bge .LBB3_2
; THUMB1-NEXT:  @ %bb.1:
; THUMB1-NEXT:    ldr r2, .LCPI3_0
; THUMB1-NEXT:  .LBB3_2: @ %entry
; THUMB1-NEXT:    mov r0, r2
; THUMB1-NEXT:    bx lr
; THUMB1-NEXT:    .p2align 2
; THUMB1-NEXT:  @ %bb.3:
; THUMB1-NEXT:  .LCPI3_0:
; THUMB1-NEXT:    .long 4283826005 @ 0xff55ff55
;
; THUMB2-LABEL: t4:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    cmp r0, r1
; THUMB2-NEXT:    it lt
; THUMB2-NEXT:    mvnlt r2, #11141290
; THUMB2-NEXT:    mov r0, r2
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t4:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    cmp r0, r1
; V8MBASE-NEXT:    bge .LBB3_2
; V8MBASE-NEXT:  @ %bb.1:
; V8MBASE-NEXT:    movw r2, #65365
; V8MBASE-NEXT:    movt r2, #65365
; V8MBASE-NEXT:  .LBB3_2: @ %entry
; V8MBASE-NEXT:    mov r0, r2
; V8MBASE-NEXT:    bx lr
entry:
  %0 = icmp slt i32 %a, %b
  %1 = select i1 %0, i32 4283826005, i32 %x
  ret i32 %1
}

; rdar://9758317
define i32 @t5(i32 %a) nounwind {
; ARM-LABEL: t5:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    sub r0, r0, #1
; ARM-NEXT:    rsbs r1, r0, #0
; ARM-NEXT:    adc r0, r0, r1
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t5:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    sub r0, r0, #1
; ARMT2-NEXT:    clz r0, r0
; ARMT2-NEXT:    lsr r0, r0, #5
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t5:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    subs r1, r0, #1
; THUMB1-NEXT:    rsbs r0, r1, #0
; THUMB1-NEXT:    adcs r0, r1
; THUMB1-NEXT:    bx lr
;
; THUMB2-LABEL: t5:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    subs r0, #1
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t5:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    subs r1, r0, #1
; V8MBASE-NEXT:    rsbs r0, r1, #0
; V8MBASE-NEXT:    adcs r0, r1
; V8MBASE-NEXT:    bx lr
entry:
  %cmp = icmp eq i32 %a, 1
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define i32 @t6(i32 %a) nounwind {
; ARM-LABEL: t6:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movne r0, #1
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t6:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    cmp r0, #0
; ARMT2-NEXT:    movwne r0, #1
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t6:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    subs r1, r0, #1
; THUMB1-NEXT:    sbcs r0, r1
; THUMB1-NEXT:    bx lr
;
; THUMB2-LABEL: t6:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t6:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    subs r1, r0, #1
; V8MBASE-NEXT:    sbcs r0, r1
; V8MBASE-NEXT:    bx lr
entry:
  %tobool = icmp ne i32 %a, 0
  %lnot.ext = zext i1 %tobool to i32
  ret i32 %lnot.ext
}

define i32 @t7(i32 %a, i32 %b) nounwind readnone {
; ARM-LABEL: t7:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    subs r0, r0, r1
; ARM-NEXT:    movne r0, #1
; ARM-NEXT:    lsl r0, r0, #2
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t7:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    subs r0, r0, r1
; ARMT2-NEXT:    movwne r0, #1
; ARMT2-NEXT:    lsl r0, r0, #2
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t7:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    subs r0, r0, r1
; THUMB1-NEXT:    subs r1, r0, #1
; THUMB1-NEXT:    sbcs r0, r1
; THUMB1-NEXT:    lsls r0, r0, #2
; THUMB1-NEXT:    bx lr
;
; THUMB2-LABEL: t7:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    subs r0, r0, r1
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    lsls r0, r0, #2
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t7:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    subs r0, r0, r1
; V8MBASE-NEXT:    subs r1, r0, #1
; V8MBASE-NEXT:    sbcs r0, r1
; V8MBASE-NEXT:    lsls r0, r0, #2
; V8MBASE-NEXT:    bx lr
entry:
  %0 = icmp ne i32 %a, %b
  %1 = select i1 %0, i32 4, i32 0
  ret i32 %1
}

; ARM scheduler emits icmp/zext before both calls, so isn't relevant
define void @t8(i32 %a) {
; ARM-LABEL: t8:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    .save {r4, lr}
; ARM-NEXT:    push {r4, lr}
; ARM-NEXT:    mov r1, r0
; ARM-NEXT:    sub r0, r0, #5
; ARM-NEXT:    rsbs r2, r0, #0
; ARM-NEXT:    adc r4, r0, r2
; ARM-NEXT:    mov r0, #9
; ARM-NEXT:    bl t7
; ARM-NEXT:    mov r1, r0
; ARM-NEXT:    mov r0, r4
; ARM-NEXT:    pop {r4, lr}
; ARM-NEXT:    b t7
;
; ARMT2-LABEL: t8:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    .save {r4, lr}
; ARMT2-NEXT:    push {r4, lr}
; ARMT2-NEXT:    mov r4, r0
; ARMT2-NEXT:    mov r0, #9
; ARMT2-NEXT:    mov r1, r4
; ARMT2-NEXT:    bl t7
; ARMT2-NEXT:    mov r1, r0
; ARMT2-NEXT:    sub r0, r4, #5
; ARMT2-NEXT:    clz r0, r0
; ARMT2-NEXT:    lsr r0, r0, #5
; ARMT2-NEXT:    pop {r4, lr}
; ARMT2-NEXT:    b t7
;
; THUMB1-LABEL: t8:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    .save {r4, lr}
; THUMB1-NEXT:    push {r4, lr}
; THUMB1-NEXT:    mov r4, r0
; THUMB1-NEXT:    movs r0, #9
; THUMB1-NEXT:    mov r1, r4
; THUMB1-NEXT:    bl t7
; THUMB1-NEXT:    mov r1, r0
; THUMB1-NEXT:    subs r2, r4, #5
; THUMB1-NEXT:    rsbs r0, r2, #0
; THUMB1-NEXT:    adcs r0, r2
; THUMB1-NEXT:    bl t7
; THUMB1-NEXT:    pop {r4, pc}
;
; THUMB2-LABEL: t8:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    .save {r4, lr}
; THUMB2-NEXT:    push {r4, lr}
; THUMB2-NEXT:    mov r4, r0
; THUMB2-NEXT:    movs r0, #9
; THUMB2-NEXT:    mov r1, r4
; THUMB2-NEXT:    bl t7
; THUMB2-NEXT:    mov r1, r0
; THUMB2-NEXT:    subs r0, r4, #5
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    pop.w {r4, lr}
; THUMB2-NEXT:    b t7
;
; V8MBASE-LABEL: t8:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    .save {r4, lr}
; V8MBASE-NEXT:    push {r4, lr}
; V8MBASE-NEXT:    mov r1, r0
; V8MBASE-NEXT:    subs r0, r0, #5
; V8MBASE-NEXT:    rsbs r4, r0, #0
; V8MBASE-NEXT:    adcs r4, r0
; V8MBASE-NEXT:    movs r0, #9
; V8MBASE-NEXT:    bl t7
; V8MBASE-NEXT:    mov r1, r0
; V8MBASE-NEXT:    mov r0, r4
; V8MBASE-NEXT:    pop {r4}
; V8MBASE-NEXT:    pop {r2}
; V8MBASE-NEXT:    mov lr, r2
; V8MBASE-NEXT:    b t7
entry:
  %cmp = icmp eq i32 %a, 5
  %conv = zext i1 %cmp to i32
  %call = tail call i32 @t7(i32 9, i32 %a)
  tail call i32 @t7(i32 %conv, i32 %call)
  ret void
}

; ARM scheduler emits icmp/zext before both calls, so isn't relevant
define void @t9(i8* %a, i8 %b) {
; ARM-LABEL: t9:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    .save {r4, lr}
; ARM-NEXT:    push {r4, lr}
; ARM-NEXT:    ldrsb r4, [r0]
; ARM-NEXT:    mov r0, #1
; ARM-NEXT:    bl f
; ARM-NEXT:    and r0, r4, #255
; ARM-NEXT:    cmp r0, r0
; ARM-NEXT:    bne .LBB8_3
; ARM-NEXT:  @ %bb.1: @ %while.body.preheader
; ARM-NEXT:    add r1, r4, #1
; ARM-NEXT:    mov r2, r0
; ARM-NEXT:  .LBB8_2: @ %while.body
; ARM-NEXT:    @ =>This Inner Loop Header: Depth=1
; ARM-NEXT:    add r2, r2, #1
; ARM-NEXT:    add r1, r1, #1
; ARM-NEXT:    and r3, r2, #255
; ARM-NEXT:    cmp r3, r0
; ARM-NEXT:    blt .LBB8_2
; ARM-NEXT:  .LBB8_3: @ %while.end
; ARM-NEXT:    pop {r4, lr}
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t9:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    .save {r4, lr}
; ARMT2-NEXT:    push {r4, lr}
; ARMT2-NEXT:    ldrsb r4, [r0]
; ARMT2-NEXT:    mov r0, #1
; ARMT2-NEXT:    bl f
; ARMT2-NEXT:    uxtb r0, r4
; ARMT2-NEXT:    cmp r0, r0
; ARMT2-NEXT:    popne {r4, pc}
; ARMT2-NEXT:  .LBB8_1: @ %while.body.preheader
; ARMT2-NEXT:    add r1, r4, #1
; ARMT2-NEXT:    mov r2, r0
; ARMT2-NEXT:  .LBB8_2: @ %while.body
; ARMT2-NEXT:    @ =>This Inner Loop Header: Depth=1
; ARMT2-NEXT:    add r2, r2, #1
; ARMT2-NEXT:    add r1, r1, #1
; ARMT2-NEXT:    uxtb r3, r2
; ARMT2-NEXT:    cmp r3, r0
; ARMT2-NEXT:    blt .LBB8_2
; ARMT2-NEXT:  @ %bb.3: @ %while.end
; ARMT2-NEXT:    pop {r4, pc}
;
; THUMB1-LABEL: t9:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    .save {r4, lr}
; THUMB1-NEXT:    push {r4, lr}
; THUMB1-NEXT:    movs r1, #0
; THUMB1-NEXT:    ldrsb r4, [r0, r1]
; THUMB1-NEXT:    movs r0, #1
; THUMB1-NEXT:    bl f
; THUMB1-NEXT:    uxtb r0, r4
; THUMB1-NEXT:    cmp r0, r0
; THUMB1-NEXT:    bne .LBB8_3
; THUMB1-NEXT:  @ %bb.1: @ %while.body.preheader
; THUMB1-NEXT:    adds r1, r4, #1
; THUMB1-NEXT:    mov r2, r0
; THUMB1-NEXT:  .LBB8_2: @ %while.body
; THUMB1-NEXT:    @ =>This Inner Loop Header: Depth=1
; THUMB1-NEXT:    adds r1, r1, #1
; THUMB1-NEXT:    adds r2, r2, #1
; THUMB1-NEXT:    uxtb r3, r2
; THUMB1-NEXT:    cmp r3, r0
; THUMB1-NEXT:    blt .LBB8_2
; THUMB1-NEXT:  .LBB8_3: @ %while.end
; THUMB1-NEXT:    pop {r4, pc}
;
; THUMB2-LABEL: t9:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    .save {r4, lr}
; THUMB2-NEXT:    push {r4, lr}
; THUMB2-NEXT:    ldrsb.w r4, [r0]
; THUMB2-NEXT:    movs r0, #1
; THUMB2-NEXT:    bl f
; THUMB2-NEXT:    uxtb r0, r4
; THUMB2-NEXT:    cmp r0, r0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    popne {r4, pc}
; THUMB2-NEXT:  .LBB8_1: @ %while.body.preheader
; THUMB2-NEXT:    adds r1, r4, #1
; THUMB2-NEXT:    mov r2, r0
; THUMB2-NEXT:  .LBB8_2: @ %while.body
; THUMB2-NEXT:    @ =>This Inner Loop Header: Depth=1
; THUMB2-NEXT:    adds r2, #1
; THUMB2-NEXT:    adds r1, #1
; THUMB2-NEXT:    uxtb r3, r2
; THUMB2-NEXT:    cmp r3, r0
; THUMB2-NEXT:    blt .LBB8_2
; THUMB2-NEXT:  @ %bb.3: @ %while.end
; THUMB2-NEXT:    pop {r4, pc}
;
; V8MBASE-LABEL: t9:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    .save {r4, lr}
; V8MBASE-NEXT:    push {r4, lr}
; V8MBASE-NEXT:    movs r1, #0
; V8MBASE-NEXT:    ldrsb r4, [r0, r1]
; V8MBASE-NEXT:    movs r0, #1
; V8MBASE-NEXT:    bl f
; V8MBASE-NEXT:    uxtb r0, r4
; V8MBASE-NEXT:    cmp r0, r0
; V8MBASE-NEXT:    bne .LBB8_3
; V8MBASE-NEXT:  @ %bb.1: @ %while.body.preheader
; V8MBASE-NEXT:    adds r1, r4, #1
; V8MBASE-NEXT:    mov r2, r0
; V8MBASE-NEXT:  .LBB8_2: @ %while.body
; V8MBASE-NEXT:    @ =>This Inner Loop Header: Depth=1
; V8MBASE-NEXT:    adds r1, r1, #1
; V8MBASE-NEXT:    adds r2, r2, #1
; V8MBASE-NEXT:    uxtb r3, r2
; V8MBASE-NEXT:    cmp r3, r0
; V8MBASE-NEXT:    blt .LBB8_2
; V8MBASE-NEXT:  .LBB8_3: @ %while.end
; V8MBASE-NEXT:    pop {r4, pc}
entry:
  %0 = load i8, i8* %a
  %conv = sext i8 %0 to i32
  %conv119 = zext i8 %0 to i32
  %conv522 = and i32 %conv, 255
  %cmp723 = icmp eq i32 %conv522, %conv119
  tail call void @f(i1 zeroext %cmp723)
  br i1 %cmp723, label %while.body, label %while.end

while.body:                                       ; preds = %entry, %while.body
  %ref.025 = phi i8 [ %inc9, %while.body ], [ %0, %entry ]
  %in.024 = phi i32 [ %inc, %while.body ], [ %conv, %entry ]
  %inc = add i32 %in.024, 1
  %inc9 = add i8 %ref.025, 1
  %conv1 = zext i8 %inc9 to i32
  %cmp = icmp slt i32 %conv1, %conv119
  %conv5 = and i32 %inc, 255
  br i1 %cmp, label %while.body, label %while.end

while.end:
  ret void
}

declare void @f(i1 zeroext)

define i1 @t10() {
; ARM-LABEL: t10:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    .save {r11, lr}
; ARM-NEXT:    push {r11, lr}
; ARM-NEXT:    .pad #8
; ARM-NEXT:    sub sp, sp, #8
; ARM-NEXT:    mvn r0, #2
; ARM-NEXT:    mvn r1, #7
; ARM-NEXT:    str r0, [sp, #4]
; ARM-NEXT:    mvn r0, #7
; ARM-NEXT:    str r0, [sp]
; ARM-NEXT:    mvn r0, #2
; ARM-NEXT:    bl __aeabi_idivmod
; ARM-NEXT:    sub r0, r1, r0, lsl #3
; ARM-NEXT:    add r0, r0, #3
; ARM-NEXT:    rsbs r1, r0, #0
; ARM-NEXT:    adc r0, r0, r1
; ARM-NEXT:    add sp, sp, #8
; ARM-NEXT:    pop {r11, lr}
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t10:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    .save {r11, lr}
; ARMT2-NEXT:    push {r11, lr}
; ARMT2-NEXT:    .pad #8
; ARMT2-NEXT:    sub sp, sp, #8
; ARMT2-NEXT:    mvn r0, #2
; ARMT2-NEXT:    str r0, [sp, #4]
; ARMT2-NEXT:    mvn r0, #7
; ARMT2-NEXT:    str r0, [sp]
; ARMT2-NEXT:    mvn r0, #2
; ARMT2-NEXT:    mvn r1, #7
; ARMT2-NEXT:    bl __aeabi_idivmod
; ARMT2-NEXT:    sub r0, r1, r0, lsl #3
; ARMT2-NEXT:    add r0, r0, #3
; ARMT2-NEXT:    clz r0, r0
; ARMT2-NEXT:    lsr r0, r0, #5
; ARMT2-NEXT:    add sp, sp, #8
; ARMT2-NEXT:    pop {r11, pc}
;
; THUMB1-LABEL: t10:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    .save {r4, r5, r7, lr}
; THUMB1-NEXT:    push {r4, r5, r7, lr}
; THUMB1-NEXT:    .pad #8
; THUMB1-NEXT:    sub sp, #8
; THUMB1-NEXT:    movs r0, #7
; THUMB1-NEXT:    mvns r4, r0
; THUMB1-NEXT:    str r4, [sp]
; THUMB1-NEXT:    adds r5, r4, #5
; THUMB1-NEXT:    str r5, [sp, #4]
; THUMB1-NEXT:    mov r0, r5
; THUMB1-NEXT:    mov r1, r4
; THUMB1-NEXT:    bl __aeabi_idivmod
; THUMB1-NEXT:    muls r0, r4, r0
; THUMB1-NEXT:    adds r0, r0, r1
; THUMB1-NEXT:    subs r1, r0, r5
; THUMB1-NEXT:    rsbs r0, r1, #0
; THUMB1-NEXT:    adcs r0, r1
; THUMB1-NEXT:    add sp, #8
; THUMB1-NEXT:    pop {r4, r5, r7, pc}
;
; THUMB2-LABEL: t10:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    .save {r7, lr}
; THUMB2-NEXT:    push {r7, lr}
; THUMB2-NEXT:    .pad #8
; THUMB2-NEXT:    sub sp, #8
; THUMB2-NEXT:    mvn r0, #2
; THUMB2-NEXT:    str r0, [sp, #4]
; THUMB2-NEXT:    mvn r0, #7
; THUMB2-NEXT:    str r0, [sp]
; THUMB2-NEXT:    mvn r0, #2
; THUMB2-NEXT:    mvn r1, #7
; THUMB2-NEXT:    bl __aeabi_idivmod
; THUMB2-NEXT:    sub.w r0, r1, r0, lsl #3
; THUMB2-NEXT:    adds r0, #3
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    add sp, #8
; THUMB2-NEXT:    pop {r7, pc}
;
; V8MBASE-LABEL: t10:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    .pad #8
; V8MBASE-NEXT:    sub sp, #8
; V8MBASE-NEXT:    movs r0, #7
; V8MBASE-NEXT:    mvns r0, r0
; V8MBASE-NEXT:    str r0, [sp]
; V8MBASE-NEXT:    adds r0, r0, #5
; V8MBASE-NEXT:    str r0, [sp, #4]
; V8MBASE-NEXT:    movs r1, #0
; V8MBASE-NEXT:    rsbs r0, r1, #0
; V8MBASE-NEXT:    adcs r0, r1
; V8MBASE-NEXT:    add sp, #8
; V8MBASE-NEXT:    bx lr
entry:
  %q = alloca i32
  %p = alloca i32
  store i32 -3, i32* %q
  store i32 -8, i32* %p
  %0 = load i32, i32* %q
  %1 = load i32, i32* %p
  %div = sdiv i32 %0, %1
  %mul = mul nsw i32 %div, %1
  %rem = srem i32 %0, %1
  %add = add nsw i32 %mul, %rem
  %cmp = icmp eq i32 %add, %0
  ret i1 %cmp
}

define i1 @t11() {
; ARM-LABEL: t11:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    .pad #4
; ARM-NEXT:    sub sp, sp, #4
; ARM-NEXT:    ldr r0, .LCPI10_0
; ARM-NEXT:    mov r1, #33
; ARM-NEXT:    umull r2, r3, r1, r0
; ARM-NEXT:    lsr r0, r3, #3
; ARM-NEXT:    add r0, r0, r0, lsl #2
; ARM-NEXT:    sub r0, r1, r0, lsl #1
; ARM-NEXT:    ldr r1, [sp]
; ARM-NEXT:    and r1, r1, #-33554432
; ARM-NEXT:    orr r0, r1, r0
; ARM-NEXT:    mov r1, #255
; ARM-NEXT:    orr r0, r0, #40960
; ARM-NEXT:    orr r1, r1, #3840
; ARM-NEXT:    str r0, [sp]
; ARM-NEXT:    and r0, r0, r1
; ARM-NEXT:    sub r0, r0, #3
; ARM-NEXT:    rsbs r1, r0, #0
; ARM-NEXT:    adc r0, r0, r1
; ARM-NEXT:    add sp, sp, #4
; ARM-NEXT:    mov pc, lr
; ARM-NEXT:    .p2align 2
; ARM-NEXT:  @ %bb.1:
; ARM-NEXT:  .LCPI10_0:
; ARM-NEXT:    .long 3435973837 @ 0xcccccccd
;
; ARMT2-LABEL: t11:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    .pad #4
; ARMT2-NEXT:    sub sp, sp, #4
; ARMT2-NEXT:    ldr r1, [sp]
; ARMT2-NEXT:    mov r0, #33
; ARMT2-NEXT:    movw r2, #52429
; ARMT2-NEXT:    movt r2, #52428
; ARMT2-NEXT:    bfi r1, r0, #0, #12
; ARMT2-NEXT:    mov r0, #10
; ARMT2-NEXT:    bfi r1, r0, #12, #13
; ARMT2-NEXT:    mov r0, r1
; ARMT2-NEXT:    bfc r0, #12, #20
; ARMT2-NEXT:    umull r2, r3, r0, r2
; ARMT2-NEXT:    lsr r2, r3, #3
; ARMT2-NEXT:    add r2, r2, r2, lsl #2
; ARMT2-NEXT:    sub r0, r0, r2, lsl #1
; ARMT2-NEXT:    movw r2, #40960
; ARMT2-NEXT:    movt r2, #65024
; ARMT2-NEXT:    and r1, r1, r2
; ARMT2-NEXT:    orr r0, r1, r0
; ARMT2-NEXT:    str r0, [sp]
; ARMT2-NEXT:    bfc r0, #12, #20
; ARMT2-NEXT:    sub r0, r0, #3
; ARMT2-NEXT:    clz r0, r0
; ARMT2-NEXT:    lsr r0, r0, #5
; ARMT2-NEXT:    add sp, sp, #4
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t11:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    .pad #4
; THUMB1-NEXT:    sub sp, #4
; THUMB1-NEXT:    movs r0, #5
; THUMB1-NEXT:    lsls r0, r0, #13
; THUMB1-NEXT:    ldr r1, [sp]
; THUMB1-NEXT:    orrs r1, r0
; THUMB1-NEXT:    ldr r0, .LCPI10_0
; THUMB1-NEXT:    ands r0, r1
; THUMB1-NEXT:    adds r0, r0, #3
; THUMB1-NEXT:    str r0, [sp]
; THUMB1-NEXT:    movs r1, #0
; THUMB1-NEXT:    rsbs r0, r1, #0
; THUMB1-NEXT:    adcs r0, r1
; THUMB1-NEXT:    add sp, #4
; THUMB1-NEXT:    bx lr
; THUMB1-NEXT:    .p2align 2
; THUMB1-NEXT:  @ %bb.1:
; THUMB1-NEXT:  .LCPI10_0:
; THUMB1-NEXT:    .long 4261453824 @ 0xfe00a000
;
; THUMB2-LABEL: t11:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    .pad #4
; THUMB2-NEXT:    sub sp, #4
; THUMB2-NEXT:    ldr r1, [sp]
; THUMB2-NEXT:    movs r0, #33
; THUMB2-NEXT:    movw r2, #52429
; THUMB2-NEXT:    bfi r1, r0, #0, #12
; THUMB2-NEXT:    movs r0, #10
; THUMB2-NEXT:    bfi r1, r0, #12, #13
; THUMB2-NEXT:    mov r0, r1
; THUMB2-NEXT:    movt r2, #52428
; THUMB2-NEXT:    bfc r0, #12, #20
; THUMB2-NEXT:    umull r2, r3, r0, r2
; THUMB2-NEXT:    lsrs r2, r3, #3
; THUMB2-NEXT:    add.w r2, r2, r2, lsl #2
; THUMB2-NEXT:    sub.w r0, r0, r2, lsl #1
; THUMB2-NEXT:    movw r2, #40960
; THUMB2-NEXT:    movt r2, #65024
; THUMB2-NEXT:    ands r1, r2
; THUMB2-NEXT:    orrs r0, r1
; THUMB2-NEXT:    str r0, [sp]
; THUMB2-NEXT:    bfc r0, #12, #20
; THUMB2-NEXT:    subs r0, #3
; THUMB2-NEXT:    clz r0, r0
; THUMB2-NEXT:    lsrs r0, r0, #5
; THUMB2-NEXT:    add sp, #4
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t11:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    .pad #4
; V8MBASE-NEXT:    sub sp, #4
; V8MBASE-NEXT:    movw r0, #40960
; V8MBASE-NEXT:    ldr r1, [sp]
; V8MBASE-NEXT:    orrs r1, r0
; V8MBASE-NEXT:    movw r0, #40960
; V8MBASE-NEXT:    movt r0, #65024
; V8MBASE-NEXT:    ands r0, r1
; V8MBASE-NEXT:    adds r0, r0, #3
; V8MBASE-NEXT:    str r0, [sp]
; V8MBASE-NEXT:    movs r1, #0
; V8MBASE-NEXT:    rsbs r0, r1, #0
; V8MBASE-NEXT:    adcs r0, r1
; V8MBASE-NEXT:    add sp, #4
; V8MBASE-NEXT:    bx lr
entry:
  %bit = alloca i32
  %load = load i32, i32* %bit
  %clear = and i32 %load, -4096
  %set = or i32 %clear, 33
  store i32 %set, i32* %bit
  %load1 = load i32, i32* %bit
  %clear2 = and i32 %load1, -33550337
  %set3 = or i32 %clear2, 40960
  %clear5 = and i32 %set3, 4095
  %rem = srem i32 %clear5, 10
  %clear9 = and i32 %set3, -4096
  %set10 = or i32 %clear9, %rem
  store i32 %set10, i32* %bit
  %clear12 = and i32 %set10, 4095
  %cmp = icmp eq i32 %clear12, 3
  ret i1 %cmp
}

define i32 @t12(i32 %a) nounwind {
; ARM-LABEL: t12:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movne r0, #1
; ARM-NEXT:    lsl r0, r0, #1
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t12:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    cmp r0, #0
; ARMT2-NEXT:    movwne r0, #1
; ARMT2-NEXT:    lsl r0, r0, #1
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t12:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    subs r1, r0, #1
; THUMB1-NEXT:    sbcs r0, r1
; THUMB1-NEXT:    lsls r0, r0, #1
; THUMB1-NEXT:    bx lr
;
; THUMB2-LABEL: t12:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #1
; THUMB2-NEXT:    lsls r0, r0, #1
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t12:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    subs r1, r0, #1
; V8MBASE-NEXT:    sbcs r0, r1
; V8MBASE-NEXT:    lsls r0, r0, #1
; V8MBASE-NEXT:    bx lr
entry:
  %tobool = icmp ne i32 %a, 0
  %lnot.ext = select i1 %tobool, i32 2, i32 0
  ret i32 %lnot.ext
}

define i32 @t13(i32 %a) nounwind {
; ARM-LABEL: t13:
; ARM:       @ %bb.0: @ %entry
; ARM-NEXT:    cmp r0, #0
; ARM-NEXT:    movne r0, #3
; ARM-NEXT:    mov pc, lr
;
; ARMT2-LABEL: t13:
; ARMT2:       @ %bb.0: @ %entry
; ARMT2-NEXT:    cmp r0, #0
; ARMT2-NEXT:    movwne r0, #3
; ARMT2-NEXT:    bx lr
;
; THUMB1-LABEL: t13:
; THUMB1:       @ %bb.0: @ %entry
; THUMB1-NEXT:    cmp r0, #0
; THUMB1-NEXT:    beq .LBB12_2
; THUMB1-NEXT:  @ %bb.1:
; THUMB1-NEXT:    movs r0, #3
; THUMB1-NEXT:  .LBB12_2: @ %entry
; THUMB1-NEXT:    bx lr
;
; THUMB2-LABEL: t13:
; THUMB2:       @ %bb.0: @ %entry
; THUMB2-NEXT:    cmp r0, #0
; THUMB2-NEXT:    it ne
; THUMB2-NEXT:    movne r0, #3
; THUMB2-NEXT:    bx lr
;
; V8MBASE-LABEL: t13:
; V8MBASE:       @ %bb.0: @ %entry
; V8MBASE-NEXT:    cbz r0, .LBB12_2
; V8MBASE-NEXT:  @ %bb.1:
; V8MBASE-NEXT:    movs r0, #3
; V8MBASE-NEXT:  .LBB12_2: @ %entry
; V8MBASE-NEXT:    bx lr
entry:
  %tobool = icmp ne i32 %a, 0
  %lnot.ext = select i1 %tobool, i32 3, i32 0
  ret i32 %lnot.ext
}