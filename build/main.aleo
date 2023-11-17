program shamir.aleo;

record SecretPart:
    owner as address.private;
    x as field.private;
    y as field.private;

struct Share:
    x as field;
    y as field;




function create_shares:
    input r0 as field.private;
    input r1 as u8.private;
    input r2 as field.private;
    input r3 as [address; 5u32].private;
    cast 0field into r4 as address;
    is.neq r3[0u32] r4 into r5;
    add 0u8 1u8 into r6;
    ternary r5 r6 0u8 into r7;
    is.neq r3[1u32] r4 into r8;
    add r7 1u8 into r9;
    ternary r8 r9 r7 into r10;
    is.neq r3[2u32] r4 into r11;
    add r10 1u8 into r12;
    ternary r11 r12 r10 into r13;
    is.neq r3[3u32] r4 into r14;
    add r13 1u8 into r15;
    ternary r14 r15 r13 into r16;
    lte r1 r16 into r17;
    assert.eq r17 true;
    hash.bhp256 r2 into r18 as field;
    add r2 1field into r19;
    hash.bhp256 r19 into r20 as field;
    mul r18 1field into r21;
    mul r21 1field into r22;
    mul r20 1field into r23;
    add r22 r23 into r24;
    add r24 r0 into r25;
    cast r3[0u32] 1field r25 into r26 as SecretPart.record;
    mul r18 2field into r27;
    mul r27 2field into r28;
    mul r20 2field into r29;
    add r28 r29 into r30;
    add r30 r0 into r31;
    cast r3[1u32] 2field r31 into r32 as SecretPart.record;
    mul r18 3field into r33;
    mul r33 3field into r34;
    mul r20 3field into r35;
    add r34 r35 into r36;
    add r36 r0 into r37;
    cast r3[2u32] 3field r37 into r38 as SecretPart.record;
    mul r18 4field into r39;
    mul r39 4field into r40;
    mul r20 4field into r41;
    add r40 r41 into r42;
    add r42 r0 into r43;
    cast r3[3u32] 4field r43 into r44 as SecretPart.record;
    mul r18 5field into r45;
    mul r45 5field into r46;
    mul r20 5field into r47;
    add r46 r47 into r48;
    add r48 r0 into r49;
    cast r3[4u32] 5field r49 into r50 as SecretPart.record;
    output r26 as SecretPart.record;
    output r32 as SecretPart.record;
    output r38 as SecretPart.record;
    output r44 as SecretPart.record;
    output r50 as SecretPart.record;


function restore_secret_from_shares:
    input r0 as Share.private;
    input r1 as Share.private;
    input r2 as Share.private;
    sub 0field r1.x into r3;
    mul r0.y r3 into r4;
    sub r0.x r1.x into r5;
    div r4 r5 into r6;
    sub 0field r2.x into r7;
    mul r6 r7 into r8;
    sub r0.x r2.x into r9;
    div r8 r9 into r10;
    sub 0field r0.x into r11;
    mul r1.y r11 into r12;
    sub r1.x r0.x into r13;
    div r12 r13 into r14;
    sub 0field r2.x into r15;
    mul r14 r15 into r16;
    sub r1.x r2.x into r17;
    div r16 r17 into r18;
    add r10 r18 into r19;
    sub 0field r0.x into r20;
    mul r2.y r20 into r21;
    sub r2.x r0.x into r22;
    div r21 r22 into r23;
    sub 0field r1.x into r24;
    mul r23 r24 into r25;
    sub r2.x r1.x into r26;
    div r25 r26 into r27;
    add r19 r27 into r28;
    output r28 as field.private;


function restore_secret_from_n_shares:
    input r0 as u8.private;
    input r1 as [Share; 5u32].private;
    is.eq r0 2u8 into r2;
    sub 0field r1[1u32].x into r3;
    mul r1[0u32].y r3 into r4;
    sub r1[0u32].x r1[1u32].x into r5;
    div r4 r5 into r6;
    sub 0field r1[0u32].x into r7;
    mul r1[1u32].y r7 into r8;
    sub r1[1u32].x r1[0u32].x into r9;
    div r8 r9 into r10;
    add r6 r10 into r11;
    is.eq r0 3u8 into r12;
    sub 0field r1[1u32].x into r13;
    mul r1[0u32].y r13 into r14;
    sub r1[0u32].x r1[1u32].x into r15;
    div r14 r15 into r16;
    sub 0field r1[2u32].x into r17;
    mul r16 r17 into r18;
    sub r1[0u32].x r1[2u32].x into r19;
    div r18 r19 into r20;
    sub 0field r1[0u32].x into r21;
    mul r1[1u32].y r21 into r22;
    sub r1[1u32].x r1[0u32].x into r23;
    div r22 r23 into r24;
    sub 0field r1[2u32].x into r25;
    mul r24 r25 into r26;
    sub r1[1u32].x r1[2u32].x into r27;
    div r26 r27 into r28;
    add r20 r28 into r29;
    sub 0field r1[0u32].x into r30;
    mul r1[2u32].y r30 into r31;
    sub r1[2u32].x r1[0u32].x into r32;
    div r31 r32 into r33;
    sub 0field r1[1u32].x into r34;
    mul r33 r34 into r35;
    sub r1[2u32].x r1[1u32].x into r36;
    div r35 r36 into r37;
    add r29 r37 into r38;
    ternary r12 r38 0field into r39;
    ternary r2 r11 r39 into r40;
    output r40 as field.private;


function restore_secret:
    input r0 as SecretPart.record;
    input r1 as SecretPart.record;
    input r2 as SecretPart.record;
    sub 0field r1.x into r3;
    mul r0.y r3 into r4;
    sub r0.x r1.x into r5;
    div r4 r5 into r6;
    sub 0field r2.x into r7;
    mul r6 r7 into r8;
    sub r0.x r2.x into r9;
    div r8 r9 into r10;
    sub 0field r0.x into r11;
    mul r1.y r11 into r12;
    sub r1.x r0.x into r13;
    div r12 r13 into r14;
    sub 0field r2.x into r15;
    mul r14 r15 into r16;
    sub r1.x r2.x into r17;
    div r16 r17 into r18;
    add r10 r18 into r19;
    sub 0field r0.x into r20;
    mul r2.y r20 into r21;
    sub r2.x r0.x into r22;
    div r21 r22 into r23;
    sub 0field r1.x into r24;
    mul r23 r24 into r25;
    sub r2.x r1.x into r26;
    div r25 r26 into r27;
    add r19 r27 into r28;
    output r28 as field.private;
