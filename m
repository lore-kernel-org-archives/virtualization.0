Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C95A0F9
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708738; cv=none; b=kcK9b/hhPMj8k/xwrJaqMOlUa3AppWaBjeHw+zhiVUsIHUtpOviaUEPdNWFM4TLJnGmNqJPSw6QLPrHHSn2GMXHMsod6EmDRof41mtivlw41JCMLPoMlpOOwFDNbEAtUTj3IpW5wUq2DQho7KKjswO7gi+HMm+uKq90OmRybjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708738; c=relaxed/simple;
	bh=Y5u1qb3o8jFWtGibc8YJEuaQWEpyo58a0wSHycQXleQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cAcfpBzNIXTYH0ufH2d5Y6VJbumycuMUXr+uA5pD73f2Rkw70fh3vLx9lCw7mttPHQJcPTR7QEL0HjsJg1pDM9eFiR5Aymx5xNe9OhwOy5TO/tQ82YvT/OxXucJGRJvBIxn9S4GO7l8m5YJgBRA0izTQny69J8sJRnNA8chDvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G054jbzd; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G054jbzd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAD81820AC
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 17:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ddFVht1Ik92K for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 17:45:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9111B8209F
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9111B8209F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G054jbzd
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9111B8209F
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 17:45:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9D2D5CE125C;
	Tue, 14 May 2024 17:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7236BC2BD10;
	Tue, 14 May 2024 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708730;
	bh=Y5u1qb3o8jFWtGibc8YJEuaQWEpyo58a0wSHycQXleQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G054jbzd+J9V/nAGuyYQaXf4T9BMH783EEmaCmvg66SJTcqK7jZ9+ElWJEwLEyt7E
	 XJmKsFWNKmYKPmovj1YBED2fdBYb6tbJGguRkEogzYlK7PJcLWf8OfpMAlW7x47MgL
	 yPS0EFZGjP3X8yK93NmWAecIbgT5z3OitiNLoeE5aKPnIYqvtEUiMt/wKbWDbOwXVg
	 0GoKGunjUjvRldCr09m0npf42Kd/q8BsJpdid5urLb7jWZLOTH03MgJ1VLFKaDCOXh
	 0LtUamA7Cke/CuemSovSYmQhF8MqtV3WpsnY+06nu1P1tQFj2G2eUv8NhNuRHGV7uB
	 c9PCS0Vmow/gQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andrew Bresticker <abrestic@rivosinc.com>, Chethan
 Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Oscar Salvador <osalvador@suse.de>, Santosh Mamila
 <santosh.mamila@catalinasystems.io>, Sivakumar Munnangi
 <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/8] riscv: mm: Change attribute from __init to
 __meminit for page functions
In-Reply-To: <CAHVXubgYfi6hNjUAGeXoOcAbAS8Bvd_TtrTD8FhJP1EpPGDKMw@mail.gmail.com>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-3-bjorn@kernel.org>
 <CAHVXubgYfi6hNjUAGeXoOcAbAS8Bvd_TtrTD8FhJP1EpPGDKMw@mail.gmail.com>
