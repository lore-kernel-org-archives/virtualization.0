Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6243337B8C
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611197; cv=none; b=bam+Clo8dokyXD4C49bCu/sGmPBvxYcNk8Nr2tq+EzuHVE10MurvdhhEwvq96EIMpyUlnMDMr3cAhUX3Zo1j/26LuVFWcS4DbPz3VqIl2f1jY3132cai3RVGPdcIeXxideLgOPeFeky/2MQ0bg7PA0JZw30xXOWSyYPSzopm8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611197; c=relaxed/simple;
	bh=rP57xdqwD1wb6gA5Tm/PqiOfja4SmdPoS7hHRx3Ynlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3MSfEcKz/uxLQZwWFSYyxrFIDu9MotRlkOkjzDPCSECJazPsDwnkAz81jBo3p5hbnlC4rHbwpEXSua6BnOQFo+BYJcOUPMgRRSh2p2yTtpZR33DTKp5iLRXhv13hF6NaVWK0p/fZwak1/vMK6gdQ3n5IijE4dPEBHS/IziCbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R3uquS7D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DFq1Nhqb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R3uquS7D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DFq1Nhqb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFCDB5BE37;
	Mon,  5 Jan 2026 11:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sq7KPXy9CZZvgz6hcAmaAiaWfI6QDSCYH9PhP1wlCXQ=;
	b=R3uquS7DuaTqkmiy3OL14/GMUd1PcYm5UmreeS2zp+4xRhygoZX3LqQjYR5k/5GLd9B24x
	JFSb6HcM/UDD6OER7qPF89zQUWI+rpGpbVcSLt46GUf5iGinfReidaWahawxnhchocq3or
	Pt/ay2wiUh1LPWztr/DNhVtFg1oSwtk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sq7KPXy9CZZvgz6hcAmaAiaWfI6QDSCYH9PhP1wlCXQ=;
	b=DFq1Nhqb2K455fBwjfKUATz/GZWRxyGpycWnPfkV3LVFmseqSauzLSAZTgCooIsa562iob
	umiYRFNeJuuHcljvuu0t8Yct3EXpiTxRHPQlaOON8+ybe+KUQMEoO8urCmoBsze4NptrfP
	eKALTL9Kwlr9d4uO3lJTNs6eP2suCVM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D09113964;
	Mon,  5 Jan 2026 11:06:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rI8SGTibW2k7WgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:06:32 +0000
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
Subject: [PATCH v5 11/21] x86/paravirt: Use common code for paravirt_steal_clock()
Date: Mon,  5 Jan 2026 12:05:10 +0100
Message-ID: <20260105110520.21356-12-jgross@suse.com>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

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
index 1f30358dfecd..62e11572da27 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -799,6 +799,7 @@ if HYPERVISOR_GUEST
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

