Return-Path: <SRS0=gicz=BZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE5FC433E1
	for <virtualization@archiver.kernel.org>; Sat, 15 Aug 2020 10:06:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F8A23105
	for <virtualization@archiver.kernel.org>; Sat, 15 Aug 2020 10:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F8A23105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8DE32887A0;
	Sat, 15 Aug 2020 10:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1G4raOsINDE; Sat, 15 Aug 2020 10:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 685CD88708;
	Sat, 15 Aug 2020 10:06:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 488DEC089F;
	Sat, 15 Aug 2020 10:06:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E616CC004D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 10:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D614888393
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 10:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1reVQ55Lu0eZ
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 10:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1B3AD8836F
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 10:06:49 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3634FB04F;
 Sat, 15 Aug 2020 10:07:11 +0000 (UTC)
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] x86/paravirt: avoid needless paravirt step clearing
 page table entries
Date: Sat, 15 Aug 2020 12:06:41 +0200
Message-Id: <20200815100641.26362-7-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200815100641.26362-1-jgross@suse.com>
References: <20200815100641.26362-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, "VMware, Inc." <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
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

pte_clear() et al are based on tw0 paravirt steps today: one step to
create a page table entry with all zeroes, and one step to write this
entry value.

Drop the first step as it is completely useless.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f0464b88ea1e..d25cc6830e89 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -448,7 +448,7 @@ static inline pudval_t pud_val(pud_t pud)
 
 static inline void pud_clear(pud_t *pudp)
 {
-	set_pud(pudp, __pud(0));
+	set_pud(pudp, native_make_pud(0));
 }
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
@@ -485,15 +485,15 @@ static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 } while (0)
 
 #define pgd_clear(pgdp) do {						\
-	if (pgtable_l5_enabled())						\
-		set_pgd(pgdp, __pgd(0));				\
+	if (pgtable_l5_enabled())					\
+		set_pgd(pgdp, native_make_pgd(0));			\
 } while (0)
 
 #endif  /* CONFIG_PGTABLE_LEVELS == 5 */
 
 static inline void p4d_clear(p4d_t *p4dp)
 {
-	set_p4d(p4dp, __p4d(0));
+	set_p4d(p4dp, native_make_p4d(0));
 }
 
 static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -504,12 +504,12 @@ static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep)
 {
-	set_pte(ptep, __pte(0));
+	set_pte(ptep, native_make_pte(0));
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
 {
-	set_pmd(pmdp, __pmd(0));
+	set_pmd(pmdp, native_make_pmd(0));
 }
 
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
