Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662A332A45
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120832; cv=none; b=qybYdKS/x+7p8bqGPmvh5mx/ZwWZ3syEPAF1fHiLse//8IW8hdaxXQXjAbDxJcJ0hJefdWnii9SDyztinmW/V902y032NRnaD2MGTBg/e68qKPBMZeRgVy0EATyTxVIYiMRv8h9dqGjqds9G/IOhZw/PBPG1xu0b9SIZkPt13tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120832; c=relaxed/simple;
	bh=KS8fe3tcaEWBMDARocb/nL7jL4ZSZt3fJ4pVwL98WBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi9myDSqzG27EwQXcwPhMTvOELCgecTDfb7jF7KD1dT0Vz8opcrRWHxoW0DGopQBtMsBSVrVzbCcBu9o1dZqxg17a7XmXusZE9KeduqQs+yRF9n1xFAvHKw/jWo6ebD59xKlSeINJBhIsuu5ClejAqMgCokVOWngR2CM88eFQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2B8C33849;
	Wed, 17 Sep 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F8CD1368D;
	Wed, 17 Sep 2025 14:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kce7FXzLymhmEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 17 Sep 2025 14:53:48 +0000
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
Subject: [PATCH v2 14/21] x86/paravirt: Move pv_native_*() prototypes to paravirt.c
Date: Wed, 17 Sep 2025 16:52:13 +0200
Message-ID: <20250917145220.31064-15-jgross@suse.com>
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
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)]
X-Rspamd-Queue-Id: C2B8C33849
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

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

