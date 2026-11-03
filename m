Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690153;
	b=sHMLUd/UDdmQKwwplhUzhoe7PzStOku5JLXutTmp/xGk6iRnRFFhOpyLPBaM4ZnvN8iy
	 E92jiTQCrn6Ah7cF6ZaGw60xNHODx2ObucVRrHo+3dVLtuP5ApRw8BrrE3Py7Og5Nfyu7
	 OdQVm9RKAlW7HcZlKVg/Zr3iDFKHJgF5Y3x55800kqN47MpLNJNGcnVaKpZJ+DDFh8ftt
	 /lviT+Lxxor05RqCLgNhy3e+6969KzXSPvG9XFcV5y8EYSqvT8tsDdFbxO7l2t4F8u2bg
	 nyItGSOFwlnk3+fYNiJQ/76qKrtf7dAjgseCxt0+d0DKycxpekrcIgz3SZ9C5+COoYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690153;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
	b=I4G66ocRXfNnVZxl0RBFmYVzjChk9shkPzLBMq2pA+ILyoqI4n2GxORMPgoZ+mzDE304
	 Jf78jcDqoHg3l3QFZiEVXCxyYT6zerxHpHI9WL/Piq4FA9LaNdJxak8ke8rmiP6cXhgXY
	 OZikWBpQE9aOAiJC5nEdWMkxsJeE8YUZV7gk+SNpL0vFJ78YBgjXh5dVya1pVxXMw6TU9
	 /EdSwCAPyaZz6Q5JThl2CGfMLZd2KoJ4ytdARu+BEH5a3d+SZ2ZrWjhmyx/56xwAAQMsu
	 oqInujSyJmz3JoAXCybMZsxoeCe4+WeniI706aCOgNCSyh4WVlgS8gcw29SIuefKuXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MDtNYgYC;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3627606A330
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 07:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3627606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MDtNYgYC
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1833364a12.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690152; x=1794294952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
        b=PRlQT6JYzi6/KMUW8iU9+lRp0ty/cc0n3kQX3Ig7+b8UNZkOh1XTmuBaoQmsStybw2
         GwDGFDNodZXdrBHzs//2m74+E46LqMAHhBM+U9hFgquxgzA+OlKWwTd7GScZyY71wxW2
         GXFscBjDAmA1EzZjFNKKeFt10Zoj0CvtkvLavYCy6j6yxu0ICR8mkeNQb9yR/zKxOrSq
         NmE66453sM27rJZjgT2+02au+MpavJVAVBWqmjzdW6HI2fhb9Hmx9AU0UUkgtBdhPnNW
         3M4/0CHgCXzDHnRkgJA5rzcXeEV+yCm7QJtZzqWwmEaEMbKbcdZUz28tznaXA5UFg/p9
         lqRA==
X-Forwarded-Encrypted: i=1; AKwUvBy9v99VqOz2l71hWr3xqzoJEc2muvi2MFWrdedh5a/IhYf65nwqxVFGj8/TzZuuSkrSRycHCeX+FK5v7XvaDg==@lists.linux.dev
X-Gm-Message-State: APuU4Z80ntJdow52NQBKEElktsZgRHl1no4HDcrGRXeiabciygSPkNfl
	7eACLiqDEDo9UXm1+KiU8Q0wXfnNiWJ6bleAFl6LlYmlNWov/AoBCZ/KAj7C5ABs0oWSlVkVWok
	wcy0TPoKECR4TBxs9gElS8gfbYoutuBEDiYaFqS0bCfhzp6oyt5Bi4SGFw/cofyDonlQYLrq3lW
	zNRjnKo8fj/WYMIbIX90ZCSLcu11u2HHZu8vL56Lm99Ik1z0UnKoEuvsX1Qsm7RYyX9+bsgWMM0
	CrFX2EStW6NP8ogwKs=
X-Gm-Gg: AYBFou3wBd8e1h9aTc8JJKV1rn/F/figzxeE7YJpvUozNyPZzWDZX+aukZoLhLWEHVt
	q51O0YOeg9FJdtXok6Ca1CEUorw9gyAUJO0FIxJwbE9cYRP+Ga+mSZyMD/zKYIo2yKBG9dH3DrO
	+IDy0Bn3WN4/GrUh9S+A96GXSF4y7NxjovLcFhNgQQhn0w9bWjxaaScS9wArfIRXz0ZJA/LV8bX
	JlZVJu5cmtAb1fuDXH17sAKggZLMoQy6mOk8UIR4JoQa06FtKdcLu+bLvTkgo1CvDWvJ8GQYi2+
	57gYsQ6nGQMiPV9Ek0NjjdyUuRO2BI7uyEjkv/hpw6pu/JasFrEhO6rm1qxAuS2rifqtQSeTfrQ
	BTOngIVvFlxg+BzLbU1eh3EzXiQqErulVe30cIzEAPNWRxVUGVe3//mG7/87Xe/UtvMIDOKH4fG
	TUwFUB1V2ziDb2H8sEflVKqc7htJnqQP23
X-Received: by 2002:a17:90b:4b:b0:3ab:752f:5f9c with SMTP id 98e67ed59e1d1-3ae897c5e71mr8417510a91.31.1793690151800;
        Mon, 02 Nov 2026 23:15:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0872a3207sm260898a91.8.2026.11.02.23.15.51
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:15:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1f2fafeaso466343685a.2
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793690150; x=1794294950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
        b=MDtNYgYCMLpS+gKBKirLfUopdR6yId1op0a761D+Haao4xkydc6IeKF4CAXBNdI1QU
         b3i+KGompKEstsK6/kSQjfrmba1KXOi/RoOs3DISOaA97u+zJIYJJzPEnD1rK35LwrCP
         CykuGOqUiq0bjKVHcpDu+AKfIrWSUTEOHXX1o=
X-Forwarded-Encrypted: i=1; AKwUvBy7vgAJ077Kg5t+b5/Z3kwZvBr26ixsyR4NoE6E/2jdfKMi1ekiWyZemdASfcapThWjdp/9xCxZqO0zHMKb2w==@lists.linux.dev
X-Received: by 2002:a05:620a:1a04:b0:93e:7939:acd0 with SMTP id af79cd13be357-944216bd289mr2142665685a.37.1793690150288;
        Mon, 02 Nov 2026 23:15:50 -0800 (PST)
X-Received: by 2002:a05:620a:1a04:b0:93e:7939:acd0 with SMTP id af79cd13be357-944216bd289mr2142663485a.37.1793690149883;
        Mon, 02 Nov 2026 23:15:49 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2d2sm1018334585a.15.2026.11.02.23.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:15:44 -0800 (PST)
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
Subject: [PATCH v3 1/3] x86/vmware: Move high-bandwidth hypercalls out of line
Date: Tue,  3 Nov 2026 02:14:56 -0500
Message-ID: <5c509e51a3e04b95a6447fabc9db20d72152a8f3.1793685318.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
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
