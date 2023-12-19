Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18BB3D0D3
	for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gyB2nCYT"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so3583634a12.2
        for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 13:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703023088; x=1703627888; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12jLcQvq3fbBtMC3j4PCHBa5+ySb4h0g2GNykkr2s3A=;
        b=gyB2nCYTNJzwQFNcVQyv//lzyIsFSyB9AjspRRFY6L9K+KYg3cva7wcmVuPqj27Qz1
         VoKEN1OlsFRWsW65+6fOGH4OUqThsX3tPwqbXzWg5lhIkfVN0YnQguGyGh3aMK8MxEzC
         Zuw5uw1ilbUAPWSbk/njRoHU6hbuCP568T8aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703023088; x=1703627888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12jLcQvq3fbBtMC3j4PCHBa5+ySb4h0g2GNykkr2s3A=;
        b=FD3TGtuhU9Dg4jek7fHgNUf2pgISQizihbak8zjYso5U2xXXzu7pRjzXaiyK0Jg9DV
         tBYYVwlYcBvSWmkMt08l7scbRzTCXs5w/icY7dgvGCrJGzt2eqlG6e1+Vh8YlJoGSK+I
         Wua66jpFrpTXRvm0yDdN/C1OCI96G6WZa6oUim7jctQPyJha9RmhUuamq2ANl3qobfqn
         x3q2UXCXXsqqiBwMi3lQ0qw02j8lY8mxB4Ic+/KzSwRw2amqqJ2gkfgixyZu3s5SW0fa
         TqM7r05WtWvdiq6xm3HWJs+d0BLMTDZYXfX5VHuFY4WNhwYCJ9HBBrIoCdboDQHXQ5KZ
         Qx7Q==
X-Gm-Message-State: AOJu0Yzu3hmNAbm8VV66NyhrSyDTYhw6TFy8d23jDLXfWsaNXo/1273o
	DfdnsM5Uw4cUxlBu4+A0PGndlg==
X-Google-Smtp-Source: AGHT+IHsH7/etvwZSQ9bs9sQYWQ+NOHzah8TVWPsgWWtyCUEya556xESq+9jAZ2L1lNdJq5AsU59fg==
X-Received: by 2002:a17:902:c406:b0:1d0:8d2e:9ebc with SMTP id k6-20020a170902c40600b001d08d2e9ebcmr21473640plk.59.1703023088143;
        Tue, 19 Dec 2023 13:58:08 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902e8c100b001d3aa7604c5sm5356476plg.0.2023.12.19.13.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:58:07 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v3 2/6] x86/vmware: Introduce vmware_hypercall API
Date: Tue, 19 Dec 2023 13:57:47 -0800
Message-Id: <20231219215751.9445-3-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
References: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Makhalov <amakhalov@vmware.com>

Introduce vmware_hypercall family of functions. It is a common
implementation to be used by the VMware guest code and virtual
device drivers in architecture independent manner.

The API consists of vmware_hypercallX and vmware_hypercall_hb_{out,in}
set of functions by analogy with KVM hypercall API. Architecture
specific implementation is hidden inside.

It will simplify future enhancements in VMware hypercalls such
as SEV-ES and TDX related changes without needs to modify a
caller in device drivers code.

