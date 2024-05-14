Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57E14D42C
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695543; cv=none; b=D2zB13w9Uah3Fr1r09SPV7cWaY2dNaoHn+FwQ7EOeSD2jy9rCVfnXDG+K6TpZZWBj06GNeHGfGH9gThqzR8Ik+sVNJZRD8v0HDi4N/IiF0hsg7AIo+5tNHbZFhT/Fvcdae4S96udqo6e6s4mBLQC4ZDSA7YTBK2NZF2Fef30oEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695543; c=relaxed/simple;
	bh=ID0c8KED4MaRAhJEPecqve06L1MFkX8CguX3Z8emb34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXnEfu097YFBo0F+RsQvfPhB/YePH10wHfRMLL8DU7YQYMpqx05Rj6WIEUs5Fhj/5w7VZ7XSYJ/evACYC2PvSDHof2kTfPLAuQirdXF/9r++wesyGdx1uI7ywT0FknBAwe4cwf5mQnCi/QuCwrihrZo7QY07j7ovSyjQxU0NmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DocwhOPM; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DocwhOPM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB318402E8
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t-kf3yLsXRco for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 14:05:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 79AA8403C7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79AA8403C7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DocwhOPM
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79AA8403C7
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C6ECE61277;
	Tue, 14 May 2024 14:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AD3C32782;
	Tue, 14 May 2024 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695539;
	bh=ID0c8KED4MaRAhJEPecqve06L1MFkX8CguX3Z8emb34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DocwhOPMzvezJPtOLEyIs2TIRSDK1iKYiQIktTqvDEydUXhzyMFEVIe4w7rEBUoLH
	 s1Aip/eIuRLs0LXxRO2MMKQduZjZ4DBOo06roaRsDYMD4/V0p/WrJ1lfcdUWNFUWwn
	 ODSRdACvCftCwaJk1JNzfbi3KPDD6bOSxG75Dty41GwFFUJmy5m2JNOYIkDK9lRWK4
	 +67Ojs55jbeazXTVY+CfQswUJQMXyrqtCucl7p6pKvQpAHUytS7hU/8LLSnmhoiUR/
	 8vk20MjslNrDRrN0YMhL+gaxgJaWiumVfcpTRg8PMQDoBY6o9yqd75mDcjXratHavn
	 aZt3F8dpoR/bA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 8/8] riscv: mm: Add support for ZONE_DEVICE
Date: Tue, 14 May 2024 16:04:46 +0200
Message-Id: <20240514140446.538622-9-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

ZONE_DEVICE pages need DEVMAP PTEs support to function
(ARCH_HAS_PTE_DEVMAP). Claim another RSW (reserved for software) bit
in the PTE for DEVMAP mark, add the corresponding helpers, and enable
ARCH_HAS_PTE_DEVMAP for riscv64.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig                    |  1 +
 arch/riscv/include/asm/pgtable-64.h   | 20 ++++++++++++++++++++
 arch/riscv/include/asm/pgtable-bits.h |  1 +
 arch/riscv/include/asm/pgtable.h      | 15 +++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b9398b64bb69..6d426afdd904 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -36,6 +36,7 @@ config RISCV
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
+	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 221a5c1ee287..c67a9bbfd010 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -400,4 +400,24 @@ static inline struct page *pgd_page(pgd_t pgd)
 #define p4d_offset p4d_offset
 p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int pte_devmap(pte_t pte);
+static inline pte_t pmd_pte(pmd_t pmd);
+
+static inline int pmd_devmap(pmd_t pmd)
+{
+	return pte_devmap(pmd_pte(pmd));
+}
+
+static inline int pud_devmap(pud_t pud)
+{
+	return 0;
+}
+
+static inline int pgd_devmap(pgd_t pgd)
+{
+	return 0;
+}
+#endif
+
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index 179bd4afece4..a8f5205cea54 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -19,6 +19,7 @@
 #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
 
 #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
+#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7933f493db71..216de1db3cd0 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -387,6 +387,11 @@ static inline int pte_special(pte_t pte)
 	return pte_val(pte) & _PAGE_SPECIAL;
 }
 
+static inline int pte_devmap(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_DEVMAP;
+}
+
 /* static inline pte_t pte_rdprotect(pte_t pte) */
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -428,6 +433,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
 }
 
+static inline pte_t pte_mkdevmap(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DEVMAP);
+}
+
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return pte;
@@ -711,6 +721,11 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 	return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkdevmap(pmd_t pmd)
+{
+	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
+}
+
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-- 
2.40.1

