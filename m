Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83D80020
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301134; cv=none; b=ZNifz4HVxbd41lTTUkhMksBq2fN+L/bqwii+yfkQKqXRBKPvHgtc4fYdR1xBENxF3TJwyfJreok+0lWJHAeAZiuuIRgfgf+WWrmUqykORh1M3ggJrRZ9jwcCTUCWwi3yvq9CmDjIYQQbzpFYi8ratlpYoESWTIurS7VA7CiMwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301134; c=relaxed/simple;
	bh=tP7EG5a9H+6WQUK7/ZhP8N575ilx5NZpoxhPWsiIALA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umT4OW6pJ1naButPIqbrMrITn0dPlDVYIMx2pkOh7Lv8lzTamAW/Hejk0CWiExju/Su31OqAU9wztHt1eZx3IbMIDdhD4eFSmixbq29WtzYLQBgeRE4ONFZRSUDKrTvWTnJ0JOqU6rGprS6p+OtF/EtvMQFhzqFTn4qOLaCGTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh39Fdl1; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh39Fdl1"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C796A401B0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WoF-alr5-cxA for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 14:18:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 55B464012F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55B464012F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Dh39Fdl1
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55B464012F
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 14:18:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D801E62243;
	Tue, 21 May 2024 14:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203FCC2BD11;
	Tue, 21 May 2024 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301129;
	bh=tP7EG5a9H+6WQUK7/ZhP8N575ilx5NZpoxhPWsiIALA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Dh39Fdl1R6PctLN2xxAMhZZmzV1xeFmZv6jfhquWSpe6BUz1Unxn7w6GJWpQE6MXU
	 aQdXjmZeX0PRXfyv2mZj6vl5wivtAjUy7mfT7qUG5ycsi+/mVwUcN4s8MUCXn0teyi
	 vxI/lJtbRV1dZMsEQq+u++F3tNHEIumzcHrwC//+l/xX7P2O4p+vrDoIlUUpta01S+
	 CVaKDR1e8ozil0gg1jHkc4TZ2ji/jntKWe7atmY/hLZw8BfwTZCm9Mu+wVSqQ6Hc+3
	 GSUI+sIVyZhZ/iEd992Sfc+zUnalUN0RU0DS1VXc6443jCOyCX/9xJls8NlPp5EmYQ
	 9Ma41oadmcpYA==
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
Subject: Re: [PATCH v3 5/9] riscv: mm: Add memory hotplugging support
In-Reply-To: <CAHVXubi_yQ6L5g4dODoHMNvgO6kHy8i6YskRXSPoTU4N2P8rUA@mail.gmail.com>
References: <20240521114830.841660-1-bjorn@kernel.org>
 <20240521114830.841660-6-bjorn@kernel.org>
 <CAHVXubi_yQ6L5g4dODoHMNvgO6kHy8i6YskRXSPoTU4N2P8rUA@mail.gmail.com>
Date: Tue, 21 May 2024 16:18:46 +0200
Message-ID: <87jzjndz95.fsf@all.your.base.are.belong.to.us>
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
>> For an architecture to support memory hotplugging, a couple of
>> callbacks needs to be implemented:
>>
>>  arch_add_memory()
>>   This callback is responsible for adding the physical memory into the
>>   direct map, and call into the memory hotplugging generic code via
>>   __add_pages() that adds the corresponding struct page entries, and
>>   updates the vmemmap mapping.
>>
>>  arch_remove_memory()
>>   This is the inverse of the callback above.
>>
>>  vmemmap_free()
>>   This function tears down the vmemmap mappings (if
>>   CONFIG_SPARSEMEM_VMEMMAP is enabled), and also deallocates the
>>   backing vmemmap pages. Note that for persistent memory, an
>>   alternative allocator for the backing pages can be used; The
>>   vmem_altmap. This means that when the backing pages are cleared,
>>   extra care is needed so that the correct deallocation method is
>>   used.
>>
>>  arch_get_mappable_range()
>>   This functions returns the PA range that the direct map can map.
>>   Used by the MHP internals for sanity checks.
>>
>> The page table unmap/teardown functions are heavily based on code from
>> the x86 tree. The same remove_pgd_mapping() function is used in both
>> vmemmap_free() and arch_remove_memory(), but in the latter function
>> the backing pages are not removed.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/mm/init.c | 261 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 261 insertions(+)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 6f72b0b2b854..6693b742bf2f 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1493,3 +1493,264 @@ void __init pgtable_cache_init(void)
>>         }
>>  }
>>  #endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static void __meminit free_pagetable(struct page *page, int order)
>> +{
>> +       unsigned int nr_pages =3D 1 << order;
>> +
>> +       /*
>> +        * vmemmap/direct page tables can be reserved, if added at
>> +        * boot.
>> +        */
>> +       if (PageReserved(page)) {
>> +               __ClearPageReserved(page);
>
> What's the difference between __ClearPageReserved() and
> ClearPageReserved()? Because it seems like free_reserved_page() calls
> the latter already, so why would you need to call
> __ClearPageReserved() on the first page?

Indeed! x86 copy pasta (which uses bootmem info page that RV doesn't).

>> +               while (nr_pages--)
>> +                       free_reserved_page(page++);
>> +               return;
>> +       }
>> +
>> +       free_pages((unsigned long)page_address(page), order);
>> +}
>> +
>> +static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
>> +{
>> +       pte_t *pte;
>> +       int i;
>> +
>> +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
>> +               pte =3D pte_start + i;
>> +               if (!pte_none(*pte))
>> +                       return;
>> +       }
>> +
>> +       free_pagetable(pmd_page(*pmd), 0);
>> +       pmd_clear(pmd);
>> +}
>> +
>> +static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
>> +{
>> +       pmd_t *pmd;
>> +       int i;
>> +
>> +       for (i =3D 0; i < PTRS_PER_PMD; i++) {
>> +               pmd =3D pmd_start + i;
>> +               if (!pmd_none(*pmd))
>> +                       return;
>> +       }
>> +
>> +       free_pagetable(pud_page(*pud), 0);
>> +       pud_clear(pud);
>> +}
>> +
>> +static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
>> +{
>> +       pud_t *pud;
>> +       int i;
>> +
>> +       for (i =3D 0; i < PTRS_PER_PUD; i++) {
>> +               pud =3D pud_start + i;
>> +               if (!pud_none(*pud))
>> +                       return;
>> +       }
>> +
>> +       free_pagetable(p4d_page(*p4d), 0);
>> +       p4d_clear(p4d);
>> +}
>> +
>> +static void __meminit free_vmemmap_storage(struct page *page, size_t si=
ze,
>> +                                          struct vmem_altmap *altmap)
>> +{
>> +       if (altmap)
>> +               vmem_altmap_free(altmap, size >> PAGE_SHIFT);
>> +       else
>> +               free_pagetable(page, get_order(size));
>> +}
>> +
>> +static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long=
 addr, unsigned long end,
