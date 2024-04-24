Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762C16F0E1
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000472; cv=none; b=kVA4AY++6A5eTpj2iBjj3r1VbXrqfBSYNp9fH87lvVHyK0T+qvuR4dceIiYScUc4jjcZffS2hfK5zrvdGrCOLpynCWEQIza6Sv9cJMMJhjg6P8lF/dCnS7TRuD07AmuEwdL7B0obzUqguQm1SeG25kAFM1f8VchX+ItA+PyVzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000472; c=relaxed/simple;
	bh=RjqHHh8+OvvgHWX6skeosEzS4N2AwclxB9HYRka+bGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpgDIAzYCYLgJjNm6XpDHkjon4c9uj18YrxVqN4brhLn6Vg8WzsxiQGhDG4kJK7qWPH9bigS/HzFv6Gr0D0sEXXn4mxDPRAiuIIo5c+Vdc6RPVebkDkgEoLwkeAK71VWxdkBuHqm1kLOIMPMn+LKB5q0LS2p84/zx6qeJDpq6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VZqmN5QG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VZqmN5QG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so3728705ad.0
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 16:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714000470; x=1714605270; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yW3rWzRu2U3mMza79f2YiFDKKLiYjn35V/dUh+fOfas=;
        b=VZqmN5QG8NnhbQsPzD1lpPqvitDuH4lsmbNNLb4LJATBZ9kZX+b2M7ow9/dHOuLey4
         zIV0fGvJI44CyPu/dy9V8btLCs7bfGjkZq3WWlTSMN62NObSn0K/PblfIhmTnKo7Fzsd
         lZ0KbZ1Wzd11ujnIqOH+VqfEgtU9Jdvn0kW1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000470; x=1714605270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yW3rWzRu2U3mMza79f2YiFDKKLiYjn35V/dUh+fOfas=;
        b=wNNXD4/QTt8TyhoRiz5g8iC9AnHh1mFEaBcdBeooGwgoI9MIOtHUYlQ+A6MPpiMiq3
         eRwOpwKPqGLSJpbd0dGOCSvBfHCpxArfb2aF3RQbk8FWTQvEcrwKo/2m8VR+44GKifTi
         7TEz5ddIOSK9f8wKfKOE7tV9ePgZI7Q33WUL31WEU1WqfLklAmrN82w2QEk1u/GlzVcA
         Nf3ILTtvExhIoZaHDAhcbAzH27J/1w12weLcZgSdx1m96EDBbXQKnYZWbec3wTsAQlHh
         ACIAn8PKJZNbgXSwp5tSRvRToLn9Sb/V+woLuraxeuHSPa44l+7qCn2RRDbBCXXhOp8j
         nyIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9mDwLFIfzq8rnOPDKJoiDVAZNo65XNeIWoAmRP8nauCEUCHppFN4E5fb7jBCyPQXzkN/E2zuBDIzPREaN7gqXUEXf3LhfjoGk+CaL7c=
X-Gm-Message-State: AOJu0YwVTR1lFVJKwBk80F9jpBnTfrBzGz1MdagUvzR6n6mvSlOz2xzL
	xS0Bz3oc3olrjD+0+HZRaJpnPcGdgnW6O1UKSbiwB2SnnjNanABXbTV83rYbdA==
X-Google-Smtp-Source: AGHT+IEr4i3DB4r3Qkm4dkUw7/0uwv+gx9Lch3vZC0mX7eYJ4jMuT6PuvlXOirfn5+jM9r3f/0CttQ==
X-Received: by 2002:a17:903:18d:b0:1e0:b689:950b with SMTP id z13-20020a170903018d00b001e0b689950bmr5683142plg.16.1714000470208;
        Wed, 24 Apr 2024 16:14:30 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([64.186.27.43])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903111100b001e520495f51sm12383936plh.124.2024.04.24.16.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:14:29 -0700 (PDT)
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
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v9 2/8] x86/vmware: Move common macros to vmware.h
Date: Wed, 24 Apr 2024 16:14:07 -0700
Message-Id: <20240424231407.14098-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240424231407.14098-1-alexey.makhalov@broadcom.com>
References: <adcbfb9a-a4e1-4a32-b786-6c204d941e9f@broadcom.com>
 <20240424231407.14098-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move VMware hypercall macros to vmware.h. This is a prerequisite for
