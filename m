Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED8318B8A
	for <virtualization@lists.linux.dev>; Wed, 18 Feb 2026 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402972; cv=none; b=RrK7qEGBQ9++HO7lg77g/o786JxqRLQ2QGwz3/tPkuNtBec0oNoej3v/uuAwJ5kXc4uJDRLTrwckA86mjxHcdfhOQ1k4A6RNwa9E98huoX6frPY3LEMSGOBijuydxNLazUbwP8poX9pNP9YBSWAfhCYQPIWuM2TiW9b7yihsBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402972; c=relaxed/simple;
	bh=2eSlOLaXtr5fyV0SQpnOosYrwcsLxiKXsiZ9FL9JTyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8pazF5HZPyAhftL/fmZWcMVyrC+oMabZC9M1M19JygMhv27on/QmwSLCFoWJtJuPiNBhLePj5yrlC4HZK5hWzUblWAmoxKoPZphIKE+x5G/l7gHbaNNQ9Qer4xymDhclx16rtfxatKPxCNlglKXBW9EzRKgQBplpasP/xJXjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 242CD3E6E8;
	Wed, 18 Feb 2026 08:22:49 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7B363EA65;
	Wed, 18 Feb 2026 08:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +dGeL9h2lWk1HwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 18 Feb 2026 08:22:48 +0000
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
Subject: [PATCH v3 13/16] x86/paravirt: Prepare support of MSR instruction interfaces
Date: Wed, 18 Feb 2026 09:21:30 +0100
Message-ID: <20260218082133.400602-14-jgross@suse.com>
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
X-Rspamd-Queue-Id: 242CD3E6E8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

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
index 1e7188247c1f..999a5abe54ed 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -457,27 +457,38 @@ extern struct paravirt_patch_template pv_ops;
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
@@ -491,7 +502,7 @@ extern struct paravirt_patch_template pv_ops;
  * functions.
  */
 #define PV_THUNK_NAME(func) "__raw_callee_save_" #func
-#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
+#define __PV_CALLEE_SAVE_REGS_THUNK(func, section, helper)		\
 	extern typeof(func) __raw_callee_save_##func;			\
 									\
 	asm(".pushsection " section ", \"ax\";"				\
@@ -501,16 +512,16 @@ extern struct paravirt_patch_template pv_ops;
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
2.53.0

