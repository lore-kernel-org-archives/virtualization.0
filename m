Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287FE28488D
	for <virtualization@lists.linux.dev>; Sat,  7 Mar 2026 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845614; cv=none; b=CCh9o+qLQwoBRJZUmllpfAvJ5k81KTBUjLnBMYhCTy2JWrjCNl5MQf1ggXTAivrFeDfQyThUqnI0KQhX/gtylpvxw+DZ2wBPKFZyQkIvBUK5kdj+d8lH3P6QbRxESAIHDWdjS2ypWEcUSVDz6SB9qIXQfogoFLnBFzFLzUydJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845614; c=relaxed/simple;
	bh=sYGIrnAJyjCt8iIoF30ta2b9Ec4Gre5mQsKFa6a6+tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFmiUoVofOVjniKOVT2P+6y71KDDvgO6koH+OKhxyUFNOVs8mMssxuYvp3P5X1lHZ545lC9P82AYZYbZIprEzZGZJ8xTweLT5oPhG24QgJ9YHosRX/BZXoYpip6GfVVJwZowuKPCLdbrQnc74JQ4oqP1t9zjxNOO9sgNeghWmNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YGxanQaA; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YGxanQaA"
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7d4c383f2fcso7038125a34.0
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 17:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845611; x=1773450411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDBpeRPGQkSyveVh0r0L9u3UrQSmg15QNxwWzbeb67Y=;
        b=TMKfcXy1D26CFBCVuI0IehpaFphxSkqDCYDzsjnA7s48T23AlTcBPvNbxNA3rAM8aV
         a6ytFswFMm9IJEefODE3BDWYKsgmmX9U1DqAlED2kLuwZ14FoVLCCAZeZESHPOxaj5Qq
         MijNLBYEL1IWPfC/aOdi73sYSVqFmZ6d0kbkTcMLnyypfzfYCee7R6kYdnyYM6T4Ko/S
         49FwjBkzGW/Pn/itEzNs98BqdQSTY+QUlC7FXLbL6Su+BeSx7RI+lI4UCpvn4Na8rEuA
         K4Clup2RyeXyf5x3D7ZFTlazRQWbbgeiDQTXC38Hv7SIEG87QJp8kb0yR69xqwaN+s5e
         w4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzEXJyl7IdTzFc35iMaObxurMrNlGeRAtG8Fr4oAIDLAohnbpR+us56W+dWYWbSjNbvAO7su5P7K4zooP4XA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhMOcZ6F9oR750Yg+cfUB5eADdtPKwFu6yr/HObjozYvoSwvqk
	4GOzYDid58U6BxB7ZolZ0+OytXnJYNx8xbdo2Y9jbfx/oFXFD/Wdiof1Wnsgtuj2MC1xImdnqjJ
	pjwp9QFdbD+UKnBoLM38cktj3YH+tUTny/qMfl9FEgvYboemOMW0EJg0zV9Uc0uGQW7KSXtjGtm
	uaB7y00na+p7ZjlCwMAgYoPjc6qEp7tTm+GCn3WjwoFj8yfWM3WTKYJzAiptXNMCDN1MkmfjJaN
	mdObEuU8JUHMbEhI3g4IrV8Xw==
X-Gm-Gg: ATEYQzwH6MduWqj1uUq5PiAOkYbXQN/jotnQkKLIr8/tyMOJiiKFKrMuYmSKoXjtzZN
	B5dIXl/UtpFLr7opcOoNNoG6c5Jcr4zoTNnr2z3+DtsrtfhZKrU8KETVUMbrnXVPUAsQCPRydNT
	YXGZ0L1DzPMBp0mH3eN6mTGMqiw7DbqXFn/U0UpFA4aZyAScDyr5CfHbzj4OM9B3r5CEk/lXZfX
	AY22tK1FDlam5PnoAEVj5jp4Mk7QzG2GMyltnvKVCunXgQHCmgoP4KnxisvUse+UA3rHavyL4Zn
	pMrYfaY/k3XqpesFwDVq+mwKcaQ7soRtHxcd9dl9p4DJItUscg2M7c5P4wDAtiJa/9BKyV+dPS+
	c7gCL28dfMAFaFGAyefSUxk266NfkW47fB4civbXPlnIZU510o7T3NAxhYKwxYrogQBp3bpquCN
	x5/FjjWJECGRALlHp669HwJZDTm62mEznt6UlXGr/i9VvHhNPBQ1jwZK0FNeCR
