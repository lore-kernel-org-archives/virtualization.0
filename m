Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D9365
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704400; cv=none; b=S95Set6ZoQQaxmql8OWXdtSjdmeIFFghfujmJ1KpFvYzYptFkWz7lIhZcNBiYNWRg0Uy/Lhajgz9VqwfsRdB6sbfw6eSdprwtL2PSzUDCYQ3G3Z8aPyLeW/5rqqIB79goPTPfV5KZ4Gr5MZcYbXAy/V3YzOSdCOYH5jyR0F353s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704400; c=relaxed/simple;
	bh=2O3FVoVp95G4P4aUBtb5SLdBJuD22ckBazyVVu22ZDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OphAaiyMq2aGkeDZLte17PHaz9sPPT1uahoAUBHsifte7qXrOwEhQAx46MU+xr5LPzvKUvlBivm5M174QEiep+EEoGVi34Llq6Ghd2q1pk+FBv0AL33tOyG4skOY8qSnPmwMkLzoO0tA2qE3blVct/GG329z12OBL8h/w02qZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTI29hSi; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTI29hSi"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BDF94400F5
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 16:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TEwLZS7OgTqM for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 16:33:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 75829405B8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75829405B8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WTI29hSi
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75829405B8
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 16:33:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 80B22CE12A5;
	Tue, 14 May 2024 16:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F1BC2BD10;
	Tue, 14 May 2024 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715704392;
	bh=2O3FVoVp95G4P4aUBtb5SLdBJuD22ckBazyVVu22ZDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WTI29hSiyDCBZ/ISmRKtXANpO+MIhVZR4JWCVcJqN9/o+DiUQ5X0GEXAdrgRbrqyZ
	 b+wMqcBFG+zX/Kql95Loc0oVKFWI3aDu/VsJ6sUjSCyxr34W2VMnjPBg7uvGlV/hZf
	 58sTwPUhjQ7JMumSjb2rr2cwE1QWDF6sGQYy+c8i5MpLLEcO/yEfjel9AzUt4f9Ndw
	 iHHJc31d3f817J5K1WR8DjMU2QpBKILOiQ3F5iJ+kPtnSXMw28vI/Wyx4ymQyRvfsG
	 S0fOOCFPj7SWbYL/SpOwoFMZPh2UYXNv3uMEs0lkKg9UHfVRQRY8cPajbAQF84TznI
	 /HHuZ+HKrZCgw==
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
Subject: Re: [PATCH v2 1/8] riscv: mm: Pre-allocate vmemmap/direct map PGD
 entries
In-Reply-To: <CAHVXubhfsvDZrw_Cvg8AnEm00P0TQvrSOV_jVSBRckmJLp6EFQ@mail.gmail.com>
References: <20240514140446.538622-1-bjorn@kernel.org>
 <20240514140446.538622-2-bjorn@kernel.org>
 <CAHVXubhfsvDZrw_Cvg8AnEm00P0TQvrSOV_jVSBRckmJLp6EFQ@mail.gmail.com>
Date: Tue, 14 May 2024 18:33:09 +0200
Message-ID: <87wmnwtku2.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> Hi Bj=C3=B6rn,
>
> On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> The RISC-V port copies the PGD table from init_mm/swapper_pg_dir to
>> all userland page tables, which means that if the PGD level table is
>> changed, other page tables has to be updated as well.
>>
>> Instead of having the PGD changes ripple out to all tables, the
>> synchronization can be avoided by pre-allocating the PGD entries/pages
>> at boot, avoiding the synchronization all together.
>>
>> This is currently done for the bpf/modules, and vmalloc PGD regions.
>> Extend this scheme for the PGD regions touched by memory hotplugging.
>>
>> Prepare the RISC-V port for memory hotplug by pre-allocate
>> vmemmap/direct map entries at the PGD level. This will roughly waste
>> ~128 worth of 4K pages when memory hotplugging is enabled in the
>> kernel configuration.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/kasan.h | 4 ++--
>>  arch/riscv/mm/init.c           | 7 +++++++
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kas=
an.h
>> index 0b85e363e778..e6a0071bdb56 100644
>> --- a/arch/riscv/include/asm/kasan.h
>> +++ b/arch/riscv/include/asm/kasan.h
>> @@ -6,8 +6,6 @@
>>
>>  #ifndef __ASSEMBLY__
>>
>> -#ifdef CONFIG_KASAN
>> -
>>  /*
>>   * The following comment was copied from arm64:
>>   * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
>> @@ -34,6 +32,8 @@
>>   */
>>  #define KASAN_SHADOW_START     ((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) =
& PGDIR_MASK)
>>  #define KASAN_SHADOW_END       MODULES_LOWEST_VADDR
>> +
>> +#ifdef CONFIG_KASAN
>>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>>
>>  void kasan_init(void);
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 2574f6a3b0e7..5b8cdfafb52a 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -27,6 +27,7 @@
>>
>>  #include <asm/fixmap.h>
>>  #include <asm/io.h>
>> +#include <asm/kasan.h>
>>  #include <asm/numa.h>
>>  #include <asm/pgtable.h>
>>  #include <asm/sections.h>
>> @@ -1488,10 +1489,16 @@ static void __init preallocate_pgd_pages_range(u=
nsigned long start, unsigned lon
>>         panic("Failed to pre-allocate %s pages for %s area\n", lvl, area=
);
>>  }
>>
>> +#define PAGE_END KASAN_SHADOW_START
>> +
>>  void __init pgtable_cache_init(void)
>>  {
>>         preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc=
");
>>         if (IS_ENABLED(CONFIG_MODULES))
>>                 preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, =
"bpf/modules");
>> +       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
>> +               preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, =
"vmemmap");
>> +               preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "dire=
ct map");
>> +       }
>>  }
>>  #endif
>> --
>> 2.40.1
>>
>
> As you asked, with
> https://lore.kernel.org/linux-riscv/20240514133614.87813-1-alexghiti@rivo=
sinc.com/T/#u,
> you will be able to remove the usage of KASAN_SHADOW_START.

Very nice -- consistency! I'll need to respin, so I'll clean this up for
the next version.

> But anyhow, you can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>


Thank you!
Bj=C3=B6rn