>> +                                        bool is_vmemmap, struct vmem_al=
tmap *altmap)
>> +{
>> +       unsigned long next;
>> +       pte_t *ptep, pte;
>> +
>> +       for (; addr < end; addr =3D next) {
>> +               next =3D (addr + PAGE_SIZE) & PAGE_MASK;
>
> Nit: use ALIGN() instead.
>
>> +               if (next > end)
>> +                       next =3D end;
>> +
>> +               ptep =3D pte_base + pte_index(addr);
>> +               pte =3D READ_ONCE(*ptep);
>
> Nit: Use ptep_get()
>
>> +
>> +               if (!pte_present(*ptep))
>> +                       continue;
>> +
>> +               pte_clear(&init_mm, addr, ptep);
>> +               if (is_vmemmap)
>> +                       free_vmemmap_storage(pte_page(pte), PAGE_SIZE, a=
ltmap);
>> +       }
>> +}
>> +
>> +static void __meminit remove_pmd_mapping(pmd_t *pmd_base, unsigned long=
 addr, unsigned long end,
>> +                                        bool is_vmemmap, struct vmem_al=
tmap *altmap)
>> +{
>> +       unsigned long next;
>> +       pte_t *pte_base;
>> +       pmd_t *pmdp, pmd;
>> +
>> +       for (; addr < end; addr =3D next) {
>> +               next =3D pmd_addr_end(addr, end);
>> +               pmdp =3D pmd_base + pmd_index(addr);
>> +               pmd =3D READ_ONCE(*pmdp);
>
> Nit: Use pmdp_get()
>
>> +
>> +               if (!pmd_present(pmd))
>> +                       continue;
>> +
>> +               if (pmd_leaf(pmd)) {
>> +                       pmd_clear(pmdp);
>> +                       if (is_vmemmap)
>> +                               free_vmemmap_storage(pmd_page(pmd), PMD_=
SIZE, altmap);
>> +                       continue;
>> +               }
>> +
>> +               pte_base =3D (pte_t *)pmd_page_vaddr(*pmdp);
>> +               remove_pte_mapping(pte_base, addr, next, is_vmemmap, alt=
map);
>> +               free_pte_table(pte_base, pmdp);
>> +       }
>> +}
>> +
>> +static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long=
 addr, unsigned long end,
>> +                                        bool is_vmemmap, struct vmem_al=
tmap *altmap)
>> +{
>> +       unsigned long next;
>> +       pud_t *pudp, pud;
>> +       pmd_t *pmd_base;
>> +
>> +       for (; addr < end; addr =3D next) {
>> +               next =3D pud_addr_end(addr, end);
>> +               pudp =3D pud_base + pud_index(addr);
>> +               pud =3D READ_ONCE(*pudp);
>
> Nit: Use pudp_get()
>
>> +
>> +               if (!pud_present(pud))
>> +                       continue;
>> +
>> +               if (pud_leaf(pud)) {
>> +                       if (pgtable_l4_enabled) {
>> +                               pud_clear(pudp);
>> +                               if (is_vmemmap)
>> +                                       free_vmemmap_storage(pud_page(pu=
d), PUD_SIZE, altmap);
>> +                       }
>> +                       continue;
>> +               }
>> +
>> +               pmd_base =3D pmd_offset(pudp, 0);
>> +               remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, alt=
map);
>> +
>> +               if (pgtable_l4_enabled)
>> +                       free_pmd_table(pmd_base, pudp);
>> +       }
>> +}
>> +
>> +static void __meminit remove_p4d_mapping(p4d_t *p4d_base, unsigned long=
 addr, unsigned long end,
>> +                                        bool is_vmemmap, struct vmem_al=
tmap *altmap)
>> +{
>> +       unsigned long next;
>> +       p4d_t *p4dp, p4d;
>> +       pud_t *pud_base;
>> +
>> +       for (; addr < end; addr =3D next) {
>> +               next =3D p4d_addr_end(addr, end);
>> +               p4dp =3D p4d_base + p4d_index(addr);
>> +               p4d =3D READ_ONCE(*p4dp);
>
> Nit: Use p4dp_get()

...and I'll make sure to address these nits as well.


Thanks!
Bj=C3=B6rn