X-Received: by 2002:a05:6830:91c:b0:7cf:d9bb:639d with SMTP id 46e09a7af769-7d726f21965mr2826301a34.1.1772845609911;
        Fri, 06 Mar 2026 17:06:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-416e65dc4e1sm393026fac.7.2026.03.06.17.06.49
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 17:06:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2be07cafe1cso83359017eec.0
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 17:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772845608; x=1773450408; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDBpeRPGQkSyveVh0r0L9u3UrQSmg15QNxwWzbeb67Y=;
        b=YGxanQaAiWJDH1dX5IsUmHB4r4oz9KV5oIcuBx87CTJ2tpxjwMjQZU1zMbraMOcb3D
         Tiq593AWmh3gr1VUYdIf2SyVB+ciV+FfCzP8mQKNWrHrDWacg5RmHUGijy2QJdC+yPcb
         1CENV/2dSfCOokpOElNhjIkmi6e984oRiYbDo=
X-Forwarded-Encrypted: i=1; AJvYcCV5r5orVh+a4ds1VA4KB0dZ2kiCssM7srwm4evLoU+XuZS6d+napPzMPc2Km0m2opwHp5F5u2lfNvi13a07nw==@lists.linux.dev
X-Received: by 2002:a05:7300:fd0e:b0:2be:53a:5f4 with SMTP id 5a478bee46e88-2be4deac6f0mr1729608eec.9.1772845607972;
        Fri, 06 Mar 2026 17:06:47 -0800 (PST)
X-Received: by 2002:a05:7300:fd0e:b0:2be:53a:5f4 with SMTP id 5a478bee46e88-2be4deac6f0mr1729584eec.9.1772845606909;
        Fri, 06 Mar 2026 17:06:46 -0800 (PST)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80cc1dsm2237336eec.3.2026.03.06.17.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:06:46 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: x86@kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: ajay.kaher@broadcom.com,
	brennan.lamoreaux@broadcom.com,
	bo.gan@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	linux-coco@lists.linux.dev,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/4] x86/vmware: Introduce common vmware_hypercall()
Date: Sat,  7 Mar 2026 00:42:35 +0000
Message-ID: <20260307004238.1181299-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
References: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Introduce vmware_hypercall(), a unified low-bandwidth VMware hypercall
API, and convert the static inlines vmware_hypercallX() family into thin
wrappers on top of it.

vmware_hypercall() is implemented as a static call with four backend
implementations: backdoor, vmcall, vmmcall, and tdxcall. All share the
same logical API but differ in their underlying register mappings.

By updating the static call target early during boot, before the first
hypercall is issued, the !alternatives_patched case no longer needs to
be handled. This allows removal of vmware_hypercall_slow().

The new API implements the widest practical hypercall use case: up to
six input and six output arguments. While this may be slightly less
efficient due to clobbering all six registers and moving unused
arguments - it avoids subtle ABI issues, including cases where other
hypervisors implementing VMware hypercalls corrupt registers.
See QEMU issue #3293 ("vmmouse driver corrupts upper 32 bits of
registers on x86-64") for an example of such behavior.

Additionally, enhance the VMware hypercall ABI documentation in
<asm/vmware.h>.

Link: https://gitlab.com/qemu-project/qemu/-/issues/3293
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/include/asm/vmware.h | 274 ++++++++++++++-------------------
 arch/x86/kernel/cpu/vmware.c  | 276 +++++++++++++++++++---------------
 2 files changed, 267 insertions(+), 283 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 4220dae14a2d..6a084e088b30 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -3,48 +3,84 @@
 #define _ASM_X86_VMWARE_H
 
 #include <asm/cpufeatures.h>
-#include <asm/alternative.h>
 #include <linux/stringify.h>
