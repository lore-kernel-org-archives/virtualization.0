Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344014D2B8
	for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306259; cv=none; b=VMZYiGSnv28vBDAneqLhjK0BcaMbIBvHIP592ryIjRnCqg4mysRn3Np993De3lb3+5j7/lY8uFKjQ9qDp+jzUTyf8MiZitf8w5w0dtXrE2JmoJZNyGcBavXolmUs1Nvzzr0t7S4UtZvCUFwED2mec24+gdsfaBB8YpyYValEMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306259; c=relaxed/simple;
	bh=NK72QWSTENiSeyhJ+Lf5DB1HqQQ8kTSBLLwmEwv6BrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4TeAe9GbMnLwa43OeT/VcsSRaxTzjdBpbgxmiTZFo95I0xXb+obfoiWbNxvVIDtOD7vxOA5aojgU2XYqRIQPEs4cj5Nv1FLqFTIex/NNN7vs2tifGHxrd2JbPR8eo8WGeuUXu82+iBbspRoIwt5WcwhgItTzwT29uJ3B+njyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fZTOC3K5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fZTOC3K5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ae259b1c87so21550306d6.1
        for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306256; x=1718911056; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqNd+iLeT7nJUI6zs92vMpVdcAWS0GdB0qzOjw5qGd8=;
        b=fZTOC3K5/Bjn3tWEX89YFz2gn6ayvEAjGN6T314DbNrdLXn8nC1yAGab0Mr5lhkL4f
         B0yeclAYxQgNN9VqNcVo3ugUgJFEErC2UZemjLPXOy9hHD+ltsZYg0wDXYPj6vjuElet
         zPyRHKZVBDfDiIInHp78gTxguB5vDeKWw6wtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306256; x=1718911056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqNd+iLeT7nJUI6zs92vMpVdcAWS0GdB0qzOjw5qGd8=;
        b=hh/IQHwrh3gdUYLyxDyI9VU7cZ6KNRbvVKVBH+EH5R1Zykcrh0nbXuGB0judsNYAru
         QEd0Y3c+IedxFhMPEqND3aR+wFoRLSuVxVCgRTmcNw2ArxYieq5A7i/HhFWUeOvUfbhB
         ivqxMqW1P2vhH9TfNNPRk6oIvK04brtC6DoyQPdOeGeDzB8xasALAl4/QLgEwlTeml01
         vEj3gAlleeWCocSyw1+NVPWkBQ4LuWRa3UyLTtYAKwwQbxughQqkAWQouLbablOsdWa2
         2TXRtC0Taiq/N0TZbY1vXFusJuO0gAaQP5yHCfsH79K8wDbbf1Ppr17RbGitw/JVhPuf
         VyOA==
X-Forwarded-Encrypted: i=1; AJvYcCWokl/ycupk4kvtrtvM9WZdP76g+lDTLcPoylMmHknRwbMMKokGz30XnukoGCGdJMRuWC8zYLfvYn6vJk9Myr2p9FkL0OO/QnLAp6Q3Ffc=
X-Gm-Message-State: AOJu0YwRUWY8Jxb8Esx/pdxi0LSedg2SG0Qjcl3OXdNqYDmSNjACv16h
	TzvXAqBYbDLAOyg70ok9X1eZDhwXx8ZYjY9lKqQlEp0Qk+yQ2f8icopCbLwI1g==
X-Google-Smtp-Source: AGHT+IGxx4Y4IaoFQvp412CQV+xWQXgbXgVf+lHMhgxiPdk13pgmWYUgwKjVFqFc7qbuQQdnfsavtg==
X-Received: by 2002:a0c:c486:0:b0:6af:33ed:87de with SMTP id 6a1803df08f44-6b2af2eef89mr11681586d6.20.1718306256370;
        Thu, 13 Jun 2024 12:17:36 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:36 -0700 (PDT)
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
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v11 5/8] x86/vmware: Use VMware hypercall API
Date: Thu, 13 Jun 2024 12:16:47 -0700
Message-Id: <20240613191650.9913-6-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove VMWARE_CMD macro and move to vmware_hypercall API.
No functional changes intended.

Use u32/u64 instead of uint32_t/uint64_t across the file

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 95 ++++++++++--------------------------
 1 file changed, 25 insertions(+), 70 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 533ac2d1de88..c0a3ffa9e023 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -49,54 +49,16 @@
 #define STEALCLOCK_DISABLED        0
 #define STEALCLOCK_ENABLED         1
 
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
-#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)                         \
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
-
 struct vmware_steal_time {
 	union {
-		uint64_t clock;	/* stolen time counter in units of vtsc */
+		u64 clock;	/* stolen time counter in units of vtsc */
 		struct {
 			/* only for little-endian */
-			uint32_t clock_low;
-			uint32_t clock_high;
+			u32 clock_low;
+			u32 clock_high;
 		};
 	};
-	uint64_t reserved[7];
+	u64 reserved[7];
 };
 
 static unsigned long vmware_tsc_khz __ro_after_init;
