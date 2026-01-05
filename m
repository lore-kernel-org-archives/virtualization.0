Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19933468C
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611154; cv=none; b=IzNCB/itVkVAEJ0FfI4MLu5uR5FOEeggRtrOkO5Crocb3DWPeyyo/TJm9Gb5OrGRRd4fEbwTwuc1XBuPKhruhZUVYuzLD/6yQ4WxPHLVzyqM6Qe7BLGTZufy4QOtIon1PZQKg3oP1tWWcmhXeb5CYp8Ka/5yp4xTK0QzmzGtEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611154; c=relaxed/simple;
	bh=Of56GsD7isv4ATlm9RX6vEYv9ysMRbEhMJaMhsk0d88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiyT6vKtrUWvfeO4p+pL5MaFd+YZiEWrZ93dRdxICYypvSSOHcrGDe+w6vhrd3qxPa44yIB2sPONk8yx4VKyamWgHpIP+nY5UGlCn4qztgmyMEMVroEC3ps7MT4rqHAg1h57Uc1FgKazmRJtfgmaI+p7fOVoLgdOr4W1DUv2fN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oYl2+4aH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k6bwBGwY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oYl2+4aH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k6bwBGwY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27E715BE34;
	Mon,  5 Jan 2026 11:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tin0LZKuG0DO+L5y+JnGKTUV+K4stlx2fe2x0Ru7R/k=;
	b=oYl2+4aHPp4AsAtXru1OzeaF1iluaplPdwnGSZa8MGjXQt/UUshKxL0io6VZ7kj5a64NCK
	Ls7ENWxdqSN8ISWTib0c6qLpJgYxai+Mum6qLwSWovq4FhdljY6ZdKRUgxrRpNLpySl46D
	w0rSSSbG5sLBQYrjWMgJPY0fSnMg8+o=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tin0LZKuG0DO+L5y+JnGKTUV+K4stlx2fe2x0Ru7R/k=;
	b=k6bwBGwYneFhWPkDSi1wvfStzc+HnI5spPFe0r5rrCEgHnQ3uZcecxXJWsqkS0211m29Y4
	t0sZ1rjrl5L2T068GIBtr5dYYwDFZdKyKVDcc898NaJiBsVmkdzqy/gLeoo7waG+cHEZBa
	xf2Iguo0rO9NeTb6u88JjlShEMFgLCg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A988C13964;
	Mon,  5 Jan 2026 11:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NCKhJw2bW2kGWgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:05:49 +0000
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
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v5 04/21] x86/paravirt: Move thunk macros to paravirt_types.h
Date: Mon,  5 Jan 2026 12:05:03 +0100
Message-ID: <20260105110520.21356-5-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105110520.21356-1-jgross@suse.com>
References: <20260105110520.21356-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,infradead.org:email,imap1.dmz-prg2.suse.org:helo];
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

The macros for generating PV-thunks are part of the generic paravirt
infrastructure, so they should be in paravirt_types.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h       | 68 ---------------------------
 arch/x86/include/asm/paravirt_types.h | 68 +++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index fd9826397419..1344d2fb2b86 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -581,74 +581,6 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 
 #endif /* SMP && PARAVIRT_SPINLOCKS */
 
