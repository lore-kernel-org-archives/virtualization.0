Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6717EBB9
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702279; cv=none; b=fLx9Fc21uB/DuyBrmdDnMzSEbxCOphsFhwK+Vh7T54c9bAJfzlO6Elaw4qw5EcQAh0F1WgKvXtF1aYJjQWENMbr3rgc8Rl/YjBOafCHZP2xfzlOBq1qp/sgRuXwBp9Bk8RGFXKoeFvZg6uixLh1p81PzlyOJMnKfBmPBXv5jalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702279; c=relaxed/simple;
	bh=ZRZC+ewraM3sNSDTKtcy7um+e8MQrAqS8SrqujW4WhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ss/wO0otVRchRnpLMB5nsO+ZVwQ8cA5XwdOFsQEp0Mp17YcB1vYIn8xt2jVEnVLW/VST9afdQGOWQumdm1X9cXhVBs5iVNX4zloESwNwDF6cylnXBHuppfo0Gwdyd/ZPC1gagZ6SHpVKUvh3er8NiU5c9yf712iiN07cyquKXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=06/tvfA+; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="06/tvfA+"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECFE7402E4
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 15:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iiNEmLwengnv for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 15:57:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BB245400F5
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB245400F5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=06/tvfA+
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BB245400F5
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 15:57:55 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-572d2461001so396565a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715702274; x=1716307074; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YVPz8d9fNN7RmoGRWLz27p194UlG1xw9/YZRFhtwc4=;
        b=06/tvfA+xMsjSExOAVuZtiT8NAnBQOrQr2ITLhG7tqKUaLLdpSoNDYlIJ0iq4LSi2n
         3xeLaDqLMN7wIilZ5GgzEEKs2MLa6sNGCgv5avGe5kXXkIMp/qAuRaQQ4+6GH/8gmrt9
         KbvvyqkvNVIiKk/rEMI9CdauLe3KIvs6A3V05O4W4IHNDb1763ggGftwG8JhU9C1q4BK
         6kb08G81bwhU7Xwm03ldzGN4hEJ8phoPrndhKKVC1z/a5yGVujLztMMbGo5v6TEWytcb
         XO1D3vmgoQ2nCxc4+HNHX8UeDJQZmN2EEjc8iuvLGUE+2iHJlzDhORt7qYHtdNJG5utH
         hkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702274; x=1716307074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YVPz8d9fNN7RmoGRWLz27p194UlG1xw9/YZRFhtwc4=;
        b=Gb2NKoEiXWoqqNYCDDrbtRcEkIWdi8AFHhkpJvidy41j6JsttJTWcvtwEcWkiXlmP2
         8mCP0SuyKcxhOSJbj2MpbGv9nhNlbH6yg2d3NoqUl2C9IEkwWnokt/SVo+zooybV94Mh
         YspsodtuOYmCdJSuoY8fF7nWBwDweKLEkgS6TLeMBIXzLE6UFmkcZvvMPQwWS43LOJ+h
         korSATXoS9tZoNTK8cdrh+C19GMEamS4l9cuVVAw4d4zW2ZIwCof5S/f9JM3n3+agRQ5
         HwTjK7xxffbg9nhai0EFr0eInKmMMKgBGp82eMR7yXdrc1VZ8fGIduNkmJsk2xOfjgq1
         EkqA==
X-Forwarded-Encrypted: i=1; AJvYcCVdN5VBGsImNAobeBrXisoQU53Vb/IdqCOwPuLmAz3CE0GZ5lVaCd6N9PnutZZIPhF6nIGx414m7+38NWRx47ZCp1vuTFPaZRNl8md3AdFldRCJp2APxA42sA==
X-Gm-Message-State: AOJu0YwotvqB7BbtX4qKuh4VF0wQg/naYaJnKawLvavDOA1s2kZskRoT
	TtFle9hOTh2JEXODNRb7SY33rghrrvmONracf70vtoMVxeQP3orFtWh34gmrlbIK7zT+aHaPRNJ
	/L6IzYABdj0c4WuObyCudGZcpVhPt4JKJgdOD9g==
X-Google-Smtp-Source: AGHT+IGpm9BtgF2gQRgKdtEpvWTCkNaf/J7ULsUq4SiDnv5BQvS5Vo6yygT4W4ORsVjJhPMMfM/u6EKEY/mm3nAcHd8=
X-Received: by 2002:a17:907:9705:b0:a5a:7cd3:b2e7 with SMTP id
 a640c23a62f3a-a5a7cd3b463mr311306266b.11.1715702273691; Tue, 14 May 2024
 08:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-2-bjorn@kernel.org>
In-Reply-To: <20240514140446.538622-2-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 17:57:42 +0200
Message-ID: <CAHVXubhfsvDZrw_Cvg8AnEm00P0TQvrSOV_jVSBRckmJLp6EFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] riscv: mm: Pre-allocate vmemmap/direct map PGD entries
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
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
>
>  #ifndef __ASSEMBLY__
>
> -#ifdef CONFIG_KASAN
> -
>  /*
>   * The following comment was copied from arm64:
>   * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
> @@ -34,6 +32,8 @@
>   */
>  #define KASAN_SHADOW_START     ((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) &=
 PGDIR_MASK)
>  #define KASAN_SHADOW_END       MODULES_LOWEST_VADDR
> +
> +#ifdef CONFIG_KASAN
>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>
>  void kasan_init(void);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2574f6a3b0e7..5b8cdfafb52a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -27,6 +27,7 @@
>
>  #include <asm/fixmap.h>
>  #include <asm/io.h>
> +#include <asm/kasan.h>
>  #include <asm/numa.h>
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
> @@ -1488,10 +1489,16 @@ static void __init preallocate_pgd_pages_range(un=
signed long start, unsigned lon
>         panic("Failed to pre-allocate %s pages for %s area\n", lvl, area)=
;
>  }
>
> +#define PAGE_END KASAN_SHADOW_START
> +
>  void __init pgtable_cache_init(void)
>  {
>         preallocate_pgd_pages_range(VMALLOC_START, VMALLOC_END, "vmalloc"=
);
>         if (IS_ENABLED(CONFIG_MODULES))
>                 preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "=
bpf/modules");
> +       if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
> +               preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "=
vmemmap");
> +               preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "direc=
t map");
> +       }
>  }
>  #endif
> --
> 2.40.1
>

As you asked, with
https://lore.kernel.org/linux-riscv/20240514133614.87813-1-alexghiti@rivosi=
nc.com/T/#u,
you will be able to remove the usage of KASAN_SHADOW_START.

But anyhow, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
