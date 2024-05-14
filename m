Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887E8147C62
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695533; cv=none; b=j4H4yKRabN+4mYftesndn/3lm/fNVlnI+jT1aFAASdcG+2CBmatfbi2BENxPjW2zP9qQiARKO5IDbNOi/fYuKBUp0FuMpFZ3RfA0pCjyhCOzMVcBx42bz02r0o0g6wE+Hh4FEWDseQg7XJVPFWxfqVx9BO0p48clNWQllb+CXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695533; c=relaxed/simple;
	bh=KrXLi2kuhfXzcPr+BoNvWMq+KlIFOy4AuLG7kxwToYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sxeze67MxaVITuRqfwXRl2cWqaqUp619uXsGEJ/qY/jRL3Pg5+z9fZLfedvzsLe2lR3IjKzmTz83tObxt9N1rU4BF23daz6XteZ691n4uCBMdEpvYc5VM5JTm0QEaiac9WGk5whcuKYrOCEqKUODDrPZSs3bjOHVXC9v1oYvQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJp+pNmr; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJp+pNmr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24A23403C7
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K9pMvs3FQYCV for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 14:05:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6C2A9402E8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C2A9402E8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qJp+pNmr
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C2A9402E8
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 14:05:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DA595CE1290;
	Tue, 14 May 2024 14:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71035C32782;
	Tue, 14 May 2024 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695522;
	bh=KrXLi2kuhfXzcPr+BoNvWMq+KlIFOy4AuLG7kxwToYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJp+pNmrnz2hVpw3ad/kdlC3wpDSy94U8cdclU7Y7AHoh1yrK5uwu7FPeuJrmjv8m
	 DFM/uYWS2H44l8qKMC+uOJeRNLMQyPOGghW7IuFo7YZPggnkJxEh44Gg3ZQAQSFrSq
	 QOe4J2HCtPFecfwfKl8+/b6GjnF90naa+RZ3qRbWrLNrrF6zi/rxpo62MieP1NpgDj
	 9JPmB0ipQUv3I+2c7oUx9omig2cfqp+yG7/qs+VfFFwgfBf3Xs4/2Q8xjmcxox33H0
	 LtH2mRL8D/SX2fgmIEwUvBMZVQOYb5npRRDc2cGRpvSqdVzBllfNTxAQ/SIeEm0mcd
	 bkyQaYhcOsyPw==
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
Subject: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
Date: Tue, 14 May 2024 16:04:42 +0200
Message-Id: <20240514140446.538622-5-bjorn@kernel.org>
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

For an architecture to support memory hotplugging, a couple of
callbacks needs to be implemented:

 arch_add_memory()
  This callback is responsible for adding the physical memory into the
  direct map, and call into the memory hotplugging generic code via
  __add_pages() that adds the corresponding struct page entries, and
  updates the vmemmap mapping.

 arch_remove_memory()
  This is the inverse of the callback above.

 vmemmap_free()
  This function tears down the vmemmap mappings (if
  CONFIG_SPARSEMEM_VMEMMAP is enabled), and also deallocates the
  backing vmemmap pages. Note that for persistent memory, an
  alternative allocator for the backing pages can be used; The
  vmem_altmap. This means that when the backing pages are cleared,
  extra care is needed so that the correct deallocation method is
  used.

 arch_get_mappable_range()
  This functions returns the PA range that the direct map can map.
  Used by the MHP internals for sanity checks.

