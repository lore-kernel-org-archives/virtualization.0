Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26C72618
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 00:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101835; cv=none; b=bg8Od2iNEJ29P5ejV4527okMbXcLGTfvEQbh/QgYPymhlhAdILyIr4Y2zR7Q34+sqbVfhzUDaV50/1zQpzLOgBuFW7Rbasc0DrSM7WgQUGufn725j0cD4Aw7Xbg6iRCFEJwTUvNLqZoThi+J4czXa7H76Hx1/FSnXTqcoO3t108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101835; c=relaxed/simple;
	bh=sYGIrnAJyjCt8iIoF30ta2b9Ec4Gre5mQsKFa6a6+tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzVMqHO8kSzxEM0OOksAHdnafNmN3s18BTnVu5eI/lMd1hp87YOZf2M6M4MgFuZJlsR02D/7LTbYk4QwOOkTnvWttFZSoVwJ0nrgqbd5SCIbXra4pcQCjGbcBjK6L3tzuoIs/FS+TaA124ja7XSDun5iZTJK9PY4eTQ6nhnPRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ViTIPcEp; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ViTIPcEp"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso2236249a12.0
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 17:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101832; x=1773706632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDBpeRPGQkSyveVh0r0L9u3UrQSmg15QNxwWzbeb67Y=;
        b=E+3yOA8R2DPwrqPflyEMoRE+ei+LgQlYaONh/84zEqMWBmN8WVk+9lFgwBOxnR4r5g
         WSlPmtmCDOzIlmzHjF8NIcwUx+kEcrPvr9w2+qftrBnpEIaFmzcO66EZcuoO2E3lDlSC
         vXdGM/MmOw1PMtQYL0Yrm27BaZ3sgft+79w3yPI+jV6asEEpGfLNqu4T7bUQL9ZBiPXM
         MX7d5vliSuIok142D9e4PdUGA+FBjn/k9HGOn8c6RViF+q76mdufXJ6WqTqtGWZIn7BR
         6oG2CX3GbjA8Wk7WZCM9IV69j7XvPMrijroZQC2j2YTUMdZWq8C8P4C54nS6nkpCC8Bj
         fOiw==
X-Forwarded-Encrypted: i=1; AJvYcCUX5U9zVDSVb8AE5ot2SfndyqP/3ZRCOrdgcbKyVpWzPD3ypitcwptc+LpZuvQW36wgEVXK4quNYCzwPNIjdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZZ+OigDdYfcIIoKFPyAqIEBkhuEJQpE1VtEeo+GN0gVwXnu9e
	O+I4vOzZEzmGSjE69+CXk3VyY5MEERixSHAeT+w+XvFFYUzTKmIpkeYyYoL6BpXM72pmTrqf2KG
	f3bz3bv7C+YPJDTGUQnt3mQh/smRzxltlAXD7g5iec/fUhfKsoOz1/Gj5w820gtxlwmKSJwF4eg
	2K3LWN5fKUzXPCm9SDw8KxcK8L9AsdCILHdBv7my9O1OusmlIInKNW4Hh0b0IKu1F5WMUljoCwa
	Yk8LMtye/vYhoPc3bbUgC5HdA==
X-Gm-Gg: ATEYQzxu/yd0TT0xq1E7TsjTOVh6L7ULso0S1ggepaH++iIIlsvQCAduf07jM356FEJ
	NWLOHRMlyUj+OuZXQGsI0MkmsOCZ94eedJBpyiKWjt4zhkdzlkt8/408ntSutObtYmyTI0rwtbQ
	jVBfZHIxL9jlwPqwhTCyGpyRkxm2XGry5IGbkhc5M72phMWp/e8MCC0fhQuoQtv0UtdMjZ8oCkA
	69Fb2lAPUFq1gdQ8A76sedzs/q6nXqJ235DPsRiKQZhtP/8jxcuDrJF36qN788uzk8wjOsIm8je
	Wir3My0kTDjd6Bba1j40mlNWkR5cSN3G3EVu+MySHFVnTvwuzGA14fdB0i0mObiB45vAfkF0xp9
	rdEKRs9sQZaBvMRCyopXgLxZYp4FqfAm3kjTp2TPs5VaEMFrBkRrg+THzFdUNdTeNa2uMQ7Q+nV
	HkBlldPk/hxIviXBcwsgfoUVOrGvCPDh1v8KSx3rAeUcpkaQDALBiQpmuXhDcf
X-Received: by 2002:a17:903:f87:b0:2ae:44f4:1678 with SMTP id d9443c01a7336-2ae824b83e7mr120783475ad.57.1773101832327;
        Mon, 09 Mar 2026 17:17:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae83f481bcsm16724335ad.46.2026.03.09.17.17.11
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:17:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2be2f742c46so61826140eec.0
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 17:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773101830; x=1773706630; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDBpeRPGQkSyveVh0r0L9u3UrQSmg15QNxwWzbeb67Y=;
        b=ViTIPcEp3CpGNmp32paSx5PwbSM1/vrLX3udXeGY3S0Tv1xZlXMnjzJv+eA6VUYaLf
         Ed5yMkBodTImk164jXJ8/hUcqRet8hYKncv4jdLCvBoKv48inMYEuBgP2edXS4azFgOH
         pGQtsRVKE1ips7ZVIbG/hG/Y1gAiwSfg79XpM=
X-Forwarded-Encrypted: i=1; AJvYcCV5Q/a2S3n3YrcqUSDDXkkkOTwJV7RoyLXFy++O8w42/i7J4eLNpWF67O1ZJSVdAcAtwAnBpRK6hzcOkvL/kw==@lists.linux.dev
X-Received: by 2002:a05:7300:8623:b0:2be:2409:6c6e with SMTP id 5a478bee46e88-2be4de767damr6029549eec.5.1773101830115;
        Mon, 09 Mar 2026 17:17:10 -0700 (PDT)
X-Received: by 2002:a05:7300:8623:b0:2be:2409:6c6e with SMTP id 5a478bee46e88-2be4de767damr6029533eec.5.1773101829206;
        Mon, 09 Mar 2026 17:17:09 -0700 (PDT)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm12678991eec.17.2026.03.09.17.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:17:08 -0700 (PDT)
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
Subject: [PATCH v2 1/4] x86/vmware: Introduce common vmware_hypercall()
Date: Mon,  9 Mar 2026 23:52:47 +0000
Message-ID: <20260309235250.2611115-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260309235250.2611115-1-alexey.makhalov@broadcom.com>
References: <20260307004238.1181299-1-alexey.makhalov@broadcom.com>
 <20260309235250.2611115-1-alexey.makhalov@broadcom.com>
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

