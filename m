Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F077620
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297594; cv=none; b=TZ27a/WpSjPLu1VgUct9CymGeE8eZaxZmYmO63xbxCAvysIoX72bwL2MdvyCPWZANr52msP3Ar2P8flGB62k+TWwVGChhfqktjwrnbqzH0DG0OD6saTwN/OeqypwEMjnG8nHLacnNiobLc2B/glB53KWsmiD55vHIb8RMdReh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297594; c=relaxed/simple;
	bh=8qax5awtexiiUvkhrvySpeijJ459/7r8LyU81TOtaew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjjQdfpBW3k9Xp4KBbhJu+fHgxuUI1mho1TVHnAk403ip87StqOXekTslDPmUw6ajR5Ne1BteMEr4IYbp6fqPXCCAEyaDY/g4sZAEeemVbedM2NE7mvil+D8hfpn8yheYUsTTYoo+61iutojB4RagdWXBr/ORAlR7x1FlEBvoyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Fs0uR7n6; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Fs0uR7n6"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5EBD6403C0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xQeb62M7CeAf for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 13:19:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C2A8940179
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2A8940179
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Fs0uR7n6
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2A8940179
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:19:50 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a59cdd185b9so1321233866b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716297588; x=1716902388; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUsqZcIImoN3lygpYsAoZ85j0J0RTOEqy4OcMBQJ2fM=;
        b=Fs0uR7n61dvG1Ul9FAanEsESssgmMvA5wCj6hGzQ/KypYaf8YkMcGpooONampIV8qW
         pwDz3/i5y8GAUAEYS8BRGsf2UkVUXnnvq7nm6Kk9tJVOoGNJ2MdcMtmEH93k/abrKyaj
         9HP+5nzAFjoeZwO0Oyyh+R+21OHYbsSGT0r4fb3Xa7wkaHmQPZPGRQbad3+3MTo/fsV9
         8oXizezPaaO4fmMIPrDixmi6XNF62RexEKnwPcQwOTSXa+nlfkL8KGxSczaTr9lkNMZ9
         aaBwarEmbGsCb3zrWotplhxY8fSXL2Kh+jLn5BGV6ho7fovDvkibGHeS8Pq1dL757VlE
         QQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716297588; x=1716902388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUsqZcIImoN3lygpYsAoZ85j0J0RTOEqy4OcMBQJ2fM=;
        b=c2DR3CJCU4BybdhLAZW0WBUyWxI2WVcRaqZCoARE25fJKDkGqu5rjOF+Mc2T8MevrB
         j2Gs1cPfSFYlm7sri5J+bUTWXMiI5TNLy9bc1KlVRWtZY72KjtDedM4G3h3Ol4NPsne+
         ee0E35G75h6+7svSCCCVOFmPDlA4X9lDHRXBMSzMnJ8tlEjRPqlI6sN5C6dI8KofGwQo
         mAi6T+4s8HJDAjiFtTD6tb4g4ciA55HJyec8g8jJkzRYHTieuNJvWcj9kgOorIwsAvdI
         Gq8aUtwyZnjSZeUyhUQcvTBIuxap/1lKt7VvnfBZIh2Rs22aBMPgOZpjkkONwKlRypzx
         8bSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwqL6Gjhi0rhJJbQpkwOaYI8DiMiV9A1ppr5X0j0Q065Z/h/53IHYAFq2MQHvhkRuKvFACMYh4Dg3DrEg0HR6zcafpGaYdzz+SGbH0PACdT4h7G3thsnVjRg==
X-Gm-Message-State: AOJu0YwmGGz7jRVJEmLg5amyi0WBtYCb4kjXOGGkxPXMIfAZxTgQorJK
	/ipucGZTcFZX5HORf9wyktGXlixQ2yfGp2gKT44o2f4S0MwHpDuomzXV1ZNZ/rI+mJOvamUznMZ
	FoV7znfJLZ1mKMulHhpPr6cwnYODbi0tCgkUwsA==
X-Google-Smtp-Source: AGHT+IEEzbyXnt/Njk3xCSo+L3Pf6K4ovTW/ntRZWyISNPBKcK+gLEL/RjTpGtnUz3wDTJ4yIeDk+UMPwIYqZTbvTRM=
X-Received: by 2002:a17:907:9919:b0:a5a:8673:cccd with SMTP id
 a640c23a62f3a-a5d5c8270d0mr837719766b.30.1716297588567; Tue, 21 May 2024
 06:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-6-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-6-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 15:19:37 +0200
