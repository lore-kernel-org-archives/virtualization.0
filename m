Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C97581F
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294950; cv=none; b=ZEzS72f9fCdh5TVr1W4Fesx8RlxKe1aYvFMLVeUZ/vNfsfY0wzBtUbA6JSSZ8k7Fnf4/4Uu9QVip6t0BzlnHlWiw5g6f+jAfzRVplK2qkyoRStsanGMVRY7J3SVBCvZezQl83/Jg0240rkAUf37vUHvIcKyLg+92xnlIrMHPf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294950; c=relaxed/simple;
	bh=7zabcxtWOV9roTYwMOUwyvCTAijI6gl/R8UqQpEX8Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B213IS1FTn2UDLu4YE5G0beXIFm+edRgywB000U1gXe9Ns+tI5YdLhN0DYgXW+RlU2i4JjCIcveohiImXqpua0N03/IUyWlRTWv6ffeAVf2P/hs8h0qZZeUpTV6bgKfaX9CMJR9uWOZTK1ZtE66tmKV933/101P9i1XNm5trJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JZiNRISQ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JZiNRISQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5EE240426
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 12:35:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvlxNP4ES20F for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 12:35:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4114A40179
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4114A40179
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=JZiNRISQ
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4114A40179
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 12:35:47 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a59b81d087aso799064866b.3
        for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716294945; x=1716899745; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WWapkkThh/Y99F52WW+zEVSnw2Q3pRRIZyBMEsctj8=;
        b=JZiNRISQZCQLeX3w3mdt9QQWhsnG2Ih8yT2hgXosuZcA94nI4kJzN8Lt2BjCtIyK7/
         g5/vk9cfPiQWu+gHxuxNB7hD8A2a2pPHryPiL0pXCm9Pq5v2RBI91hrh59uFqnBFmyOT
         QGGYRSQMrq6ATT1ZKwIHlBMyi0KVZSua3EYttOyI619WoF9eRaPaBXjMamqt3sw/En3G
         UKbY10UgbTabKDtw1SF6Tmn4QCKn9oKYvTJ/j2uuputL/z+T2Uj/N6cte0azWrtRizKr
         O7at+P8cXh8puvgGxV8LXPK8ikYaW84ZLLzJD8tZfqMW9FvsDOXRXTBMyGyoi8nxn+Sj
         OkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294945; x=1716899745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WWapkkThh/Y99F52WW+zEVSnw2Q3pRRIZyBMEsctj8=;
        b=jYtmpaVdjUXtPJ3pzcobCancGaeiXUG9X1QJMjiHqyuJhPfok4/tYR7UodZJ9QBxfy
         Qzk5PK5l34HSwHgiVh2R/Coc/ddvgz4J/6vrPBdW9wkm6v43Ulw12gLe5vFQB3Np9zN6
         j1aA7DgHhfXDN3we63F32SBwBMPEOUrcxkrKpKJliYADWJ05LP05+ceamw9BxB8bXnND
         Zy5IeTLDubXjz0iGEHc2Gvr3SqAbsgx0P+gXmcCHd0joWdmOp9ZJWggDu5yFyai7lmVt
         aPEyjzUO3aZTPmCPtwulWebEymDBiVFnoZvlpGGfL3U6zGHxeoDWRavrZtVr354RhKtr
         DABA==
X-Forwarded-Encrypted: i=1; AJvYcCUNCDG7NZAGKqQsS1Ptu4ld62sM5bYUIHklZGKxK7DQvcZ1yzonlXvJoKqS5ZMEHuGmu6Z3TTmwIm8e0hzOwSKFCL7BX9XVI/9RdMaKZFYOfch0VpnvpodYyA==
X-Gm-Message-State: AOJu0Yy8tqo4TBffit6viqB45ITodkXaZ5tsSbyKVhPyK4mDYQ7R5aIL
	MLddut3AWkN91KtRc1kzyzbORFfcBqg9H4KtWXtQSEItgeKdKtnxosT05efXtAhgZgG/pZiuRiu
	8LCIBx9ZDaL3O+Fvokog37ulMlp/jpBPOCqPtFw==
X-Google-Smtp-Source: AGHT+IEAnwtcawhGsvoiDU5egcp+8BWpo/0gaVCuP0mcubsH7FN3B4W2sdAU3nQcpY7za33qaVUAyqjvbYRuIWmtcsE=
X-Received: by 2002:a17:907:2d13:b0:a59:c577:c5c3 with SMTP id
 a640c23a62f3a-a5a2d57a48emr3475611566b.29.1716294945079; Tue, 21 May 2024
 05:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-4-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-4-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 14:35:34 +0200