Date: Tue, 14 May 2024 19:45:27 +0200
Message-ID: <87ikzg479k.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> Prepare for memory hotplugging support by changing from __init to
>> __meminit for the page table functions that are used by the upcoming
>> architecture specific callbacks.
>>
>> Changing the __init attribute to __meminit, avoids that the functions
>> are removed after init. The __meminit attribute makes sure the
>> functions are kept in the kernel text post init, but only if memory
>> hotplugging is enabled for the build.
>>
>> Also, make sure that the altmap parameter is properly passed on to
>> vmemmap_populate_hugepages().
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/mmu.h     |  4 +--
>>  arch/riscv/include/asm/pgtable.h |  2 +-
>>  arch/riscv/mm/init.c             | 58 ++++++++++++++------------------
>>  3 files changed, 29 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
>> index 60be458e94da..c09c3c79f496 100644
>> --- a/arch/riscv/include/asm/mmu.h
>> +++ b/arch/riscv/include/asm/mmu.h
>> @@ -28,8 +28,8 @@ typedef struct {
>>  #endif
>>  } mm_context_t;
>>
>> -void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t p=
a,
>> -                              phys_addr_t sz, pgprot_t prot);
>> +void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_=
t pa, phys_addr_t sz,
>> +                                 pgprot_t prot);
>>  #endif /* __ASSEMBLY__ */
>>
>>  #endif /* _ASM_RISCV_MMU_H */
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/p=
gtable.h
>> index 58fd7b70b903..7933f493db71 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -162,7 +162,7 @@ struct pt_alloc_ops {
>>  #endif
>>  };
>>
>> -extern struct pt_alloc_ops pt_ops __initdata;
>> +extern struct pt_alloc_ops pt_ops __meminitdata;
>>
>>  #ifdef CONFIG_MMU
>>  /* Number of PGD entries that a user-mode program can use */
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 5b8cdfafb52a..c969427eab88 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -295,7 +295,7 @@ static void __init setup_bootmem(void)
>>  }
>>
>>  #ifdef CONFIG_MMU
>> -struct pt_alloc_ops pt_ops __initdata;
>> +struct pt_alloc_ops pt_ops __meminitdata;
>>
>>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>> @@ -357,7 +357,7 @@ static inline pte_t *__init get_pte_virt_fixmap(phys=
_addr_t pa)
>>         return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
>>  }
>>
>> -static inline pte_t *__init get_pte_virt_late(phys_addr_t pa)
>> +static inline pte_t *__meminit get_pte_virt_late(phys_addr_t pa)
>>  {
>>         return (pte_t *) __va(pa);
>>  }
>> @@ -376,7 +376,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(ui=
ntptr_t va)
>>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>>  }
>>
>> -static phys_addr_t __init alloc_pte_late(uintptr_t va)
>> +static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
>>  {
>>         struct ptdesc *ptdesc =3D pagetable_alloc(GFP_KERNEL & ~__GFP_HI=
GHMEM, 0);
>>
>> @@ -384,9 +384,8 @@ static phys_addr_t __init alloc_pte_late(uintptr_t v=
a)
>>         return __pa((pte_t *)ptdesc_address(ptdesc));
>>  }
>>
>> -static void __init create_pte_mapping(pte_t *ptep,
>> -                                     uintptr_t va, phys_addr_t pa,
>> -                                     phys_addr_t sz, pgprot_t prot)
>> +static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phy=
s_addr_t pa, phys_addr_t sz,
>> +                                        pgprot_t prot)
>>  {
>>         uintptr_t pte_idx =3D pte_index(va);
>>
>> @@ -440,7 +439,7 @@ static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t=
 pa)
>>         return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
>>  }
>>
>> -static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
>> +static pmd_t *__meminit get_pmd_virt_late(phys_addr_t pa)
>>  {
>>         return (pmd_t *) __va(pa);
>>  }
>> @@ -457,7 +456,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t=
 va)
>>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>>  }
>>
>> -static phys_addr_t __init alloc_pmd_late(uintptr_t va)
>> +static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
>>  {
>>         struct ptdesc *ptdesc =3D pagetable_alloc(GFP_KERNEL & ~__GFP_HI=
GHMEM, 0);
>>
>> @@ -465,9 +464,9 @@ static phys_addr_t __init alloc_pmd_late(uintptr_t v=
a)
>>         return __pa((pmd_t *)ptdesc_address(ptdesc));
>>  }
>>
>> -static void __init create_pmd_mapping(pmd_t *pmdp,
>> -                                     uintptr_t va, phys_addr_t pa,
>> -                                     phys_addr_t sz, pgprot_t prot)
>> +static void __meminit create_pmd_mapping(pmd_t *pmdp,
>> +                                        uintptr_t va, phys_addr_t pa,
>> +                                        phys_addr_t sz, pgprot_t prot)
>>  {
>>         pte_t *ptep;
>>         phys_addr_t pte_phys;
>> @@ -503,7 +502,7 @@ static pud_t *__init get_pud_virt_fixmap(phys_addr_t=
 pa)
>>         return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
>>  }
>>
>> -static pud_t *__init get_pud_virt_late(phys_addr_t pa)
>> +static pud_t *__meminit get_pud_virt_late(phys_addr_t pa)
>>  {
>>         return (pud_t *)__va(pa);
>>  }
>> @@ -521,7 +520,7 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t=
 va)
>>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>>  }
>>
>> -static phys_addr_t alloc_pud_late(uintptr_t va)
>> +static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
>>  {
>>         unsigned long vaddr;
>>
>> @@ -541,7 +540,7 @@ static p4d_t *__init get_p4d_virt_fixmap(phys_addr_t=
 pa)
>>         return (p4d_t *)set_fixmap_offset(FIX_P4D, pa);
>>  }
>>
>> -static p4d_t *__init get_p4d_virt_late(phys_addr_t pa)
>> +static p4d_t *__meminit get_p4d_virt_late(phys_addr_t pa)
>>  {
>>         return (p4d_t *)__va(pa);
>>  }
>> @@ -559,7 +558,7 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t=
 va)
