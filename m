Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E687F486
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298889; cv=none; b=KVzOnFLrjWe4ReXBZ9hFQZWKvJo2UVVOAnEuWNA8wZuP+CDTFQXo7skQXV9nI0JFqIJakQYzvXSIfn79pI4+W4SaZbeJq0G5RYhuiN8b168HThmUKyPlkrBymmVqsyThnnOuSQvZJGMoxwA4JdB7zdFeShYfVbXRMwQiWNBCo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298889; c=relaxed/simple;
	bh=N1+Z7lTXO2rp04BsKfbKtrj2Ok1QKv8CGiazBoT7hjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSabjXXqR79C5FbN6VeysAWbAxXdOxpLv7ovjnIRBQKMWDkYnY3sdxZBjXsvjWLStjnzGu84nmzpyxh34kBVUNf6k9/HVdzrVeVrp/I83OXqVUciZpnTTaU30Njb1iPPiDm0TDx4I6VwF7Kq/6unr7VY1fSmR6TIbEFc6+DejRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bi4nO5Q8; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bi4nO5Q8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EE9A608D6
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wex2cvYWUQKy for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 13:41:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4E51F608D0
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E51F608D0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bi4nO5Q8
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E51F608D0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:41:26 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so43117455e9.1
        for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716298884; x=1716903684; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+1xsVOenBqGRXV+vq+cVu4jiCpn+H/2Flnt09jmSX0=;
        b=bi4nO5Q8rWRTK6IjlRV5nqcx69NPrSPYrZp3eJScJBqgDzul+UwxmVOInxK65+UT1j
         d9Y4Bny+iwky9vPXkaVSa9ZzJKssuwAuDo5HWneENv7XSQrTUZuHIrPbJnnoEDbTRhpU
         MnUo7dsvtZndk3SRv5fpYxMqnNDdzvEz+FZ/4jVts0uqrcyKu0SEX1pZZKLdrD/Bdqo9
         Nm9IVdOccDqdd43YozxdbEqvGo6taK3Z1VaEceQTsVxJZbfrCnZaj9zGRe/BS7Xu42+U
         kK1WdeHb2sK24t/PfPYrH3ph3wEDE0OM4kTvOTTX7tErbNWkOOmALbxMmj6Tz+YKvtaI
         pA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716298884; x=1716903684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+1xsVOenBqGRXV+vq+cVu4jiCpn+H/2Flnt09jmSX0=;
        b=owmaKqDCw+5oeKsUGQLPoBmEu0kC1tbuI6bzbacIOUqXbV07FUpef7hSiSYCN+Re6i
         LUmpXNb3geZMfeIljZ1IzW+HF9HKIymo8+T6fbFGM0n7gNsB4IOVnQ+VEUl+rsdGP1Dh
         yMHVbbgLnLxO9Qn/uEw8ilxiNQY0G9jpzeVAyeLxQz8SVQPZCwbRWE0B0vzI5JOFvHwX
         LbtQ9X69kSbq0TS52BYH0uWYmoS+vR23SMrNt7u0p1yVAMM3IQEeWnyAIEAG7JcSizPB
         4zTy2l91waLCfgHiSuiMLRTlsEB8H1nWqsssP5/CW4HoSigutNNz+GLmnFh6h+djsM4G
         7Y7A==
X-Forwarded-Encrypted: i=1; AJvYcCVtLHiaSbvT96PcjYryg0rmcJXPNmwnQni9HH+J08upc8yaPWr1RLTKw0/1uIhtoIRVvn/xxBrmo3CDXZUcDZGVOCGATLE8THKf3PIfKKOvwaRtQvtGK6Xh+Q==
X-Gm-Message-State: AOJu0YxNY8nWeag3bfqe5p07U1VF4FvgwSiY+OJWxbZhsA657CpoJG5h
	pSGmhm9+5patzuo94/uKayfQKTIgaFW/9Egca5H1Jyn6MrkE0u/i4cD8/GCA1Y4eP/X90HxJ5mR
	IKE6EeZwbMI6lR2y4AdJBG3VPKtQhP8LVgN7XPA==
