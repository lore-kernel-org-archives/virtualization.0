Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62A2F855
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221555; cv=none; b=tk2Uq71aH31Q/v5W4ctpDjYO88GIzPonl7aVufSORYmM86XqQEI/CqPf9HzeG0MGaA0tDveg022NtJaibBxFXfsYgLWI7kxzSeRxDsiY7ZvqaeQAayuW2LQelLzpCYeyZ0FctP/qJ1AlaryrVlpRE/ifZWPrWM4m3Wu42Am+S2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221555; c=relaxed/simple;
	bh=cpjpeDG3Oi/Xaxnm8EApXaEf/9L0dpizxBqg7otXitA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJJjcSIODIaia+YwiTxkSZOT0WiTZIubwHHMy1Kop9XhiUd8p8Fq4LutV5JQzu6LQ0TyXK7zExO3MUcWFhVCBH1jKcY/BiqMZXuwlgv4lrebPewdRsX++1D4r667bffxYDjM1K+zupnBKmdyamJW8/gwVcVtfBtMBTjP9FTRKc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fzkFioyQ; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fzkFioyQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42E7B6089D
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGGvrTZ2htxa for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jun 2024 09:32:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EE2E66088E
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE2E66088E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fzkFioyQ
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE2E66088E
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:32:32 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so4523649a12.1
        for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719221551; x=1719826351; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylP9hhefoKdB6RU1zDeF3Hm4NcbTZcv1z2JYeHMCiz0=;
        b=fzkFioyQyTEfIJK3PRqpFTQKBmsqwS6NlAV1Fbvk1xwmBAlfMAaE+cheI6mxMBCkNW
         DLeRsNyUBt6kWvuXTADC5y9A9QKwoXXCy65dGrNlHr+ZJDRR73lLpwqHM4z9ErgWuf/Q
         I7JL5B8ZqLuIc+OOAOKAmv2mqHJSu7xUh1X0eqfoUHCoyK1YaeqhxJz8Nwr833fvLa0P
         WRISvQC+RYEOl8StLd1D1nWMi3Xe01XXaHDVLCtypRA/5+ussejWAjMhz61r7FR7saY0
         AQ37STTipkJikKBaSipPNPjisd7KKkA1cGCCQM543sj2Gy6oPKNjbLOTKUUM9O3OupIf
         iujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221551; x=1719826351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylP9hhefoKdB6RU1zDeF3Hm4NcbTZcv1z2JYeHMCiz0=;
        b=nTUVG9LfkjXTLeUvm4875aGS7Uj9uKWun02+utM3uOH2zYzLrzR8UoXCuKQV96GN4S
         AtVG1vzped0/gMjHxHEc0yDKKJrLONifYbaYjmSZZMT3A7KsrMfA0bypEduAwpieid9H
         /xYTaQCdJNdbK7WvXa9h3J4dWBXKtdScgkUMPZjcPLIqzX7isLtK1uEjGwNdEpiXGLTN
         q2YqfvhBu2YqhQKpQZDITnErjeUKQfSqKqlGum/h88povVNCqaWN3040mIf8uYQ0yN7j
         ftlhNe3H91DuB+CT6rtU7bJuyEBaesOfbY6fBHbOvNZqHKeO92Jlhfmvu40YzkNCX9+F
         1oMA==
X-Forwarded-Encrypted: i=1; AJvYcCXxzVIVIVhZ1XU1Ts6jKHZacHCxiOiEem3poW+P8/Ha25xkBmiAXGjlZun82LsxPv9K1xAyIZkzSH0rLwWme4ZwSW0lQ9JolgNWo6uKtqVb/Z0YeMnBGDP/Iw==
X-Gm-Message-State: AOJu0Yy3ii4YJ7Vx1//P4YTHDdRJSP5I7FhiULtXdu6V3kv6UH3lxnTn
	34zTdNZMEDr9uWQWZ21I1FdFd2g10x211EiUjKrIZiDky9xJlbviCJXVOmBtRyWBGtuxsMZ8dHy
	xR6I2gBVd/9sOBGfLJi9qHVXCS42vGVxuWpVmmg==
