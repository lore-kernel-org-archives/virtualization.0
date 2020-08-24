Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BD9C433E3
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117EE22CF8
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117EE22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9D1F85F9D;
	Mon, 24 Aug 2020 08:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kBLCAcyMbsqK; Mon, 24 Aug 2020 08:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0113785EAF;
	Mon, 24 Aug 2020 08:56:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA4C7C089F;
	Mon, 24 Aug 2020 08:56:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0A51C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9A5D985F92
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6XhAAdmkjWCz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A791685F05
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:01 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 0343FD13;
 Mon, 24 Aug 2020 10:55:57 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 22/76] x86/boot/compressed/64: Add set_page_en/decrypted()
 helpers
Date: Mon, 24 Aug 2020 10:54:17 +0200
Message-Id: <20200824085511.7553-23-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
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

From: Joerg Roedel <jroedel@suse.de>

The functions are needed to map the GHCB for SEV-ES guests. The GHCB is
used for communication with the hypervisor, so its content must not be
encrypted. After the GHCB is not needed anymore it must be mapped
encrypted again so that the running kernel image can safely re-use the
memory.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-22-joro@8bytes.org
---
 arch/x86/boot/compressed/ident_map_64.c | 133 ++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h         |   2 +
 2 files changed, 135 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index aa91bebc0fe9..05742f641a06 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -24,6 +24,7 @@
 
 /* These actually do the work of building the kernel identity maps. */
 #include <linux/pgtable.h>
+#include <asm/cmpxchg.h>
 #include <asm/trap_pf.h>
 #include <asm/trapnr.h>
 #include <asm/init.h>
@@ -165,6 +166,138 @@ void finalize_identity_maps(void)
 	write_cr3(top_level_pgt);
 }
 
+static pte_t *split_large_pmd(struct x86_mapping_info *info,
+			      pmd_t *pmdp, unsigned long __address)
+{
+	unsigned long page_flags;
+	unsigned long address;
+	pte_t *pte;
+	pmd_t pmd;
+	int i;
+
+	pte = (pte_t *)info->alloc_pgt_page(info->context);
+	if (!pte)
+		return NULL;
+
+	address     = __address & PMD_MASK;
+	/* No large page - clear PSE flag */
+	page_flags  = info->page_flag & ~_PAGE_PSE;
+
+	/* Populate the PTEs */
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		set_pte(&pte[i], __pte(address | page_flags));
+		address += PAGE_SIZE;
+	}
+
+	/*
+	 * Ideally we need to clear the large PMD first and do a TLB
+	 * flush before we write the new PMD. But the 2M range of the
+	 * PMD might contain the code we execute and/or the stack
+	 * we are on, so we can't do that. But that should be safe here
+	 * because we are going from large to small mappings and we are
+	 * also the only user of the page-table, so there is no chance
+	 * of a TLB multihit.
+	 */
+	pmd = __pmd((unsigned long)pte | info->kernpg_flag);
+	set_pmd(pmdp, pmd);
+	/* Flush TLB to establish the new PMD */
+	write_cr3(top_level_pgt);
+
+	return pte + pte_index(__address);
+}
+
+static void clflush_page(unsigned long address)
+{
+	unsigned int flush_size;
+	char *cl, *start, *end;
+
+	/*
+	 * Hardcode cl-size to 64 - CPUID can't be used here because that might
+	 * cause another #VC exception and the GHCB is not ready to use yet.
+	 */
+	flush_size = 64;
+	start      = (char *)(address & PAGE_MASK);
+	end        = start + PAGE_SIZE;
+
+	/*
+	 * First make sure there are no pending writes on the cache-lines to
+	 * flush.
+	 */
+	asm volatile("mfence" : : : "memory");
+
+	for (cl = start; cl != end; cl += flush_size)
+		clflush(cl);
+}
+
+static int set_clr_page_flags(struct x86_mapping_info *info,
+			      unsigned long address,
+			      pteval_t set, pteval_t clr)
+{
+	pgd_t *pgdp = (pgd_t *)top_level_pgt;
+	p4d_t *p4dp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep, pte;
+
+	/*
+	 * First make sure there is a PMD mapping for 'address'.
+	 * It should already exist, but keep things generic.
+	 *
+	 * To map the page just read from it and fault it in if there is no
+	 * mapping yet. add_identity_map() can't be called here because that
+	 * would unconditionally map the address on PMD level, destroying any
+	 * PTE-level mappings that might already exist. Use assembly here so
+	 * the access won't be optimized away.
+	 */
+	asm volatile("mov %[address], %%r9"
+		     :: [address] "g" (*(unsigned long *)address)
+		     : "r9", "memory");
+
+	/*
+	 * The page is mapped at least with PMD size - so skip checks and walk
+	 * directly to the PMD.
+	 */
+	p4dp = p4d_offset(pgdp, address);
+	pudp = pud_offset(p4dp, address);
+	pmdp = pmd_offset(pudp, address);
+
+	if (pmd_large(*pmdp))
+		ptep = split_large_pmd(info, pmdp, address);
+	else
+		ptep = pte_offset_kernel(pmdp, address);
+
+	if (!ptep)
+		return -ENOMEM;
+
+	/*
+	 * Changing encryption attributes of a page requires to flush it from
+	 * the caches.
+	 */
+	if ((set | clr) & _PAGE_ENC)
+		clflush_page(address);
+
+	/* Update PTE */
+	pte = *ptep;
+	pte = pte_set_flags(pte, set);
+	pte = pte_clear_flags(pte, clr);
+	set_pte(ptep, pte);
+
+	/* Flush TLB after changing encryption attribute */
+	write_cr3(top_level_pgt);
+
+	return 0;
+}
+
+int set_page_decrypted(unsigned long address)
+{
+	return set_clr_page_flags(&mapping_info, address, 0, _PAGE_ENC);
+}
+
+int set_page_encrypted(unsigned long address)
+{
+	return set_clr_page_flags(&mapping_info, address, _PAGE_ENC, 0);
+}
+
 static void do_pf_error(const char *msg, unsigned long error_code,
 			unsigned long address, unsigned long ip)
 {
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index eaa8b45ebccb..01c0fb3417ca 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -98,6 +98,8 @@ static inline void choose_random_location(unsigned long input,
 #endif
 
 #ifdef CONFIG_X86_64
+extern int set_page_decrypted(unsigned long address);
+extern int set_page_encrypted(unsigned long address);
 extern unsigned char _pgtable[];
 #endif
 
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
