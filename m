Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854420;
	b=Z6jvdsGpQd8IRC0IgNTcTKRq1s3kEttKWzcKt+2MFtpACyCmwUfVo7B3573ohBRVwV3b
	 ev5TE7Mps7NUwC7w5+yTxTLKBOCXT+TQa3eexIthtIcsHkPCN645mCl1XM6KmJ+iTUGRL
	 LWqlU5qU/lyLazcyi9Tgbs5Ddzz83kZqcsehMs37CPZdAE4GGQ/6mDLGPdhxAREXbRXXg
	 aTX11WHo+D9Hc1cXGsONE0He+j6LyDN+zx08pEdyf2VbVpDh6N32B5MyWAn7bLss5JrbV
	 3E+n3TCQivZ7k7Cel25ajsuGynDt4HBUzTVo4laqUM7IS9uF0sg50KAHv2KG8r097VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854420;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=EstgW3BFXnX4df1tuW4tEnqzE/nSwaIt9m5b3CVovjM=;
	b=tyW3IAGjScwUI8PI28Pq1Li/mCAqTBT6kuTjUF1WQZdvyqMj/S3nE7Jnwuib002dUoI2
	 cPyZMus/74tJn+Dc6EXcVGdGkhvdmlZyfN0BRjzk/CRWW3PaaHIUUfzXg+4yGFjfzKXB8
	 ZvDvPUdu3CyJIVefjEIWWeVd1W+NeCG1X/yUbZodqkQTHYNji+v773/gYmPLjch+ERM4l
	 XgOrwIpPABULLfbOiGE4OUUr6aiYlZxXkdEeNL8f3jOCOM4S0FZ11Gku/eywfdkcfM50J
	 irOATy9MrhAUo3rSmYPGfcBj6L8ZNisoPk102SJbNmbu/5DT7TLxmFLuhFatE5ljyug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b="d7/gxS2i";
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b="d7/gxS2i";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317C606A323
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 18:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3317C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=d7/gxS2i;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=d7/gxS2i
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D2F92230D;
	Mon, 16 Nov 2026 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EstgW3BFXnX4df1tuW4tEnqzE/nSwaIt9m5b3CVovjM=;
	b=d7/gxS2iZEwV2qSsgM3D9VB3DqJoIXkBbK34RIXkiYBiBqLSS44U5xzn70VLA90JNCFh48
	n9lh//HAd7jumt+fyh0dHjuX3ABGmQMQ1TfANBfPGVvGpqPJZ4+l5hzjeIrznVt0iQDecI
	FBq78T/n3jVhalWndFmr4Sb9YWq3aZg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="d7/gxS2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EstgW3BFXnX4df1tuW4tEnqzE/nSwaIt9m5b3CVovjM=;
	b=d7/gxS2iZEwV2qSsgM3D9VB3DqJoIXkBbK34RIXkiYBiBqLSS44U5xzn70VLA90JNCFh48
	n9lh//HAd7jumt+fyh0dHjuX3ABGmQMQ1TfANBfPGVvGpqPJZ4+l5hzjeIrznVt0iQDecI
	FBq78T/n3jVhalWndFmr4Sb9YWq3aZg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4AC91334C;
	Mon, 16 Nov 2026 18:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WpBNJhFO+2qQeAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 18:40:17 +0000
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
Subject: [PATCH v6 12/17] x86/paravirt: Split off MSR related hooks into new header
Date: Mon, 16 Nov 2026 19:39:00 +0100
Message-ID: <20261116183905.1591611-13-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116183905.1591611-1-jgross@suse.com>
References: <20261116183905.1591611-1-jgross@suse.com>
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
X-Rspamd-Queue-Id: 5D2F92230D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.01

Move the WRMSR, RDMSR and RDPMC related parts of paravirt.h and
paravirt_types.h into a new header file paravirt-msr.h.

Switch all moved helper functions to __always_inline.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
V4:
- always use __always_inline
---
 arch/x86/include/asm/msr.h            |  2 +-
 arch/x86/include/asm/paravirt-msr.h   | 56 +++++++++++++++++++++++++++
 arch/x86/include/asm/paravirt.h       | 55 --------------------------
 arch/x86/include/asm/paravirt_types.h | 13 -------
 arch/x86/kernel/paravirt.c            | 14 ++++---
 arch/x86/xen/enlighten_pv.c           | 11 +++---
 tools/objtool/check.c                 |  1 +
 7 files changed, 73 insertions(+), 79 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-msr.h

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 36c80fcec71e..72f079df643d 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -322,7 +322,7 @@ static inline u64 native_read_pmc(int counter)
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
+#include <asm/paravirt-msr.h>
 #else
 static __always_inline u64 read_msr(u32 msr)
 {
diff --git a/arch/x86/include/asm/paravirt-msr.h b/arch/x86/include/asm/paravirt-msr.h
new file mode 100644
index 000000000000..3a39dfa3fe3e
--- /dev/null
+++ b/arch/x86/include/asm/paravirt-msr.h
@@ -0,0 +1,56 @@
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
+static __always_inline void write_msrns(u32 msr, u64 val)
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
+static __always_inline int write_msrns_safe(u32 msr, u64 val)
+{
+	return PVOP_CALL2(int, pv_ops_msr, write_msr_safe, msr, val);
+}
+
+static __always_inline u64 do_rdpmc(int counter)
+{
+	return PVOP_CALL1(u64, pv_ops_msr, read_pmc, counter);
+}
+
+#endif /* _ASM_X86_PARAVIRT_MSR_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c79522588842..eb16d55f94d3 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -130,61 +130,6 @@ static inline void __write_cr4(unsigned long x)
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
-static inline void write_msr(u32 msr, u64 val)
-{
-	paravirt_write_msr(msr, val);
-}
-
-static __always_inline void write_msrns(u32 msr, u64 val)
-{
-	paravirt_write_msr(msr, val);
-}
-
-static inline int write_msr_safe(u32 msr, u64 val)
-{
-	return paravirt_write_msr_safe(msr, val);
-}
-
-static __always_inline int write_msrns_safe(u32 msr, u64 val)
-{
-	return paravirt_write_msr_safe(msr, val);
-}
-
-static __always_inline int read_msr_safe(u32 msr, u64 *p)
-{
-	return paravirt_read_msr_safe(msr, p);
-}
-
-static __always_inline u64 do_rdpmc(int counter)
-{
-	return PVOP_CALL1(u64, pv_ops, cpu.read_pmc, counter);
-}
-
 static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 {
 	PVOP_VCALL2(pv_ops, cpu.alloc_ldt, ldt, entries);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b4c4a23e77a1..2459163fa196 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -58,19 +58,6 @@ struct pv_cpu_ops {
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
index 00b59d774389..739dbfd8aadf 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -110,11 +110,6 @@ struct paravirt_patch_template pv_ops = {
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
@@ -212,6 +207,15 @@ struct paravirt_patch_template pv_ops = {
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
index c5117a7730d6..a4719762d7ea 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1360,11 +1360,6 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
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
@@ -1385,6 +1380,12 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
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
index 931c5c412f15..c7df519d9992 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -530,6 +530,7 @@ static struct {
 } pv_ops_tables[] = {
 	{ .name = "pv_ops", },
 	{ .name = "pv_ops_lock", },
+	{ .name = "pv_ops_msr", },
 	{ .name = NULL, .idx_off = -1 }
 };
 
-- 
2.56.0

