Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3E332902
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611141; cv=none; b=V2geF1xrrsEazpeSpJPneGFe7mXNouQRUmmmrepsGp2+IO8fHsiYmdjsfPFmCVdZUWrWjJ7YRpNnn/Y9rwCRj/U9/WY9t5qCJNHoz/94EoqEWQN3PNHjqIZWXzNo/YKY/uUtia9lT4dTkG25nnEAsOjNB3gQOH6774CPAKbGVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611141; c=relaxed/simple;
	bh=l55RHXC3KqUQTDrgxfm+3zsxnfHH+YKTHgubZz0HyYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhf8McnQ6Hx8tdWVA34+mBz2nWRnFuzUV+Ctl5Q2UvwPteeES9FeRSKCWd7DhwbN0Vhmvp34RGogmbKdDTDiO/yDoXsXSzPN5TNgpZRkT9jHNmWkpx0jgZeyvqM56g0lQS7KV/VIfEHTVPFSDqCokqcE232og2fxewcfEPQoXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FA16336E8;
	Mon,  5 Jan 2026 11:05:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3C4F13964;
	Mon,  5 Jan 2026 11:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1QOOgGbW2n6WQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 05 Jan 2026 11:05:37 +0000
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
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v5 02/21] x86/paravirt: Remove some unneeded struct declarations
Date: Mon,  5 Jan 2026 12:05:01 +0100
Message-ID: <20260105110520.21356-3-jgross@suse.com>
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
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 5FA16336E8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

In paravirt_types.h and paravirt.h there are some struct declarations
which are not needed. Remove them.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V2:
- remove mm_struct from paravirt.h, too
---
 arch/x86/include/asm/paravirt.h       | 4 ----
 arch/x86/include/asm/paravirt_types.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b5e59a7ba0d0..612b3df65b1b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -6,10 +6,6 @@
 
 #include <asm/paravirt_types.h>
 
-#ifndef __ASSEMBLER__
-struct mm_struct;
-#endif
-
 #ifdef CONFIG_PARAVIRT
 #include <asm/pgtable_types.h>
 #include <asm/asm.h>
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 3502939415ad..09ec8dc574a9 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -11,16 +11,11 @@
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
 
-struct page;
 struct thread_struct;
-struct desc_ptr;
-struct tss_struct;
 struct mm_struct;
-struct desc_struct;
 struct task_struct;
 struct cpumask;
 struct flush_tlb_info;
-struct mmu_gather;
 struct vm_area_struct;
 
 /*
@@ -205,7 +200,6 @@ struct pv_mmu_ops {
 #endif
 } __no_randomize_layout;
 
-struct arch_spinlock;
 #ifdef CONFIG_SMP
 #include <asm/spinlock_types.h>
 #endif
-- 
2.51.0

