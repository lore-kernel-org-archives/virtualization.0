Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F48C4167D
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 14:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4FE44389D;
	Mon, 30 Oct 2023 14:25:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4FE44389D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=fAl6ZMq2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5_lHwx1-TOgE; Mon, 30 Oct 2023 14:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D30DE40C0D;
	Mon, 30 Oct 2023 14:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D30DE40C0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACC07C0039;
	Mon, 30 Oct 2023 14:25:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B08C9C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8ADE743896
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:25:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8ADE743896
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fQPI7zTq8Ia9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:25:30 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BB5D40C0D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 14:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BB5D40C0D
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8FD4B21CBA;
 Mon, 30 Oct 2023 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1698675928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAmhy1SfZZc3OWn+kKZBUGwLdrE+H9vpNfY8eC/OJPE=;
 b=fAl6ZMq2YroKEIhjHpAt6yh2R55oV8ESiRpWRgC7/crBhG0aI4gT8m6YmCsH8pZGXXxW/N
 QG9VdRT1vUZyC0jCyIpg53jcT+McJL/sa0rgM86EaYd9T7ArTeoPiaj9sYNqIh06J7DnM6
 9KXdfYXV9DfNzcV6wOiLvTBdXeoGyHs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 326F4138F8;
 Mon, 30 Oct 2023 14:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T0HoCti8P2X6QAAAMHmgww
 (envelope-from <jgross@suse.com>); Mon, 30 Oct 2023 14:25:28 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v4 3/5] x86/paravirt: introduce ALT_NOT_XEN
Date: Mon, 30 Oct 2023 15:25:06 +0100
Message-Id: <20231030142508.1407-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231030142508.1407-1-jgross@suse.com>
References: <20231030142508.1407-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ajay Kaher <akaher@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
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

Introduce the macro ALT_NOT_XEN as a short form of
ALT_NOT(X86_FEATURE_XENPV).

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- split off from next patch
---
 arch/x86/include/asm/paravirt.h       | 42 ++++++++++++---------------
 arch/x86/include/asm/paravirt_types.h |  3 ++
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index ed5c7342f2ef..3749311d51c3 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -142,8 +142,7 @@ static inline void write_cr0(unsigned long x)
 static __always_inline unsigned long read_cr2(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
-				"mov %%cr2, %%rax;",
-				ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%cr2, %%rax;", ALT_NOT_XEN);
 }
 
 static __always_inline void write_cr2(unsigned long x)
@@ -154,13 +153,12 @@ static __always_inline void write_cr2(unsigned long x)
 static inline unsigned long __read_cr3(void)
 {
 	return PVOP_ALT_CALL0(unsigned long, mmu.read_cr3,
-			      "mov %%cr3, %%rax;", ALT_NOT(X86_FEATURE_XENPV));
+			      "mov %%cr3, %%rax;", ALT_NOT_XEN);
 }
 
 static inline void write_cr3(unsigned long x)
 {
-	PVOP_ALT_VCALL1(mmu.write_cr3, x,
-			"mov %%rdi, %%cr3", ALT_NOT(X86_FEATURE_XENPV));
+	PVOP_ALT_VCALL1(mmu.write_cr3, x, "mov %%rdi, %%cr3", ALT_NOT_XEN);
 }
 
 static inline void __write_cr4(unsigned long x)
@@ -182,7 +180,7 @@ extern noinstr void pv_native_wbinvd(void);
 
 static __always_inline void wbinvd(void)
 {
-	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
+	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT_XEN);
 }
 
 static inline u64 paravirt_read_msr(unsigned msr)
@@ -390,27 +388,25 @@ static inline void paravirt_release_p4d(unsigned long pfn)
 static inline pte_t __pte(pteval_t val)
 {
 	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
-					  "mov %%rdi, %%rax",
-					  ALT_NOT(X86_FEATURE_XENPV)) };
+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pteval_t pte_val(pte_t pte)
 {
 	return PVOP_ALT_CALLEE1(pteval_t, mmu.pte_val, pte.pte,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline pgd_t __pgd(pgdval_t val)
 {
 	return (pgd_t) { PVOP_ALT_CALLEE1(pgdval_t, mmu.make_pgd, val,
-					  "mov %%rdi, %%rax",
-					  ALT_NOT(X86_FEATURE_XENPV)) };
+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pgdval_t pgd_val(pgd_t pgd)
 {
 	return PVOP_ALT_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 #define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
@@ -444,14 +440,13 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 static inline pmd_t __pmd(pmdval_t val)
 {
 	return (pmd_t) { PVOP_ALT_CALLEE1(pmdval_t, mmu.make_pmd, val,
-					  "mov %%rdi, %%rax",
-					  ALT_NOT(X86_FEATURE_XENPV)) };
+					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
 }
 
 static inline pmdval_t pmd_val(pmd_t pmd)
 {
 	return PVOP_ALT_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
@@ -464,7 +459,7 @@ static inline pud_t __pud(pudval_t val)
 	pudval_t ret;
 
 	ret = PVOP_ALT_CALLEE1(pudval_t, mmu.make_pud, val,
-			       "mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+			       "mov %%rdi, %%rax", ALT_NOT_XEN);
 
 	return (pud_t) { ret };
 }
@@ -472,7 +467,7 @@ static inline pud_t __pud(pudval_t val)
 static inline pudval_t pud_val(pud_t pud)
 {
 	return PVOP_ALT_CALLEE1(pudval_t, mmu.pud_val, pud.pud,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline void pud_clear(pud_t *pudp)
@@ -492,8 +487,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 static inline p4d_t __p4d(p4dval_t val)
 {
 	p4dval_t ret = PVOP_ALT_CALLEE1(p4dval_t, mmu.make_p4d, val,
-					"mov %%rdi, %%rax",
-					ALT_NOT(X86_FEATURE_XENPV));
+					"mov %%rdi, %%rax", ALT_NOT_XEN);
 
 	return (p4d_t) { ret };
 }
@@ -501,7 +495,7 @@ static inline p4d_t __p4d(p4dval_t val)
 static inline p4dval_t p4d_val(p4d_t p4d)
 {
 	return PVOP_ALT_CALLEE1(p4dval_t, mmu.p4d_val, p4d.p4d,
-				"mov %%rdi, %%rax", ALT_NOT(X86_FEATURE_XENPV));
+				"mov %%rdi, %%rax", ALT_NOT_XEN);
 }
 
 static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
@@ -687,17 +681,17 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 static __always_inline unsigned long arch_local_save_flags(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
-				ALT_NOT(X86_FEATURE_XENPV));
+				ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_disable(void)
 {
-	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT(X86_FEATURE_XENPV));
+	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_enable(void)
 {
-	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT(X86_FEATURE_XENPV));
+	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT_XEN);
 }
 
 static __always_inline unsigned long arch_local_irq_save(void)
@@ -759,7 +753,7 @@ void native_pv_lock_init(void) __init;
 .endm
 
 #define SAVE_FLAGS	ALTERNATIVE "PARA_IRQ_save_fl;", "pushf; pop %rax;", \
-				    ALT_NOT(X86_FEATURE_XENPV)
+				    ALT_NOT_XEN
 #endif
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index c3d680544da1..291d794f2344 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -557,5 +557,8 @@ extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
 #endif	/* __ASSEMBLY__ */
+
+#define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
+
 #endif  /* CONFIG_PARAVIRT */
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */
-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