Message-ID: <CAHVXubiQ9jg1knGokXfFxbRtapxKg8LqXJB0D2MRR5QifSZFBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] riscv: mm: Change attribute from __init to
 __meminit for page functions
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

On Tue, May 21, 2024 at 1:48=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Prepare for memory hotplugging support by changing from __init to
> __meminit for the page table functions that are used by the upcoming
> architecture specific callbacks.
>
> Changing the __init attribute to __meminit, avoids that the functions
> are removed after init. The __meminit attribute makes sure the
> functions are kept in the kernel text post init, but only if memory
> hotplugging is enabled for the build.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/include/asm/mmu.h     |  4 +--
>  arch/riscv/include/asm/pgtable.h |  2 +-
>  arch/riscv/mm/init.c             | 56 ++++++++++++++------------------
>  3 files changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index 947fd60f9051..c9e03e9da3dc 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -31,8 +31,8 @@ typedef struct {
>  #define cntx2asid(cntx)                ((cntx) & SATP_ASID_MASK)
>  #define cntx2version(cntx)     ((cntx) & ~SATP_ASID_MASK)
>
> -void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa=
,
> -                              phys_addr_t sz, pgprot_t prot);
> +void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t=
 pa, phys_addr_t sz,
> +                                 pgprot_t prot);
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_MMU_H */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 58fd7b70b903..7933f493db71 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -162,7 +162,7 @@ struct pt_alloc_ops {
>  #endif
>  };
>
> -extern struct pt_alloc_ops pt_ops __initdata;
> +extern struct pt_alloc_ops pt_ops __meminitdata;
>
>  #ifdef CONFIG_MMU
>  /* Number of PGD entries that a user-mode program can use */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c98010ede810..c969427eab88 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -295,7 +295,7 @@ static void __init setup_bootmem(void)
>  }
>
>  #ifdef CONFIG_MMU
> -struct pt_alloc_ops pt_ops __initdata;
> +struct pt_alloc_ops pt_ops __meminitdata;
>
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> @@ -357,7 +357,7 @@ static inline pte_t *__init get_pte_virt_fixmap(phys_=
addr_t pa)
>         return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
>  }
>
> -static inline pte_t *__init get_pte_virt_late(phys_addr_t pa)
> +static inline pte_t *__meminit get_pte_virt_late(phys_addr_t pa)
>  {
>         return (pte_t *) __va(pa);
>  }
> @@ -376,7 +376,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(uin=
tptr_t va)
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> -static phys_addr_t __init alloc_pte_late(uintptr_t va)
> +static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
>  {
>         struct ptdesc *ptdesc =3D pagetable_alloc(GFP_KERNEL & ~__GFP_HIG=
HMEM, 0);
>
> @@ -384,9 +384,8 @@ static phys_addr_t __init alloc_pte_late(uintptr_t va=
)
>         return __pa((pte_t *)ptdesc_address(ptdesc));
>  }
>
> -static void __init create_pte_mapping(pte_t *ptep,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phys=
_addr_t pa, phys_addr_t sz,
> +                                        pgprot_t prot)
>  {
>         uintptr_t pte_idx =3D pte_index(va);
>
> @@ -440,7 +439,7 @@ static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t =
pa)
>         return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
>  }
>
> -static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
> +static pmd_t *__meminit get_pmd_virt_late(phys_addr_t pa)
>  {
>         return (pmd_t *) __va(pa);
>  }
> @@ -457,7 +456,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t =
va)
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> -static phys_addr_t __init alloc_pmd_late(uintptr_t va)
> +static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
>  {
>         struct ptdesc *ptdesc =3D pagetable_alloc(GFP_KERNEL & ~__GFP_HIG=
HMEM, 0);
>
> @@ -465,9 +464,9 @@ static phys_addr_t __init alloc_pmd_late(uintptr_t va=
)
>         return __pa((pmd_t *)ptdesc_address(ptdesc));
>  }
>
> -static void __init create_pmd_mapping(pmd_t *pmdp,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +static void __meminit create_pmd_mapping(pmd_t *pmdp,
> +                                        uintptr_t va, phys_addr_t pa,
> +                                        phys_addr_t sz, pgprot_t prot)
>  {
>         pte_t *ptep;
>         phys_addr_t pte_phys;
> @@ -503,7 +502,7 @@ static pud_t *__init get_pud_virt_fixmap(phys_addr_t =
pa)
>         return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
>  }
>
> -static pud_t *__init get_pud_virt_late(phys_addr_t pa)
> +static pud_t *__meminit get_pud_virt_late(phys_addr_t pa)
>  {
>         return (pud_t *)__va(pa);
>  }
> @@ -521,7 +520,7 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t =
va)
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> -static phys_addr_t alloc_pud_late(uintptr_t va)
> +static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
>  {
>         unsigned long vaddr;
>
> @@ -541,7 +540,7 @@ static p4d_t *__init get_p4d_virt_fixmap(phys_addr_t =
pa)
>         return (p4d_t *)set_fixmap_offset(FIX_P4D, pa);
>  }
>
> -static p4d_t *__init get_p4d_virt_late(phys_addr_t pa)
> +static p4d_t *__meminit get_p4d_virt_late(phys_addr_t pa)
>  {
>         return (p4d_t *)__va(pa);
>  }
> @@ -559,7 +558,7 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t =
va)
>         return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>  }
>
> -static phys_addr_t alloc_p4d_late(uintptr_t va)
> +static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
>  {
>         unsigned long vaddr;
>
> @@ -568,9 +567,8 @@ static phys_addr_t alloc_p4d_late(uintptr_t va)
>         return __pa(vaddr);
>  }
>
> -static void __init create_pud_mapping(pud_t *pudp,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys=
_addr_t pa, phys_addr_t sz,
> +                                        pgprot_t prot)
>  {
>         pmd_t *nextp;
>         phys_addr_t next_phys;
> @@ -595,9 +593,8 @@ static void __init create_pud_mapping(pud_t *pudp,
>         create_pmd_mapping(nextp, va, pa, sz, prot);
>  }
>
> -static void __init create_p4d_mapping(p4d_t *p4dp,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +static void __meminit create_p4d_mapping(p4d_t *p4dp, uintptr_t va, phys=
_addr_t pa, phys_addr_t sz,
> +                                        pgprot_t prot)
>  {
>         pud_t *nextp;
>         phys_addr_t next_phys;
> @@ -653,9 +650,8 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
>  #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while=
(0)
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
> -void __init create_pgd_mapping(pgd_t *pgdp,
> -                                     uintptr_t va, phys_addr_t pa,
> -                                     phys_addr_t sz, pgprot_t prot)
> +void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t=
 pa, phys_addr_t sz,
> +                                 pgprot_t prot)
>  {
>         pgd_next_t *nextp;
>         phys_addr_t next_phys;
> @@ -680,8 +676,7 @@ void __init create_pgd_mapping(pgd_t *pgdp,
>         create_pgd_next_mapping(nextp, va, pa, sz, prot);
>  }
>
> -static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
> -                                     phys_addr_t size)
> +static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, p=
hys_addr_t size)
>  {
>         if (pgtable_l5_enabled &&
>             !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >=3D=
 P4D_SIZE)
> @@ -714,7 +709,7 @@ asmlinkage void __init __copy_data(void)
>  #endif
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -static __init pgprot_t pgprot_from_va(uintptr_t va)
> +static __meminit pgprot_t pgprot_from_va(uintptr_t va)
>  {
>         if (is_va_kernel_text(va))
>                 return PAGE_KERNEL_READ_EXEC;
> @@ -739,7 +734,7 @@ void mark_rodata_ro(void)
>                                   set_memory_ro);
>  }
>  #else
> -static __init pgprot_t pgprot_from_va(uintptr_t va)
> +static __meminit pgprot_t pgprot_from_va(uintptr_t va)
>  {
>         if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
>                 return PAGE_KERNEL;
> @@ -1231,9 +1226,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         pt_ops_set_fixmap();
>  }
>
> -static void __init create_linear_mapping_range(phys_addr_t start,
> -                                              phys_addr_t end,
> -                                              uintptr_t fixed_map_size)
> +static void __meminit create_linear_mapping_range(phys_addr_t start, phy=
s_addr_t end,
> +                                                 uintptr_t fixed_map_siz=
e)
>  {
>         phys_addr_t pa;
>         uintptr_t va, map_size;
> --
> 2.40.1
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
