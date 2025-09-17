Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE714332A53
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120826; cv=none; b=P/JSUzyHK0TiP1X6VF1PWhmKt8lJbhXqiEMzG16bdn3oqTqoD81a/CKJLMz/Ysp9auk2tDjh4On7dkHOq7SGU9lNJVfG7zCOBRNQ2oza+1/odEaWgXAxNUBWmSTDrccomALjzm9T63imkbf0j4gawQrGtjmNsg3bwhSGnyh8P4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120826; c=relaxed/simple;
	bh=nIRySOT2pPuOHT+dnFvmJctkKtXylRy/0jXTsQosxrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8b5+c4hrNjGJNJD9LZtSg87kk9NaW0RqU7/+AQGtadw55aZB/zyIuewNL7B8qM7UAU2h74Ym4Uq7rLnvC76beWPlc/F225rWbNVsqpj+s57/24Igq/F88JPB0jGWL6iZK5TN4doAPwELmEJkxr6/dYg4qUCmnQn7htrqJtkIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZPgWOJzg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZPgWOJzg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZPgWOJzg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZPgWOJzg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8EFC2073E;
	Wed, 17 Sep 2025 14:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vLZFP8NFZ1/X1AyjobjHKnI++28gh5LEu/UDtvy5bk=;
	b=ZPgWOJzg5t2RczyhraeBrSN9rHXijZg2EXRH21tJ+DS12d+sy4qbMuXcugJniX+K/2vgXd
	CQh52yBj20Ne0v8FYoNps8lloDfGteF/jfV+UiN4AfsiofWHB94OYLH8DO+EzMhWjIAnW5
	wX8CUTSOJIOa3rGnBNuWdSbHrmXexrw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vLZFP8NFZ1/X1AyjobjHKnI++28gh5LEu/UDtvy5bk=;
	b=ZPgWOJzg5t2RczyhraeBrSN9rHXijZg2EXRH21tJ+DS12d+sy4qbMuXcugJniX+K/2vgXd
	CQh52yBj20Ne0v8FYoNps8lloDfGteF/jfV+UiN4AfsiofWHB94OYLH8DO+EzMhWjIAnW5
	wX8CUTSOJIOa3rGnBNuWdSbHrmXexrw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C6D41368D;
	Wed, 17 Sep 2025 14:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id daJiCXbLymhaEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:53:42 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 13/21] x86/paravirt: Introduce new paravirt-base.h header
Date: Wed, 17 Sep 2025 16:52:12 +0200
Message-ID: <20250917145220.31064-14-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917145220.31064-1-jgross@suse.com>
References: <20250917145220.31064-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

Move the pv_info related definitions and the declarations of the global
paravirt function primitives into a new header file paravirt-base.h.

This enables to use that header instead of paravirt_types.h in
ptrace.h.

Additionally it is in preparation of reducing include hell with
paravirt enabled.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/include/asm/paravirt-base.h  | 29 +++++++++++++++++++++++++++
 arch/x86/include/asm/paravirt.h       |  4 +++-
 arch/x86/include/asm/paravirt_types.h | 23 +--------------------
 arch/x86/include/asm/ptrace.h         |  2 +-
 4 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt-base.h

diff --git a/arch/x86/include/asm/paravirt-base.h b/arch/x86/include/asm/paravirt-base.h
new file mode 100644
index 000000000000..3827ea20de18
--- /dev/null
+++ b/arch/x86/include/asm/paravirt-base.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_X86_PARAVIRT_BASE_H
+#define _ASM_X86_PARAVIRT_BASE_H
+
+/*
+ * Wrapper type for pointers to code which uses the non-standard
+ * calling convention.  See PV_CALL_SAVE_REGS_THUNK below.
+ */
+struct paravirt_callee_save {
+	void *func;
+};
+
+struct pv_info {
+#ifdef CONFIG_PARAVIRT_XXL
+	u16 extra_user_64bit_cs;  /* __USER_CS if none */
+#endif
+	const char *name;
+};
+
+void default_banner(void);
+extern struct pv_info pv_info;
+unsigned long paravirt_ret0(void);
+#ifdef CONFIG_PARAVIRT_XXL
+u64 _paravirt_ident_64(u64);
+#endif
+#define paravirt_nop	((void *)nop_func)
+
+#endif /* _ASM_X86_PARAVIRT_BASE_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b69e75a5c872..62399f5d037d 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -4,6 +4,9 @@
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
 
+#ifndef __ASSEMBLER__
+#include <asm/paravirt-base.h>
+#endif
 #include <asm/paravirt_types.h>
 
 #ifdef CONFIG_PARAVIRT
@@ -601,7 +604,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #undef PVOP_VCALL4
 #undef PVOP_CALL4
 
-extern void default_banner(void);
 void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLER__ */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 7acff40cc159..148d157e2a4a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -7,6 +7,7 @@
 #ifndef __ASSEMBLER__
 #include <linux/types.h>
 
+#include <asm/paravirt-base.h>
 #include <asm/desc_defs.h>
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
@@ -18,23 +19,6 @@ struct cpumask;
 struct flush_tlb_info;
 struct vm_area_struct;
 
-/*
- * Wrapper type for pointers to code which uses the non-standard
- * calling convention.  See PV_CALL_SAVE_REGS_THUNK below.
- */
-struct paravirt_callee_save {
-	void *func;
-};
-
-/* general info */
-struct pv_info {
-#ifdef CONFIG_PARAVIRT_XXL
-	u16 extra_user_64bit_cs;  /* __USER_CS if none */
-#endif
-
-	const char *name;
-};
-
 #ifdef CONFIG_PARAVIRT_XXL
 struct pv_lazy_ops {
 	/* Set deferred update mode, used for batching operations. */
@@ -226,7 +210,6 @@ struct paravirt_patch_template {
 	struct pv_lock_ops	lock;
 } __no_randomize_layout;
 
-extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
 
 #define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
@@ -497,17 +480,13 @@ extern struct paravirt_patch_template pv_ops;
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 
-unsigned long paravirt_ret0(void);
 #ifdef CONFIG_PARAVIRT_XXL
-u64 _paravirt_ident_64(u64);
 unsigned long pv_native_save_fl(void);
 void pv_native_irq_disable(void);
 void pv_native_irq_enable(void);
 unsigned long pv_native_read_cr2(void);
 #endif
 
-#define paravirt_nop	((void *)nop_func)
-
 #endif	/* __ASSEMBLER__ */
 
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f75467f73d..fe2dab7d74e3 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -172,7 +172,7 @@ struct pt_regs {
 #endif /* !__i386__ */
 
 #ifdef CONFIG_PARAVIRT
-#include <asm/paravirt_types.h>
+#include <asm/paravirt-base.h>
 #endif
 
 #include <asm/proto.h>
-- 
2.51.0

