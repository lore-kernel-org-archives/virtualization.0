Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244D4A64CA
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451657; cv=none; b=cuGiiL0wt1CEYVR3k3T5ZWZrPf/EFPL4KadM/Kh6TBlUjd/JdaYbJR/5vOoRhBHbufuN7XEn0uu24+SQSkEs4Oi3WxU7w5xB3QrnEvzHVeOc5MBHn6992u9jle2+TmVpM3/EiT/KD6Tj7zzIxRslGl05ZIKvDO00poyxF3NT3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451657; c=relaxed/simple;
	bh=1KHlc1wHj45U9E/CloOnejb8Z/oRbJCgq5P42bIgUC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ry0Nvy/Z1D0M0JDtKNlJ0qVk9Jbs/yJoBbKjjnTIvqci/c2+2zYf5G9MfXIasrM44QMVSgLuZzEz0zPe3YQVOm99lLHqd2pBEb9FjgjRZAqMfeRDeUCkvWSgorbed9yB61MZEbalUvZzkhxE6Ach68QnD/GFn5X65kHKf5JbgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AdsRe8xt; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AdsRe8xt"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-39266382df6so2357242a91.3
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 09:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451655; x=1789056455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DQ17Gra4qRIZ9+bjeO8XFOZVaIoBgdk+Vd/GhAwUauw=;
        b=GQZ8VScOHYqTkxRGYmEnc2/eFc1cb3gaU9IBh3at8Cn4+B4XqSX76PVTbjn3iHhPs0
         /3p/L9G/Q44qpVe3M5H6Rg5MKFL6ExxJ29SqK210UBSpLp6XQkuG0PlKot/xVZ6ObxB1
         KIIRj1w8WODYOreoQ0AkqBV7pXb2Ki+xN1JDF9xPcI36+cEDwFWTvqVe9bpUltUoG1+r
         b6gPZvpiVeEeBeprtgTHOq4J9pPzAc1VK0+0OqQNcoDiYnpthm9LLzQRDxDOD035BBR8
         A32w9d0vK9XAlXZvv4ZNrgCb2vNyTap+2u6pKc2NBbJZNIL+a155jSuxrV6W8YPUuuhd
         SmBw==
X-Forwarded-Encrypted: i=1; AKwUvBySXTItBIy2QK9OhOT1rlC2lQBmDUEGnloeu6PxDXsjv4SpPR019icfajEGHN3+mGPnTKiR9FcIDUAb/ZS8lA==@lists.linux.dev
X-Gm-Message-State: AFuF++nmC1+7Ka2yX1OFhsxFesk3xTMgOBkb7lGnzd65UaRwYsxuU/Md
	G2e6nfGsHEnoL1tTSxT57AQynRjcSZHOjaMS6yXTirbq8NRnYDqFWXgz+pbKGOlT3RSFI/3LVIc
	K8aO5Q3iM4tLZR4vXlm/onGB72I15sFZgJE8fHyexdsIQGCJPsqiQKJVKZNl3ute/8ZbXjMgtRt
	KXpkGTKRCFMC0+QfB5wHcCmIy6oDCkIp+9EaKNV2prQ1TBnY5nAn9mcFlLiMd92oO1rKGUrAjIT
	akR94494fsf+JeQtIo=
X-Gm-Gg: AYBFou0qe9YB/8BXt8evwYV6hTxgNwuhUhKDvIcQN1pwQ/0DykS+PnZSXrU2sbBEfWK
	OQFesWQb8yEu/C4tgeNi1fkepMFWFj7O9+b9z+76uAovoC6CBTJPwyAy13xPqBH2+NUa1vKeI3s
	bRFEMcM87ZmA8zQ4uAlPftbG/9Ev9gk1QnGFToPelM6bswkzpEeBpD2+nn5sY8/M9/5uPdX3fff
	VyYPB8wG6Uojgqggfa23YejBOVe8ZuQb7VbmJs0X9yCQKoGUz7sN+xQc7CunKomIqV95GjieD/A
	/LUfianTfevQVO3e2Bq3fsDq6N5nMx6IM2UGSh3sWrE/huhVHtfCE/TVqlhf3WPK0RZwlsfAijx
	Dms7iuu4mvvwN2R/bZeBXgPCsELUBk2v5QNX2HlUQsf+Vn8elw0c1D60Y3gaYJlUsxKheca7y1K
	URHHvuLMsL66TZrjHUDg9LzP5+Cy/NaAC6