the introduction of vmware_hypercall API. No functional changes besides
exporting vmware_hypercall_mode symbol.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
---
 arch/x86/include/asm/vmware.h | 72 +++++++++++++++++++++++++++++------
 arch/x86/kernel/cpu/vmware.c  | 43 +--------------------
 2 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index ac9fc51e2b18..de2533337611 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -8,25 +8,34 @@
 
 /*
  * The hypercall definitions differ in the low word of the %edx argument
- * in the following way: the old port base interface uses the port
- * number to distinguish between high- and low bandwidth versions.
+ * in the following way: the old I/O port based interface uses the port
+ * number to distinguish between high- and low bandwidth versions, and
+ * uses IN/OUT instructions to define transfer direction.
  *
  * The new vmcall interface instead uses a set of flags to select
  * bandwidth mode and transfer direction. The flags should be loaded
  * into %dx by any user and are automatically replaced by the port
- * number if the VMWARE_HYPERVISOR_PORT method is used.
- *
- * In short, new driver code should strictly use the new definition of
- * %dx content.
+ * number if the I/O port method is used.
  */
 
-/* Old port-based version */
-#define VMWARE_HYPERVISOR_PORT    0x5658
-#define VMWARE_HYPERVISOR_PORT_HB 0x5659
+#define VMWARE_HYPERVISOR_HB		BIT(0)
+#define VMWARE_HYPERVISOR_OUT		BIT(1)
+
+#define VMWARE_HYPERVISOR_PORT		0x5658
+#define VMWARE_HYPERVISOR_PORT_HB	(VMWARE_HYPERVISOR_PORT | \
+					 VMWARE_HYPERVISOR_HB)
+
+#define VMWARE_HYPERVISOR_MAGIC		0x564d5868U
+
+#define VMWARE_CMD_GETVERSION		10
+#define VMWARE_CMD_GETHZ		45
+#define VMWARE_CMD_GETVCPU_INFO		68
+#define VMWARE_CMD_STEALCLOCK		91
+
+#define CPUID_VMWARE_FEATURES_ECX_VMMCALL	BIT(0)
+#define CPUID_VMWARE_FEATURES_ECX_VMCALL	BIT(1)
 
-/* Current vmcall / vmmcall version */
-#define VMWARE_HYPERVISOR_HB   BIT(0)
-#define VMWARE_HYPERVISOR_OUT  BIT(1)
+extern u8 vmware_hypercall_mode;
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
@@ -54,4 +63,43 @@
 		      "rep insb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
+
+#define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
+	__asm__("inl (%%dx), %%eax" :					\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(VMWARE_HYPERVISOR_PORT), "b"(UINT_MAX) :		\
+		"memory")
+
+#define VMWARE_VMCALL(cmd, eax, ebx, ecx, edx)				\
+	__asm__("vmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(0), "b"(UINT_MAX) :					\
+		"memory")
+
+#define VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx)				\
+	__asm__("vmmcall" :						\
+		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
+		"a"(VMWARE_HYPERVISOR_MAGIC),				\
+		"c"(VMWARE_CMD_##cmd),					\
+		"d"(0), "b"(UINT_MAX) :					\
+		"memory")
+
+#define VMWARE_CMD(cmd, eax, ebx, ecx, edx) do {		\
+	switch (vmware_hypercall_mode) {			\
+	case CPUID_VMWARE_FEATURES_ECX_VMCALL:			\
+		VMWARE_VMCALL(cmd, eax, ebx, ecx, edx);		\
+		break;						\
+	case CPUID_VMWARE_FEATURES_ECX_VMMCALL:			\
+		VMWARE_VMMCALL(cmd, eax, ebx, ecx, edx);	\
+		break;						\
+	default:						\
+		VMWARE_PORT(cmd, eax, ebx, ecx, edx);		\
+		break;						\
+	}							\
+	} while (0)
+
 #endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index f58c8d669bd3..acd9658f7c4b 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -41,8 +41,6 @@
 
 #define CPUID_VMWARE_INFO_LEAF               0x40000000
 #define CPUID_VMWARE_FEATURES_LEAF           0x40000010
-#define CPUID_VMWARE_FEATURES_ECX_VMMCALL    BIT(0)
-#define CPUID_VMWARE_FEATURES_ECX_VMCALL     BIT(1)
 
 #define VMWARE_HYPERVISOR_MAGIC	0x564D5868
 
@@ -58,44 +56,6 @@
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
 		uint64_t clock;	/* stolen time counter in units of vtsc */
@@ -109,7 +69,8 @@ struct vmware_steal_time {
 };
 
 static unsigned long vmware_tsc_khz __ro_after_init;
-static u8 vmware_hypercall_mode     __ro_after_init;
+u8 vmware_hypercall_mode __ro_after_init;
+EXPORT_SYMBOL_GPL(vmware_hypercall_mode);
 
 static inline int __vmware_platform(void)
 {
-- 
2.39.0

