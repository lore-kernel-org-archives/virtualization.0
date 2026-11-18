Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984373;
	b=znB/LBTzjxV2yVRXk18ZqqvaedctZGkzwQHkzmSQMTGIcWCqDREwL+w/2NdhYaOTLHdW
	 9ZJrYB+zcAMMQ3G4Pm6KQR/j6I3JvZJhoE9G5AkQddf//IohhGi6XMZgw26CzigtvGx//
	 QAUdaZ+PLILnzTfnmG2wpg8cnSEYNGQ+UR/31lFc/6wf/Y6UxXRXGPJTBYj1y9xIV4Q0y
	 v2okqaMVoU1ltK05rAggqmcLGoB6xk7niibav7OsYwLD7/7+d8Fmf0R9t50uUnxsgSwIs
	 ytMEGSfjtprvUOSv1O22D186BpJ1AZqrwU0ErwINYnPW/oE4dUWee+k1aVHBpnZjMMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984373;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
	b=jU2K26S2MMBuDHjpRt5f58i47ZhlXmhkVy2ywoGv6j8k3gi8qxkSz5L4kmMiEXuTgGf5
	 zQjfEVmyIc7rGVLeTlKVEjXeuu8oOxODsOjxp29DKksGCjfcs37IajSHjx/mBCTTjp1rP
	 AAXkOr8DnvoSXdDWjTL0k2+9aKkz0o+18U/RDqxXWevg84ISB8A23O/v8BnNsviZVt609
	 QxVUoYD97tilPuJYZC5ZR9RWGThZkmkN7oS9GckmA/6RseG6WHSU9FbGLxiHag5ODXlpQ
	 eBmQe5xLuHlPBeeSMueGkd2uQILePBz1AWcdYSqTKcm906rOmgdRlJz+O6+crCZ/zqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gfAK5aqG;
	arc=none smtp.remote-ip=209.85.222.99
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9D606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gfAK5aqG
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so372053241.3
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984371; x=1795589171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
        b=HgkFbNDhQZ14+gnCYQXVE7U0A/lbkI4C1MJ7DXT2Q7DE+Iv9N8oDD65ZjQMOXI0d39
         1gp9O3JGRMjo7Qh2EixaTENbX31EBdJP23W+cP79mTQx6NktPU/+IibztqGN2gnq3VwB
         PVCDofwkYabL0ooOPQ0j/puestpjKnzH7GYdwMo2pGxW5BW4OT+EzeDJhSrA5cl/KBuv
         vRLxIIBU8HAFbEFDd7imn1hgaIkrrc1OgZSFAdPRrS/ANDTPj0Fo2dQ0ir0coq5FcYfn
         TlDByDkXFplX8tRnJLNBzArLQhJDXwWke/C+Kc7zp65vo1w6XZsS7tWEuZhg2/TZQFPI
         lLyg==
X-Forwarded-Encrypted: i=1; AL+hErFayVULNshlnMiiP7dwkTfL2P9It93WoPNQyCSzbHIToEXaZaNqfEYu0vr88/H7Z43LSrxjz8VemVPUXZ2GOg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+jUpEpp8l/ka6QtfD2apsrcfoZGX8uC7/8nphQYarAMqsQIrlO
	9RdC7+QNgP00qhP0zDmy9+J7gqTCRzHoUgFS3QPiQVD23snyJ/tC6O28wepDR2fHAPs93TKy4nA
	nNqSrtkZwe4Sbw3bg9hIiKRGeWBXWKa8d6R9TsYmO4/2rL8JdQxlG7lOI6P9BGwS07UXu3ZqRFx
	qMVyWagh0xml9KZ9h0SrMQluVye4SxVTvVJshKsCd6thhh6YamwKM1SwHeYHflEgkxignK2Htd3
	MoiANT0BcpnjBxvJfI=
