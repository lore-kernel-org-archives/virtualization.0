Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171A423167
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372983; cv=none; b=r8d5R+aaPnv68QYvmPdP01Jbf7eXTxj6AC4DBc4Xz5/XvMEwVL75xFqXyNxRpi7fCaS3JA6ViEb9UuPATK0sZqvuAt3ZApEm/spn6GkCe6ZylSaS9PwLyek0nTVxZHUxP49dYryZoQWOL29a73zqS3bQ6wsVe1fido+eQGnW/8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372983; c=relaxed/simple;
	bh=zoNp2MEwxpapGPYMOxrVEgWI0UKeUcfXNVrmBbZdCEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8zebHDwDwqdxG6lkUIarccZSLFBPNzo9SI2R46hDUxH79qDJzkfsRMivRUK+2y8SqA4E9GfyF4+xXPM2GLWiVqQS8t7u1JuQTNfR5Co2/F2aJ0pvzvsGpPpVFVpgLyYe4reolfrrMTM+ByjYJlayj6q+/6g+PkBCgfLj0nFpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NYTOgfRA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vSx4Lv8o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NYTOgfRA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vSx4Lv8o"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBBC26A844;
	Tue, 28 Apr 2026 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4UTqMDnY9oPKbnFNsOGQOM06/lMQ7yHP6cTQbqn+y8=;
	b=NYTOgfRAWA1hfhFRnzXNdNpgEKBGG6M0sYzUAmjnbOyQSHIgmrpYWWwp9NPd3ZRglV8lCC
	sDpggevzhMPiLMgEWZf3dOFJIJLZOuYngx3aC4PftukQllLmov0kSjIG6sGoSLGUB1Q1Vn
	HUdtL4YizZZ7sh48RsrOohsbQadmAS4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vSx4Lv8o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4UTqMDnY9oPKbnFNsOGQOM06/lMQ7yHP6cTQbqn+y8=;
	b=vSx4Lv8oEacd8ES/wwTIMOBS1uG+qtd1CRYYMKkO6QX5bRHd+MHk8O+fVBXD0SQE9YYAna
	t9LDT6qjg9kSCLUC6YkgLWhFxHnKVkcPsZ2N2m/3DTTdR2XWDVMSq/+RnonH8q65stfTqZ
	7wUWkiKOqFsvL5/TVomyudv7WY0/GNQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97472593B0;
	Tue, 28 Apr 2026 10:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HPnaIzOP8GmyPgAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 28 Apr 2026 10:42:59 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH RFC 09/11] x86/msr: Add macros for preparing to switch rdmsr/wrmsr interfaces
Date: Tue, 28 Apr 2026 12:42:03 +0200
Message-ID: <20260428104205.916924-10-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428104205.916924-1-jgross@suse.com>
References: <20260428104205.916924-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: DBBC26A844
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

In order to prepare switching the rdmsr(), rdmasr_safe(), wrmsr() and
wrmsr_safe() interfaces to 64-bit values instead of 32-bit pairs, add
macros to call different implementations depending on the number of
passed parameters.

This enables to use the same function/macro names as today while
doing the interface switch per component instead of one go.

At the same time switch the rdmsr related interfaces to inline
functions, avoiding to change variables passed as a parameter to be
changed.

The helper macros will be removed when all users of the current
interfaces have been switched to the new ones.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h      | 46 +++++++++++++++++++++++++++++----
 arch/x86/include/asm/paravirt.h |  6 ++---
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index a5596d268053..4dd181aedb00 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -12,6 +12,7 @@
 #include <uapi/asm/msr.h>
 #include <asm/shared/msr.h>
 
+#include <linux/args.h>
 #include <linux/types.h>
 #include <linux/percpu.h>
 
@@ -179,14 +180,14 @@ static inline u64 native_read_pmc(int counter)
  * pointer indirection), this allows gcc to optimize better
  */
 
-#define rdmsr(msr, low, high)					\
+#define __rdmsr_3(msr, low, high)				\
 do {								\
 	u64 __val = native_read_msr((msr));			\
 	(void)((low) = (u32)__val);				\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
-static inline void wrmsr(u32 msr, u32 low, u32 high)
+static inline void __wrmsr_3(u32 msr, u32 low, u32 high)
 {
 	native_write_msr(msr, (u64)high << 32 | low);
 }
@@ -206,7 +207,7 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 }
 
 /* rdmsr with exception handling */
-#define rdmsr_safe(msr, low, high)				\
+#define __rdmsr_safe_3(msr, low, high)				\
 ({								\
 	u64 __val;						\
 	int __err = native_read_msr_safe((msr), &__val);	\
@@ -243,13 +244,48 @@ static __always_inline void wrmsrns(u32 msr, u64 val)
 }
 
 /*
- * Dual u32 version of wrmsrq_safe():
+ * Dual u32 versions of wrmsr_safe():
  */
-static inline int wrmsr_safe(u32 msr, u32 low, u32 high)
+static __always_inline int __wrmsr_safe_3(u32 msr, u32 low, u32 high)
 {
 	return wrmsrq_safe(msr, (u64)high << 32 | low);
 }
 
+/*
+ * u64 versions of rdmsr/wrmsr[_safe]():
+ */
+static __always_inline u64 __rdmsr_1(u32 msr)
+{
+	u64 val;
+
+	rdmsrq(msr, val);
+
+	return val;
+}
+
+static __always_inline void __wrmsr_2(u32 msr, u64 val)
+{
+	wrmsrq(msr, val);
+}
+
+static __always_inline int __rdmsr_safe_2(u32 msr, u64 *p)
+{
+	return rdmsrq_safe(msr, p);
+}
+
+static __always_inline int __wrmsr_safe_2(u32 msr, u64 val)
+{
+	return wrmsrq_safe(msr, val);
+}
+
+/*
+ * Macros for selecting u64 or dual u32 versions of rdmsr/wrmsr[_safe]():
+ */
+#define rdmsr(...) CONCATENATE(__rdmsr_, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+#define wrmsr(...) CONCATENATE(__wrmsr_, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+#define rdmsr_safe(...) CONCATENATE(__rdmsr_safe_, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+#define wrmsr_safe(...) CONCATENATE(__wrmsr_safe_, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+
 struct msr __percpu *msrs_alloc(void);
 void msrs_free(struct msr __percpu *msrs);
 int msr_set_bit(u32 msr, u8 bit);
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cdfe4007443e..359fbc09f132 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -150,14 +150,14 @@ static inline int paravirt_write_msr_safe(u32 msr, u64 val)
 	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
 
-#define rdmsr(msr, val1, val2)			\
+#define __rdmsr_3(msr, val1, val2)		\
 do {						\
 	u64 _l = paravirt_read_msr(msr);	\
 	val1 = (u32)_l;				\
 	val2 = _l >> 32;			\
 } while (0)
 
-static __always_inline void wrmsr(u32 msr, u32 low, u32 high)
+static __always_inline void __wrmsr_3(u32 msr, u32 low, u32 high)
 {
 	paravirt_write_msr(msr, (u64)high << 32 | low);
 }
@@ -178,7 +178,7 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 }
 
 /* rdmsr with exception handling */
-#define rdmsr_safe(msr, a, b)				\
+#define __rdmsr_safe_3(msr, a, b)				\
 ({							\
 	u64 _l;						\
 	int _err = paravirt_read_msr_safe((msr), &_l);	\
-- 
2.53.0

