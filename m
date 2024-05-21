Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81F76413
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292142; cv=none; b=hrYv7pyQuexzU0Kr1jBWU6xYEkxFPd3AxVUkNVdKBIJTzkrmaNxrbFJFP4O04ZxcbHXSR4YNMryKWKzWQIkGDhUeR9bzgYR7CYWvQ4z30I+mpqVcfnSH4hnL2YGu95TIO6ZNIaiLw54HQmgvxC8V3p0got0F5/BDb7bzqr5Xofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292142; c=relaxed/simple;
	bh=DyW6NyCJCRvw/wgT+8WCsVm6Sv3fnQSVUnww9+XHdH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPXcvgEX8cgrvMbhZ7s1KCusUzXpTq6QduTX7f+yPP8JG1O24NmwKslrwNCGNI0Hq9SopHiUr3J9dsdnyz2DliikR3SYl2nkZTitvgem++dWopmmKfb7dZyppenuLeVJWVWOO9yTklocBs1z3VXaPICidBnLFGlPkPBmZiUcR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtdarXYk; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtdarXYk"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F46540275
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:49:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRmKSTqNG-T9 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 11:49:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D14F8401C3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D14F8401C3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EtdarXYk
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D14F8401C3
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 11:48:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 13AE762215;
	Tue, 21 May 2024 11:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065ADC2BD11;
	Tue, 21 May 2024 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292138;
	bh=DyW6NyCJCRvw/wgT+8WCsVm6Sv3fnQSVUnww9+XHdH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtdarXYkV3DME9vOo1G0uAPmao9Ep7FhO3CDDdIUvSEx3nuRwgv4S46uO2nY4T2FU
	 YeGt33vbk2te65221+YRq/egYDqtZ6eBhzy78fucQZtK4W52ztIGQ5/WhcRsr1Nlju
	 Qwv/qdJqaOZPH+pww3sKHzD7n4SN2EyuQBE4R9wvKDvotLBnsrbvQWAh49lxQ6cXjt
	 wywCLyng4NP+pp9ETrxKI9oDwDRyWeOnsia06rJKFlIikjyrffEd3Qs7sP+1gTUsR+
	 qvDhvMYxZcVUmfiBhOEEfJFplGJ7msBamcfVEuyxdIz4ZSbjzxqvol954Hks91OGbq
	 exPQiAZeHjeuQ==
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
Subject: [PATCH v3 3/9] riscv: mm: Change attribute from __init to __meminit for page functions
Date: Tue, 21 May 2024 13:48:24 +0200
Message-Id: <20240521114830.841660-4-bjorn@kernel.org>
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

Prepare for memory hotplugging support by changing from __init to
__meminit for the page table functions that are used by the upcoming
architecture specific callbacks.

Changing the __init attribute to __meminit, avoids that the functions
are removed after init. The __meminit attribute makes sure the
functions are kept in the kernel text post init, but only if memory
hotplugging is enabled for the build.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/mmu.h     |  4 +--
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/mm/init.c             | 56 ++++++++++++++------------------
 3 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 947fd60f9051..c9e03e9da3dc 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -31,8 +31,8 @@ typedef struct {
 #define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
 #define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
 
-void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
-			       phys_addr_t sz, pgprot_t prot);
+void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+				  pgprot_t prot);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_MMU_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 58fd7b70b903..7933f493db71 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -162,7 +162,7 @@ struct pt_alloc_ops {
 #endif
 };
 
-extern struct pt_alloc_ops pt_ops __initdata;
+extern struct pt_alloc_ops pt_ops __meminitdata;
 
 #ifdef CONFIG_MMU
 /* Number of PGD entries that a user-mode program can use */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c98010ede810..c969427eab88 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -295,7 +295,7 @@ static void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-struct pt_alloc_ops pt_ops __initdata;
+struct pt_alloc_ops pt_ops __meminitdata;
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
@@ -357,7 +357,7 @@ static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
 	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
 }
 
-static inline pte_t *__init get_pte_virt_late(phys_addr_t pa)
+static inline pte_t *__meminit get_pte_virt_late(phys_addr_t pa)
 {
 	return (pte_t *) __va(pa);
 }