Current implementation extends an idea from commit bac7b4e84323
("x86/vmware: Update platform detection code for VMCALL/VMMCALL
hypercalls") to have a slow, but safe path in VMWARE_HYPERCALL
earlier during the boot when alternatives are not yet applied.
This logic was inherited from VMWARE_CMD from the commit mentioned
above. Default alternative code was optimized by size to reduce
excessive nop alignment once alternatives are applied. Total
default code size is 26 bytes, in worse case (3 bytes alternative)
remaining 23 bytes will be aligned by only 3 long NOP instructions.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Jeff Sipek <jsipek@vmware.com>
---
 arch/x86/include/asm/vmware.h | 262 ++++++++++++++++++++++++++--------
 arch/x86/kernel/cpu/vmware.c  |  35 ++---
 2 files changed, 220 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index 3636faa8b4fe..719e41260ece 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -40,69 +40,219 @@
 
 extern u8 vmware_hypercall_mode;
 
-/* The low bandwidth call. The low word of edx is presumed clear. */
-#define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
-		      "inl (%%dx), %%eax",				\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
-
 /*
- * The high bandwidth out call. The low word of edx is presumed to have the
- * HB and OUT bits set.
+ * The low bandwidth call. The low word of edx is presumed to have OUT bit
+ * set. The high word of edx may contain input data from the caller.
  */
-#define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep outsb",					\
+#define VMWARE_HYPERCALL						\
+	ALTERNATIVE_3("cmpb $"						\
+			__stringify(CPUID_VMWARE_FEATURES_ECX_VMMCALL)	\
+			", %[mode]\n\t"					\
+		      "jg 2f\n\t"					\
+		      "je 1f\n\t"					\
+		      "movw %[port], %%dx\n\t"				\
+		      "inl (%%dx), %%eax\n\t"				\
+		      "jmp 3f\n\t"					\
+		      "1: vmmcall\n\t"					\
+		      "jmp 3f\n\t"					\
+		      "2: vmcall\n\t"					\
+		      "3:\n\t",						\
+		      "movw %[port], %%dx\n\t"				\
+		      "inl (%%dx), %%eax", X86_FEATURE_HYPERVISOR,	\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 
+static inline
+unsigned long vmware_hypercall1(unsigned long cmd, unsigned long in1)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall3(unsigned long cmd, unsigned long in1,
+				uint32_t *out1, uint32_t *out2)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall4(unsigned long cmd, unsigned long in1,
+				uint32_t *out1, uint32_t *out2,
+				uint32_t *out3)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (0)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall5(unsigned long cmd, unsigned long in1,
+				unsigned long in3, unsigned long in4,
+				unsigned long in5, uint32_t *out2)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=c" (*out2)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall6(unsigned long cmd, unsigned long in1,
+				unsigned long in3, uint32_t *out2,
+				uint32_t *out3, uint32_t *out4,
+				uint32_t *out5)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=c" (*out2), "=d" (*out3), "=S" (*out4),
+		  "=D" (*out5)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
+				unsigned long in3, unsigned long in4,
+				unsigned long in5, uint32_t *out1,
+				uint32_t *out2, uint32_t *out3)
+{
+	unsigned long out0;
+
+	asm_inline volatile (VMWARE_HYPERCALL
+		: "=a" (out0), "=b" (*out1), "=c" (*out2), "=d" (*out3)
+		: [port] "i" (VMWARE_HYPERVISOR_PORT),
+		  [mode] "m" (vmware_hypercall_mode),
+		  "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (in1),
+		  "c" (cmd),
+		  "d" (in3),
+		  "S" (in4),
+		  "D" (in5)
+		: "cc", "memory");
+	return out0;
+}
+
+
+#ifdef CONFIG_X86_64
+#define VMW_BP_REG "%%rbp"
+#define VMW_BP_CONSTRAINT "r"
+#else
+#define VMW_BP_REG "%%ebp"
+#define VMW_BP_CONSTRAINT "m"
+#endif
+
 /*
- * The high bandwidth in call. The low word of edx is presumed to have the
- * HB bit set.
+ * High bandwidth calls are not supported on encrypted memory guests.
+ * The caller should check cc_platform_has(CC_ATTR_MEM_ENCRYPT) and use
+ * low bandwidth hypercall it memory encryption is set.
+ * This assumption simplifies HB hypercall impementation to just I/O port
+ * based approach without alternative patching.
  */
