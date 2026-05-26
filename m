Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07040313F
	for <virtualization@lists.linux.dev>; Tue, 26 May 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808107; cv=none; b=Sb0mBBdue3qXeFG10RBAiDKTwB22UPTFVNjR/KLyWCvKHS4rnMeppkg4zzDRNHO5p8UtjY4YLzjpvp09378Aicq1IkS53mz7pel+I++IBX8WqXwJRPgCWw3KXRrJ1leNU2+aA5eMm3tcz7uheaN3T0O9aE0IrqRE6y8sAlKGKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808107; c=relaxed/simple;
	bh=4BQGZ6rn8EXcTIPdVHwax3ftXTIof8c7Gjp1842aZm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCjpEsMmnLMmNQXJReQAvsW/Yf5J/Sx8N5bp1CQHr9Ip7tSaVEWBNDGPQL1TKq7hfXsQt9KYdd4uyaInEz5s+9mFBW9gkZ0xAPA19kFpVRKkG8mORGiftuY6LYbsFM+A0RW/o5frxv1NNZKeaBrdnnkVHtP3oG6xCCzX6Gmd52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a88ZLq0n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mOta7BZD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a88ZLq0n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mOta7BZD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E471B75EA3;
	Tue, 26 May 2026 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779808104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yR9KBKqLhdL4TaLLpf7zLaGBy80B1vMaPGZJkdtW870=;
	b=a88ZLq0n4eFHQXBU9atAHBhQVYJrMA0/zfysFwKMWr1VF6Y+YNozmaTK5hGfJlp6CfC/i+
	MqyZwloTt6lGEbbZbLIV7Amrq7zm984jW+0H4Vm/rAdF4x8LhRpr0vOfg8YC69VC3ZXC3F
	62E3QjH3pFj+396aoMqY1FFUTKKVz/M=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779808103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yR9KBKqLhdL4TaLLpf7zLaGBy80B1vMaPGZJkdtW870=;
	b=mOta7BZDekc5rViscFO2is8xDKTfVybUW8145uGk9BhyHejpNnUJ1v2hZewdHD4PiQrWGr
	HzQcYLHvZvJ6pSmW1zJLMLBcGjD5OhoSdrQYQBmVClmtpoXhJpvAfYw8K3jmdGGk4D6ilC
	WYdt36liqhak0Xz/9Oqc4Sj0N71bPQQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 974155A27D;
	Tue, 26 May 2026 15:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z97RI2e3FWqqVQAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 26 May 2026 15:08:23 +0000
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
Subject: [PATCH 4/5] x86/xen: Get rid of last XEN_LAZY_MMU uses
Date: Tue, 26 May 2026 17:05:13 +0200
Message-ID: <20260526150514.129330-5-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526150514.129330-1-jgross@suse.com>
References: <20260526150514.129330-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]

There are only very few use cases of XEN_LAZY_MMU left. Get rid of
them in order to avoid having to call enter_lazy(XEN_LAZY_MMU) and
leave_lazy(XEN_LAZY_MMU).

The query in xen_batched_set_pte() can be replaced by using
is_lazy_mmu_mode_active() instead.

As xen_flush_lazy_mmu() will be called only with lazy MMU mode being
active, the test for the lazy mode can just be dropped.

In xen_start_context_switch() and xen_end_context_switch() use
__task_lazy_mmu_mode_pause() and __task_lazy_mmu_mode_resume(),
allowing to drop xen_enter_lazy_mmu() and xen_leave_lazy_mmu()
completely.

Call arch_flush_lazy_mmu_mode() from arch_leave_lazy_mmu_mode(), as
this is the only required action now.

Drop the lazy mmu enter and leave paravirt hooks, leaving the flush
hook as the only needed one.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       |  9 ++++-----
 arch/x86/include/asm/paravirt_types.h | 11 +----------
 arch/x86/kernel/paravirt.c            |  6 +-----
 arch/x86/xen/enlighten_pv.c           |  7 ++-----
 arch/x86/xen/mmu_pv.c                 | 28 +++------------------------
 5 files changed, 11 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cdfe4007443e..0591aa38fd85 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -483,17 +483,16 @@ static inline void arch_end_context_switch(struct task_struct *next)
 
 static inline void arch_enter_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(pv_ops, mmu.lazy_mode.enter);
 }
 
-static inline void arch_leave_lazy_mmu_mode(void)
+static inline void arch_flush_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(pv_ops, mmu.lazy_mode.leave);
+	PVOP_VCALL0(pv_ops, mmu.lazy_mode_flush);
 }
 
-static inline void arch_flush_lazy_mmu_mode(void)
+static inline void arch_leave_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(pv_ops, mmu.lazy_mode.flush);
+	arch_flush_lazy_mmu_mode();
 }
 
 static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 4f5ae0068aab..b4c4a23e77a1 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -19,15 +19,6 @@ struct cpumask;
 struct flush_tlb_info;
 struct vm_area_struct;
 