-#ifdef CONFIG_X86_32
-/* save and restore all caller-save registers, except return value */
-#define PV_SAVE_ALL_CALLER_REGS		"pushl %ecx;"
-#define PV_RESTORE_ALL_CALLER_REGS	"popl  %ecx;"
-#else
-/* save and restore all caller-save registers, except return value */
-#define PV_SAVE_ALL_CALLER_REGS						\
-	"push %rcx;"							\
-	"push %rdx;"							\
-	"push %rsi;"							\
-	"push %rdi;"							\
-	"push %r8;"							\
-	"push %r9;"							\
-	"push %r10;"							\
-	"push %r11;"
-#define PV_RESTORE_ALL_CALLER_REGS					\
-	"pop %r11;"							\
-	"pop %r10;"							\
-	"pop %r9;"							\
-	"pop %r8;"							\
-	"pop %rdi;"							\
-	"pop %rsi;"							\
-	"pop %rdx;"							\
-	"pop %rcx;"
-#endif
-
-/*
- * Generate a thunk around a function which saves all caller-save
- * registers except for the return value.  This allows C functions to
- * be called from assembler code where fewer than normal registers are
- * available.  It may also help code generation around calls from C
- * code if the common case doesn't use many registers.
- *
- * When a callee is wrapped in a thunk, the caller can assume that all
- * arg regs and all scratch registers are preserved across the
- * call. The return value in rax/eax will not be saved, even for void
- * functions.
- */
-#define PV_THUNK_NAME(func) "__raw_callee_save_" #func
-#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
-	extern typeof(func) __raw_callee_save_##func;			\
-									\
-	asm(".pushsection " section ", \"ax\";"				\
-	    ".globl " PV_THUNK_NAME(func) ";"				\
-	    ".type " PV_THUNK_NAME(func) ", @function;"			\
-	    ASM_FUNC_ALIGN						\
-	    PV_THUNK_NAME(func) ":"					\
-	    ASM_ENDBR							\
-	    FRAME_BEGIN							\
-	    PV_SAVE_ALL_CALLER_REGS					\
-	    "call " #func ";"						\
-	    PV_RESTORE_ALL_CALLER_REGS					\
-	    FRAME_END							\
-	    ASM_RET							\
-	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
-	    ".popsection")
-
-#define PV_CALLEE_SAVE_REGS_THUNK(func)			\
-	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
-
-/* Get a reference to a callee-save function */
-#define PV_CALLEE_SAVE(func)						\
-	((struct paravirt_callee_save) { __raw_callee_save_##func })
-
-/* Promise that "func" already uses the right calling convention */
-#define __PV_IS_CALLEE_SAVE(func)			\
-	((struct paravirt_callee_save) { func })
-
 #ifdef CONFIG_PARAVIRT_XXL
 static __always_inline unsigned long arch_local_save_flags(void)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index bd83528835e9..0b60eab6ae24 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -512,5 +512,73 @@ unsigned long pv_native_read_cr2(void);
 
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
 
+#ifdef CONFIG_X86_32
+/* save and restore all caller-save registers, except return value */
+#define PV_SAVE_ALL_CALLER_REGS		"pushl %ecx;"
+#define PV_RESTORE_ALL_CALLER_REGS	"popl  %ecx;"
+#else
+/* save and restore all caller-save registers, except return value */
+#define PV_SAVE_ALL_CALLER_REGS						\
+	"push %rcx;"							\
+	"push %rdx;"							\
+	"push %rsi;"							\
+	"push %rdi;"							\
+	"push %r8;"							\
+	"push %r9;"							\
+	"push %r10;"							\
+	"push %r11;"
+#define PV_RESTORE_ALL_CALLER_REGS					\
+	"pop %r11;"							\
+	"pop %r10;"							\
+	"pop %r9;"							\
+	"pop %r8;"							\
+	"pop %rdi;"							\
+	"pop %rsi;"							\
+	"pop %rdx;"							\
+	"pop %rcx;"
+#endif
+
+/*
+ * Generate a thunk around a function which saves all caller-save
+ * registers except for the return value.  This allows C functions to
+ * be called from assembler code where fewer than normal registers are
+ * available.  It may also help code generation around calls from C
+ * code if the common case doesn't use many registers.
+ *
+ * When a callee is wrapped in a thunk, the caller can assume that all
+ * arg regs and all scratch registers are preserved across the
+ * call. The return value in rax/eax will not be saved, even for void
+ * functions.
+ */
+#define PV_THUNK_NAME(func) "__raw_callee_save_" #func
+#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
+	extern typeof(func) __raw_callee_save_##func;			\
+									\
+	asm(".pushsection " section ", \"ax\";"				\
+	    ".globl " PV_THUNK_NAME(func) ";"				\
+	    ".type " PV_THUNK_NAME(func) ", @function;"			\
+	    ASM_FUNC_ALIGN						\
+	    PV_THUNK_NAME(func) ":"					\
+	    ASM_ENDBR							\
+	    FRAME_BEGIN							\
+	    PV_SAVE_ALL_CALLER_REGS					\
+	    "call " #func ";"						\
+	    PV_RESTORE_ALL_CALLER_REGS					\
+	    FRAME_END							\
+	    ASM_RET							\
+	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
+	    ".popsection")
+
+#define PV_CALLEE_SAVE_REGS_THUNK(func)			\
+	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
+
+/* Get a reference to a callee-save function */
+#define PV_CALLEE_SAVE(func)						\
+	((struct paravirt_callee_save) { __raw_callee_save_##func })
+
+/* Promise that "func" already uses the right calling convention */
+#define __PV_IS_CALLEE_SAVE(func)			\
+	((struct paravirt_callee_save) { func })
+
 #endif  /* CONFIG_PARAVIRT */
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */
-- 
2.51.0

