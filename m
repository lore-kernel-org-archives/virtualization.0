Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8E25A34F
	for <virtualization@lists.linux.dev>; Mon,  6 Oct 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736819; cv=none; b=VDvNjvh0CBLld6zxkeAYMHzVygb1KPZA9VrAqscbjEdU30JKuFm6dH9RCY68BM3CMExqXZHkL27hnKhpcNHEivhwicuRH/fMhFXckk2YYFKdISSGR2NxlqUktZ+wLmNtZGUugJMnTG4jG2VCMPrw7Niq72XOOu+BJEzCQe7Niec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736819; c=relaxed/simple;
	bh=h+CttcB00kv2HDVBDK9P8cPxKJp7Xq/KWG4FAcJoec4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwl9OoySQ5jdQg/LFRNcLpwQQWmEqvZzVAi/LPE8HUV+OTuayjbYFP3vz4x5A6fBUUBazhVs6gd+OEhgmz6JfhmQytzRlcjwH9n4IF6pOzZGeMHSWAeBMWMyqCRVQIrpD5/ujwpvuHcwUwxXXr0JNTPtjPlnpohBSvmhfXuSoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OWCb5EOT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OWCb5EOT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OWCb5EOT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OWCb5EOT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EC7F1F452;
	Mon,  6 Oct 2025 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oj+q7e4wJ8KHifBxZWmsDCnOFxDHhXGK3TRIXIaeHY8=;
	b=OWCb5EOTmwm9yuRsMZNPEKYyXZcM6O3kSsjxXjhjRqHEOPUUOHtv8VZYGmn9BsqJdGAmsg
	NgOTrl4WI2llQcTa0jkvitiBZzhIi9tfSdQz0BQOzwJ8WT9JqzoMdaRL6gmH9CcvPn/Z0q
	a/VSczJ7lhYaMm7ECciguZzXO83Yr1U=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OWCb5EOT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oj+q7e4wJ8KHifBxZWmsDCnOFxDHhXGK3TRIXIaeHY8=;
	b=OWCb5EOTmwm9yuRsMZNPEKYyXZcM6O3kSsjxXjhjRqHEOPUUOHtv8VZYGmn9BsqJdGAmsg
	NgOTrl4WI2llQcTa0jkvitiBZzhIi9tfSdQz0BQOzwJ8WT9JqzoMdaRL6gmH9CcvPn/Z0q
	a/VSczJ7lhYaMm7ECciguZzXO83Yr1U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F45A13A7E;
	Mon,  6 Oct 2025 07:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TanxBe1z42hnHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 06 Oct 2025 07:46:53 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Russell King <linux@armlinux.org.uk>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v3 07/21] arm/paravirt: Use common code for paravirt_steal_clock()
Date: Mon,  6 Oct 2025 09:45:52 +0200
Message-ID: <20251006074606.1266-8-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006074606.1266-1-jgross@suse.com>
References: <20251006074606.1266-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8EC7F1F452
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,citrix.com:email,suse.com:dkim,suse.com:mid,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,citrix.com:email,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

Remove the arch specific variant of paravirt_steal_clock() and use
the common one instead.

This allows to remove paravirt.c and paravirt.h from arch/arm.

Until all archs supporting Xen have been switched to the common code
of paravirt_steal_clock(), drivers/xen/time.c needs to include
asm/paravirt.h for those archs, while this is not necessary for arm
any longer.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/Kconfig                |  1 +
 arch/arm/include/asm/paravirt.h | 18 ------------------
 arch/arm/kernel/Makefile        |  1 -
 arch/arm/kernel/paravirt.c      | 20 --------------------
 drivers/xen/time.c              |  2 ++
 5 files changed, 3 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/include/asm/paravirt.h
 delete mode 100644 arch/arm/kernel/paravirt.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2a124c92e4f6..39ab0860bfbc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1319,6 +1319,7 @@ config UACCESS_WITH_MEMCPY
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	select HAVE_PV_STEAL_CLOCK_GEN
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
deleted file mode 100644
index 69da4bdcf856..000000000000
--- a/arch/arm/include/asm/paravirt.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_ARM_PARAVIRT_H
-#define _ASM_ARM_PARAVIRT_H
-
-#ifdef CONFIG_PARAVIRT
-#include <linux/static_call_types.h>
-
-u64 dummy_steal_clock(int cpu);
-
-DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
-
-static inline u64 paravirt_steal_clock(int cpu)
-{
-	return static_call(pv_steal_clock)(cpu);
-}
-#endif
-
-#endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index afc9de7ef9a1..b36cf0cfd4a7 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -83,7 +83,6 @@ AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
 obj-$(CONFIG_VDSO)		+= vdso.o
 obj-$(CONFIG_EFI)		+= efi.o
-obj-$(CONFIG_PARAVIRT)	+= paravirt.o
 
 obj-y			+= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
diff --git a/arch/arm/kernel/paravirt.c b/arch/arm/kernel/paravirt.c
deleted file mode 100644
index 3895a5578852..000000000000
--- a/arch/arm/kernel/paravirt.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *
- * Copyright (C) 2013 Citrix Systems
- *
- * Author: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
- */
-
-#include <linux/export.h>
-#include <linux/jump_label.h>
-#include <linux/types.h>
-#include <linux/static_call.h>
-#include <asm/paravirt.h>
-
-static u64 native_steal_clock(int cpu)
-{
-	return 0;
-}
-
-DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index d360ded2ef39..53b12f5ac465 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -10,7 +10,9 @@
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
 
+#ifndef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
 #include <asm/paravirt.h>
+#endif
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
-- 
2.51.0

