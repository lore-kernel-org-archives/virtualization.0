Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DC318B81
	for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402966; cv=none; b=FoxoP4Rd5HYyFkGjCriVkHyOv02sDtYtCG6xLJ7XPVW+e/+nPPOYmz748HYTL7uFsKrdi6iwmdvV+Sf0wVPee1Q5cithT2DibTReIPHJ68RoVzm4loymSLeb85h94mJn7ouda2f+HnGBQEq3T6vrxtELZTjsq3AD2xdz/VuZCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402966; c=relaxed/simple;
	bh=UPdlOVFOc2qa90mrb32eR4l90Fmm3wVHIK5/BbhxkW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpGHVHGJJQTQSQVR819vnEl9B+gxbVdk3M/LQ/ooiURoMef6cfCU8CYG/e/8pgwovtnaEMOc2GL71hqXGAY7EQSsFZv1grktCudsIpywV3xMEdqFyMN7cUEVK9S7+o5Wvdo2c4sXbQi3iajvDo/UzMWQJHc0zzdA/niGGo+Xcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85F953E704;
	Wed, 18 Feb 2026 08:22:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE2A3EA65;
	Wed, 18 Feb 2026 08:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOkqBtN2lWkuHwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 18 Feb 2026 08:22:43 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 12/16] x86/paravirt: Split off MSR related hooks into new header
Date: Wed, 18 Feb 2026 09:21:29 +0100
Message-ID: <20260218082133.400602-13-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218082133.400602-1-jgross@suse.com>
References: <20260218082133.400602-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 85F953E704
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Move the WRMSR, RDMSR and RDPMC related parts of paravirt.h and
paravirt_types.h into a new header file paravirt-msr.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
---
 arch/x86/include/asm/msr.h            |  2 +-
 arch/x86/include/asm/paravirt-msr.h   | 46 +++++++++++++++++++++++++++
 arch/x86/include/asm/paravirt.h       | 45 --------------------------
 arch/x86/include/asm/paravirt_types.h | 13 --------
 arch/x86/kernel/paravirt.c            | 14 +++++---
 arch/x86/xen/enlighten_pv.c           | 11 ++++---
 tools/objtool/check.c                 |  1 +
 7 files changed, 63 insertions(+), 69 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-msr.h

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 990268dea5ad..66f57265f2f8 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -308,7 +308,7 @@ static inline u64 native_read_pmc(int counter)
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
+#include <asm/paravirt-msr.h>
 #else
 static __always_inline u64 read_msr(u32 msr)
 {
diff --git a/arch/x86/include/asm/paravirt-msr.h b/arch/x86/include/asm/paravirt-msr.h
new file mode 100644
index 000000000000..b299864b438a
--- /dev/null
+++ b/arch/x86/include/asm/paravirt-msr.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_PARAVIRT_MSR_H
+#define _ASM_X86_PARAVIRT_MSR_H
+
+#include <asm/paravirt_types.h>
+
+struct pv_msr_ops {
+	/* Unsafe MSR operations.  These will warn or panic on failure. */
+	u64 (*read_msr)(u32 msr);
+	void (*write_msr)(u32 msr, u64 val);
+
+	/* Safe MSR operations.  Returns 0 or -EIO. */
+	int (*read_msr_safe)(u32 msr, u64 *val);
+	int (*write_msr_safe)(u32 msr, u64 val);
+
+	u64 (*read_pmc)(int counter);
+} __no_randomize_layout;
+
+extern struct pv_msr_ops pv_ops_msr;
+
+static __always_inline u64 read_msr(u32 msr)
+{
+	return PVOP_CALL1(u64, pv_ops_msr, read_msr, msr);
+}
+
+static __always_inline void write_msr(u32 msr, u64 val)
+{
+	PVOP_VCALL2(pv_ops_msr, write_msr, msr, val);
+}
+
+static __always_inline int read_msr_safe(u32 msr, u64 *val)
+{
+	return PVOP_CALL2(int, pv_ops_msr, read_msr_safe, msr, val);
+}
+
+static __always_inline int write_msr_safe(u32 msr, u64 val)
+{
+	return PVOP_CALL2(int, pv_ops_msr, write_msr_safe, msr, val);
+}
+
+static __always_inline u64 rdpmc(int counter)
+{
+	return PVOP_CALL1(u64, pv_ops_msr, read_pmc, counter);
+}
+
+#endif /* _ASM_X86_PARAVIRT_MSR_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 6b3aed5c2309..fcda593dd5c9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -130,51 +130,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(pv_ops, cpu.write_cr4, x);
 }
 