X-Google-Smtp-Source: AGHT+IEHsbdyc9+JywKTd0t0PpMsBEzeUY13uoyr7VftCkfS7u3Z4jvNXqxJorAsuGUNCeaWmG6E1b/MXJC0vpgD+7A=
X-Received: by 2002:a05:600c:5601:b0:41a:adc3:f777 with SMTP id
 5b1f17b1804b1-41feaa38ec7mr320385465e9.16.1716298884332; Tue, 21 May 2024
 06:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-10-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-10-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 15:41:13 +0200
Message-ID: <CAHVXubirHPj1pZhU7sFxFTzBWz_Psf5uts9y3Dji-a03nb=_iw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] riscv: mm: Add support for ZONE_DEVICE
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
> ZONE_DEVICE pages need DEVMAP PTEs support to function
> (ARCH_HAS_PTE_DEVMAP). Claim another RSW (reserved for software) bit
> in the PTE for DEVMAP mark, add the corresponding helpers, and enable
> ARCH_HAS_PTE_DEVMAP for riscv64.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig                    |  1 +
>  arch/riscv/include/asm/pgtable-64.h   | 20 ++++++++++++++++++++
>  arch/riscv/include/asm/pgtable-bits.h |  1 +
>  arch/riscv/include/asm/pgtable.h      | 17 +++++++++++++++++
>  4 files changed, 39 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2724dc2af29f..0b74698c63c7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -36,6 +36,7 @@ config RISCV
>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         select ARCH_HAS_PMEM_API
>         select ARCH_HAS_PREPARE_SYNC_CORE_CMD
> +       select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
>         select ARCH_HAS_PTE_SPECIAL
>         select ARCH_HAS_SET_DIRECT_MAP if MMU
>         select ARCH_HAS_SET_MEMORY if MMU
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index 221a5c1ee287..c67a9bbfd010 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -400,4 +400,24 @@ static inline struct page *pgd_page(pgd_t pgd)
>  #define p4d_offset p4d_offset
>  p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static inline int pte_devmap(pte_t pte);
> +static inline pte_t pmd_pte(pmd_t pmd);
> +
> +static inline int pmd_devmap(pmd_t pmd)
> +{
> +       return pte_devmap(pmd_pte(pmd));
> +}
> +
> +static inline int pud_devmap(pud_t pud)
> +{
> +       return 0;
> +}
> +
> +static inline int pgd_devmap(pgd_t pgd)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif /* _ASM_RISCV_PGTABLE_64_H */
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/a=
sm/pgtable-bits.h
> index 179bd4afece4..a8f5205cea54 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -19,6 +19,7 @@
>  #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
>
>  #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
> +#define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
>  #define _PAGE_TABLE     _PAGE_PRESENT
>
>  /*
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 7933f493db71..02fadc276064 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -387,6 +387,13 @@ static inline int pte_special(pte_t pte)
>         return pte_val(pte) & _PAGE_SPECIAL;
>  }
>
> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
> +static inline int pte_devmap(pte_t pte)
> +{
> +       return pte_val(pte) & _PAGE_DEVMAP;
> +}
> +#endif

Not sure you need the #ifdef here.

> +
>  /* static inline pte_t pte_rdprotect(pte_t pte) */
>
>  static inline pte_t pte_wrprotect(pte_t pte)
> @@ -428,6 +435,11 @@ static inline pte_t pte_mkspecial(pte_t pte)
>         return __pte(pte_val(pte) | _PAGE_SPECIAL);
>  }
>
> +static inline pte_t pte_mkdevmap(pte_t pte)
> +{
> +       return __pte(pte_val(pte) | _PAGE_DEVMAP);
> +}
> +
>  static inline pte_t pte_mkhuge(pte_t pte)
>  {
>         return pte;
> @@ -711,6 +723,11 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
>         return pte_pmd(pte_mkdirty(pmd_pte(pmd)));
>  }
>
> +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> +{
> +       return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
> +}
> +
>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>                                 pmd_t *pmdp, pmd_t pmd)
>  {
> --
> 2.40.1
>

Otherwise, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