X-Gm-Gg: AYBFou1t+uRjWby2JboqyMsikc8Up3wfINn6jroU1cxhq5rfV/4IUf/hTbrHHiyERJT
	RVlCi4YB5rD7LeHedFxyS6E/1J96GIdPjKF9dCOgdqyFe9wTZst3hBVZTU7NPHEaxhLZ3IXrr/i
	msgCaY45Sw1/Kyrb4v0/BsS//sljUYYIhDqIGIzsblzGU3fE99kTZpc4f6DfKGa1hSGD+St0kFb
	N1tOi1A6Aa1171S1yVhi4cmuIRCRXASmf0dw4Ou0AfCbFOZK+C9pxRUvzuAstAlCydxnxKJHet9
	3wn/zoIhr5TqvW5q5M6S+OWwnXqP15w6kJYAUcx8xPqRVreA04SQYSWjnqoC1AaDCDSjZZDsPPU
	BJT1W6W3+ULnp2PIooXinm7VXyVHt7ikbVyTUGJJLyLHuacf6Vg3tfJaHKL5V0V8XtZn4YlS67S
	QtuLtnJnvkaZfsPWOGIRp+qgJxEGeMn60t
X-Received: by 2002:a05:6102:644e:b0:7c1:8aa5:36c8 with SMTP id ada2fe7eead31-7d6ba4f29ccmr527682137.36.1794984371377;
        Tue, 17 Nov 2026 22:46:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-99e4a5fa27esm172656241.16.2026.11.17.22.46.10
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:46:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94960131befso117945785a.0
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794984370; x=1795589170; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
        b=gfAK5aqGlrzRRRr9NfM7VMdZ8O/V4mM+i32fyLPHPf26fmpkHKcvCjzIxV7Y8mg50S
         e5pYAP0Hb21sVf+k8+D2JqTe4QQInKIC9wgZV69AEFFE5SdFzLfzTaqC1jWYtgHnXnGm
         msNFXKTFW1LyLV19Zgon9T57MVoGg3w59C7qM=
X-Forwarded-Encrypted: i=1; AL+hErH/Ip/ErdcpUYuZXiEkZSpDQD/Ig5WIktrD1/zjbcRlWSMPTjW72zoXyoXRwb1xi+aG5WoEl62lTrolkgjSOA==@lists.linux.dev
X-Received: by 2002:a05:622a:528c:b0:533:8b99:fcd2 with SMTP id d75a77b69052e-55d5a668644mr25275711cf.40.1794984019885;
        Tue, 17 Nov 2026 22:40:19 -0800 (PST)
X-Received: by 2002:a05:622a:528c:b0:533:8b99:fcd2 with SMTP id d75a77b69052e-55d5a668644mr25275241cf.40.1794984019244;
        Tue, 17 Nov 2026 22:40:19 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d61cf3b56sm2078141cf.13.2026.11.17.22.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:40:18 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v4 1/3] x86/vmware: Move high-bandwidth hypercalls out of line
Date: Wed, 18 Nov 2026 01:40:11 -0500
Message-ID: <59bf54707b78e2a4d2072c1aff6bcf72cb35e6b2.1794206170.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794206170.git.zack.rusin@broadcom.com>
References: <cover.1794206170.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The high-bandwidth helpers contain inline assembly which temporarily uses
%bp as a VMware ABI register. Keeping that assembly in vmware.h duplicates
it in callers.

Move both helpers to vmware.c and export them for the vmwgfx module.
Preserve their unwind hints and remove the redundant caller-wide objtool
annotations from vmwgfx.

Preserve the argument sequence from commit e0e022004bbe ("x86/vmware:
Fix i386 high-bandwidth hypercall arguments").

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/vmware.h       | 62 +-------------------------
 arch/x86/kernel/cpu/vmware.c        | 68 +++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |  3 --
 3 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index fb011cef01e7..f3ffe358d2a3 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -253,12 +253,6 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
 	return out0;
 }
 
-#ifdef CONFIG_X86_64
-#define VMW_BP_CONSTRAINT "r"
-#else
-#define VMW_BP_CONSTRAINT "m"
-#endif
-
 /*
  * High bandwidth calls are not supported on encrypted memory guests.
  * The caller should check cc_platform_has(CC_ATTR_MEM_ENCRYPT) and use
@@ -266,66 +260,14 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
  * This assumption simplifies HB hypercall implementation to just I/O port
  * based approach without alternative patching.
  */
-static inline
 unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
 				      unsigned long in3, unsigned long in4,
 				      unsigned long in5, unsigned long in6,