-static inline u64 paravirt_read_msr(u32 msr)
-{
-	return PVOP_CALL1(u64, pv_ops, cpu.read_msr, msr);
-}
-
-static inline void paravirt_write_msr(u32 msr, u64 val)
-{
-	PVOP_VCALL2(pv_ops, cpu.write_msr, msr, val);
-}
-
-static inline int paravirt_read_msr_safe(u32 msr, u64 *val)
-{
-	return PVOP_CALL2(int, pv_ops, cpu.read_msr_safe, msr, val);
-}
-
-static inline int paravirt_write_msr_safe(u32 msr, u64 val)
-{
-	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
-}
-
-static __always_inline u64 read_msr(u32 msr)
-{
-	return paravirt_read_msr(msr);
-}
-
-static __always_inline int read_msr_safe(u32 msr, u64 *p)
-{
-	return paravirt_read_msr_safe(msr, p);
-}
-
-static __always_inline void write_msr(u32 msr, u64 val)
-{
-	paravirt_write_msr(msr, val);
-}
-
-static __always_inline int write_msr_safe(u32 msr, u64 val)
-{
-	return paravirt_write_msr_safe(msr, val);
-}
-
-static __always_inline u64 rdpmc(int counter)
-{
-	return PVOP_CALL1(u64, pv_ops, cpu.read_pmc, counter);
-}
-
 static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 {
 	PVOP_VCALL2(pv_ops, cpu.alloc_ldt, ldt, entries);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 4f5ae0068aab..1e7188247c1f 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -67,19 +67,6 @@ struct pv_cpu_ops {
 	void (*cpuid)(unsigned int *eax, unsigned int *ebx,
 		      unsigned int *ecx, unsigned int *edx);
 
-	/* Unsafe MSR operations.  These will warn or panic on failure. */
-	u64 (*read_msr)(u32 msr);
-	void (*write_msr)(u32 msr, u64 val);
-
-	/*
-	 * Safe MSR operations.
-	 * Returns 0 or -EIO.
-	 */
-	int (*read_msr_safe)(u32 msr, u64 *val);
-	int (*write_msr_safe)(u32 msr, u64 val);
-
-	u64 (*read_pmc)(int counter);
-
 	void (*start_context_switch)(struct task_struct *prev);
 	void (*end_context_switch)(struct task_struct *next);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 792fa96b3233..089a87ac1582 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -109,11 +109,6 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
-	.cpu.read_msr		= native_read_msr,
-	.cpu.write_msr		= native_write_msr,
-	.cpu.read_msr_safe	= native_read_msr_safe,
-	.cpu.write_msr_safe	= native_write_msr_safe,
-	.cpu.read_pmc		= native_read_pmc,
 	.cpu.load_tr_desc	= native_load_tr_desc,
 	.cpu.set_ldt		= native_set_ldt,
 	.cpu.load_gdt		= native_load_gdt,
@@ -215,6 +210,15 @@ struct paravirt_patch_template pv_ops = {
 };
 
 #ifdef CONFIG_PARAVIRT_XXL
+struct pv_msr_ops pv_ops_msr = {
+	.read_msr	= native_read_msr,
+	.write_msr	= native_write_msr,
+	.read_msr_safe	= native_read_msr_safe,
+	.write_msr_safe	= native_write_msr_safe,
+	.read_pmc	= native_read_pmc,
+};
+EXPORT_SYMBOL(pv_ops_msr);
+
 NOKPROBE_SYMBOL(native_load_idt);
 #endif
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 0a6a50f3e9a9..b94437f26cc0 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1366,11 +1366,6 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 	pv_ops.cpu.read_cr0 = xen_read_cr0;
 	pv_ops.cpu.write_cr0 = xen_write_cr0;
 	pv_ops.cpu.write_cr4 = xen_write_cr4;
-	pv_ops.cpu.read_msr = xen_read_msr;
-	pv_ops.cpu.write_msr = xen_write_msr;
-	pv_ops.cpu.read_msr_safe = xen_read_msr_safe;
-	pv_ops.cpu.write_msr_safe = xen_write_msr_safe;
-	pv_ops.cpu.read_pmc = xen_read_pmc;
 	pv_ops.cpu.load_tr_desc = paravirt_nop;
 	pv_ops.cpu.set_ldt = xen_set_ldt;
 	pv_ops.cpu.load_gdt = xen_load_gdt;
@@ -1391,6 +1386,12 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 	pv_ops.cpu.start_context_switch = xen_start_context_switch;
 	pv_ops.cpu.end_context_switch = xen_end_context_switch;
 
+	pv_ops_msr.read_msr = xen_read_msr;
+	pv_ops_msr.write_msr = xen_write_msr;
+	pv_ops_msr.read_msr_safe = xen_read_msr_safe;
+	pv_ops_msr.write_msr_safe = xen_write_msr_safe;
+	pv_ops_msr.read_pmc = xen_read_pmc;
+
 	xen_init_irq_ops();
 
 	/*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 37f87c4a0134..d400cb435757 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -529,6 +529,7 @@ static struct {
 } pv_ops_tables[] = {
 	{ .name = "pv_ops", },
 	{ .name = "pv_ops_lock", },
+	{ .name = "pv_ops_msr", },
 	{ .name = NULL, .idx_off = -1 }
 };
 
-- 
2.53.0