>>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>>  }
>>
>> -static phys_addr_t alloc_p4d_late(uintptr_t va)
>> +static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
>>  {
>>         unsigned long vaddr;
>>
>> @@ -568,9 +567,8 @@ static phys_addr_t alloc_p4d_late(uintptr_t va)
>>         return __pa(vaddr);
>>  }
>>
>> -static void __init create_pud_mapping(pud_t *pudp,
>> -                                     uintptr_t va, phys_addr_t pa,
>> -                                     phys_addr_t sz, pgprot_t prot)
>> +static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phy=
s_addr_t pa, phys_addr_t sz,
>> +                                        pgprot_t prot)
>>  {
>>         pmd_t *nextp;
>>         phys_addr_t next_phys;
>> @@ -595,9 +593,8 @@ static void __init create_pud_mapping(pud_t *pudp,
>>         create_pmd_mapping(nextp, va, pa, sz, prot);
>>  }
>>
>> -static void __init create_p4d_mapping(p4d_t *p4dp,
>> -                                     uintptr_t va, phys_addr_t pa,
>> -                                     phys_addr_t sz, pgprot_t prot)
>> +static void __meminit create_p4d_mapping(p4d_t *p4dp, uintptr_t va, phy=
s_addr_t pa, phys_addr_t sz,
>> +                                        pgprot_t prot)
>>  {
>>         pud_t *nextp;
>>         phys_addr_t next_phys;
>> @@ -653,9 +650,8 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
>>  #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot) do {} whil=
e(0)
>>  #endif /* __PAGETABLE_PMD_FOLDED */
>>
>> -void __init create_pgd_mapping(pgd_t *pgdp,
>> -                                     uintptr_t va, phys_addr_t pa,
>> -                                     phys_addr_t sz, pgprot_t prot)
>> +void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_=
t pa, phys_addr_t sz,
>> +                                 pgprot_t prot)
>>  {
>>         pgd_next_t *nextp;
>>         phys_addr_t next_phys;
>> @@ -680,8 +676,7 @@ void __init create_pgd_mapping(pgd_t *pgdp,
>>         create_pgd_next_mapping(nextp, va, pa, sz, prot);
>>  }
>>
>> -static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
>> -                                     phys_addr_t size)
>> +static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, =
phys_addr_t size)
>>  {
>>         if (pgtable_l5_enabled &&
>>             !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >=
=3D P4D_SIZE)
>> @@ -714,7 +709,7 @@ asmlinkage void __init __copy_data(void)
>>  #endif
>>
>>  #ifdef CONFIG_STRICT_KERNEL_RWX
>> -static __init pgprot_t pgprot_from_va(uintptr_t va)
>> +static __meminit pgprot_t pgprot_from_va(uintptr_t va)
>>  {
>>         if (is_va_kernel_text(va))
>>                 return PAGE_KERNEL_READ_EXEC;
>> @@ -739,7 +734,7 @@ void mark_rodata_ro(void)
>>                                   set_memory_ro);
>>  }
>>  #else
>> -static __init pgprot_t pgprot_from_va(uintptr_t va)
>> +static __meminit pgprot_t pgprot_from_va(uintptr_t va)
>>  {
>>         if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
>>                 return PAGE_KERNEL;
>> @@ -1231,9 +1226,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>         pt_ops_set_fixmap();
>>  }
>>
>> -static void __init create_linear_mapping_range(phys_addr_t start,
>> -                                              phys_addr_t end,
>> -                                              uintptr_t fixed_map_size)
>> +static void __meminit create_linear_mapping_range(phys_addr_t start, ph=
ys_addr_t end,
>> +                                                 uintptr_t fixed_map_si=
ze)
>>  {
>>         phys_addr_t pa;
>>         uintptr_t va, map_size;
>> @@ -1435,7 +1429,7 @@ int __meminit vmemmap_populate(unsigned long start=
, unsigned long end, int node,
>>          * memory hotplug, we are not able to update all the page tables=
 with
>>          * the new PMDs.
>>          */
>> -       return vmemmap_populate_hugepages(start, end, node, NULL);
>> +       return vmemmap_populate_hugepages(start, end, node, altmap);
>
> Is this a fix? Does this deserve to be split into another patch then?

It's enablement. The altmap can't be used unless there's ZONE_DEVICE
support AFAIU.


Bj=C3=B6rn