-				      u32 *out1)
-{
-	unsigned long out0;
-
-	asm_inline volatile (
-		UNWIND_HINT_SAVE
-		"mov %[in6], %%" _ASM_AX "\n\t"
-		"push %%" _ASM_BP "\n\t"
-		UNWIND_HINT_UNDEFINED
-		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
-		"mov %[magic], %%eax\n\t"
-		"rep outsb\n\t"
-		"pop %%" _ASM_BP "\n\t"
-		UNWIND_HINT_RESTORE
-		: "=&a" (out0), "=b" (*out1)
-		: "b" (cmd),
-		  "c" (in2),
-		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
-		  "S" (in4),
-		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT(in6),
-		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
-		: "cc", "memory");
-	return out0;
-}
-
-static inline
+				      u32 *out1);
 unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 				     unsigned long in3, unsigned long in4,
 				     unsigned long in5, unsigned long in6,
-				     u32 *out1)
-{
-	unsigned long out0;
-
-	asm_inline volatile (
-		UNWIND_HINT_SAVE
-		"mov %[in6], %%" _ASM_AX "\n\t"
-		"push %%" _ASM_BP "\n\t"
-		UNWIND_HINT_UNDEFINED
-		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
-		"mov %[magic], %%eax\n\t"
-		"rep insb\n\t"
-		"pop %%" _ASM_BP "\n\t"
-		UNWIND_HINT_RESTORE
-		: "=&a" (out0), "=b" (*out1)
-		: "b" (cmd),
-		  "c" (in2),
-		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
-		  "S" (in4),
-		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT(in6),
-		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
-		: "cc", "memory");
-	return out0;
-}
-#undef VMW_BP_CONSTRAINT
+				     u32 *out1);
 #undef VMWARE_HYPERCALL
 
 #endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index f7ab9e7902cf..7cfc894f0663 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -30,12 +30,14 @@
 #include <linux/reboot.h>
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
+#include <asm/asm.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
 #include <asm/cpuid/api.h>
 #include <asm/timer.h>
 #include <asm/apic.h>
+#include <asm/unwind_hints.h>
 #include <asm/vmware.h>
 #include <asm/svm.h>
 
@@ -67,6 +69,72 @@ struct vmware_steal_time {
 static unsigned long vmware_tsc_khz __ro_after_init;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
+#ifdef CONFIG_X86_64
+#define VMW_BP_CONSTRAINT "r"
+#else
+#define VMW_BP_CONSTRAINT "m"
+#endif
+
+unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
+				      unsigned long in3, unsigned long in4,
+				      unsigned long in5, unsigned long in6,
+				      u32 *out1)
+{
+	unsigned long out0;
+
+	asm volatile(UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
+		"push %%" _ASM_BP "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
+		"rep outsb\n\t"
+		"pop %%" _ASM_BP "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=&a" (out0), "=b" (*out1)
+		: "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
+		: "cc", "memory");
+	return out0;
+}
+EXPORT_SYMBOL_GPL(vmware_hypercall_hb_out);
+
+unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
+				     unsigned long in3, unsigned long in4,
+				     unsigned long in5, unsigned long in6,
+				     u32 *out1)
+{
+	unsigned long out0;
+
+	asm volatile(UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
+		"push %%" _ASM_BP "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
+		"rep insb\n\t"
+		"pop %%" _ASM_BP "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=&a" (out0), "=b" (*out1)
+		: "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
+		: "cc", "memory");
+	return out0;
+}
+EXPORT_SYMBOL_GPL(vmware_hypercall_hb_in);
+
+#undef VMW_BP_CONSTRAINT
+
 unsigned long vmware_hypercall_slow(unsigned long cmd,
 				    unsigned long in1, unsigned long in3,
 				    unsigned long in4, unsigned long in5,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index fd77ab6568cb..20ab4019680c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -24,7 +24,6 @@
  *
  */
 
-#include <linux/objtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -289,7 +288,6 @@ static int vmw_send_msg(struct rpc_channel *channel, const char *msg)
 
 	return -EINVAL;
 }
-STACK_FRAME_NON_STANDARD_FP(vmw_send_msg);
 
 
 /**
@@ -384,7 +382,6 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 	return 0;
 }
-STACK_FRAME_NON_STANDARD(vmw_recv_msg);
 
 
 /**