+#include <linux/static_call.h>
 
 /*
  * VMware hypercall ABI.
  *
- * - Low bandwidth (LB) hypercalls (I/O port based, vmcall and vmmcall)
- * have up to 6 input and 6 output arguments passed and returned using
- * registers: %eax (arg0), %ebx (arg1), %ecx (arg2), %edx (arg3),
- * %esi (arg4), %edi (arg5).
- * The following input arguments must be initialized by the caller:
- * arg0 - VMWARE_HYPERVISOR_MAGIC
- * arg2 - Hypercall command
- * arg3 bits [15:0] - Port number, LB and direction flags
+ * - Low bandwidth (LB) hypercalls: I/O port based (aka backdoor), vmcall and
+ * vmmcall have up to 6 input and 6 output on registers arguments, with the
+ * register mapping:
+ *  +------+----------------------------------------+-----------------+
+ *  | Reg  | Input argument                         | Output argument |
+ *  +======+========================================+=================+
+ *  | %eax | VMWARE_HYPERVISOR_MAGIC                | out0            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %ebx | (in1)                                  | out1            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %ecx | (cmd) - Hypercall command              | out2            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %edx | Bits [15:0] - Port number for backdoor | out3            |
+ *  |      |               Zero for vmcall/vmmcall  |                 |
+ *  |      | Bits [31:16] - (in3)                   |                 |
+ *  +------+----------------------------------------+-----------------+
+ *  | %esi | (in4)                                  | out4            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %edi | (in5)                                  | out5            |
+ *  +------+----------------------------------------+-----------------+
  *
- * - Low bandwidth TDX hypercalls (x86_64 only) are similar to LB
- * hypercalls. They also have up to 6 input and 6 output on registers
- * arguments, with different argument to register mapping:
- * %r12 (arg0), %rbx (arg1), %r13 (arg2), %rdx (arg3),
- * %rsi (arg4), %rdi (arg5).
+ * - Low bandwidth TDX hypercalls (x86_64 only) are similar to LB hypercalls.
+ * They also have up to 6 input and 6 output on registers arguments, with
+ * different argument to register mapping:
+ *  +------+----------------------------------------+-----------------+
+ *  | Reg  | Input argument                         | Output argument |
+ *  +======+========================================+=================+
+ *  | %r12 | VMWARE_HYPERVISOR_MAGIC                | out0            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %ebx | (in1)                                  | out1            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %r13 | (cmd) - Hypercall command              | out2            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %edx | Bits [15:0] - Must be zero             | out3            |
+ *  |      | Bits [31:16] - (in3)                   |                 |
+ *  +------+----------------------------------------+-----------------+
+ *  | %esi | (in4)                                  | out4            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %edi | (in5)                                  | out5            |
+ *  +------+----------------------------------------+-----------------+
  *
- * - High bandwidth (HB) hypercalls are I/O port based only. They have
- * up to 7 input and 7 output arguments passed and returned using
- * registers: %eax (arg0), %ebx (arg1), %ecx (arg2), %edx (arg3),
- * %esi (arg4), %edi (arg5), %ebp (arg6).
- * The following input arguments must be initialized by the caller:
- * arg0 - VMWARE_HYPERVISOR_MAGIC
- * arg1 - Hypercall command
- * arg3 bits [15:0] - Port number, HB and direction flags
+ * - High bandwidth (HB) hypercalls are I/O port based only. They have up to 7
+ * input and 7 output on reegister arguments with the following mapping:
+ *  +------+----------------------------------------+-----------------+
+ *  | Reg  | Input argument                         | Output argument |
+ *  +======+========================================+=================+
+ *  | %eax | VMWARE_HYPERVISOR_MAGIC                | out0            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %ebx | (cmd) - Hypercall command              | out1            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %ebx | (in2)                                  | out2            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %edx | Bits [15:0] - Port number and HB flag  | out3            |
+ *  |      | Bits [31:16] - (in3)                   |                 |
+ *  +------+----------------------------------------+-----------------+
+ *  | %esi | (in4)                                  | out4            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %edi | (in5)                                  | out5            |
+ *  +------+----------------------------------------+-----------------+
+ *  | %ebp | (in6)                                  | out6            |
+ *  +------+----------------------------------------+-----------------+
  *
- * For compatibility purposes, x86_64 systems use only lower 32 bits
- * for input and output arguments.
+ * For compatibility purposes, x86_64 systems use only lower 32 bits for input
+ * and output arguments.
  *
- * The hypercall definitions differ in the low word of the %edx (arg3)
- * in the following way: the old I/O port based interface uses the port
- * number to distinguish between high- and low bandwidth versions, and
- * uses IN/OUT instructions to define transfer direction.
+ * The hypercall definitions differ in the low word of the %edx (arg3) in the
+ * following way: the old I/O port based interface uses the port number, the
+ * bandwidth mode flag, and uses IN/OUT instructions to define transfer
+ * direction.
  *
- * The new vmcall interface instead uses a set of flags to select
- * bandwidth mode and transfer direction. The flags should be loaded
- * into arg3 by any user and are automatically replaced by the port
- * number if the I/O port method is used.
+ * The new vmcall interface instead uses a set of flags to select bandwidth
+ * mode and transfer direction.
  */
 
 #define VMWARE_HYPERVISOR_HB		BIT(0)
