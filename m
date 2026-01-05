Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB291333451
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611147; cv=none; b=bZTPWlzDZX7OzMNyJpLZKQW2ontyIm68nFDVywvRgfOB1zKY1dYuoxHMtGZJhtNmpd/LY4TkoWBm8LQ2U1Zd9jEsp5+CH/5WAsD/JkLmCztGInJnXMnN2HnSMBOyl1Sfijchi0dySYYsr4lR0E0zMFSf+nxbD0Bev9dd2DMIzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611147; c=relaxed/simple;
	bh=kUH+L7/2HHRyaJ3BwnHrQ7wrvqRagquarMrmjbTYnU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV3wqwPd6K0eiDL0x60CBidTV8gNqV3WEBNxpB84QEsdGcxLdFU+czViX2pStZWifHTQmub/3zrUknEEXncxlETs0NAvilV4+F0w+6p6YgAsMVYl8KabEUjIC2JnTtxExR5MUTCRx/kGFeK/6vJO6cbkpvVbwMAUQVCw685Ba2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BGLMepTo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BGLMepTo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BGLMepTo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BGLMepTo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 397655BE37;
	Mon,  5 Jan 2026 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FerepE8qgDl1PWvP4qZ94ewZ5g/P09V/bdS4rj8r54U=;
	b=BGLMepToyj76poQTfRvR5xCMsrRjTxaopda7BhoUEqhYeZjcsZfx+HfE7lUL7tDEdFJYYZ
	9oXJR+b+8aB7HKl/fjl1gpOXfj4PvpvjkUF4jvAbaq6iCXpRVS10p+Vb09Q//eBOzjxoD2
	ETH5nPpbtiWkoG8rFH7h/4FC/u+5CSw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767611144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FerepE8qgDl1PWvP4qZ94ewZ5g/P09V/bdS4rj8r54U=;
	b=BGLMepToyj76poQTfRvR5xCMsrRjTxaopda7BhoUEqhYeZjcsZfx+HfE7lUL7tDEdFJYYZ
	9oXJR+b+8aB7HKl/fjl1gpOXfj4PvpvjkUF4jvAbaq6iCXpRVS10p+Vb09Q//eBOzjxoD2
	ETH5nPpbtiWkoG8rFH7h/4FC/u+5CSw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9B5D13964;
	Mon,  5 Jan 2026 11:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TOG3LwebW2kDWgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:05:43 +0000
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
Subject: [PATCH v5 03/21] x86/paravirt: Remove PARAVIRT_DEBUG config option
Date: Mon,  5 Jan 2026 12:05:02 +0100
Message-ID: <20260105110520.21356-4-jgross@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
index 80527299f859..1f30358dfecd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -809,13 +809,6 @@ config PARAVIRT_XXL
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
index 09ec8dc574a9..bd83528835e9 100644
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

