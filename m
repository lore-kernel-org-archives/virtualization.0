Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48078C8D
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292151; cv=none; b=GgSgmiUb7xRxlD/IYCuDIFLhDBRd4FSLGz0N0EJsG7QRN6k7axa6pNtn8gKfaoPkrSFV0dLX9N+wEBt1Q+YCRB8s9CPLg1NRZJDUJwmQa52l4H0isKclY4i9vCQ/Z4Hl13V9APEBj+ZA04JXfFSqeKW0eS1LC2to78xve/xJBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292151; c=relaxed/simple;
	bh=YmNQGTYS7tg+RvjQBa8mIUVU0Q8jznFPplKEu6+/K8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7Ifjg7YmMQXjOC3y3pFTTQL/Yp1KorlOopTpUeTG3uQRiJMNWdVMC5BG8n7+RIxAnF4A9RDnucSrQ5WaYUMM6YEt0adDyRkAcuWmvanAtO/4aKuGF6ja1vn6dcqHZckJDSU2cbjtISZ0ZjCMDDoD23n/TEnLfSKb+qz7xqhFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzvEzHHe; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzvEzHHe"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7A75401C5
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MTeSvtHq3gcL for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 11:49:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 79CDC401C3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79CDC401C3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UzvEzHHe
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79CDC401C3
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D3FD462213;
	Tue, 21 May 2024 11:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC39FC2BD11;
	Tue, 21 May 2024 11:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292147;
	bh=YmNQGTYS7tg+RvjQBa8mIUVU0Q8jznFPplKEu6+/K8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzvEzHHexF7JresSjbUV+sseX7MhZnOt/Q6RxfcvlB4jlYBbvS+Mc5EYr2OPt3w1n
	 VnthCTVkILvDLIi1nYESspY9tZiEk/S8GdRdvBNtYuxxGJgGKsmeVaJ4NdBI2fjNpL
	 O4lr9BqHQjAn99ZqfKqqrd8aspSj2moxL790uHQs3eJW+b7TxXtKU8u1ydUEtbB+SJ
	 pUsoV8TCLbwqbeD5kw7g+Jin6DjIO1XOT1XywHo8E6kMryiVfWswgG3ubvVFBby7xy
	 B5SfqddkJ20baZ98Z3B4D3Kkq65i2wxIOluwx6t+d5EhaQjAj2Q9LikQm46I4C6dpm
	 fz3dUdiRyl1CQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v3 5/9] riscv: mm: Add memory hotplugging support
Date: Tue, 21 May 2024 13:48:26 +0200
Message-Id: <20240521114830.841660-6-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521114830.841660-1-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
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
 arch/riscv/mm/init.c | 261 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 261 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 6f72b0b2b854..6693b742bf2f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1493,3 +1493,264 @@ void __init pgtable_cache_init(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static void __meminit free_pagetable(struct page *page, int order)
+{
+	unsigned int nr_pages = 1 << order;
+
+	/*
+	 * vmemmap/direct page tables can be reserved, if added at
+	 * boot.
+	 */
+	if (PageReserved(page)) {
+		__ClearPageReserved(page);
+		while (nr_pages--)
+			free_reserved_page(page++);
+		return;
+	}
+
+	free_pages((unsigned long)page_address(page), order);
+}
+
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
+	free_pagetable(pmd_page(*pmd), 0);
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
+	free_pagetable(pud_page(*pud), 0);
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
+	free_pagetable(p4d_page(*p4d), 0);
+	p4d_clear(p4d);
+}
+
+static void __meminit free_vmemmap_storage(struct page *page, size_t size,
+					   struct vmem_altmap *altmap)
+{
+	if (altmap)
+		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
+	else
+		free_pagetable(page, get_order(size));
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
+	int ret = 0;
+
+	create_linear_mapping_range(start, start + size, 0, &params->pgprot);
+	ret = __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT, params);
+	if (ret) {
+		remove_linear_mapping(start, size);
+		goto out;
+	}
+
+	max_pfn = PFN_UP(start + size);
+	max_low_pfn = max_pfn;
+
+ out:
+	flush_tlb_all();
+	return ret;
+}
+
+void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+{
+	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
+	remove_linear_mapping(start, size);
+	flush_tlb_all();
+}
+
+void __ref vmemmap_free(unsigned long start, unsigned long end, struct vmem_altmap *altmap)
+{
+	remove_pgd_mapping(start, end, true, altmap);
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.40.1

