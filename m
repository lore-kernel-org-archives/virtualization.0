Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF81315D52
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764227350; cv=none; b=HeP1Raty/aBruasrcvvr6qe81Wj13UMOavn9xqtCSb7EzuYn3PAWU4dOyQuXaUH/lLK0GWdVABOIEPwGMK21nRpmvHBMzTwCIE0fnB7vOCMrXalsONZ3ZosjL9CGbiAMp7LSuFfUFV2QTVzGTE+YnhZEAm7dcAM3nFpH+2T+1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764227350; c=relaxed/simple;
	bh=8D6pTZak3Z1jQBaBhx/kipigOtq0lcnvk0bu38nLNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tulSzhLczq7pEmm+NcZzeHgd0OCokYBeMiOpNJISd7GJ0uwzZpTlc53RFvSY+hYo+tnSv8P9fvcRAcGcRUZX5kLgKz/y21DNynG1rFWqOT5gILXeGohGizrZTgzx4gVsfv88E0RFwh8Pr1dj5Ppr5onZnV1+lZMRclpWFWd6V1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p6/YXdV/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p6/YXdV/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p6/YXdV/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p6/YXdV/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0494D5BCC4;
	Thu, 27 Nov 2025 07:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764227346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ef39VT4vtYrVtOwdPEy2lPrhqcRxm7VrmKcn0eP7rDM=;
	b=p6/YXdV/+M5/DF/s8Swn6sl0fvoKVD5pbdXGTkU8zzU/94+Fne3UnC4ycxuHcv4cXT57Ml
	0MLzVovfK4+4elI9AdbqCUhL1FOrY1wVq70F7mWWC3re0PAE5s8VNnKm2WkF8AtG44r4QN
	cpZIW1C/IeTM1hl2DewCDWEPslJ9g14=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="p6/YXdV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764227346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ef39VT4vtYrVtOwdPEy2lPrhqcRxm7VrmKcn0eP7rDM=;
	b=p6/YXdV/+M5/DF/s8Swn6sl0fvoKVD5pbdXGTkU8zzU/94+Fne3UnC4ycxuHcv4cXT57Ml
	0MLzVovfK4+4elI9AdbqCUhL1FOrY1wVq70F7mWWC3re0PAE5s8VNnKm2WkF8AtG44r4QN
	cpZIW1C/IeTM1hl2DewCDWEPslJ9g14=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 954463EA63;
	Thu, 27 Nov 2025 07:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1IEAIxH5J2lrXAAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 27 Nov 2025 07:09:05 +0000
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
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v4 03/21] x86/paravirt: Remove PARAVIRT_DEBUG config option
Date: Thu, 27 Nov 2025 08:08:26 +0100
Message-ID: <20251127070844.21919-4-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127070844.21919-1-jgross@suse.com>
References: <20251127070844.21919-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0494D5BCC4

The only effect of CONFIG_PARAVIRT_DEBUG set is that instead of doing
a call using a NULL pointer a BUG() is being raised.

While the BUG() will be a little bit easier to analyse, the call of
NULL isn't really that difficult to find the reason for.

Remove the config option to make paravirt coding a little bit less
annoying.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                      | 7 -------
 arch/x86/include/asm/paravirt.h       | 1 -
 arch/x86/include/asm/paravirt_types.h | 8 --------
 3 files changed, 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..aa279fec5c1f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -805,13 +805,6 @@ config PARAVIRT_XXL
 	bool
 	depends on X86_64
 
-config PARAVIRT_DEBUG
-	bool "paravirt-ops debugging"
-	depends on PARAVIRT && DEBUG_KERNEL
-	help
-	  Enable to debug paravirt_ops internals.  Specifically, BUG if
-	  a paravirt_op is missing when it is called.
-
 config PARAVIRT_SPINLOCKS
 	bool "Paravirtualization layer for spinlocks"
 	depends on PARAVIRT && SMP
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 612b3df65b1b..fd9826397419 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -12,7 +12,6 @@
 #include <asm/nospec-branch.h>
 
 #ifndef __ASSEMBLER__
-#include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
 #include <linux/static_call_types.h>
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 84cc8c95713b..085095f94f97 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -354,12 +354,6 @@ extern struct paravirt_patch_template pv_ops;
 #define VEXTRA_CLOBBERS	 , "rax", "r8", "r9", "r10", "r11"
 #endif	/* CONFIG_X86_32 */
 
-#ifdef CONFIG_PARAVIRT_DEBUG
-#define PVOP_TEST_NULL(op)	BUG_ON(pv_ops.op == NULL)
-#else
-#define PVOP_TEST_NULL(op)	((void)pv_ops.op)
-#endif
-
 #define PVOP_RETVAL(rettype)						\
 	({	unsigned long __mask = ~0UL;				\
 		BUILD_BUG_ON(sizeof(rettype) > sizeof(unsigned long));	\
@@ -388,7 +382,6 @@ extern struct paravirt_patch_template pv_ops;
 #define ____PVOP_CALL(ret, op, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
-		PVOP_TEST_NULL(op);					\
 		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
 				ALT_CALL_ALWAYS)			\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
@@ -402,7 +395,6 @@ extern struct paravirt_patch_template pv_ops;
 			  extra_clbr, ...)				\
 	({								\
 		PVOP_CALL_ARGS;						\
-		PVOP_TEST_NULL(op);					\
 		asm volatile(ALTERNATIVE_2(PARAVIRT_CALL,		\
 				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
 				 alt, cond)				\
-- 
2.51.0