@@ -70,103 +106,64 @@
 #define CPUID_VMWARE_FEATURES_ECX_VMMCALL	BIT(0)
 #define CPUID_VMWARE_FEATURES_ECX_VMCALL	BIT(1)
 
-extern unsigned long vmware_hypercall_slow(unsigned long cmd,
-					   unsigned long in1, unsigned long in3,
-					   unsigned long in4, unsigned long in5,
-					   u32 *out1, u32 *out2, u32 *out3,
-					   u32 *out4, u32 *out5);
-
 #define VMWARE_TDX_VENDOR_LEAF 0x1af7e4909ULL
 #define VMWARE_TDX_HCALL_FUNC  1
 
-extern unsigned long vmware_tdx_hypercall(unsigned long cmd,
-					  unsigned long in1, unsigned long in3,
-					  unsigned long in4, unsigned long in5,
-					  u32 *out1, u32 *out2, u32 *out3,
-					  u32 *out4, u32 *out5);
+unsigned long dummy_vmware_hypercall(unsigned long cmd,
+				     unsigned long in1, unsigned long in3,
+				     unsigned long in4, unsigned long in5,
+				     u32 *out1, u32 *out2, u32 *out3,
+				     u32 *out4, u32 *out5);
 
 /*
- * The low bandwidth call. The low word of %edx is presumed to have OUT bit
- * set. The high word of %edx may contain input data from the caller.
+ * Low bandwidth (LB) VMware hypercall.
+ *
+ * It is backed by the backdoor, vmcall, vmmcall or tdx call implementation.
+ *
+ * Use inX/outX arguments naming as the register mappings vary between
+ * different implementations. See VMware hypercall ABI above.
+ * These 10 arguments could be nicely wrapped in in/out structures, but it
+ * will introduce unnecessary structs copy in vmware_tdx_hypercall().
+ *
+ * NOTE:
+ * Do not merge vmware_{backdoor,vmcall,vmmcall}_hypercall implementations
+ * using alternative instructions. Such patching mechanism can not be used
+ * in vmware_hypercall path, as the first hypercall will be called much
+ * before the apply_alternatives(). See vmware_platform_setup().
  */
-#define VMWARE_HYPERCALL					\
-	ALTERNATIVE_2("movw %[port], %%dx\n\t"			\
-		      "inl (%%dx), %%eax",			\
-		      "vmcall", X86_FEATURE_VMCALL,		\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+DECLARE_STATIC_CALL(vmware_hypercall, dummy_vmware_hypercall);
 
+/*
+ * Set of commonly used vmware_hypercallX functions - wrappers on top of the
+ * vmware_hypercall.
+ */
 static inline
 unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
 {
-	unsigned long out0;
-
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
-		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0,
-					    NULL, NULL, NULL, NULL, NULL);
-
-	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
-		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
-					     NULL, NULL, NULL, NULL, NULL);
+	u32 out1, out2, out3, out4, out5;
 
-	asm_inline volatile (VMWARE_HYPERCALL
-		: "=a" (out0)
-		: [port] "i" (VMWARE_HYPERVISOR_PORT),
-		  "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (in1),
-		  "c" (cmd),
-		  "d" (0)
-		: "cc", "memory");
-	return out0;
+	return static_call_mod(vmware_hypercall)(cmd, in1, 0, 0, 0,
+			       &out1, &out2, &out3, &out4, &out5);
 }
 
 static inline
 unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
 				u32 *out1, u32 *out2)
 {
-	unsigned long out0;
-
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
-		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0,
-					    out1, out2, NULL, NULL, NULL);
-
-	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
-		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
-					     out1, out2, NULL, NULL, NULL);
+	u32 out3, out4, out5;
 