-#define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
-		      "rep insb",					\
-		      "vmcall", X86_FEATURE_VMCALL,			\
-		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+static inline
+unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
+				      unsigned long in3, unsigned long in4,
+				      unsigned long in5, unsigned long in6,
+				      uint32_t *out1)
+{
+	unsigned long out0;
+
+	asm_inline volatile (
+		UNWIND_HINT_SAVE
+		"push " VMW_BP_REG "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %[in6], " VMW_BP_REG "\n\t"
+		"rep outsb\n\t"
+		"pop " VMW_BP_REG "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=a" (out0), "=b" (*out1)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT (in6)
+		: "cc", "memory");
+	return out0;
+}
+
+static inline
+unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
+				     unsigned long in3, unsigned long in4,
+				     unsigned long in5, unsigned long in6,
+				     uint32_t *out1)
+{
+	unsigned long out0;
 
-#define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
-	__asm__("inl (%%dx), %%eax" :					\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
-		"memory")
-
-#define VMWARE_VMCALL(cmd, eax, ebx, ecx, edx)				\
-	__asm__("vmcall" :						\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(0), "b"(UINT_MAX) :					\
-		"memory")
-
-#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)				\
-	__asm__("vmmcall" :						\
-		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
-		"a"(VMWARE_HYPERVISOR_MAGIC),				\
-		"c"(VMWARE_CMD_##cmd),					\
-		"d"(0), "b"(UINT_MAX) :					\
-		"memory")
-
-#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
-	switch (vmware_hypercall_mode) {			\
-	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
-		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
-		break;						\
-	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
-		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
-		break;						\
-	default:						\
-		VMWARE_PORT(cmd, eax, ebx, ecx, edx);		\
-		break;						\
-	}							\
-	} while (0)
+	asm_inline volatile (
+		UNWIND_HINT_SAVE
+		"push " VMW_BP_REG "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %[in6], " VMW_BP_REG "\n\t"
+		"rep insb\n\t"
+		"pop " VMW_BP_REG "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=a" (out0), "=b" (*out1)
+		: "a" (VMWARE_HYPERVISOR_MAGIC),
+		  "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT (in6)
+		: "cc", "memory");
+	return out0;
+}
+#undef VMW_BP_REG
+#undef VMW_BP_CONSTRAINT
+#undef VMWARE_HYPERCALL
 
 #endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 4db8e1daa4a1..3aa1adaed18f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -67,9 +67,10 @@ EXPORT_SYMBOL_GPL(vmware_hypercall_mode);
 
 static inline int __vmware_platform(void)
 {
-	uint32_t eax, ebx, ecx, edx;
-	VMWARE_CMD(GETVERSION, eax, ebx, ecx, edx);
-	return eax != (uint32_t)-1 && ebx == VMWARE_HYPERVISOR_MAGIC;
+	uint32_t eax, ebx, ecx;
+
+	eax = vmware_hypercall3(VMWARE_CMD_GETVERSION, 0, &ebx, &ecx);
+	return eax != UINT_MAX && ebx == VMWARE_HYPERVISOR_MAGIC;
 }
 
 static unsigned long vmware_get_tsc_khz(void)
@@ -121,21 +122,12 @@ static void __init vmware_cyc2ns_setup(void)
 	pr_info("using clock offset of %llu ns\n", d->cyc2ns_offset);
 }
 
-static int vmware_cmd_stealclock(uint32_t arg1, uint32_t arg2)
+static int vmware_cmd_stealclock(uint32_t addr_hi, uint32_t addr_lo)
 {
-	uint32_t result, info;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(result),
-		"=c"(info) :
-		"a"(VMWARE_HYPERVISOR_MAGIC),
-		"b"(0),
-		"c"(VMWARE_CMD_STEALCLOCK),
-		"d"(0),
-		"S"(arg1),
-		"D"(arg2) :
-		"memory");
-	return result;
+	uint32_t info;
+
+	return vmware_hypercall5(VMWARE_CMD_STEALCLOCK, 0, 0, addr_hi, addr_lo,
+				 &info);
 }
 
 static bool stealclock_enable(phys_addr_t pa)
@@ -344,10 +336,10 @@ static void __init vmware_set_capabilities(void)
 
 static void __init vmware_platform_setup(void)
 {
-	uint32_t eax, ebx, ecx, edx;
+	uint32_t eax, ebx, ecx;
 	uint64_t lpj, tsc_khz;
 
-	VMWARE_CMD(GETHZ, eax, ebx, ecx, edx);
+	eax = vmware_hypercall3(VMWARE_CMD_GETHZ, UINT_MAX, &ebx, &ecx);
 
 	if (ebx != UINT_MAX) {
 		lpj = tsc_khz = eax | (((uint64_t)ebx) << 32);
@@ -429,8 +421,9 @@ static uint32_t __init vmware_platform(void)
 /* Checks if hypervisor supports x2apic without VT-D interrupt remapping. */
 static bool __init vmware_legacy_x2apic_available(void)
 {
-	uint32_t eax, ebx, ecx, edx;
-	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
+	uint32_t eax;
+
+	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
 	return !(eax & BIT(VCPU_RESERVED)) &&
 		(eax & BIT(VCPU_LEGACY_X2APIC));
 }
-- 
2.39.0