Message-ID: <CAHVXubi_yQ6L5g4dODoHMNvgO6kHy8i6YskRXSPoTU4N2P8rUA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] riscv: mm: Add memory hotplugging support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:49=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> For an architecture to support memory hotplugging, a couple of
> callbacks needs to be implemented:
>
>  arch_add_memory()
>   This callback is responsible for adding the physical memory into the
>   direct map, and call into the memory hotplugging generic code via
>   __add_pages() that adds the corresponding struct page entries, and
>   updates the vmemmap mapping.
>
>  arch_remove_memory()
>   This is the inverse of the callback above.
>
>  vmemmap_free()
>   This function tears down the vmemmap mappings (if
>   CONFIG_SPARSEMEM_VMEMMAP is enabled), and also deallocates the
>   backing vmemmap pages. Note that for persistent memory, an
>   alternative allocator for the backing pages can be used; The
>   vmem_altmap. This means that when the backing pages are cleared,
>   extra care is needed so that the correct deallocation method is
>   used.
>
>  arch_get_mappable_range()
>   This functions returns the PA range that the direct map can map.
>   Used by the MHP internals for sanity checks.
>
> The page table unmap/teardown functions are heavily based on code from
> the x86 tree. The same remove_pgd_mapping() function is used in both
> vmemmap_free() and arch_remove_memory(), but in the latter function
> the backing pages are not removed.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 261 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 261 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 6f72b0b2b854..6693b742bf2f 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1493,3 +1493,264 @@ void __init pgtable_cache_init(void)
>         }
>  }
>  #endif
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static void __meminit free_pagetable(struct page *page, int order)
> +{
> +       unsigned int nr_pages =3D 1 << order;
> +
> +       /*
> +        * vmemmap/direct page tables can be reserved, if added at
> +        * boot.
> +        */
> +       if (PageReserved(page)) {
> +               __ClearPageReserved(page);

What's the difference between __ClearPageReserved() and
ClearPageReserved()? Because it seems like free_reserved_page() calls
the latter already, so why would you need to call
__ClearPageReserved() on the first page?

> +               while (nr_pages--)
> +                       free_reserved_page(page++);
> +               return;
> +       }
> +
> +       free_pages((unsigned long)page_address(page), order);
> +}
> +
> +static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
> +{
> +       pte_t *pte;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
> +               pte =3D pte_start + i;
> +               if (!pte_none(*pte))
> +                       return;
> +       }
> +
> +       free_pagetable(pmd_page(*pmd), 0);
> +       pmd_clear(pmd);
> +}
> +
> +static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
> +{
> +       pmd_t *pmd;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PMD; i++) {
> +               pmd =3D pmd_start + i;
> +               if (!pmd_none(*pmd))
> +                       return;
> +       }
> +
> +       free_pagetable(pud_page(*pud), 0);
> +       pud_clear(pud);
> +}
> +
> +static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
> +{
> +       pud_t *pud;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PUD; i++) {
> +               pud =3D pud_start + i;
> +               if (!pud_none(*pud))
> +                       return;
> +       }
> +
> +       free_pagetable(p4d_page(*p4d), 0);
> +       p4d_clear(p4d);
> +}
> +
> +static void __meminit free_vmemmap_storage(struct page *page, size_t siz=
e,
> +                                          struct vmem_altmap *altmap)
> +{
> +       if (altmap)
> +               vmem_altmap_free(altmap, size >> PAGE_SHIFT);
> +       else
> +               free_pagetable(page, get_order(size));
> +}
> +
> +static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long =
addr, unsigned long end,
> +                                        bool is_vmemmap, struct vmem_alt=
map *altmap)
> +{
> +       unsigned long next;
> +       pte_t *ptep, pte;
> +
> +       for (; addr < end; addr =3D next) {
> +               next =3D (addr + PAGE_SIZE) & PAGE_MASK;

Nit: use ALIGN() instead.

> +               if (next > end)
> +                       next =3D end;
> +
> +               ptep =3D pte_base + pte_index(addr);
> +               pte =3D READ_ONCE(*ptep);

Nit: Use ptep_get()

> +
> +               if (!pte_present(*ptep))
> +                       continue;
> +
> +               pte_clear(&init_mm, addr, ptep);
> +               if (is_vmemmap)
> +                       free_vmemmap_storage(pte_page(pte), PAGE_SIZE, al=
tmap);
> +       }
> +}
> +
> +static void __meminit remove_pmd_mapping(pmd_t *pmd_base, unsigned long =
addr, unsigned long end,
> +                                        bool is_vmemmap, struct vmem_alt=
map *altmap)
> +{
> +       unsigned long next;
> +       pte_t *pte_base;
> +       pmd_t *pmdp, pmd;
> +
> +       for (; addr < end; addr =3D next) {
> +               next =3D pmd_addr_end(addr, end);
> +               pmdp =3D pmd_base + pmd_index(addr);
> +               pmd =3D READ_ONCE(*pmdp);

Nit: Use pmdp_get()

> +
> +               if (!pmd_present(pmd))
> +                       continue;
> +
> +               if (pmd_leaf(pmd)) {
> +                       pmd_clear(pmdp);
> +                       if (is_vmemmap)
> +                               free_vmemmap_storage(pmd_page(pmd), PMD_S=
IZE, altmap);
> +                       continue;
> +               }
> +
> +               pte_base =3D (pte_t *)pmd_page_vaddr(*pmdp);
> +               remove_pte_mapping(pte_base, addr, next, is_vmemmap, altm=
ap);
> +               free_pte_table(pte_base, pmdp);
> +       }
> +}
> +
> +static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long =
addr, unsigned long end,
> +                                        bool is_vmemmap, struct vmem_alt=
map *altmap)
> +{
> +       unsigned long next;
> +       pud_t *pudp, pud;
> +       pmd_t *pmd_base;
> +
> +       for (; addr < end; addr =3D next) {
> +               next =3D pud_addr_end(addr, end);
> +               pudp =3D pud_base + pud_index(addr);
> +               pud =3D READ_ONCE(*pudp);

Nit: Use pudp_get()

> +
> +               if (!pud_present(pud))
> +                       continue;
> +
> +               if (pud_leaf(pud)) {
> +                       if (pgtable_l4_enabled) {
> +                               pud_clear(pudp);
> +                               if (is_vmemmap)
> +                                       free_vmemmap_storage(pud_page(pud=
), PUD_SIZE, altmap);
> +                       }
> +                       continue;
> +               }
> +
> +               pmd_base =3D pmd_offset(pudp, 0);
> +               remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altm=
ap);
> +
> +               if (pgtable_l4_enabled)
> +                       free_pmd_table(pmd_base, pudp);
> +       }
> +}
> +
> +static void __meminit remove_p4d_mapping(p4d_t *p4d_base, unsigned long =
addr, unsigned long end,
> +                                        bool is_vmemmap, struct vmem_alt=
map *altmap)
> +{
> +       unsigned long next;
> +       p4d_t *p4dp, p4d;
> +       pud_t *pud_base;
> +
> +       for (; addr < end; addr =3D next) {
> +               next =3D p4d_addr_end(addr, end);
> +               p4dp =3D p4d_base + p4d_index(addr);
> +               p4d =3D READ_ONCE(*p4dp);

Nit: Use p4dp_get()

> +
> +               if (!p4d_present(p4d))
> +                       continue;
> +
> +               if (p4d_leaf(p4d)) {
> +                       if (pgtable_l5_enabled) {
> +                               p4d_clear(p4dp);
> +                               if (is_vmemmap)
> +                                       free_vmemmap_storage(p4d_page(p4d=
), P4D_SIZE, altmap);
> +                       }
> +                       continue;
> +               }
> +
> +               pud_base =3D pud_offset(p4dp, 0);
> +               remove_pud_mapping(pud_base, addr, next, is_vmemmap, altm=
ap);
> +
> +               if (pgtable_l5_enabled)
> +                       free_pud_table(pud_base, p4dp);
> +       }
> +}
> +
> +static void __meminit remove_pgd_mapping(unsigned long va, unsigned long=
 end, bool is_vmemmap,
> +                                        struct vmem_altmap *altmap)
> +{
> +       unsigned long addr, next;
> +       p4d_t *p4d_base;
> +       pgd_t *pgd;
> +
> +       for (addr =3D va; addr < end; addr =3D next) {
> +               next =3D pgd_addr_end(addr, end);
> +               pgd =3D pgd_offset_k(addr);
> +
> +               if (!pgd_present(*pgd))
> +                       continue;
> +
> +               if (pgd_leaf(*pgd))
> +                       continue;
> +
> +               p4d_base =3D p4d_offset(pgd, 0);
> +               remove_p4d_mapping(p4d_base, addr, next, is_vmemmap, altm=
ap);
> +       }
> +
> +       flush_tlb_all();
> +}
> +
> +static void __meminit remove_linear_mapping(phys_addr_t start, u64 size)
> +{
> +       unsigned long va =3D (unsigned long)__va(start);
> +       unsigned long end =3D (unsigned long)__va(start + size);
> +
> +       remove_pgd_mapping(va, end, false, NULL);
> +}
> +
> +struct range arch_get_mappable_range(void)
> +{
> +       struct range mhp_range;
> +
> +       mhp_range.start =3D __pa(PAGE_OFFSET);
> +       mhp_range.end =3D __pa(PAGE_END - 1);
> +       return mhp_range;
> +}
> +
> +int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_param=
s *params)
> +{
> +       int ret =3D 0;
> +
> +       create_linear_mapping_range(start, start + size, 0, &params->pgpr=
ot);
> +       ret =3D __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,=
 params);
> +       if (ret) {
> +               remove_linear_mapping(start, size);
> +               goto out;
> +       }
> +
> +       max_pfn =3D PFN_UP(start + size);
> +       max_low_pfn =3D max_pfn;
> +
> + out:
> +       flush_tlb_all();
> +       return ret;
> +}
> +
> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *a=
ltmap)
> +{
> +       __remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
> +       remove_linear_mapping(start, size);
> +       flush_tlb_all();
> +}
> +
> +void __ref vmemmap_free(unsigned long start, unsigned long end, struct v=
mem_altmap *altmap)
> +{
> +       remove_pgd_mapping(start, end, true, altmap);
> +}
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> --
> 2.40.1
>