The page table unmap/teardown functions are heavily based on code from
the x86 tree. The same remove_pgd_mapping() function is used in both
vmemmap_free() and arch_remove_memory(), but in the latter function
the backing pages are not removed.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 242 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 6f72b0b2b854..7f0b921a3d3a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1493,3 +1493,245 @@ void __init pgtable_cache_init(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
+{
+	pte_t *pte;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = pte_start + i;
+		if (!pte_none(*pte))
+			return;
+	}
+
+	free_pages((unsigned long)page_address(pmd_page(*pmd)), 0);
+	pmd_clear(pmd);
+}
+
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+{
+	pmd_t *pmd;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd = pmd_start + i;
+		if (!pmd_none(*pmd))
+			return;
+	}
+
+	free_pages((unsigned long)page_address(pud_page(*pud)), 0);
+	pud_clear(pud);
+}
+
+static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
+{
+	pud_t *pud;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		pud = pud_start + i;
+		if (!pud_none(*pud))
+			return;
+	}
+
+	free_pages((unsigned long)page_address(p4d_page(*p4d)), 0);
+	p4d_clear(p4d);
+}
+
+static void __meminit free_vmemmap_storage(struct page *page, size_t size,
+					   struct vmem_altmap *altmap)
+{
+	if (altmap)
+		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
+	else
+		free_pages((unsigned long)page_address(page), get_order(size));
+}
+
+static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, unsigned long end,
+					 bool is_vmemmap, struct vmem_altmap *altmap)
+{
+	unsigned long next;
+	pte_t *ptep, pte;
+
+	for (; addr < end; addr = next) {
+		next = (addr + PAGE_SIZE) & PAGE_MASK;
+		if (next > end)
+			next = end;
+
+		ptep = pte_base + pte_index(addr);
+		pte = READ_ONCE(*ptep);
+
+		if (!pte_present(*ptep))
+			continue;
+
+		pte_clear(&init_mm, addr, ptep);
+		if (is_vmemmap)
+			free_vmemmap_storage(pte_page(pte), PAGE_SIZE, altmap);
+	}
+}
+
+static void __meminit remove_pmd_mapping(pmd_t *pmd_base, unsigned long addr, unsigned long end,
+					 bool is_vmemmap, struct vmem_altmap *altmap)
+{
+	unsigned long next;
+	pte_t *pte_base;
+	pmd_t *pmdp, pmd;
+
+	for (; addr < end; addr = next) {
+		next = pmd_addr_end(addr, end);
+		pmdp = pmd_base + pmd_index(addr);
+		pmd = READ_ONCE(*pmdp);
+
+		if (!pmd_present(pmd))
+			continue;
+
+		if (pmd_leaf(pmd)) {
+			pmd_clear(pmdp);
+			if (is_vmemmap)
+				free_vmemmap_storage(pmd_page(pmd), PMD_SIZE, altmap);
+			continue;
+		}
+
+		pte_base = (pte_t *)pmd_page_vaddr(*pmdp);
+		remove_pte_mapping(pte_base, addr, next, is_vmemmap, altmap);
+		free_pte_table(pte_base, pmdp);
+	}
+}
+
+static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long addr, unsigned long end,
+					 bool is_vmemmap, struct vmem_altmap *altmap)
+{
+	unsigned long next;
+	pud_t *pudp, pud;
+	pmd_t *pmd_base;
+
+	for (; addr < end; addr = next) {
+		next = pud_addr_end(addr, end);
+		pudp = pud_base + pud_index(addr);
+		pud = READ_ONCE(*pudp);
+
+		if (!pud_present(pud))
+			continue;
+
+		if (pud_leaf(pud)) {
+			if (pgtable_l4_enabled) {
+				pud_clear(pudp);
+				if (is_vmemmap)
+					free_vmemmap_storage(pud_page(pud), PUD_SIZE, altmap);
+			}
+			continue;
+		}
+
+		pmd_base = pmd_offset(pudp, 0);
+		remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altmap);
+
+		if (pgtable_l4_enabled)
+			free_pmd_table(pmd_base, pudp);
+	}
+}
+
+static void __meminit remove_p4d_mapping(p4d_t *p4d_base, unsigned long addr, unsigned long end,
+					 bool is_vmemmap, struct vmem_altmap *altmap)
+{
+	unsigned long next;
+	p4d_t *p4dp, p4d;
+	pud_t *pud_base;
+
+	for (; addr < end; addr = next) {
+		next = p4d_addr_end(addr, end);
+		p4dp = p4d_base + p4d_index(addr);
+		p4d = READ_ONCE(*p4dp);
+
+		if (!p4d_present(p4d))
+			continue;
+
+		if (p4d_leaf(p4d)) {
+			if (pgtable_l5_enabled) {
+				p4d_clear(p4dp);
+				if (is_vmemmap)
+					free_vmemmap_storage(p4d_page(p4d), P4D_SIZE, altmap);
+			}
+			continue;
+		}
+
+		pud_base = pud_offset(p4dp, 0);
+		remove_pud_mapping(pud_base, addr, next, is_vmemmap, altmap);
+
+		if (pgtable_l5_enabled)
+			free_pud_table(pud_base, p4dp);
+	}
+}
+
+static void __meminit remove_pgd_mapping(unsigned long va, unsigned long end, bool is_vmemmap,
+					 struct vmem_altmap *altmap)
+{
+	unsigned long addr, next;
+	p4d_t *p4d_base;
+	pgd_t *pgd;
+
+	for (addr = va; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+		pgd = pgd_offset_k(addr);
+
+		if (!pgd_present(*pgd))
+			continue;
+
+		if (pgd_leaf(*pgd))
+			continue;
+
+		p4d_base = p4d_offset(pgd, 0);
+		remove_p4d_mapping(p4d_base, addr, next, is_vmemmap, altmap);
+	}
+
+	flush_tlb_all();
+}
+
+static void __meminit remove_linear_mapping(phys_addr_t start, u64 size)
+{
+	unsigned long va = (unsigned long)__va(start);
+	unsigned long end = (unsigned long)__va(start + size);
+
+	remove_pgd_mapping(va, end, false, NULL);
+}
+
+struct range arch_get_mappable_range(void)
+{
+	struct range mhp_range;
+
+	mhp_range.start = __pa(PAGE_OFFSET);
+	mhp_range.end = __pa(PAGE_END - 1);
+	return mhp_range;
+}
+
+int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_params *params)
+{
+	int ret;
+
+	create_linear_mapping_range(start, start + size, 0, &params->pgprot);
+	flush_tlb_all();
+	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT, params);
+	if (ret) {
+		remove_linear_mapping(start, size);
+		return ret;
+	}
+
+	max_pfn = PFN_UP(start + size);
+	max_low_pfn = max_pfn;
+	return 0;
+}
+
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+{
+	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
+	remove_linear_mapping(start, size);
+}
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+void __ref vmemmap_free(unsigned long start, unsigned long end, struct vmem_altmap *altmap)
+{
+	remove_pgd_mapping(start, end, true, altmap);
+}
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+#endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.40.1

