Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF5F314D3E
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764227344; cv=none; b=VZLg5bsCV2kfZZmyQg3iXzRGGhmaGrnR/qqtRTmehNdgjAQZ/w+YtgnaEhKGRR1PbivkpNDe55V6yuKSO7VCAgcfMNLTPrqcOEYjh+x4Ad3HzraPWQlMuQ1epxkiM56oeb6UJZ7d3DarIc/urA/NP8hAUrZccI5J6Mys3phYQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764227344; c=relaxed/simple;
	bh=EVwK7cgAD4yftsEUskdIzczzyyVKRWdVhyNe6sXF1GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibycR7oCqA7veaWbL9lhCzVT+x3n+VFDRQ/l6I3zCTDRICxHYo8RV1uyQSYIxyBO1MKlxaRTXf/6BQ2Cg1AUkw+K/O0Ep3sRHD1gO4pR0rjgOUv9+2AWAect/HGttlWz0bDOeQQTV8sY40UdN4TNosN/wYJTrGTND02BGCjqvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a6r1gaGo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a6r1gaGo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a6r1gaGo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a6r1gaGo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C99C5BCC5;
	Thu, 27 Nov 2025 07:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764227340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dx21/munhBkELx4QNunXJtxOzoBnIa9bJW/+9o2Lqk=;
	b=a6r1gaGoI8U9F7UmVD5N5CLcTH9h4oRKPl7HR67hCGhDrTxVkKh4JubwNNfvXCrAMcAV8v
	PHKnsvhWz1DjM06wU6ZY/0zi3S4F5bRjDFg+ACEiJZ7lkI9ZlyMHETxiPHjBvgNU8/o9Nn
	0OF0CUCLX1VO5wDQceSMYzJvuPQbIEs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=a6r1gaGo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764227340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dx21/munhBkELx4QNunXJtxOzoBnIa9bJW/+9o2Lqk=;
	b=a6r1gaGoI8U9F7UmVD5N5CLcTH9h4oRKPl7HR67hCGhDrTxVkKh4JubwNNfvXCrAMcAV8v
	PHKnsvhWz1DjM06wU6ZY/0zi3S4F5bRjDFg+ACEiJZ7lkI9ZlyMHETxiPHjBvgNU8/o9Nn
	0OF0CUCLX1VO5wDQceSMYzJvuPQbIEs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAF413EA63;
	Thu, 27 Nov 2025 07:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mKAHLAv5J2lnXAAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 27 Nov 2025 07:08:59 +0000
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
Subject: [PATCH v4 02/21] x86/paravirt: Remove some unneeded struct declarations
Date: Thu, 27 Nov 2025 08:08:25 +0100
Message-ID: <20251127070844.21919-3-jgross@suse.com>
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
X-Rspamd-Queue-Id: 2C99C5BCC5

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
index 37a8627d8277..84cc8c95713b 100644
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