-	asm_inline volatile (VMWARE_HYPERCALL
-		: "=a" (out0), "=b" (*out1), "=c" (*out2)
-		: [port] "i" (VMWARE_HYPERVISOR_PORT),
-		  "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (in1),
-		  "c" (cmd),
-		  "d" (0)
-		: "di", "si", "cc", "memory");
-	return out0;
+	return static_call_mod(vmware_hypercall)(cmd, in1, 0, 0, 0,
+			       out1, out2, &out3, &out4, &out5);
 }
 
 static inline
 unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
 				u32 *out1, u32 *out2, u32 *out3)
 {
-	unsigned long out0;
-
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
-		return vmware_tdx_hypercall(cmd, in1, 0, 0, 0,
-					    out1, out2, out3, NULL, NULL);
-
-	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
-		return vmware_hypercall_slow(cmd, in1, 0, 0, 0,
-					     out1, out2, out3, NULL, NULL);
+	u32 out4, out5;
 
-	asm_inline volatile (VMWARE_HYPERCALL
-		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
-		: [port] "i" (VMWARE_HYPERVISOR_PORT),
-		  "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (in1),
-		  "c" (cmd),
-		  "d" (0)
-		: "di", "si", "cc", "memory");
-	return out0;
+	return static_call_mod(vmware_hypercall)(cmd, in1, 0, 0, 0,
+			       out1, out2, out3, &out4, &out5);
 }
 
 static inline
@@ -174,27 +171,10 @@ unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
 				unsigned long in3, unsigned long in4,
 				unsigned long in5, u32 *out2)
 {
-	unsigned long out0;
-
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
-		return vmware_tdx_hypercall(cmd, in1, in3, in4, in5,
-					    NULL, out2, NULL, NULL, NULL);
+	u32 out1, out3, out4, out5;
 
-	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
-		return vmware_hypercall_slow(cmd, in1, in3, in4, in5,
-					     NULL, out2, NULL, NULL, NULL);
-
-	asm_inline volatile (VMWARE_HYPERCALL
-		: "=a" (out0), "=c" (*out2)
-		: [port] "i" (VMWARE_HYPERVISOR_PORT),
-		  "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (in1),
-		  "c" (cmd),
-		  "d" (in3),
-		  "S" (in4),
-		  "D" (in5)
-		: "cc", "memory");
-	return out0;
+	return static_call_mod(vmware_hypercall)(cmd, in1, in3, in4, in5,
+			       &out1, out2, &out3, &out4, &out5);
 }
 
 static inline
@@ -202,26 +182,10 @@ unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
 				unsigned long in3, u32 *out2,
 				u32 *out3, u32 *out4, u32 *out5)
 {
-	unsigned long out0;
-
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
-		return vmware_tdx_hypercall(cmd, in1, in3, 0, 0,
-					    NULL, out2, out3, out4, out5);
+	u32 out1;
 
-	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
-		return vmware_hypercall_slow(cmd, in1, in3, 0, 0,
-					     NULL, out2, out3, out4, out5);
-
-	asm_inline volatile (VMWARE_HYPERCALL
-		: "=a" (out0), "=c" (*out2), "=d" (*out3), "=S" (*out4),
-		  "=D" (*out5)
-		: [port] "i" (VMWARE_HYPERVISOR_PORT),
-		  "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (in1),
-		  "c" (cmd),
-		  "d" (in3)
-		: "cc", "memory");
-	return out0;
+	return static_call_mod(vmware_hypercall)(cmd, in1, in3, 0, 0,
+			       &out1, out2, out3, out4, out5);
 }
 
 static inline
