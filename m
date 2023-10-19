Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB541CDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 09:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A1F783B92;
	Thu, 19 Oct 2023 09:15:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A1F783B92
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=h5mOzl6O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QdCsERA5Rfbg; Thu, 19 Oct 2023 09:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF7C283B80;
	Thu, 19 Oct 2023 09:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF7C283B80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBDE7C0039;
	Thu, 19 Oct 2023 09:15:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3A19C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81B2083B84
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81B2083B84
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xhpakq2AmFmS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:42 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D16283B80
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D16283B80
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8DCF1FD93;
 Thu, 19 Oct 2023 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1697706940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpqDXDWA33mqWmoxpq5N3qpQV4XYHGfx2Mi5nQF6BSo=;
 b=h5mOzl6OsaHSlCsObCxH1ckAqQnPtRAC8wxn4fau8e8aS5wQevs+wtid2r8HprLubdGDjV
 fBmBQiTLVP5ScGHHX30RpwcEZvMtQB9tb3kdemBJ3A+mz84L2IbFm2LQFMBi2LORKM/MJO
 wFtjpZetDsR4OX9PhswdSA52DdbBnmg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66023139C2;
 Thu, 19 Oct 2023 09:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1XWEF7zzMGXnVAAAMHmgww
 (envelope-from <jgross@suse.com>); Thu, 19 Oct 2023 09:15:40 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v3 3/5] x86/paravirt: introduce ALT_NOT_XEN
Date: Thu, 19 Oct 2023 11:15:18 +0200
Message-Id: <20231019091520.14540-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231019091520.14540-1-jgross@suse.com>
References: <20231019091520.14540-1-jgross@suse.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[13];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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
index 9f84dc074f88..e99db1360d2a 100644
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
