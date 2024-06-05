Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D5194A5F
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587708; cv=none; b=lTNdNiORtziz2uRhPtB52ifFgiEKwh1Qce6DlB2QCfwgI2AfDRdeIIvTmgSCLVM/SLr/gyUwaH+1aAr5rgC6oVdUwX7OEX2EIQuVx3U+PciAHNzyHxjUsHJiIMwlpFIuZbeqWyti7jeSUw6WCIW6h5ypheZPAmeePgmdcyU14hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587708; c=relaxed/simple;
	bh=leGoQp8DEEvTCeM4J9FC79a8Zz3S/PSgaRX/3/h/W8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYifaWSewdRGRhJn4Gv2ifpv+HJWtv5k8HRAsHy3OqIAOEqp/VxU5PKHm5j3BritXMa/FyHxWQOpQPiBUpLetIhBOgk1ofSBxtFLZuDBUGSORfnhAAMf85JcTu4LCv51U9zQx5a3c1logBO/An8mCJXti7TORU9Md2T7IBTbeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrE60qV8; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrE60qV8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B942541749
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LPTwg7KbPyZ1 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:41:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5280340323
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5280340323
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SrE60qV8
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5280340323
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 816E461828;
	Wed,  5 Jun 2024 11:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BD5C4AF07;
	Wed,  5 Jun 2024 11:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587703;
	bh=leGoQp8DEEvTCeM4J9FC79a8Zz3S/PSgaRX/3/h/W8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrE60qV8oPpVdrRp9tUwh9ikl7xIxLTsNY63/3cH50PJYUc8iADgU6aQ2lWeBzVdC
	 Bm/D+UZgx+0eqn6rNGPDrUbLTFBA2D98lam6/6CUgQU0w5daAlIVKzXOo3gLZtuy0q
	 DQghfAdosXGf3Kxm7srDhYYV0bkMYx6RGPCm0Anlg7s8L2hxWW94oEgaGUZZBfR2+T
	 6x9wvIq33dfBPA55iWPQknOQO+x+spsb7EqaQ2bu9Mi4/U3NcJY07Uqia6jKeDvvXP
	 miRZUaXHShRtvlG0Jg53UQWHeEHGOz94fFtNu/D+LJZ+EGh3HfDI3TAIw4rRxg72D7
	 1q6V+P31mOieA==
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
Subject: [PATCH v4 06/11] riscv: mm: Add memory hotplugging support
Date: Wed,  5 Jun 2024 13:40:49 +0200
Message-ID: <20240605114100.315918-7-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
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
 arch/riscv/mm/init.c | 267 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 1f7e7c223bec..bfa2dea95354 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1534,3 +1534,270 @@ struct execmem_info __init *execmem_arch_setup(void)
 }
 #endif /* CONFIG_MMU */
 #endif /* CONFIG_EXECMEM */
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
+{
+	struct page *page = pmd_page(*pmd);
+	struct ptdesc *ptdesc = page_ptdesc(page);
+	pte_t *pte;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = pte_start + i;
+		if (!pte_none(*pte))
+			return;
+	}
+
+	pagetable_pte_dtor(ptdesc);
+	if (PageReserved(page))
+		free_reserved_page(page);
+	else
+		pagetable_free(ptdesc);
+	pmd_clear(pmd);
+}
+
+static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
+{
+	struct page *page = pud_page(*pud);
+	struct ptdesc *ptdesc = page_ptdesc(page);
+	pmd_t *pmd;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd = pmd_start + i;
+		if (!pmd_none(*pmd))
+			return;
+	}
+
+	pagetable_pmd_dtor(ptdesc);
+	if (PageReserved(page))
+		free_reserved_page(page);
+	else
+		pagetable_free(ptdesc);
+	pud_clear(pud);
+}
+
+static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
+{
+	struct page *page = p4d_page(*p4d);
+	pud_t *pud;
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		pud = pud_start + i;
+		if (!pud_none(*pud))
+			return;
+	}
+
+	if (PageReserved(page))
+		free_reserved_page(page);
+	else
+		free_pages((unsigned long)page_address(page), 0);
+	p4d_clear(p4d);
+}
+
+static void __meminit free_vmemmap_storage(struct page *page, size_t size,
+					   struct vmem_altmap *altmap)
+{
+	int order = get_order(size);
+
+	if (altmap) {
+		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
+		return;
+	}
+
+	if (PageReserved(page)) {
+		unsigned int nr_pages = 1 << order;
+
+		while (nr_pages--)
+			free_reserved_page(page++);
+		return;
+	}
+
+	free_pages((unsigned long)page_address(page), order);
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
+		pte = ptep_get(ptep);
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
+		pmd = pmdp_get(pmdp);
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
+		pud = pudp_get(pudp);
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
+		p4d = p4dp_get(p4dp);
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
2.43.0