-#ifdef CONFIG_PARAVIRT_XXL
-struct pv_lazy_ops {
-	/* Set deferred update mode, used for batching operations. */
-	void (*enter)(void);
-	void (*leave)(void);
-	void (*flush)(void);
-} __no_randomize_layout;
-#endif
-
 struct pv_cpu_ops {
 	/* hooks for various privileged instructions */
 #ifdef CONFIG_PARAVIRT_XXL
@@ -171,7 +162,7 @@ struct pv_mmu_ops {
 
 	void (*set_pgd)(pgd_t *pgdp, pgd_t pgdval);
 
-	struct pv_lazy_ops lazy_mode;
+	void (*lazy_mode_flush)(void);
 
 	/* dom0 ops */
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 792fa96b3233..22f72034470f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -204,11 +204,7 @@ struct paravirt_patch_template pv_ops = {
 
 	.mmu.enter_mmap		= paravirt_nop,
 
-	.mmu.lazy_mode = {
-		.enter		= paravirt_nop,
-		.leave		= paravirt_nop,
-		.flush		= paravirt_nop,
-	},
+	.mmu.lazy_mode_flush	= paravirt_nop,
 
 	.mmu.set_fixmap		= native_set_fixmap,
 #endif /* CONFIG_PARAVIRT_XXL */
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 428189f5d437..8ee4910d597a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -424,9 +424,7 @@ static void xen_start_context_switch(struct task_struct *prev)
 {
 	BUG_ON(preemptible());
 
-	if (this_cpu_read(xen_lazy_mode) == XEN_LAZY_MMU) {
-		arch_leave_lazy_mmu_mode();
-	}
+	__task_lazy_mmu_mode_pause(prev);
 	enter_lazy(XEN_LAZY_CPU);
 }
 
@@ -436,8 +434,7 @@ static void xen_end_context_switch(struct task_struct *next)
 
 	xen_mc_flush();
 	leave_lazy(XEN_LAZY_CPU);
-	if (__task_lazy_mmu_mode_active(next))
-		arch_enter_lazy_mmu_mode();
+	__task_lazy_mmu_mode_resume(next);
 }
 
 static unsigned long xen_store_tr(void)
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 51dbdc67c73c..928b4b0a4484 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -324,7 +324,7 @@ static bool xen_batched_set_pte(pte_t *ptep, pte_t pteval)
 {
 	struct mmu_update u;
 
-	if (xen_get_lazy_mode() != XEN_LAZY_MMU)
+	if (!is_lazy_mmu_mode_active())
 		return false;
 
 	xen_mc_batch();
@@ -2151,21 +2151,10 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
 #endif
 }
 
-static void xen_enter_lazy_mmu(void)
-{
-	preempt_disable();
-	if (xen_get_lazy_mode() != XEN_LAZY_MMU)
-		enter_lazy(XEN_LAZY_MMU);
-	preempt_enable();
-}
-
 static void xen_flush_lazy_mmu(void)
 {
 	preempt_disable();
-
-	if (xen_get_lazy_mode() == XEN_LAZY_MMU)
-		xen_mc_flush();
-
+	xen_mc_flush();
 	preempt_enable();
 }
 
@@ -2189,15 +2178,6 @@ static void __init xen_post_allocator_init(void)
 	pv_ops.mmu.write_cr3 = &xen_write_cr3;
 }
 
-static void xen_leave_lazy_mmu(void)
-{
-	preempt_disable();
-	xen_mc_flush();
-	if (xen_get_lazy_mode() != XEN_LAZY_NONE)
-		leave_lazy(XEN_LAZY_MMU);
-	preempt_enable();
-}
-
 void __init xen_init_mmu_ops(void)
 {
 	x86_init.paging.pagetable_init = xen_pagetable_init;
@@ -2237,9 +2217,7 @@ void __init xen_init_mmu_ops(void)
 	pv_ops.mmu.make_p4d = PV_CALLEE_SAVE(xen_make_p4d);
 	pv_ops.mmu.enter_mmap = xen_enter_mmap;
 	pv_ops.mmu.exit_mmap = xen_exit_mmap;
-	pv_ops.mmu.lazy_mode.enter = xen_enter_lazy_mmu;
-	pv_ops.mmu.lazy_mode.leave = xen_leave_lazy_mmu;
-	pv_ops.mmu.lazy_mode.flush = xen_flush_lazy_mmu;
+	pv_ops.mmu.lazy_mode_flush = xen_flush_lazy_mmu;
 	pv_ops.mmu.set_fixmap = xen_set_fixmap;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
-- 
2.54.0