X-Google-Smtp-Source: AGHT+IH/JL/qIpbyxq7hJOXhkGJPFyzywZEiucA6mKuy0VX/4fU0m7YLa6uwthvClRi+aVrun5e0UNcYS0P4SB4gud0=
X-Received: by 2002:a50:d483:0:b0:57a:33a5:9b71 with SMTP id
 4fb4d7f45d1cf-57d4bdbe8famr3538087a12.33.1719221550794; Mon, 24 Jun 2024
 02:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240605114100.315918-1-bjorn@kernel.org> <20240605114100.315918-7-bjorn@kernel.org>
In-Reply-To: <20240605114100.315918-7-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Jun 2024 11:32:19 +0200
Message-ID: <CAHVXubhO+Ew7dsykW63RcpCe6er2DohwUt51ZGxamdCc=EVi7w@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] riscv: mm: Add memory hotplugging support
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

On Wed, Jun 5, 2024 at 1:41=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
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
>  arch/riscv/mm/init.c | 267 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 1f7e7c223bec..bfa2dea95354 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1534,3 +1534,270 @@ struct execmem_info __init *execmem_arch_setup(vo=
id)
>  }
>  #endif /* CONFIG_MMU */
>  #endif /* CONFIG_EXECMEM */
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
> +{
> +       struct page *page =3D pmd_page(*pmd);
> +       struct ptdesc *ptdesc =3D page_ptdesc(page);
> +       pte_t *pte;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
> +               pte =3D pte_start + i;
> +               if (!pte_none(*pte))
> +                       return;
> +       }
> +
> +       pagetable_pte_dtor(ptdesc);
> +       if (PageReserved(page))
> +               free_reserved_page(page);
> +       else
> +               pagetable_free(ptdesc);
> +       pmd_clear(pmd);
> +}
> +
> +static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
> +{
> +       struct page *page =3D pud_page(*pud);
> +       struct ptdesc *ptdesc =3D page_ptdesc(page);
> +       pmd_t *pmd;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PMD; i++) {
> +               pmd =3D pmd_start + i;
> +               if (!pmd_none(*pmd))
> +                       return;
> +       }
> +
> +       pagetable_pmd_dtor(ptdesc);
> +       if (PageReserved(page))
> +               free_reserved_page(page);
> +       else
> +               pagetable_free(ptdesc);
> +       pud_clear(pud);
> +}
> +
> +static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
> +{
> +       struct page *page =3D p4d_page(*p4d);
> +       pud_t *pud;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PUD; i++) {
> +               pud =3D pud_start + i;
> +               if (!pud_none(*pud))
> +                       return;
> +       }
> +
> +       if (PageReserved(page))
> +               free_reserved_page(page);
> +       else
> +               free_pages((unsigned long)page_address(page), 0);
> +       p4d_clear(p4d);
> +}
> +
> +static void __meminit free_vmemmap_storage(struct page *page, size_t siz=
e,
> +                                          struct vmem_altmap *altmap)
> +{
> +       int order =3D get_order(size);
> +
> +       if (altmap) {
> +               vmem_altmap_free(altmap, size >> PAGE_SHIFT);
> +               return;
> +       }
> +
> +       if (PageReserved(page)) {
> +               unsigned int nr_pages =3D 1 << order;
> +
> +               while (nr_pages--)
> +                       free_reserved_page(page++);
> +               return;
> +       }
> +
> +       free_pages((unsigned long)page_address(page), order);
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
> +               if (next > end)
> +                       next =3D end;
> +
> +               ptep =3D pte_base + pte_index(addr);
> +               pte =3D ptep_get(ptep);
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
> +               pmd =3D pmdp_get(pmdp);
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
> +               pud =3D pudp_get(pudp);
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
> +               p4d =3D p4dp_get(p4dp);
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
> 2.43.0
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