@@ -230,27 +194,10 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
 				unsigned long in5, u32 *out1,
 				u32 *out2, u32 *out3)
 {
-	unsigned long out0;
-
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
-		return vmware_tdx_hypercall(cmd, in1, in3, in4, in5,
-					    out1, out2, out3, NULL, NULL);
+	u32 out4, out5;
 
-	if (unlikely(!alternatives_patched) && !__is_defined(MODULE))
-		return vmware_hypercall_slow(cmd, in1, in3, in4, in5,
-					     out1, out2, out3, NULL, NULL);
-
-	asm_inline volatile (VMWARE_HYPERCALL
-		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
-		: [port] "i" (VMWARE_HYPERVISOR_PORT),
-		  "a" (VMWARE_HYPERVISOR_MAGIC),
-		  "b" (in1),
-		  "c" (cmd),
-		  "d" (in3),
-		  "S" (in4),
-		  "D" (in5)
-		: "cc", "memory");
-	return out0;
+	return static_call_mod(vmware_hypercall)(cmd, in1, in3, in4, in5,
+			       out1, out2, out3, &out4, &out5);
 }
 
 #ifdef CONFIG_X86_64
@@ -322,6 +269,5 @@ unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 	return out0;
 }
 #undef VMW_BP_CONSTRAINT
-#undef VMWARE_HYPERCALL
 
 #endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index a3e6936839b1..93acd3414e37 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -64,70 +64,140 @@ struct vmware_steal_time {
 };
 
 static unsigned long vmware_tsc_khz __ro_after_init;
