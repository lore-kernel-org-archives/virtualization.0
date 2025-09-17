Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62432E75D
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120771; cv=none; b=PAhpm7J+32gAMWuYz+IUTNaCv5QUXGZehAO6570V3uUR3jVu5RmxRxsSMkds3cLrBVJsjdbloe/wZOjceuGNsmCUW+ajr7cooGwbEZGLtya2F/SqbYSHlfFjqkNKCfpcKR9oJXitZPmfx0k6BTeIEoRCoC/cuMp1oa9whauvniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120771; c=relaxed/simple;
	bh=FFf5ymBkot6R4Bde82qyh8L4IBXSB2yHfMrSKI2zgsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+1YTZrUucnM+u+UuGE+3CsUltSNAW8qsy1WdzpHQcGrT9ZsIp/+RlAVrXmeouBIjlXUwykbnW0dnsySIo3JReCFTqHtSW4nYyBOy6vTYubHhj9tFZc6Jy+L0GejfkGTXj6C9YdOLLFZOSm8l6CFZmG4dvm56YzrrYmGEBhHtD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1400F20710;
	Wed, 17 Sep 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F6771368D;
	Wed, 17 Sep 2025 14:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +9VpJT/LymjnEgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:52:47 +0000
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
Subject: [PATCH v2 04/21] x86/paravirt: Move thunk macros to paravirt_types.h
Date: Wed, 17 Sep 2025 16:52:03 +0200
Message-ID: <20250917145220.31064-5-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)]
X-Rspamd-Queue-Id: 1400F20710
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

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
index 085095f94f97..7acff40cc159 100644
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