X-Received: by 2002:a17:90b:3846:b0:398:9be6:f997 with SMTP id 98e67ed59e1d1-39aee16a175mr19226338a91.22.1788451654981;
        Thu, 03 Sep 2026 09:07:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b16974a31sm1131520a91.7.2026.09.03.09.07.34
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 09:07:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b8088202so64445a12.3
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788451653; x=1789056453; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQ17Gra4qRIZ9+bjeO8XFOZVaIoBgdk+Vd/GhAwUauw=;
        b=AdsRe8xtuQeA4Ot5Xxzyp2x066Ch/2l6Dd3WXpEj4ktJqhF/hoSjmAAuaU7Hn2lBJo
         ktCvwua6zCbkrQng1PkvgpiaTKCRUwonWFZSILIIhiqDeAPmyfmTCbVDiRFIb14/OSjk
         gonNlkOExtfbVKDof2x0TEkHfYS5e2M7mFQsg=
X-Forwarded-Encrypted: i=1; AKwUvBzdTq7+sTHdnymSPUEHwlGxqTgQQnzh6CqZO6gOMDRlnl5hxJ8UVaudmJ5SgoBmqnH5/Xb0QHyvLKIL7YaISg==@lists.linux.dev
X-Received: by 2002:a17:90b:35d0:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39aee10890cmr21433005a91.18.1788451653197;
        Thu, 03 Sep 2026 09:07:33 -0700 (PDT)
X-Received: by 2002:a17:90b:35d0:b0:398:b46d:48c0 with SMTP id 98e67ed59e1d1-39aee10890cmr21432860a91.18.1788451652514;
        Thu, 03 Sep 2026 09:07:32 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e7167sm6172054a91.5.2026.09.03.09.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:07:31 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1] x86/vmware: Fix i386 high-bandwidth hypercall arguments
Date: Thu,  3 Sep 2026 12:07:20 -0400
Message-ID: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The high-bandwidth hypercall helpers push %ebp before loading the in6
operand into it. On i386 without frame pointers, both GCC and Clang can
address the memory-constrained operand relative to %esp. The push then
moves the stack and the helpers load the wrong value.

Typical i386 configurations use the frame-pointer unwinder and happen to
address the operand through %ebp. However, UNWINDER_GUESS is available
with EXPERT and permits the affected frame-pointer-disabled configuration.
vmwgfx is also available on i386 and calls both helpers.

Stage in6 through %eax before changing either stack register, then save
%ebp and copy the staged value into it. Load the VMware magic immediately
before the string I/O instruction. Mark %eax early-clobber so it cannot
also provide in6 or an address register for it. Use the same sequence on
x86-64, where the full-width register preserves in6.

Fixes: 34bf25e820ae ("x86/vmware: Introduce VMware hypercall API")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---

Notes:
    Built on v7.3-rc1 with W=1 on i386 using GCC and Clang, with frame
    pointers enabled and disabled. Disassembly in all four cases loads in6
    before changing %ebp or %esp.

 arch/x86/include/asm/vmware.h | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 4220dae14a2d..fb011cef01e7 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -276,20 +276,22 @@ unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
 
 	asm_inline volatile (
 		UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
 		"push %%" _ASM_BP "\n\t"
 		UNWIND_HINT_UNDEFINED
-		"mov %[in6], %%" _ASM_BP "\n\t"
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
 		"rep outsb\n\t"
 		"pop %%" _ASM_BP "\n\t"
 		UNWIND_HINT_RESTORE
-		: "=a" (out0), "=b" (*out1)
-		: "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (cmd),
+		: "=&a" (out0), "=b" (*out1)
+		: "b" (cmd),
 		  "c" (in2),
 		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
 		  "S" (in4),
 		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT (in6)
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
 		: "cc", "memory");
 	return out0;
 }
@@ -304,20 +306,22 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 
 	asm_inline volatile (
 		UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
 		"push %%" _ASM_BP "\n\t"
 		UNWIND_HINT_UNDEFINED
-		"mov %[in6], %%" _ASM_BP "\n\t"
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
 		"rep insb\n\t"
 		"pop %%" _ASM_BP "\n\t"
 		UNWIND_HINT_RESTORE
-		: "=a" (out0), "=b" (*out1)
-		: "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (cmd),
+		: "=&a" (out0), "=b" (*out1)
+		: "b" (cmd),
 		  "c" (in2),
 		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
 		  "S" (in4),
 		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT (in6)
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
 		: "cc", "memory");
 	return out0;
 }

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