@@ -154,9 +116,10 @@ unsigned long vmware_hypercall_slow(unsigned long cmd,
 
 static inline int __vmware_platform(void)
 {
-	uint32_t eax, ebx, ecx, edx;
-	VMWARE_CMD(GETVERSION, eax, ebx, ecx, edx);
-	return eax != (uint32_t)-1 && ebx == VMWARE_HYPERVISOR_MAGIC;
+	u32 eax, ebx, ecx;
+
+	eax = vmware_hypercall3(VMWARE_CMD_GETVERSION, 0, &ebx, &ecx);
+	return eax != UINT_MAX && ebx == VMWARE_HYPERVISOR_MAGIC;
 }
 
 static unsigned long vmware_get_tsc_khz(void)
@@ -208,21 +171,12 @@ static void __init vmware_cyc2ns_setup(void)
 	pr_info("using clock offset of %llu ns\n", d->cyc2ns_offset);
 }
 
-static int vmware_cmd_stealclock(uint32_t arg1, uint32_t arg2)
+static int vmware_cmd_stealclock(u32 addr_hi, u32 addr_lo)
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
+	u32 info;
+
+	return vmware_hypercall5(VMWARE_CMD_STEALCLOCK, 0, 0, addr_hi, addr_lo,
+				 &info);
 }
 
 static bool stealclock_enable(phys_addr_t pa)
@@ -257,15 +211,15 @@ static bool vmware_is_stealclock_available(void)
  * Return:
  *      The steal clock reading in ns.
  */
-static uint64_t vmware_steal_clock(int cpu)
+static u64 vmware_steal_clock(int cpu)
 {
 	struct vmware_steal_time *steal = &per_cpu(vmw_steal_time, cpu);
-	uint64_t clock;
+	u64 clock;
 
 	if (IS_ENABLED(CONFIG_64BIT))
 		clock = READ_ONCE(steal->clock);
 	else {
-		uint32_t initial_high, low, high;
+		u32 initial_high, low, high;
 
 		do {
 			initial_high = READ_ONCE(steal->clock_high);
@@ -277,7 +231,7 @@ static uint64_t vmware_steal_clock(int cpu)
 			high = READ_ONCE(steal->clock_high);
 		} while (initial_high != high);
 
-		clock = ((uint64_t)high << 32) | low;
+		clock = ((u64)high << 32) | low;
 	}
 
 	return mul_u64_u32_shr(clock, vmware_cyc2ns.cyc2ns_mul,
@@ -431,13 +385,13 @@ static void __init vmware_set_capabilities(void)
 
 static void __init vmware_platform_setup(void)
 {
-	uint32_t eax, ebx, ecx, edx;
-	uint64_t lpj, tsc_khz;
+	u32 eax, ebx, ecx;
+	u64 lpj, tsc_khz;
 
-	VMWARE_CMD(GETHZ, eax, ebx, ecx, edx);
+	eax = vmware_hypercall3(VMWARE_CMD_GETHZ, UINT_MAX, &ebx, &ecx);
 
 	if (ebx != UINT_MAX) {
-		lpj = tsc_khz = eax | (((uint64_t)ebx) << 32);
+		lpj = tsc_khz = eax | (((u64)ebx) << 32);
 		do_div(tsc_khz, 1000);
 		WARN_ON(tsc_khz >> 32);
 		pr_info("TSC freq read from hypervisor : %lu.%03lu MHz\n",
@@ -488,7 +442,7 @@ static u8 __init vmware_select_hypercall(void)
  * If !boot_cpu_has(X86_FEATURE_HYPERVISOR), vmware_hypercall_mode
  * intentionally defaults to 0.
  */
-static uint32_t __init vmware_platform(void)
+static u32 __init vmware_platform(void)
 {
 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
 		unsigned int eax;
@@ -516,8 +470,9 @@ static uint32_t __init vmware_platform(void)
 /* Checks if hypervisor supports x2apic without VT-D interrupt remapping. */
 static bool __init vmware_legacy_x2apic_available(void)
 {
-	uint32_t eax, ebx, ecx, edx;
-	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
+	u32 eax;
+
+	eax = vmware_hypercall1(VMWARE_CMD_GETVCPU_INFO, 0);
 	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
 		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC));
 }
-- 
2.39.4

