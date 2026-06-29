Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218073C108B
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716230; cv=none; b=PqLUOLYTFqMGMory78NQdyh2UtZTQWCXvlPZwQJXYjney2QEwsUpULukvlm4ebDl+/UDsMCdd4SbkurEWqbm6NkZ58VkCpCsaiIS8cfcKiJL2uT4juwEazroPUdRmZGLjNOfkwV7i9ZnmZXYc+uiJaiAH9p4LeHMPZL4u4FOhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716230; c=relaxed/simple;
	bh=5V6Nyu/42HJO+m9cz3o1clppePDFnjB/BYGJKzMeMvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTBeJ327gp/OB2OAzkAVdsKBIvVb/awQbkEvQQmzPEkJPXZ3nXgl3We9NZbb3/vZVvcMasdLNRYamB8jWWVu4M8OdxV2J/C63UrllD3YxYv6PjaWSHUq++y1fT6LebJqGwmzC0GBsI9fRqS8S1hq/AZDGnNk7lNroM0jGps+/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S9ZYzPwk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S9ZYzPwk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S9ZYzPwk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S9ZYzPwk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0D7175D2E;
	Mon, 29 Jun 2026 06:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRbpUWQFFUftbKgTEwja5phgG0YxujJ6AsqfvdgAbDY=;
	b=S9ZYzPwkP4KacdW6IiP05Z9pPOLj2oqeEKl8tujDnyWNzdW+6TJwWpiX1LNR1eMvblhHVF
	9FiL8AmB8hsOP5VBUx7gm2Uz5Xr49g7nHNeEGLgL5417NEtBdzz4lkLgzhsIxIiw9ODWRK
	/eHLSItOvuHz+KvomWG54CMW6zK2v48=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRbpUWQFFUftbKgTEwja5phgG0YxujJ6AsqfvdgAbDY=;
	b=S9ZYzPwkP4KacdW6IiP05Z9pPOLj2oqeEKl8tujDnyWNzdW+6TJwWpiX1LNR1eMvblhHVF
	9FiL8AmB8hsOP5VBUx7gm2Uz5Xr49g7nHNeEGLgL5417NEtBdzz4lkLgzhsIxIiw9ODWRK
	/eHLSItOvuHz+KvomWG54CMW6zK2v48=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4985A779A8;
	Mon, 29 Jun 2026 06:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9eSEEEMXQmp+QgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:57:07 +0000
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 14/18] x86/paravirt: Prepare support of MSR instruction interfaces
Date: Mon, 29 Jun 2026 08:55:40 +0200
Message-ID: <20260629065544.3643253-15-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629065544.3643253-1-jgross@suse.com>
References: <20260629065544.3643253-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Make the paravirt callee-save infrastructure more generic by allowing
arbitrary register interfaces via prologue and epilogue helper macros.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- carved out from patch 5 of V1
---
 arch/x86/include/asm/paravirt_types.h     | 43 ++++++++++++++---------
 arch/x86/include/asm/qspinlock_paravirt.h |  4 +--
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 2459163fa196..740ea819bbab 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -448,27 +448,38 @@ extern struct paravirt_patch_template pv_ops;
 #define PV_SAVE_ALL_CALLER_REGS		"pushl %ecx;"
 #define PV_RESTORE_ALL_CALLER_REGS	"popl  %ecx;"
 #else
+/* Save and restore caller-save registers, except %rax, %rcx and %rdx. */
+#define PV_SAVE_COMMON_CALLER_REGS	\
+	"push %rsi;"			\
+	"push %rdi;"			\
+	"push %r8;"			\
+	"push %r9;"			\
+	"push %r10;"			\
+	"push %r11;"
+
+#define PV_RESTORE_COMMON_CALLER_REGS	\
+	"pop %r11;"			\
+	"pop %r10;"			\
+	"pop %r9;"			\
+	"pop %r8;"			\
+	"pop %rdi;"			\
+	"pop %rsi;"
+
 /* save and restore all caller-save registers, except return value */
 #define PV_SAVE_ALL_CALLER_REGS						\
 	"push %rcx;"							\
 	"push %rdx;"							\
-	"push %rsi;"							\
-	"push %rdi;"							\
-	"push %r8;"							\
-	"push %r9;"							\
-	"push %r10;"							\
-	"push %r11;"
+	PV_SAVE_COMMON_CALLER_REGS
+
 #define PV_RESTORE_ALL_CALLER_REGS					\
-	"pop %r11;"							\
-	"pop %r10;"							\
-	"pop %r9;"							\
-	"pop %r8;"							\
-	"pop %rdi;"							\
-	"pop %rsi;"							\
+	PV_RESTORE_COMMON_CALLER_REGS					\
 	"pop %rdx;"							\
 	"pop %rcx;"
 #endif
 
+#define PV_PROLOGUE_ALL(func)	PV_SAVE_ALL_CALLER_REGS
+#define PV_EPILOGUE_ALL(func)	PV_RESTORE_ALL_CALLER_REGS
+
 /*
  * Generate a thunk around a function which saves all caller-save
  * registers except for the return value.  This allows C functions to
@@ -482,7 +493,7 @@ extern struct paravirt_patch_template pv_ops;
  * functions.
  */
 #define PV_THUNK_NAME(func) "__raw_callee_save_" #func
-#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
+#define __PV_CALLEE_SAVE_REGS_THUNK(func, section, helper)		\
 	extern typeof(func) __raw_callee_save_##func;			\
 									\
 	asm(".pushsection " section ", \"ax\";"				\
@@ -492,16 +503,16 @@ extern struct paravirt_patch_template pv_ops;
 	    PV_THUNK_NAME(func) ":"					\
 	    ASM_ENDBR							\
 	    FRAME_BEGIN							\
-	    PV_SAVE_ALL_CALLER_REGS					\
+	    PV_PROLOGUE_##helper(func)					\
 	    "call " #func ";"						\
-	    PV_RESTORE_ALL_CALLER_REGS					\
+	    PV_EPILOGUE_##helper(func)					\
 	    FRAME_END							\
 	    ASM_RET							\
 	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
 
 #define PV_CALLEE_SAVE_REGS_THUNK(func)			\
-	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
+	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text", ALL)
 
 /* Get a reference to a callee-save function */
 #define PV_CALLEE_SAVE(func)						\
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 0a985784be9b..002b17f0735e 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -14,7 +14,7 @@ void __lockfunc __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 lock
  */
 #ifdef CONFIG_64BIT
 
-__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
+__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text", ALL);
 #define __pv_queued_spin_unlock	__pv_queued_spin_unlock
 
 /*
@@ -61,7 +61,7 @@ DEFINE_ASM_FUNC(__raw_callee_save___pv_queued_spin_unlock,
 #else /* CONFIG_64BIT */
 
 extern void __lockfunc __pv_queued_spin_unlock(struct qspinlock *lock);
-__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock, ".spinlock.text");
+__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock, ".spinlock.text", ALL);
 
 #endif /* CONFIG_64BIT */
 #endif
-- 
2.54.0

