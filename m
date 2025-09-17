Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B368332A20
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120813; cv=none; b=W938Fm59udvnMmQZeDHGaNsYKShmZFxmaG08Wv6DiyigF4TPDx/UTRm8DM5yHhQHHxh5u5cZ/fgBdANeBtAd7rXFtFKvfPT818XfFJScwiC6p7DAjx4vwultCS1A2cIl83R3o8m3HDX5vCbj57MqAoDdY9Rf0TWQBDtPOZMkgio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120813; c=relaxed/simple;
	bh=Gc0HztLWw1A41TEwPisANuAj7pvY2lNBZ4Fk2z1LJR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhRVkQF2BnV3hNwWXmQCRpocL1Hkknksw2obMFskProg3O+E06O2bkNtV45HiM9v6LJ0pXdHpZEoBqpUfT+qRCO49baSN5ZSg50g5nFUuFTkMg5kBiqaQm7u8tqVEutjci3MSebHXW3AfbrULdm4XoSVCqsvVDqFxygxFUHbE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8727433842;
	Wed, 17 Sep 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1256C1368D;
	Wed, 17 Sep 2025 14:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FWccA2rLymg7EwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:53:30 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v2 11/21] x86/paravirt: Use common code for paravirt_steal_clock()
Date: Wed, 17 Sep 2025 16:52:10 +0200
Message-ID: <20250917145220.31064-12-jgross@suse.com>
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
X-Rspamd-Queue-Id: 8727433842
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Remove the arch specific variant of paravirt_steal_clock() and use
the common one instead.

With all archs supporting Xen now having been switched to the common
variant, including paravirt.h can be dropped from drivers/xen/time.c.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                | 1 +
 arch/x86/include/asm/paravirt.h | 7 -------
 arch/x86/kernel/paravirt.c      | 6 ------
 arch/x86/xen/time.c             | 1 +
 drivers/xen/time.c              | 3 ---
 5 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 023963a597d9..5e9c7458ac50 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -784,6 +784,7 @@ if HYPERVISOR_GUEST
 config PARAVIRT
 	bool "Enable paravirtualization code"
 	depends on HAVE_STATIC_CALL
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 0ef797ea8440..766a7cee3d64 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -17,10 +17,8 @@
 #include <linux/static_call_types.h>
 #include <asm/frame.h>
 
-u64 dummy_steal_clock(int cpu);
 u64 dummy_sched_clock(void);
 
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
 
 void paravirt_set_sched_clock(u64 (*func)(void));
@@ -35,11 +33,6 @@ bool pv_is_native_spin_unlock(void);
 __visible bool __native_vcpu_is_preempted(long cpu);
 bool pv_is_native_vcpu_is_preempted(void);
 
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
-
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init paravirt_set_cap(void);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a3ba4747be1c..42991d471bf3 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -60,12 +60,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
 
 void paravirt_set_sched_clock(u64 (*func)(void))
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 96521b1874ac..e4754b2fa900 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/pvclock_gtod.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/sched/cputime.h>
 
 #include <asm/pvclock.h>
 #include <asm/xen/hypervisor.h>
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 53b12f5ac465..0b18d8a5a2dd 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -10,9 +10,6 @@
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
 
-#ifndef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
-#include <asm/paravirt.h>
-#endif
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
-- 
2.51.0

