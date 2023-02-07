Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F8EC636D4
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 07:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13FE041798;
	Tue,  7 Feb 2023 07:59:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13FE041798
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=cSLouw+e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JwMqrq7fsGCc; Tue,  7 Feb 2023 07:59:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2864241749;
	Tue,  7 Feb 2023 07:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2864241749
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECF69C0032;
	Tue,  7 Feb 2023 07:59:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE43DC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 07:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 872BB40220
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 07:59:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 872BB40220
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=cSLouw+e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jSXvH0bEtvgj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 07:59:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3DDC401A1
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3DDC401A1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 07:59:07 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4186C340B7;
 Tue,  7 Feb 2023 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675756744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5gbyCaKdJ8Mi2SS92SeXVfp2L0hg2wIdbGtZaSSemJk=;
 b=cSLouw+eDRwsEhh4tCdzm/mXIkiN3VaizXDinxf3AxfRlZvMB13J7nYgvv8ambeU0sM7ey
 DfSm73Mxx8bw6U4fEBZZv1JatzASdbZIRMW3lo65fJ3jM7DsZCHiJEcXBD8HwsYeoYT9mU
 PVM2qzsER8TVJkPgRfU9baF5PVtydIw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8DD613467;
 Tue,  7 Feb 2023 07:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k7yxL8cE4mOhXgAAMHmgww
 (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:59:03 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v2] x86/paravirt: merge activate_mm and dup_mmap callbacks
Date: Tue,  7 Feb 2023 08:59:02 +0100
Message-Id: <20230207075902.7539-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 Thomas Gleixner <tglx@linutronix.de>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The two paravirt callbacks .mmu.activate_mm and .mmu.dup_mmap are
sharing the same implementations in all cases: for Xen PV guests they
are pinning the PGD of the new mm_struct, and for all other cases
they are a NOP.

In the end both callbacks are meant to register an address space with
the underlying hypervisor, so there needs to be only a single callback
for that purpose.

So merge them to a common callback .mmu.enter_mmap (in contrast to the
corresponding already existing .mmu.exit_mmap).

As the first parameter of the old callbacks isn't used, drop it from
the replacement one.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
V2:
- expand commit message (Srivatsa S. Bhat)
---
 arch/x86/include/asm/mmu_context.h    |  4 ++--
 arch/x86/include/asm/paravirt.h       | 14 +++-----------
 arch/x86/include/asm/paravirt_types.h |  7 ++-----
 arch/x86/kernel/paravirt.c            |  3 +--
 arch/x86/mm/init.c                    |  2 +-
 arch/x86/xen/mmu_pv.c                 | 12 ++----------
 6 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00..6a14b6c2165c 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -134,7 +134,7 @@ extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 #define activate_mm(prev, next)			\
 do {						\
-	paravirt_activate_mm((prev), (next));	\
+	paravirt_enter_mmap(next);		\
 	switch_mm((prev), (next), NULL);	\
 } while (0);
 
@@ -167,7 +167,7 @@ static inline void arch_dup_pkeys(struct mm_struct *oldmm,
 static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 	arch_dup_pkeys(oldmm, mm);
-	paravirt_arch_dup_mmap(oldmm, mm);
+	paravirt_enter_mmap(mm);
 	return ldt_dup_context(oldmm, mm);
 }
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 73e9522db7c1..07bbdceaf35a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -332,16 +332,9 @@ static inline void tss_update_io_bitmap(void)
 }
 #endif
 
-static inline void paravirt_activate_mm(struct mm_struct *prev,
-					struct mm_struct *next)
+static inline void paravirt_enter_mmap(struct mm_struct *next)
 {
-	PVOP_VCALL2(mmu.activate_mm, prev, next);
-}
-
-static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
-					  struct mm_struct *mm)
-{
-	PVOP_VCALL2(mmu.dup_mmap, oldmm, mm);
+	PVOP_VCALL1(mmu.enter_mmap, next);
 }
 
 static inline int paravirt_pgd_alloc(struct mm_struct *mm)
@@ -787,8 +780,7 @@ extern void default_banner(void);
 
 #ifndef __ASSEMBLY__
 #ifndef CONFIG_PARAVIRT_XXL
-static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
-					  struct mm_struct *mm)
+static inline void paravirt_enter_mmap(struct mm_struct *mm)
 {
 }
 #endif
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8c1da419260f..71bf64b963df 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -164,11 +164,8 @@ struct pv_mmu_ops {
 	unsigned long (*read_cr3)(void);
 	void (*write_cr3)(unsigned long);
 
-	/* Hooks for intercepting the creation/use of an mm_struct. */
-	void (*activate_mm)(struct mm_struct *prev,
-			    struct mm_struct *next);
-	void (*dup_mmap)(struct mm_struct *oldmm,
-			 struct mm_struct *mm);
+	/* Hook for intercepting the creation/use of an mm_struct. */
+	void (*enter_mmap)(struct mm_struct *mm);
 
 	/* Hooks for allocating and freeing a pagetable top-level */
 	int  (*pgd_alloc)(struct mm_struct *mm);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 327757afb027..ff1109b9c6cd 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -352,8 +352,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.make_pte		= PTE_IDENT,
 	.mmu.make_pgd		= PTE_IDENT,
 
-	.mmu.dup_mmap		= paravirt_nop,
-	.mmu.activate_mm	= paravirt_nop,
+	.mmu.enter_mmap		= paravirt_nop,
 
 	.mmu.lazy_mode = {
 		.enter		= paravirt_nop,
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index cb258f58fdc8..cbc53da4c1b4 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -806,7 +806,7 @@ void __init poking_init(void)
 	BUG_ON(!poking_mm);
 
 	/* Xen PV guests need the PGD to be pinned. */
-	paravirt_arch_dup_mmap(NULL, poking_mm);
+	paravirt_enter_mmap(poking_mm);
 
 	/*
 	 * Randomize the poking address, but make sure that the following page
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index ee29fb558f2e..b3b8d289b9ab 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -885,14 +885,7 @@ void xen_mm_unpin_all(void)
 	spin_unlock(&pgd_lock);
 }
 
-static void xen_activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-	spin_lock(&next->page_table_lock);
-	xen_pgd_pin(next);
-	spin_unlock(&next->page_table_lock);
-}
-
-static void xen_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
+static void xen_enter_mmap(struct mm_struct *mm)
 {
 	spin_lock(&mm->page_table_lock);
 	xen_pgd_pin(mm);
@@ -2153,8 +2146,7 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
 #endif
 
-		.activate_mm = xen_activate_mm,
-		.dup_mmap = xen_dup_mmap,
+		.enter_mmap = xen_enter_mmap,
 		.exit_mmap = xen_exit_mmap,
 
 		.lazy_mode = {
-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