@@ -376,7 +376,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __init alloc_pte_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
@@ -384,9 +384,8 @@ static phys_addr_t __init alloc_pte_late(uintptr_t va)
 	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
-static void __init create_pte_mapping(pte_t *ptep,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	uintptr_t pte_idx = pte_index(va);
 
@@ -440,7 +439,7 @@ static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
 	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
 }
 
-static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
+static pmd_t *__meminit get_pmd_virt_late(phys_addr_t pa)
 {
 	return (pmd_t *) __va(pa);
 }
@@ -457,7 +456,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __init alloc_pmd_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
@@ -465,9 +464,9 @@ static phys_addr_t __init alloc_pmd_late(uintptr_t va)
 	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
 
-static void __init create_pmd_mapping(pmd_t *pmdp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pmd_mapping(pmd_t *pmdp,
+					 uintptr_t va, phys_addr_t pa,
+					 phys_addr_t sz, pgprot_t prot)
 {
 	pte_t *ptep;
 	phys_addr_t pte_phys;
@@ -503,7 +502,7 @@ static pud_t *__init get_pud_virt_fixmap(phys_addr_t pa)
 	return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
 }
 
-static pud_t *__init get_pud_virt_late(phys_addr_t pa)
+static pud_t *__meminit get_pud_virt_late(phys_addr_t pa)
 {
 	return (pud_t *)__va(pa);
 }
@@ -521,7 +520,7 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t alloc_pud_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -541,7 +540,7 @@ static p4d_t *__init get_p4d_virt_fixmap(phys_addr_t pa)
 	return (p4d_t *)set_fixmap_offset(FIX_P4D, pa);
 }
 
-static p4d_t *__init get_p4d_virt_late(phys_addr_t pa)
+static p4d_t *__meminit get_p4d_virt_late(phys_addr_t pa)
 {
 	return (p4d_t *)__va(pa);
 }
@@ -559,7 +558,7 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t alloc_p4d_late(uintptr_t va)
+static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -568,9 +567,8 @@ static phys_addr_t alloc_p4d_late(uintptr_t va)
 	return __pa(vaddr);
 }
 
-static void __init create_pud_mapping(pud_t *pudp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	pmd_t *nextp;
 	phys_addr_t next_phys;
@@ -595,9 +593,8 @@ static void __init create_pud_mapping(pud_t *pudp,
 	create_pmd_mapping(nextp, va, pa, sz, prot);
 }
 
-static void __init create_p4d_mapping(p4d_t *p4dp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_p4d_mapping(p4d_t *p4dp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	pud_t *nextp;
 	phys_addr_t next_phys;
@@ -653,9 +650,8 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
 #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-void __init create_pgd_mapping(pgd_t *pgdp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+				  pgprot_t prot)
 {
 	pgd_next_t *nextp;
 	phys_addr_t next_phys;
@@ -680,8 +676,7 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 	create_pgd_next_mapping(nextp, va, pa, sz, prot);
 }
 
-static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
-				      phys_addr_t size)
+static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, phys_addr_t size)
 {
 	if (pgtable_l5_enabled &&
 	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
@@ -714,7 +709,7 @@ asmlinkage void __init __copy_data(void)
 #endif
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-static __init pgprot_t pgprot_from_va(uintptr_t va)
+static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 {
 	if (is_va_kernel_text(va))
 		return PAGE_KERNEL_READ_EXEC;
@@ -739,7 +734,7 @@ void mark_rodata_ro(void)
 				  set_memory_ro);
 }
 #else
-static __init pgprot_t pgprot_from_va(uintptr_t va)
+static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 {
 	if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
 		return PAGE_KERNEL;
@@ -1231,9 +1226,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pt_ops_set_fixmap();
 }
 
-static void __init create_linear_mapping_range(phys_addr_t start,
-					       phys_addr_t end,
-					       uintptr_t fixed_map_size)
+static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
+						  uintptr_t fixed_map_size)
 {
 	phys_addr_t pa;
 	uintptr_t va, map_size;
-- 
2.40.1

