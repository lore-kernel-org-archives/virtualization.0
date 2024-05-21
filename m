Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED356208D0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307773; cv=none; b=FnhbrVY2vfZ+u3iy7heRNPn+kSa0YhdD2bJAZDIWT6pyqUYs8qjoV13vQq3DOr+XKnAv0r01POp5LWGDMlFydTReP0xUE3WBahCyVeDIij3pwGF23lpTEmLRhtHp4T3O8GQo5KVNz016Vj5X/8JDbhx8UqK1kDeVry0arum+NyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307773; c=relaxed/simple;
	bh=RkSBxB1mPmJZ/DR8Fr08TnX1zxdKqejkPexNssbR7dQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jvo/srwa/IZUmB8FbUnzfAf4NlcXqPW4IL7ys7a4VXzm+ANKKlN8jkd78wFj9RJa+pjDDICF8uk8QS1xbynAuPqjGzRZT453ZvbLK9xLFNWgg0MEQJ0W0dyUExHStYf5Z0b4pCWN3TQXl+SC9/oq8GkhqH4QNaQqcGXYyzLUC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCo9ASI2; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCo9ASI2"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A198D607AD
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 16:09:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-vMTy5sSynQ for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 16:09:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E34DE6074E
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E34DE6074E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YCo9ASI2
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E34DE6074E
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 16:09:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A8CA861BFE;
	Tue, 21 May 2024 16:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E5AC2BD11;
	Tue, 21 May 2024 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716307769;
	bh=RkSBxB1mPmJZ/DR8Fr08TnX1zxdKqejkPexNssbR7dQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YCo9ASI2Js2y0lYzH+ndmKVe0VBlFTGkycxT7Zujt14aad9AwhyXNS7KaKggq6hOZ
	 CjqBuMvBipIHRI0dSeAnRaGdIWq9dw+lco9sDto8ytsjwHOsLdjahwZxFEMUyF2PJo
	 rsSN3ldZuKLPl165ORt4ogze7omXIAaPwrKrmNWACeG75cOkrx5NAC189ciVuC4xpg
	 Dh8KVRkGsbWFABrokxiEiOf/Gc1ifElhhLSV1S7Fye8UgqFZ5Ir1yPlX4Yr65gHiyY
	 28FCxQDb2DcdZ6d5HsyVkKt/PaQmniprxTRaBhweDbGOnULeN9u2tGzvd6gEdrMkEp
	 /B4suKzHDu8yg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Albert Ou
 <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Andrew Bresticker
 <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/9] riscv: mm: Pre-allocate vmemmap/direct map PGD
 entries
In-Reply-To: <20240521114830.841660-3-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
 <20240521114830.841660-3-bjorn@kernel.org>
Date: Tue, 21 May 2024 18:09:25 +0200
Message-ID: <87frubdu4q.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The RISC-V port copies the PGD table from init_mm/swapper_pg_dir to
> all userland page tables, which means that if the PGD level table is
> changed, other page tables has to be updated as well.
>
> Instead of having the PGD changes ripple out to all tables, the
> synchronization can be avoided by pre-allocating the PGD entries/pages
> at boot, avoiding the synchronization all together.
>
> This is currently done for the bpf/modules, and vmalloc PGD regions.
> Extend this scheme for the PGD regions touched by memory hotplugging.
>
> Prepare the RISC-V port for memory hotplug by pre-allocate
> vmemmap/direct map entries at the PGD level. This will roughly waste
> ~128 worth of 4K pages when memory hotplugging is enabled in the
> kernel configuration.
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/include/asm/kasan.h | 4 ++--
>  arch/riscv/mm/init.c           | 7 +++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasa=
n.h
> index 0b85e363e778..e6a0071bdb56 100644
> --- a/arch/riscv/include/asm/kasan.h
> +++ b/arch/riscv/include/asm/kasan.h
> @@ -6,8 +6,6 @@
>=20=20
>  #ifndef __ASSEMBLY__
>=20=20
> -#ifdef CONFIG_KASAN
> -
>  /*
>   * The following comment was copied from arm64:
>   * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
> @@ -34,6 +32,8 @@
>   */
>  #define KASAN_SHADOW_START	((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) & PGD=
IR_MASK)
>  #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
> +
> +#ifdef CONFIG_KASAN
>  #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>=20=20
>  void kasan_init(void);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b66f846e7634..c98010ede810 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -27,6 +27,7 @@
>=20=20
>  #include <asm/fixmap.h>
>  #include <asm/io.h>
> +#include <asm/kasan.h>
>  #include <asm/numa.h>
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
> @@ -1488,10 +1489,16 @@ static void __init preallocate_pgd_pages_range(un=
signed long start, unsigned lon
>  	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
>  }
>=20=20
> +#define PAGE_END KASAN_SHADOW_START
> +
>  void __init pgtable_cache_init(void)
>  {
>  	preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc");
>  	if (IS_ENABLED(CONFIG_MODULES))
>  		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
> +		preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "vmemmap");
> +		preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "direct map");

Alex pointed out that KASAN PGDs should be preallocated as well! I'll
address this in the next revision.


Bj=C3=B6rn
