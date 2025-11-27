Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CE319860
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764227421; cv=none; b=mPWnm3vOHzoQesfUZ7oXIq2DuF0D6QzE1sGDp66nfQKrr92HlXajbTmpVRMzHjzGFWQ3fMx8l128HrB/wuBmH7sDGRpNmOTbmw1+cYtQN4qQaONSpCarE6MehzFVt0Xz87rSDeo84At37IiSCh/hueV7yp5UdnMVkBz7JZW1v74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764227421; c=relaxed/simple;
	bh=KS8fe3tcaEWBMDARocb/nL7jL4ZSZt3fJ4pVwL98WBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9S+Sml81tq2+j8kA+TnWzWdBHf/GeCWg/jmEI/q1yOBFrllQHrW1cBOlLIDEf0ySsXSiEXy5GxwtSNkxUH13nwvZe245OEjjOgPK+wbmrcREgKoUVk42mlmCrIb1qx0AlUxdVc6dKbhvZctK3YWnFabeu8D0SnouUXz8RZ1ZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VjRuhJyH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VjRuhJyH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VjRuhJyH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VjRuhJyH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE2C0336A3;
	Thu, 27 Nov 2025 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764227411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfZM0KCyCe4PB+tPnZRIqKjxT1C+uq5P0n+UToNC19A=;
	b=VjRuhJyHgyNf/pH+7Gj8ARU3RS6As/1gs8vdqzZYbU6gDm8PyHhBx9etKmy0rW7Mdf+vVf
	LRww4o65HM2EkkqCiHOd0bJYI+LY5c8EhfcX6L172ny+/bojuw/6UuP1ffecVk9hWn8Uf2
	h6rk8zZ7DLj+KAX5ZPLNEdqyVUFJLhU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764227411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfZM0KCyCe4PB+tPnZRIqKjxT1C+uq5P0n+UToNC19A=;
	b=VjRuhJyHgyNf/pH+7Gj8ARU3RS6As/1gs8vdqzZYbU6gDm8PyHhBx9etKmy0rW7Mdf+vVf
	LRww4o65HM2EkkqCiHOd0bJYI+LY5c8EhfcX6L172ny+/bojuw/6UuP1ffecVk9hWn8Uf2
	h6rk8zZ7DLj+KAX5ZPLNEdqyVUFJLhU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C8A23EA63;
	Thu, 27 Nov 2025 07:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id byQPEVP5J2nYXQAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 27 Nov 2025 07:10:11 +0000
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
Subject: [PATCH v4 14/21] x86/paravirt: Move pv_native_*() prototypes to paravirt.c
Date: Thu, 27 Nov 2025 08:08:37 +0100
Message-ID: <20251127070844.21919-15-jgross@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[]

The only reason the pv_native_*() prototypes are needed is the complete
definition of those functions via an asm() statement, which makes it
impossible to have those functions as static ones.

Move the prototypes from paravirt_types.h into paravirt.c, which is the
only source referencing the functions.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/include/asm/paravirt_types.h | 7 -------
 arch/x86/kernel/paravirt.c            | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 148d157e2a4a..1e50f13e6543 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -480,13 +480,6 @@ extern struct paravirt_patch_template pv_ops;
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 
-#ifdef CONFIG_PARAVIRT_XXL
-unsigned long pv_native_save_fl(void);
-void pv_native_irq_disable(void);
-void pv_native_irq_enable(void);
-unsigned long pv_native_read_cr2(void);
-#endif
-
 #endif	/* __ASSEMBLER__ */
 
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 4e37db8073f9..5dfbd3f55792 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -45,6 +45,11 @@ void __init default_banner(void)
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
+unsigned long pv_native_save_fl(void);
+void pv_native_irq_disable(void);
+void pv_native_irq_enable(void);
+unsigned long pv_native_read_cr2(void);
+
 DEFINE_ASM_FUNC(_paravirt_ident_64, "mov %rdi, %rax", .text);
 DEFINE_ASM_FUNC(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_irq_disable, "cli", .noinstr.text);
-- 
2.51.0

