Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088230ACE0
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120765; cv=none; b=oFZlmInM6eL1BZngO2zowFs8uXBfo+9BPyPFLnUR/DU53whp9eDes7j4iExpOaUiOlhf3UJwmPjHagjNOlcY8xbZJAx16RMXdlXr0xsqq8Vaxi+PsMBECGVoHoKdXeEJcBdlN1MUAPcqRpDYtnTybN5OA5N0uSQWia/2fYybfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120765; c=relaxed/simple;
	bh=EZ48LWYzIj0qdCN5pjZMXR7vDQdWROa2MKrVQsjPQLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTitOpGfb8ousFp83vV6K/eCHZ+6LMnwDBtnLelevlCdT1nRHhM3p/LBjkb8YL99s6N27/hO74/+WwW+UG27+hcEd2SWoVL3bUo4XPe43MvES7Zm4nvBd0C5cml7/1ch+pQjatbJKVepEN8ANehE80QSVnQjLaL4J+EZulbJ4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kNFPasF+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kNFPasF+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kNFPasF+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kNFPasF+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3938A206DF;
	Wed, 17 Sep 2025 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBGojd/9fmULeFb/+3b8cmJKFKWQaqHEZLj2/rO/T20=;
	b=kNFPasF+jYMMdc8BT8EAEZx3RzVB8DEuaMGnNJHIqJex4ZFL1tSEjdzBPbowZCVI3+lNfA
	JnoGvxLlNqGIXiH4i+mlIkXvAlbzqrSpOMrJpaY2rxfzBWGhoE6hRFgNz1pLNkflHiHjBS
	Q+wrUQiZv2dJfjzIy9K23+/9XeRi/Lg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758120762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBGojd/9fmULeFb/+3b8cmJKFKWQaqHEZLj2/rO/T20=;
	b=kNFPasF+jYMMdc8BT8EAEZx3RzVB8DEuaMGnNJHIqJex4ZFL1tSEjdzBPbowZCVI3+lNfA
	JnoGvxLlNqGIXiH4i+mlIkXvAlbzqrSpOMrJpaY2rxfzBWGhoE6hRFgNz1pLNkflHiHjBS
	Q+wrUQiZv2dJfjzIy9K23+/9XeRi/Lg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE2A71368D;
	Wed, 17 Sep 2025 14:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lnHPLDnLymjbEgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:52:41 +0000
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
Subject: [PATCH v2 03/21] x86/paravirt: Remove PARAVIRT_DEBUG config option
Date: Wed, 17 Sep 2025 16:52:02 +0200
Message-ID: <20250917145220.31064-4-jgross@suse.com>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80

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
index 52c8910ba2ef..023963a597d9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -794,13 +794,6 @@ config PARAVIRT_XXL
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

