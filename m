Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79146F4B8
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116218; cv=none; b=XikKjCij0/4tKDrSVV2L465VI0Cd3GsgGfHJj14iTRF6/TarqWSuG5CBw6lBtNF7ncm91uJfAobVhc/Y1/m/102zM1nN52cnkVaRVW1pl/UYrlRNjdk24al88HFjAEo49qMHQodJsZZLuNKTqe0kJzW7xuEJmb0EDxhyUahIfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116218; c=relaxed/simple;
	bh=uO+GzTBS0YDPQQgHXkEZGLEVSqtjvDKmnpZvhsy68DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0Gx5g+giA37hPWgp0E7yjywpWt7Wu4mnKczI/cSL7aeedItJegWoMDhuAG36fcUlCkm2y/aMJzd/e1oYM/S0tGmkzKy0/vcZAiZXPl0SaJySPgP6fpCST26QGXs+y3V5v3UgpjPlHfnhGUSoPtyzWysEeBPcv/IzriuF6dmDdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34D361FE05;
	Fri, 11 Sep 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFB15132D3;
	Fri, 11 Sep 2026 08:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ipiFKTa/o2o4FgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 11 Sep 2026 08:43:34 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v5 14/17] x86/paravirt: Switch MSR access pv_ops functions to instruction interfaces
Date: Fri, 11 Sep 2026 10:42:08 +0200
Message-ID: <20260911084211.3149957-15-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911084211.3149957-1-jgross@suse.com>
References: <20260911084211.3149957-1-jgross@suse.com>
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
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 34D361FE05
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

In order to prepare for inlining RDMSR/WRMSR instructions via
alternatives directly when running not in a Xen PV guest, switch the
interfaces of the MSR related pvops callbacks to ones similar of the
related instructions.

In order to prepare for supporting the immediate variants of RDMSR/WRMSR
use a 64-bit interface instead of the 32-bit one of RDMSR/WRMSR.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- former patch 5 of V1 has been split
- use 64-bit interface (Xin Li)
---
 arch/x86/include/asm/paravirt-msr.h | 64 ++++++++++++++++++++++++-----
 arch/x86/kernel/paravirt.c          | 36 ++++++++++++++--
 arch/x86/xen/enlighten_pv.c         | 45 +++++++++++++++-----
 3 files changed, 120 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/paravirt-msr.h b/arch/x86/include/asm/paravirt-msr.h
index 3e31648316a8..4b71a1cd780c 100644
--- a/arch/x86/include/asm/paravirt-msr.h
+++ b/arch/x86/include/asm/paravirt-msr.h
@@ -6,46 +6,90 @@
 
 struct pv_msr_ops {
 	/* Unsafe MSR operations.  These will warn or panic on failure. */
-	u64 (*read_msr)(u32 msr);
-	void (*write_msr)(u32 msr, u64 val);
+	struct paravirt_callee_save read_msr;
+	struct paravirt_callee_save write_msr;
 
 	/* Safe MSR operations.  Returns 0 or -EIO. */
-	int (*read_msr_safe)(u32 msr, u64 *val);
-	int (*write_msr_safe)(u32 msr, u64 val);
+	struct paravirt_callee_save read_msr_safe;
+	struct paravirt_callee_save write_msr_safe;
 
 	u64 (*read_pmc)(int counter);
 } __no_randomize_layout;
 
 extern struct pv_msr_ops pv_ops_msr;
 
