Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F15335542
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611172; cv=none; b=caXj3CDvF+YQRw5bnoFH6yppbYZOB7fzJJrS7tocbx8DweMy5EYUkusXoKFJYiabZZnPHoN3LbhhKlCtzUYHOSXYdR619+1+YflduppmMWMXRi3su/fg2Q/g0f8lkV4cWOh7Itz3lBstqCDfWj1Ke7hltuFAQY82fGOQrnDG+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611172; c=relaxed/simple;
	bh=ZadrI8bwCZoTGHeo3j27y9ZTzrQzLpBkB9RdUpj9m6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWYGXlMlg/XqzVsimW3L/B3YWc2OwKMQ8rDFVDIx83EJJHArm7S9MQozbuJ+W6MFRNzBrbFPHCHdEogzvK0IAjqLgh4C5Lzfd/OSDiNnYDQHlleUHKC89aBhtbKM2o/J9rCINDc/ZsrCol/cyXbqpwNs23tgg4+/Dw4xOXzfBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CD5E5BE34;
	Mon,  5 Jan 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCFD513964;
	Mon,  5 Jan 2026 11:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EqRlMCCbW2keWgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:06:08 +0000
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
Subject: [PATCH v5 07/21] arm/paravirt: Use common code for paravirt_steal_clock()
Date: Mon,  5 Jan 2026 12:05:06 +0100
Message-ID: <20260105110520.21356-8-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 4CD5E5BE34
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

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
index fa83c040ee2d..fc9b5b7016c3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1320,6 +1320,7 @@ config UACCESS_WITH_MEMCPY
 
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

