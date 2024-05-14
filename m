Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47C339A0
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707464; cv=none; b=NvfVz4XMNmvgUaC45V1SyGj8iqHEo+9VFRNpwiSnnA5NJx+Qnx1aWBgroe41r7rdVSJz/7dyNTuQpVdt1hbAlAPXQmcwtxJZc1/s+VVvleleYbSh0G9Eo9JW0ryd8Ijm2rT+EP/XuSYUZ+dLuUBN06jUpUO1zzotxj9zo+OfnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707464; c=relaxed/simple;
	bh=1+pUQhSplg1y4pCiDO05f9icbk19T6mlM8SfOOZhYcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmqvojSLXKfCvakHJF1VqDVR8KY0xHVrjY7m6WG7a+ZGisjJHyZ3XtWuherEhJ4jIpXzQ0PyEGH/vAiFSQJfFuyhQhPSg3L/DYB89ZORultPv9P5HWK/48zlDQPuCiakV/laxRTFK2i4E6d95rYtBiMJ11FobyKm68q065M5eXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZnG5bxYE; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZnG5bxYE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80BA760638
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 17:24:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxxazRuWH_8o for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 17:24:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 41FDA60648
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41FDA60648
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ZnG5bxYE
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41FDA60648
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 17:24:21 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so2027248a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715707459; x=1716312259; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm6je9rht4BjYmGJ1IuR6KKMw8nH5QLaou4Ka+z1F+s=;
        b=ZnG5bxYE/lWt2fmqW+aW1/5iPcLuT9s96PF5iYT+cJPxJD7Q5JeVv7Lhf9q0JbMaGo
         gOZrjDjR7HzJPAjiRF0a4UpYNSxAVd2Yb7slIGq1Dj6FWN1a4t/WXEiqseBWTCL9f/3a
         RhHktmGypI1LyonC5VkQe4vC/+WDxDucCluFHMXfk8lp4b3vo015tZMB2hCCN+rjVQHy
         52ymwaApgVRMpGjue3EQT7S3SGxm+awZeT6eN3/KpoOIxEse7kIfVKeIW+Wkn1UI0Uqa
         FrdQd4lADP4t/F2Ttnx5zC4SzJflqk5ZnfJdSxkYF7eCR8MiKVz5QZ2++eW3ZiR+AWte
         fI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707459; x=1716312259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm6je9rht4BjYmGJ1IuR6KKMw8nH5QLaou4Ka+z1F+s=;
        b=wXV4WB6c9lpM8VLbj7ljblImLkSnaSoKDlaJsLBrMqa9PTwovrOAjGspo1jPPiWH99
         YgCwWGBa4vH+rPBd4QVEaCY/qBt2bHpWWOQkvbr9iUw9UhvJYuTubKbg4Ieury9eg69l
         mheOEKSiBzTusmKM9olMw7YTFPPWFNxQ5s4kznrf4LjQlHh8J1Aneq7dz02lZF+81PIe
         pPmP37hfobWsbTfxj43h3nyDdpBD7YB9pCBXEShQOmbZKzXpVoHCroU7Ey6SjNQAIY0C
         qba8AkNvv8fvqi44rdUObLLXIaNYrsbsDUmo21xcYQDi0Oh6I5tILmtsOELCzBTy/IRk
         Q9zg==
X-Forwarded-Encrypted: i=1; AJvYcCVndx/3z6CVXZ3xBMZ8Nky8IoKdF23kd0od6cdWtZVaGDyiHvoNwkrM3thB8YfDeUrBucx+5FFjn3LNGn/4d2BTEAWhu+mzeFB6ZwNySI5Q1JY1GwttFeobZA==
X-Gm-Message-State: AOJu0Yx4vFIoLeBPF0u2rylXLVv07B2hgDN+ONG8fijQ5UaGHwZYboW3
	/B/ar6YDuBndTVqdnMC+BhBf2VPjGMY2b13QWfRTCr2H4E9TWwH789sOLsiVm+Ay2VW/wCvNhCs
	a3312uu3ibBK4pkwjEtU5yTldjn9+pSugyQBH7g==
X-Google-Smtp-Source: AGHT+IF56JWIpkZ2/AL2ubyZfgA/2Uc3aQFZ5Ej57ui6rLBhQ10e6OWlyGWRPN5l4ez0BlwqzQ5aMzCSBobUR5m/tfc=
X-Received: by 2002:a05:6402:26cd:b0:572:3fac:e085 with SMTP id
 4fb4d7f45d1cf-573328e276amr15922880a12.13.1715707459179; Tue, 14 May 2024
 10:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-4-bjorn@kernel.org>
In-Reply-To: <20240514140446.538622-4-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 19:24:08 +0200
Message-ID: <CAHVXubj0Ly_Nm-J17bxuEn_1cUC_HxOMUxJ5dnfRB5CL6D0jeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] riscv: mm: Refactor create_linear_mapping_range()
 for memory hot add
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

On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Add a parameter to the direct map setup function, so it can be used in
> arch_add_memory() later.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c969427eab88..6f72b0b2b854 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1227,7 +1227,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  }
>
>  static void __meminit create_linear_mapping_range(phys_addr_t start, phy=
s_addr_t end,
> -                                                 uintptr_t fixed_map_siz=
e)
> +                                                 uintptr_t fixed_map_siz=
e, const pgprot_t *pgprot)
>  {
>         phys_addr_t pa;
>         uintptr_t va, map_size;
> @@ -1238,7 +1238,7 @@ static void __meminit create_linear_mapping_range(p=
hys_addr_t start, phys_addr_t
>                                             best_map_size(pa, va, end - p=
a);
>
>                 create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
> -                                  pgprot_from_va(va));
> +                                  pgprot ? *pgprot : pgprot_from_va(va))=
;
>         }
>  }
>
> @@ -1282,22 +1282,19 @@ static void __init create_linear_mapping_page_tab=
le(void)
>                 if (end >=3D __pa(PAGE_OFFSET) + memory_limit)
>                         end =3D __pa(PAGE_OFFSET) + memory_limit;
>
> -               create_linear_mapping_range(start, end, 0);
> +               create_linear_mapping_range(start, end, 0, NULL);
>         }
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -       create_linear_mapping_range(ktext_start, ktext_start + ktext_size=
, 0);
> -       create_linear_mapping_range(krodata_start,
> -                                   krodata_start + krodata_size, 0);
> +       create_linear_mapping_range(ktext_start, ktext_start + ktext_size=
, 0, NULL);
> +       create_linear_mapping_range(krodata_start, krodata_start + krodat=
a_size, 0, NULL);
>
>         memblock_clear_nomap(ktext_start,  ktext_size);
>         memblock_clear_nomap(krodata_start, krodata_size);
>  #endif
>
>  #ifdef CONFIG_KFENCE
> -       create_linear_mapping_range(kfence_pool,
> -                                   kfence_pool + KFENCE_POOL_SIZE,
> -                                   PAGE_SIZE);
> +       create_linear_mapping_range(kfence_pool, kfence_pool + KFENCE_POO=
L_SIZE, PAGE_SIZE, NULL);
>
>         memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
>  #endif
> --
> 2.40.1
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