+#define PV_PROLOGUE_MSR(func)		\
+	PV_SAVE_COMMON_CALLER_REGS	\
+	PV_PROLOGUE_MSR_##func
+
+#define PV_EPILOGUE_MSR(func)	PV_RESTORE_COMMON_CALLER_REGS
+
+#define PV_CALLEE_SAVE_REGS_MSR_THUNK(func)		\
+	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text", MSR)
+
 static __always_inline u64 read_msr(u32 msr)
 {
-	return PVOP_CALL1(u64, pv_ops_msr, read_msr, msr);
+	u64 val;
+
+	asm volatile(PARAVIRT_CALL
+		     : "=a" (val), ASM_CALL_CONSTRAINT
+		     : paravirt_ptr(pv_ops_msr, read_msr), "c" (msr)
+		     : "rdx");
+
+	return val;
 }
 
 static __always_inline void write_msr(u32 msr, u64 val)
 {
-	PVOP_VCALL2(pv_ops_msr, write_msr, msr, val);
+	asm volatile(PARAVIRT_CALL
+		     : ASM_CALL_CONSTRAINT
+		     : paravirt_ptr(pv_ops_msr, write_msr), "c" (msr), "a" (val)
+		     : "memory", "rdx");
 }
 
 static __always_inline void write_msrns(u32 msr, u64 val)
 {
-	PVOP_VCALL2(pv_ops_msr, write_msr, msr, val);
+	asm volatile(PARAVIRT_CALL
+		     : ASM_CALL_CONSTRAINT
+		     : paravirt_ptr(pv_ops_msr, write_msr), "c" (msr), "a" (val)
+		     : "memory", "rdx");
 }
 
 static __always_inline int read_msr_safe(u32 msr, u64 *val)
 {
-	return PVOP_CALL2(int, pv_ops_msr, read_msr_safe, msr, val);
+	int err;
+
+	asm volatile(PARAVIRT_CALL
+		     : [err] "=d" (err), "=a" (*val), ASM_CALL_CONSTRAINT
+		     : paravirt_ptr(pv_ops_msr, read_msr_safe), "c" (msr));
+
+	return err ? -EIO : 0;
 }
 
 static __always_inline int write_msr_safe(u32 msr, u64 val)
 {
-	return PVOP_CALL2(int, pv_ops_msr, write_msr_safe, msr, val);
+	int err;
+
+	asm volatile(PARAVIRT_CALL
+		     : [err] "=a" (err), ASM_CALL_CONSTRAINT
+		     : paravirt_ptr(pv_ops_msr, write_msr_safe),
+			"c" (msr), "a" (val)
+		     : "memory", "rdx");
+
+	return err ? -EIO : 0;
 }
 
 static __always_inline int write_msrns_safe(u32 msr, u64 val)
 {
-	return PVOP_CALL2(int, pv_ops_msr, write_msr_safe, msr, val);
+	int err;
+
+	asm volatile(PARAVIRT_CALL
+		     : [err] "=a" (err), ASM_CALL_CONSTRAINT
+		     : paravirt_ptr(pv_ops_msr, write_msr_safe),
+			"c" (msr), "a" (val)
+		     : "memory", "rdx");
+
+	return err ? -EIO : 0;
 }
 
 static __always_inline u64 rdpmc(int counter)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 739dbfd8aadf..66c0d6b5423c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -50,12 +50,40 @@ unsigned long pv_native_save_fl(void);
 void pv_native_irq_disable(void);
 void pv_native_irq_enable(void);
 unsigned long pv_native_read_cr2(void);
+void pv_native_rdmsr(void);
+void pv_native_wrmsr(void);
+void pv_native_rdmsr_safe(void);
+void pv_native_wrmsr_safe(void);
 
 DEFINE_ASM_FUNC(_paravirt_ident_64, "mov %rdi, %rax", .text);
 DEFINE_ASM_FUNC(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_irq_disable, "cli", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_rdmsr,
+		"1: rdmsr\n"
+		"shl $32, %rdx; or %rdx, %rax\n"
+		"2:\n"
+		_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_RDMSR), .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_wrmsr,
+		"mov %rax, %rdx; shr $32, %rdx\n"
+		"1: wrmsr\n"
+		"2:\n"
+		_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR), .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_rdmsr_safe,
+		"1: rdmsr\n"
+		"shl $32, %rdx; or %rdx, %rax\n"
+		"xor %edx, %edx\n"
+		"2:\n"
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_RDMSR_SAFE, %%edx),
+		.noinstr.text);
+DEFINE_ASM_FUNC(pv_native_wrmsr_safe,
+		"mov %rax, %rdx; shr $32, %rdx\n"
+		"1: wrmsr\n"
+		"xor %eax, %eax\n"
+		"2:\n"
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_WRMSR_SAFE, %%eax),
+		.noinstr.text);
 #endif
 
 static noinstr void pv_native_safe_halt(void)
@@ -208,10 +236,10 @@ struct paravirt_patch_template pv_ops = {
 
 #ifdef CONFIG_PARAVIRT_XXL
 struct pv_msr_ops pv_ops_msr = {
-	.read_msr	= native_read_msr,
-	.write_msr	= native_write_msr,
-	.read_msr_safe	= native_read_msr_safe,
-	.write_msr_safe	= native_write_msr_safe,
+	.read_msr	= __PV_IS_CALLEE_SAVE(pv_native_rdmsr),
+	.write_msr	= __PV_IS_CALLEE_SAVE(pv_native_wrmsr),
+	.read_msr_safe	= __PV_IS_CALLEE_SAVE(pv_native_rdmsr_safe),
+	.write_msr_safe	= __PV_IS_CALLEE_SAVE(pv_native_wrmsr_safe),
 	.read_pmc	= native_read_pmc,
 };
 EXPORT_SYMBOL(pv_ops_msr);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index bf81e84ff261..505a85c3869e 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1148,15 +1148,32 @@ static void xen_do_write_msr(u32 msr, u64 val, int *err)
 	}
 }
 
