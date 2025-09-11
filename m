Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76823257444
	for <virtualization@lists.linux.dev>; Thu, 11 Sep 2025 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572566; cv=none; b=azQ/pEkeUZcotnjz079lchr7uzkBDoxRV7MycIG5h1N4o6+Whoaj7NcqRtBni8aXEnFvHXxFGj9tDXcglcz4JjEa6xE9Z+J70j1SAYW7xTO7K2nrGrGv1cN+WufVZIEP59avnYzlQof7tpPfNBB5UAr3a0IgqSUYc7P6gdfdE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572566; c=relaxed/simple;
	bh=JRTKjZGd6tnztpWsCIHsBatqp4HnMRhi88cWF6rvwc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwskRPe8XjPHO0n+DVkXV42kvxS7U5LQPthMrYrk7NPSE/4i626o1aQ0wzXTJ84CUoNuRPkNKO3qOC8+GywdrnqoLEM0YqxgLxXYjIzKGTUN+JVHopWuS0QrR7HO2RqijcEU6Ct76gQnN4NWCWD/1eJPhuxNdhfX5l8ZytfOofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB0B1683EE;
	Thu, 11 Sep 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61F581372E;
	Thu, 11 Sep 2025 06:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EJNYFtJtwmhjTQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 11 Sep 2025 06:36:02 +0000
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 14/14] x86/pvlocks: move paravirt spinlock functions into qspinlock.h
Date: Thu, 11 Sep 2025 08:34:33 +0200
Message-ID: <20250911063433.13783-15-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911063433.13783-1-jgross@suse.com>
References: <20250911063433.13783-1-jgross@suse.com>
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
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: BB0B1683EE
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

Instead of having the pv spinlock function definitions in paravirt.h,
move them into qspinlock.h where the arch specific functions for
qspinlocks are defined already.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h  | 58 --------------------------------
 arch/x86/include/asm/qspinlock.h | 49 +++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 13c0e4e65467..78097a7e4214 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -20,15 +20,6 @@ struct mm_struct;
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
-__visible void __native_queued_spin_unlock(struct qspinlock *lock);
-bool pv_is_native_spin_unlock(void);
-__visible bool __native_vcpu_is_preempted(long cpu);
-bool pv_is_native_vcpu_is_preempted(void);
-
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-void __init paravirt_set_cap(void);
-#endif
-
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
@@ -525,43 +516,6 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 }
 #endif
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
-
-static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
-							u32 val)
-{
-	PVOP_VCALL2(lock.queued_spin_lock_slowpath, lock, val);
-}
-
-static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
-{
-	PVOP_ALT_VCALLEE1(lock.queued_spin_unlock, lock,
-			  "movb $0, (%%" _ASM_ARG1 ");",
-			  ALT_NOT(X86_FEATURE_PVUNLOCK));
-}
-
-static __always_inline void pv_wait(u8 *ptr, u8 val)
-{
-	PVOP_VCALL2(lock.wait, ptr, val);
-}
-
-static __always_inline void pv_kick(int cpu)
-{
-	PVOP_VCALL1(lock.kick, cpu);
-}
-
-static __always_inline bool pv_vcpu_is_preempted(long cpu)
-{
-	return PVOP_ALT_CALLEE1(bool, lock.vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
-				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
-}
-
-void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
-bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
-
-#endif /* SMP && PARAVIRT_SPINLOCKS */
-
 #ifdef CONFIG_PARAVIRT_XXL
 static __always_inline unsigned long arch_local_save_flags(void)
 {
@@ -590,7 +544,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #endif
 
 extern void default_banner(void);
-void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLER__ */
 
@@ -615,12 +568,6 @@ void native_pv_lock_init(void) __init;
 #endif /* __ASSEMBLER__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
-
-#ifndef __ASSEMBLER__
-static inline void native_pv_lock_init(void)
-{
-}
-#endif
 #endif /* !CONFIG_PARAVIRT */
 
 #ifndef __ASSEMBLER__
@@ -636,10 +583,5 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 }
 #endif
 
-#ifndef CONFIG_PARAVIRT_SPINLOCKS
-static inline void paravirt_set_cap(void)
-{
-}
-#endif
 #endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 68da67df304d..376f89aa1d4c 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -28,12 +28,33 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 }
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
+void __init paravirt_set_cap(void);
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
 extern bool nopvspin;
 
+static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
+							 u32 val)
+{
+	PVOP_VCALL2(lock.queued_spin_lock_slowpath, lock, val);
+}
+
+static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
+{
+	PVOP_ALT_VCALLEE1(lock.queued_spin_unlock, lock,
+			  "movb $0, (%%" _ASM_ARG1 ");",
+			  ALT_NOT(X86_FEATURE_PVUNLOCK));
+}
+
+static __always_inline bool pv_vcpu_is_preempted(long cpu)
+{
+	return PVOP_ALT_CALLEE1(bool, lock.vcpu_is_preempted, cpu,
+				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
+				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
+}
+
 #define	queued_spin_unlock queued_spin_unlock
 /**
  * queued_spin_unlock - release a queued spinlock
@@ -62,9 +83,31 @@ static inline bool vcpu_is_preempted(long cpu)
 {
 	return pv_vcpu_is_preempted(cpu);
 }
-#endif
+
+#else /* CONFIG_PARAVIRT_SPINLOCKS */
+static inline void paravirt_set_cap(void) { }
+#endif /* !CONFIG_PARAVIRT_SPINLOCKS */
 
 #ifdef CONFIG_PARAVIRT
+void __init native_pv_lock_init(void);
+__visible void __native_queued_spin_unlock(struct qspinlock *lock);
+bool pv_is_native_spin_unlock(void);
+__visible bool __native_vcpu_is_preempted(long cpu);
+bool pv_is_native_vcpu_is_preempted(void);
+
+static __always_inline void pv_wait(u8 *ptr, u8 val)
+{
+	PVOP_VCALL2(lock.wait, ptr, val);
+}
+
+static __always_inline void pv_kick(int cpu)
+{
+	PVOP_VCALL1(lock.kick, cpu);
+}
+
+void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
+bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
+
 /*
  * virt_spin_lock_key - disables by default the virt_spin_lock() hijack.
  *
@@ -109,7 +152,9 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 	return true;
 }
 
-#endif /* CONFIG_PARAVIRT */
+#else /* CONFIG_PARAVIRT */
+static inline void native_pv_lock_init(void) { }
+#endif /* !CONFIG_PARAVIRT */
 
 #include <asm-generic/qspinlock.h>
 
-- 
2.51.0