-static u8 vmware_hypercall_mode     __ro_after_init;
-
-unsigned long vmware_hypercall_slow(unsigned long cmd,
-				    unsigned long in1, unsigned long in3,
-				    unsigned long in4, unsigned long in5,
-				    u32 *out1, u32 *out2, u32 *out3,
-				    u32 *out4, u32 *out5)
-{
-	unsigned long out0, rbx, rcx, rdx, rsi, rdi;
-
-	switch (vmware_hypercall_mode) {
-	case CPUID_VMWARE_FEATURES_ECX_VMCALL:
-		asm_inline volatile ("vmcall"
-				: "=a" (out0), "=b" (rbx), "=c" (rcx),
-				"=d" (rdx), "=S" (rsi), "=D" (rdi)
-				: "a" (VMWARE_HYPERVISOR_MAGIC),
-				"b" (in1),
-				"c" (cmd),
-				"d" (in3),
-				"S" (in4),
-				"D" (in5)
-				: "cc", "memory");
-		break;
-	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:
-		asm_inline volatile ("vmmcall"
-				: "=a" (out0), "=b" (rbx), "=c" (rcx),
-				"=d" (rdx), "=S" (rsi), "=D" (rdi)
-				: "a" (VMWARE_HYPERVISOR_MAGIC),
-				"b" (in1),
-				"c" (cmd),
-				"d" (in3),
-				"S" (in4),
-				"D" (in5)
-				: "cc", "memory");
-		break;
-	default:
-		asm_inline volatile ("movw %[port], %%dx; inl (%%dx), %%eax"
-				: "=a" (out0), "=b" (rbx), "=c" (rcx),
-				"=d" (rdx), "=S" (rsi), "=D" (rdi)
-				: [port] "i" (VMWARE_HYPERVISOR_PORT),
-				"a" (VMWARE_HYPERVISOR_MAGIC),
-				"b" (in1),
-				"c" (cmd),
-				"d" (in3),
-				"S" (in4),
-				"D" (in5)
-				: "cc", "memory");
-		break;
-	}
+static u8 vmware_hypercall_mode     __initdata;
+
+static unsigned long vmware_backdoor_hypercall(unsigned long cmd,
+			       unsigned long in1, unsigned long in3,
+			       unsigned long in4, unsigned long in5,
+			       u32 *out1, u32 *out2, u32 *out3,
+			       u32 *out4, u32 *out5)
+{
+	unsigned long out0;
+
+	/* The low word of in3(%edx) must have the backdoor port number */
+	in3 = (in3 & ~0xffff) | VMWARE_HYPERVISOR_PORT;
+
+	asm_inline volatile ("inl (%%dx), %%eax"
+		: "=a" (out0), "=b" (*out1), "=c" (*out2),
+		  "=d" (*out3), "=S" (*out4), "=D" (*out5)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
 
-	if (out1)
-		*out1 = rbx;
-	if (out2)
-		*out2 = rcx;
-	if (out3)
-		*out3 = rdx;
-	if (out4)
-		*out4 = rsi;
-	if (out5)
-		*out5 = rdi;
+	return out0;
+}
+
+static unsigned long vmware_vmcall_hypercall(unsigned long cmd,
+			       unsigned long in1, unsigned long in3,
+			       unsigned long in4, unsigned long in5,
+			       u32 *out1, u32 *out2, u32 *out3,
+			       u32 *out4, u32 *out5)
+{
+	unsigned long out0;
+
+	/* The low word of in3(%edx) must be zero: LB, IN */
+	in3 &= ~0xffff;
+
+	asm_inline volatile ("vmcall"
+		: "=a" (out0), "=b" (*out1), "=c" (*out2),
+		  "=d" (*out3), "=S" (*out4), "=D" (*out5)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
 
 	return out0;
 }
 
+static unsigned long vmware_vmmcall_hypercall(unsigned long cmd,
+			       unsigned long in1, unsigned long in3,
+			       unsigned long in4, unsigned long in5,
+			       u32 *out1, u32 *out2, u32 *out3,
+			       u32 *out4, u32 *out5)
+{
+	unsigned long out0;
+
+	/* The low word of in3(%edx) must be zero: LB, IN */
+	in3 &= ~0xffff;
+
+	asm_inline volatile ("vmmcall"
+		: "=a" (out0), "=b" (*out1), "=c" (*out2),
+		  "=d" (*out3), "=S" (*out4), "=D" (*out5)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
+
+	return out0;
+}
+
+/*
+ * TDCALL[TDG.VP.VMCALL] uses %rax (arg0) and %rcx (arg2). Therefore,
+ * we remap those registers to %r12 and %r13, respectively.
+ */
+static unsigned long vmware_tdx_hypercall(unsigned long cmd,
+				   unsigned long in1, unsigned long in3,
+				   unsigned long in4, unsigned long in5,
+				   u32 *out1, u32 *out2, u32 *out3,
+				   u32 *out4, u32 *out5)
+{
+#ifdef CONFIG_INTEL_TDX_GUEST
+	struct tdx_module_args args = {};
+
+	if (!hypervisor_is_type(X86_HYPER_VMWARE)) {
+		pr_warn_once("Incorrect usage\n");
+		return ULONG_MAX;
+	}
+
+	if (cmd & ~VMWARE_CMD_MASK) {
+		pr_warn_once("Out of range command %lx\n", cmd);
+		return ULONG_MAX;
+	}
+
+	args.rbx = in1;
+	/* The low word of in3(%rdx) must be zero: LB, IN */
+	args.rdx = in3 & ~0xffff;
+	args.rsi = in4;
+	args.rdi = in5;
+	args.r10 = VMWARE_TDX_VENDOR_LEAF;
+	args.r11 = VMWARE_TDX_HCALL_FUNC;
+	args.r12 = VMWARE_HYPERVISOR_MAGIC;
+	args.r13 = cmd;
+	/* CPL */
+	args.r15 = 0;
+
+	__tdx_hypercall(&args);
+
+	*out1 = args.rbx;
+	*out2 = args.r13;
+	*out3 = args.rdx;
+	*out4 = args.rsi;
+	*out5 = args.rdi;
+
+	return args.r12;
+#else
+	return ULONG_MAX;
+#endif
+}
+
+
+DEFINE_STATIC_CALL(vmware_hypercall, vmware_backdoor_hypercall);
+EXPORT_STATIC_CALL_GPL(vmware_hypercall);
+
+/*
+ * Perform backdoor probbing of the hypervisor when
+ * X86_FEATURE_HYPERVISOR bit is not set.
+ */
 static inline int __vmware_platform(void)
 {
 	u32 eax, ebx, ecx;
@@ -397,11 +467,35 @@ static void __init vmware_set_capabilities(void)
 		setup_force_cpu_cap(X86_FEATURE_VMW_VMMCALL);
 }
 
+static void __init vmware_select_hypercall(void)
+{
+	char *mode;
+
+	if (IS_ENABLED(CONFIG_INTEL_TDX_GUEST) &&
+	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		static_call_update(vmware_hypercall, vmware_tdx_hypercall);
+		mode = "tdcall";
+	} else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL) {
+		static_call_update(vmware_hypercall, vmware_vmcall_hypercall);
+		mode = "vmcall";
+	} else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL) {
+		static_call_update(vmware_hypercall, vmware_vmmcall_hypercall);
+		mode = "vmmcall";
+	} else {
+		mode = "backdoor";
+	}
+
+	pr_info("hypercall mode: %s\n", mode);
+}
+
 static void __init vmware_platform_setup(void)
 {
 	u32 eax, ebx, ecx;
 	u64 lpj, tsc_khz;
 
+	/* Update vmware_hypercall() before the first use. */
+	vmware_select_hypercall();
+
 	eax = vmware_hypercall3(VMWARE_CMD_GETHZ, UINT_MAX, &ebx, &ecx);
 
 	if (ebx != UINT_MAX) {
@@ -443,7 +537,7 @@ static void __init vmware_platform_setup(void)
 	vmware_set_capabilities();
 }
 
-static u8 __init vmware_select_hypercall(void)
+static u8 __init get_hypercall_mode(void)
 {
 	int eax, ebx, ecx, edx;
 
@@ -456,8 +550,8 @@ static u8 __init vmware_select_hypercall(void)
  * While checking the dmi string information, just checking the product
  * serial key should be enough, as this will always have a VMware
  * specific string when running under VMware hypervisor.
- * If !boot_cpu_has(X86_FEATURE_HYPERVISOR), vmware_hypercall_mode
- * intentionally defaults to 0.
+ * If !boot_cpu_has(X86_FEATURE_HYPERVISOR), __vmware_platform()
+ * intentionally defaults to backdoor hypercall.
  */
 static u32 __init vmware_platform(void)
 {
@@ -470,11 +564,7 @@ static u32 __init vmware_platform(void)
 		if (!memcmp(hyper_vendor_id, "VMwareVMware", 12)) {
 			if (eax >= CPUID_VMWARE_FEATURES_LEAF)
 				vmware_hypercall_mode =
-					vmware_select_hypercall();
-
-			pr_info("hypercall mode: 0x%02x\n",
-				(unsigned int) vmware_hypercall_mode);
-
+					get_hypercall_mode();
 			return CPUID_VMWARE_INFO_LEAF;
 		}
 	} else if (dmi_available && dmi_name_in_serial("VMware") &&
@@ -494,58 +584,6 @@ static bool __init vmware_legacy_x2apic_available(void)
 		(eax & GETVCPU_INFO_LEGACY_X2APIC);
 }
 
-#ifdef CONFIG_INTEL_TDX_GUEST
-/*
- * TDCALL[TDG.VP.VMCALL] uses %rax (arg0) and %rcx (arg2). Therefore,
- * we remap those registers to %r12 and %r13, respectively.
- */
-unsigned long vmware_tdx_hypercall(unsigned long cmd,
-				   unsigned long in1, unsigned long in3,
-				   unsigned long in4, unsigned long in5,
-				   u32 *out1, u32 *out2, u32 *out3,
-				   u32 *out4, u32 *out5)
-{
-	struct tdx_module_args args = {};
-
-	if (!hypervisor_is_type(X86_HYPER_VMWARE)) {
-		pr_warn_once("Incorrect usage\n");
-		return ULONG_MAX;
-	}
-
-	if (cmd & ~VMWARE_CMD_MASK) {
-		pr_warn_once("Out of range command %lx\n", cmd);
-		return ULONG_MAX;
-	}
-
-	args.rbx = in1;
-	args.rdx = in3;
-	args.rsi = in4;
-	args.rdi = in5;
-	args.r10 = VMWARE_TDX_VENDOR_LEAF;
-	args.r11 = VMWARE_TDX_HCALL_FUNC;
-	args.r12 = VMWARE_HYPERVISOR_MAGIC;
-	args.r13 = cmd;
-	/* CPL */
-	args.r15 = 0;
-
-	__tdx_hypercall(&args);
-
-	if (out1)
-		*out1 = args.rbx;
-	if (out2)
-		*out2 = args.r13;
-	if (out3)
-		*out3 = args.rdx;
-	if (out4)
-		*out4 = args.rsi;
-	if (out5)
-		*out5 = args.rdi;
-
-	return args.r12;
-}
-EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
-#endif
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
 					struct pt_regs *regs)
-- 
2.43.7