-static int xen_read_msr_safe(u32 msr, u64 *val)
+/*
+ * Prototypes for functions called via PV_CALLEE_SAVE_REGS_THUNK() in order
+ * to avoid warnings with "-Wmissing-prototypes".
+ */
+struct xen_rdmsr_safe_ret {
+	u64 val;
+	int err;
+};
+struct xen_rdmsr_safe_ret xen_read_msr_safe(u32 msr);
+int xen_write_msr_safe(u32 msr, u64 val);
+u64 xen_read_msr(u32 msr);
+void xen_write_msr(u32 msr, u64 val);
+#define PV_PROLOGUE_RDMSR	"mov %ecx, %edi;"
+#define PV_PROLOGUE_WRMSR	"mov %ecx, %edi; mov %rax, %rsi;"
+
+__visible struct xen_rdmsr_safe_ret xen_read_msr_safe(u32 msr)
 {
-	int err = 0;
+	struct xen_rdmsr_safe_ret ret = { 0, 0 };
 
-	*val = xen_do_read_msr(msr, &err);
-	return err;
+	ret.val = xen_do_read_msr(msr, &ret.err);
+	return ret;
 }
+#define PV_PROLOGUE_MSR_xen_read_msr_safe	PV_PROLOGUE_RDMSR
+PV_CALLEE_SAVE_REGS_MSR_THUNK(xen_read_msr_safe);
 
-static int xen_write_msr_safe(u32 msr, u64 val)
+__visible int xen_write_msr_safe(u32 msr, u64 val)
 {
 	int err = 0;
 
@@ -1164,20 +1181,26 @@ static int xen_write_msr_safe(u32 msr, u64 val)
 
 	return err;
 }
+#define PV_PROLOGUE_MSR_xen_write_msr_safe	PV_PROLOGUE_WRMSR
+PV_CALLEE_SAVE_REGS_MSR_THUNK(xen_write_msr_safe);
 
-static u64 xen_read_msr(u32 msr)
+__visible u64 xen_read_msr(u32 msr)
 {
 	int err = 0;
 
 	return xen_do_read_msr(msr, xen_msr_safe ? &err : NULL);
 }
+#define PV_PROLOGUE_MSR_xen_read_msr	PV_PROLOGUE_RDMSR
+PV_CALLEE_SAVE_REGS_MSR_THUNK(xen_read_msr);
 
-static void xen_write_msr(u32 msr, u64 val)
+__visible void xen_write_msr(u32 msr, u64 val)
 {
 	int err;
 
 	xen_do_write_msr(msr, val, xen_msr_safe ? &err : NULL);
 }
+#define PV_PROLOGUE_MSR_xen_write_msr	PV_PROLOGUE_WRMSR
+PV_CALLEE_SAVE_REGS_MSR_THUNK(xen_write_msr);
 
 /* This is called once we have the cpu_possible_mask */
 void __init xen_setup_vcpu_info_placement(void)
@@ -1380,10 +1403,10 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 	pv_ops.cpu.start_context_switch = xen_start_context_switch;
 	pv_ops.cpu.end_context_switch = xen_end_context_switch;
 
-	pv_ops_msr.read_msr = xen_read_msr;
-	pv_ops_msr.write_msr = xen_write_msr;
-	pv_ops_msr.read_msr_safe = xen_read_msr_safe;
-	pv_ops_msr.write_msr_safe = xen_write_msr_safe;
+	pv_ops_msr.read_msr = PV_CALLEE_SAVE(xen_read_msr);
+	pv_ops_msr.write_msr = PV_CALLEE_SAVE(xen_write_msr);
+	pv_ops_msr.read_msr_safe = PV_CALLEE_SAVE(xen_read_msr_safe);
+	pv_ops_msr.write_msr_safe = PV_CALLEE_SAVE(xen_write_msr_safe);
 	pv_ops_msr.read_pmc = xen_read_pmc;
 
 	xen_init_irq_ops();
-- 
2.55.0

