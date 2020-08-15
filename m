Return-Path: <SRS0=gicz=BZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D857C433E3
	for <virtualization@archiver.kernel.org>; Sat, 15 Aug 2020 10:06:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF8B23105
	for <virtualization@archiver.kernel.org>; Sat, 15 Aug 2020 10:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF8B23105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBE1786F0F;
	Sat, 15 Aug 2020 10:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNrmzR-o2lGF; Sat, 15 Aug 2020 10:06:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ACC5486EF9;
	Sat, 15 Aug 2020 10:06:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97B13C0890;
	Sat, 15 Aug 2020 10:06:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD49C004D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 10:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3C4D48836F
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 10:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q+vAnhcqAHlx
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 10:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D854485207
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 10:06:48 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E3EECB049;
 Sat, 15 Aug 2020 10:07:10 +0000 (UTC)
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] x86/paravirt: remove set_pte_at pv-op
Date: Sat, 15 Aug 2020 12:06:40 +0200
Message-Id: <20200815100641.26362-6-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200815100641.26362-1-jgross@suse.com>
References: <20200815100641.26362-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On x86 set_pte_at() is now always falling back to set_pte(). So instead
of having this fallback after the paravirt maze just drop the
set_pte_at paravirt operation and let set_pte_at() use the set_pte()
function directly.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       |  8 +-------
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/include/asm/pgtable.h        |  7 +++----
 arch/x86/kernel/paravirt.c            |  1 -
 arch/x86/xen/mmu_pv.c                 |  8 --------
 include/trace/events/xen.h            | 20 --------------------
 6 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index e02c409fa054..f0464b88ea1e 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -412,12 +412,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	PVOP_VCALL2(mmu.set_pte, ptep, pte.pte);
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-	PVOP_VCALL4(mmu.set_pte_at, mm, addr, ptep, pte.pte);
-}
-
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
 	PVOP_VCALL2(mmu.set_pmd, pmdp, native_pmd_val(pmd));
@@ -510,7 +504,7 @@ static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep)
 {
-	set_pte_at(mm, addr, ptep, __pte(0));
+	set_pte(ptep, __pte(0));
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f27c3febaa6e..0fad9f61c76a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -242,8 +242,6 @@ struct pv_mmu_ops {
 
 	/* Pagetable manipulation functions */
 	void (*set_pte)(pte_t *ptep, pte_t pteval);
-	void (*set_pte_at)(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, pte_t pteval);
 	void (*set_pmd)(pmd_t *pmdp, pmd_t pmdval);
 
 	pte_t (*ptep_modify_prot_start)(struct vm_area_struct *vma, unsigned long addr,
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b836138ce852..7414b416779b 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -63,7 +63,6 @@ extern pmdval_t early_pmd_flags;
 #include <asm/paravirt.h>
 #else  /* !CONFIG_PARAVIRT_XXL */
 #define set_pte(ptep, pte)		native_set_pte(ptep, pte)
-#define set_pte_at(mm, addr, ptep, pte)	native_set_pte_at(mm, addr, ptep, pte)
 
 #define set_pte_atomic(ptep, pte)					\
 	native_set_pte_atomic(ptep, pte)
@@ -1033,10 +1032,10 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 	return res;
 }
 
-static inline void native_set_pte_at(struct mm_struct *mm, unsigned long addr,
-				     pte_t *ptep , pte_t pte)
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte)
 {
-	native_set_pte(ptep, pte);
+	set_pte(ptep, pte);
 }
 
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e56a144c13b3..6c3407ba6ee9 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -360,7 +360,6 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.release_p4d	= paravirt_nop,
 
 	.mmu.set_pte		= native_set_pte,
-	.mmu.set_pte_at		= native_set_pte_at,
 	.mmu.set_pmd		= native_set_pmd,
 
 	.mmu.ptep_modify_prot_start	= __ptep_modify_prot_start,
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 3273c985d3dd..eda78144c000 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -285,13 +285,6 @@ static void xen_set_pte(pte_t *ptep, pte_t pteval)
 	__xen_set_pte(ptep, pteval);
 }
 
-static void xen_set_pte_at(struct mm_struct *mm, unsigned long addr,
-		    pte_t *ptep, pte_t pteval)
-{
-	trace_xen_mmu_set_pte_at(mm, addr, ptep, pteval);
-	__xen_set_pte(ptep, pteval);
-}
-
 pte_t xen_ptep_modify_prot_start(struct vm_area_struct *vma,
 				 unsigned long addr, pte_t *ptep)
 {
@@ -2105,7 +2098,6 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.release_pmd = xen_release_pmd_init,
 
 	.set_pte = xen_set_pte_init,
-	.set_pte_at = xen_set_pte_at,
 	.set_pmd = xen_set_pmd_hyper,
 
 	.ptep_modify_prot_start = __ptep_modify_prot_start,
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index a5ccfa67bc5c..3b61b587e137 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -153,26 +153,6 @@ DECLARE_EVENT_CLASS(xen_mmu__set_pte,
 
 DEFINE_XEN_MMU_SET_PTE(xen_mmu_set_pte);
 
-TRACE_EVENT(xen_mmu_set_pte_at,
-	    TP_PROTO(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pteval),
-	    TP_ARGS(mm, addr, ptep, pteval),
-	    TP_STRUCT__entry(
-		    __field(struct mm_struct *, mm)
-		    __field(unsigned long, addr)
-		    __field(pte_t *, ptep)
-		    __field(pteval_t, pteval)
-		    ),
-	    TP_fast_assign(__entry->mm = mm;
-			   __entry->addr = addr;
-			   __entry->ptep = ptep;
-			   __entry->pteval = pteval.pte),
-	    TP_printk("mm %p addr %lx ptep %p pteval %0*llx (raw %0*llx)",
-		      __entry->mm, __entry->addr, __entry->ptep,
-		      (int)sizeof(pteval_t) * 2, (unsigned long long)pte_val(native_make_pte(__entry->pteval)),
-		      (int)sizeof(pteval_t) * 2, (unsigned long long)__entry->pteval)
-	);
-
 TRACE_DEFINE_SIZEOF(pmdval_t);
 
 TRACE_EVENT(xen_mmu_set_pmd,
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
