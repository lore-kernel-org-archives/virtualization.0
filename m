Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7280024
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300846; cv=none; b=JMu0gHlbOL4ntdPAyv3/qun9gzIF9oeROme8PfkkHwg+hx6hkEesaXyhn26B+NYVb6tku1WYyFTzwOCXU2srRIhRXa7fWVIhEydhhWoC4aJf7B6qXQmPX3Id5CXnS8z7f971mmu+PdA28b5phFqHcfVStQgCrC0LbVxu7o3WWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300846; c=relaxed/simple;
	bh=IfBzG6Jslwq80j1PaUKC/nbk7dw2f5dLPW+Dn8TzDk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IS65q4YOiWiPoEC0ahiHhbHJyV/aw2tEBmwbfSFY+3ULPrCxBe9CFfEutKskVO49sILN5v7FM+pXbAaZeG882uM929y6Qr/uvdRlqbWPtZ4YklEkYnBt6lELadey4hXP7hLvf+8aq2TiI/ikLbNklwSomB1OEuRnNwVijt5WH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDdLV31M; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDdLV31M"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F010A40B7B
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lGJnasv_GptC for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 14:14:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CAD4E40B2D
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAD4E40B2D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rDdLV31M
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAD4E40B2D
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:14:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 42794CE0F93;
	Tue, 21 May 2024 14:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09770C2BD11;
	Tue, 21 May 2024 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300840;
	bh=IfBzG6Jslwq80j1PaUKC/nbk7dw2f5dLPW+Dn8TzDk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rDdLV31M/Rnssi32k8I78G80H12gj4bfX7j9DaXPEN1aX9BUsimWeZ3+kOnXz4pfR
	 KQthzpqNHet08+kfxxXHnZeMmeKBMbvK1UQpJukKPcYVOKTUE6xasKg+9d3p8/MaAh
	 qqcoqfuEt0DTPChsVyUvpCpLlnZBSWbAFQKsLWtXGaYOopGv5mnPuPiULVt90bwASL
	 8y0h+7Ann3k0lAFjAhqmVCAcWb879VbULQ0qQ2LqMezYPJIwWtlCSEw+3Ify3QQ1Lh
	 nDZjCDP/b3nGxujpdhnSLcI/76WZC0/20AtQ3lCE5861wlb213399eLa/lrT0ly4Lb
	 Q9qh9GAbQp5rQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, Oscar
 Salvador <osalvador@suse.de>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andrew
 Bresticker <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 9/9] riscv: mm: Add support for ZONE_DEVICE
In-Reply-To: <CAHVXubirHPj1pZhU7sFxFTzBWz_Psf5uts9y3Dji-a03nb=_iw@mail.gmail.com>
References: <20240521114830.841660-1-bjorn@kernel.org>
 <20240521114830.841660-10-bjorn@kernel.org>
 <CAHVXubirHPj1pZhU7sFxFTzBWz_Psf5uts9y3Dji-a03nb=_iw@mail.gmail.com>
Date: Tue, 21 May 2024 16:13:57 +0200
Message-ID: <87pltfdzh6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> On Tue, May 21, 2024 at 1:49=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> ZONE_DEVICE pages need DEVMAP PTEs support to function
>> (ARCH_HAS_PTE_DEVMAP). Claim another RSW (reserved for software) bit
>> in the PTE for DEVMAP mark, add the corresponding helpers, and enable
>> ARCH_HAS_PTE_DEVMAP for riscv64.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/Kconfig                    |  1 +
>>  arch/riscv/include/asm/pgtable-64.h   | 20 ++++++++++++++++++++
>>  arch/riscv/include/asm/pgtable-bits.h |  1 +
>>  arch/riscv/include/asm/pgtable.h      | 17 +++++++++++++++++
>>  4 files changed, 39 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 2724dc2af29f..0b74698c63c7 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -36,6 +36,7 @@ config RISCV
>>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>         select ARCH_HAS_PMEM_API
>>         select ARCH_HAS_PREPARE_SYNC_CORE_CMD
>> +       select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>>         select ARCH_HAS_PTE_SPECIAL
>>         select ARCH_HAS_SET_DIRECT_MAP if MMU
>>         select ARCH_HAS_SET_MEMORY if MMU
>> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/as=
m/pgtable-64.h
>> index 221a5c1ee287..c67a9bbfd010 100644
>> --- a/arch/riscv/include/asm/pgtable-64.h
>> +++ b/arch/riscv/include/asm/pgtable-64.h
>> @@ -400,4 +400,24 @@ static inline struct page *pgd_page(pgd_t pgd)
>>  #define p4d_offset p4d_offset
>>  p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
>>
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static inline int pte_devmap(pte_t pte);
>> +static inline pte_t pmd_pte(pmd_t pmd);
>> +
>> +static inline int pmd_devmap(pmd_t pmd)
>> +{
>> +       return pte_devmap(pmd_pte(pmd));
>> +}
>> +
>> +static inline int pud_devmap(pud_t pud)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline int pgd_devmap(pgd_t pgd)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
>>  #endif /* _ASM_RISCV_PGTABLE_64_H */
>> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/=
asm/pgtable-bits.h
>> index 179bd4afece4..a8f5205cea54 100644
>> --- a/arch/riscv/include/asm/pgtable-bits.h
>> +++ b/arch/riscv/include/asm/pgtable-bits.h
>> @@ -19,6 +19,7 @@
>>  #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
>>
>>  #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
>> +#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
>>  #define _PAGE_TABLE     _PAGE_PRESENT
>>
>>  /*
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/p=
gtable.h
>> index 7933f493db71..02fadc276064 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -387,6 +387,13 @@ static inline int pte_special(pte_t pte)
>>         return pte_val(pte) & _PAGE_SPECIAL;
>>  }
>>
>> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
>> +static inline int pte_devmap(pte_t pte)
>> +{
>> +       return pte_val(pte) & _PAGE_DEVMAP;
>> +}
>> +#endif
>
> Not sure you need the #ifdef here.

W/o it 32b builds break (!defined(CONFIG_ARCH_HAS_PTE_DEVMAP) will have
a default implementation).. Maybe it's cleaner just to use that instead?

>> +
>>  /* static inline pte_t pte_rdprotect(pte_t pte) */
>>
>>  static inline pte_t pte_wrprotect(pte_t pte)
>> @@ -428,6 +435,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
>>         return __pte(pte_val(pte) | _PAGE_SPECIAL);
>>  }
>>
>> +static inline pte_t pte_mkdevmap(pte_t pte)
>> +{
>> +       return __pte(pte_val(pte) | _PAGE_DEVMAP);
>> +}
>> +
>>  static inline pte_t pte_mkhuge(pte_t pte)
>>  {
>>         return pte;
>> @@ -711,6 +723,11 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
>>         return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
>>  }
>>
>> +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>> +{
>> +       return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
>> +}
>> +
>>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>                                 pmd_t *pmdp, pmd_t pmd)
>>  {
>> --
>> 2.40.1
>>
>
> Otherwise, you can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thank you!


Bj=C3=B6rn
