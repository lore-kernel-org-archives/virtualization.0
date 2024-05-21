Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A1770FB
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297844; cv=none; b=I+sEI7KDrD8t80J3oqiWqwGSh5OdqXHKIfbX3OeataMNqls/iiGn2CBga7vGsw7aP6ZibCeJsamMEysS2Mufl6ZgMrBea4bnzTtQza/iQW9jlFMCsCj0kgG5qjISnfUx3RVDI7bKhNorPmmMz3NRYEVRiFVHbD/+aa1f6jV5uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297844; c=relaxed/simple;
	bh=HtMYnwo+7zhOK7FuVJSuWZ8y7KproGqd4tIRPgFjtdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5KHpCDh1S4MUYm2cIDvVnBIdiYE3/uBJ9FGQH6iB6FJbsOZJsk73wCekeB4Jl6FxvYX2iYDwdlIsuOuQMvszCveOAxBP7yjGdol6LxGs0FRtsBjS3Y9dtY6Nx/4LCIXxGIHwDPAAk5Wj6EOH23iPHfuMAnEwRs5gsxAihidc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qTVpC3iy; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qTVpC3iy"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B807401DF
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XoBqOVBAKdk4 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 13:24:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1A983401D8
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A983401D8
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=qTVpC3iy
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1A983401D8
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 13:24:00 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a59a0e4b773so835913766b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716297838; x=1716902638; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch94/MUKajfhml6j4NyfbEOexox9CsSjGOQusf6QZ7Y=;
        b=qTVpC3iyoTKJEVNwscZdLsc9HbnWfIy2GjThxCivQ4bqyXPynjdFO78SXu33VMj+HU
         hs5ZazlFN2KqLt+T/2gU/z586QOI8dNDrz23124c0lMbOfVcJxON/mU6tbL4d/G5qGup
         zeO4+SR2unc7THkY4CM7JHkgHG5AO152f1OjeSplurEJj1asZFc2hpf6Sd7djnCRK62d
         yq3vf4+YsDpY6eKbsNtGB4dtG0PXc+53QvQdJfFpoKK0QxxOsEnADnz/nozGz7Ng4pcw
         CjRczPWGqpbcbnRIL31r4k3GpAu/Pm2EEQK0zg7E+8WjlCXr3vBr6hH6yrFjWyqpl4Do
         THVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716297838; x=1716902638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch94/MUKajfhml6j4NyfbEOexox9CsSjGOQusf6QZ7Y=;
        b=m/mKO7cKjRGxw6qtDXmX2oK5/6G/HkaSaRXYtNTlmmwmJGilsr9smXVrO9coRDG+SB
         f9YHgAdTh+sscoxamZ+C4HSpn0yA45oLXrPKDmCR8dTUo4CKnOYPk9hTpZYxsbmHh1gz
         k4WTtfPCuMzh6E1/vWrfYds78PvXFSprZC5sTH0vD/TrdHshqkRpqUkJi7tm1z0xcb8s
         odRDH6U40TXv6QHCh2+Ci56BoNcqzym1MIpDp7WdwH+WMiDJRDCuddcR41G6GOeaaRLR
         CArc74f0tpwqOLaSebYz57t+rxoNAXkNkkmEJssOAliJ1+WHOb01kFLHJf1+p4DnfBCW
         3u4Q==
X-Forwarded-Encrypted: i=1; AJvYcCULVSdFryvekLtuOHqItsHuwBBB++j1+VkV2oCsAGoO1geTMBIWd6UXSTe/AIB5K5e3H4914dRyproCzswlFT4mXxHPV7dFOJnGD6XRAD51rYeUFCKlC9kN+w==
X-Gm-Message-State: AOJu0YwGGBv4E4r5r3R782ba47/3903UdhIQb41ZeEg275de0d7A3jEK
	YEm1QvsosIWulIwD5yd4mPWL8QXrtOmKuUsMWS+5Jrkq6v9OUSDnEjkFiRa8xxywuhwOhNEmBn1
	5P6Zh/3DmXWmOkUyzd9TtOZEh+CcZ/hVqmQPUhQ==
X-Google-Smtp-Source: AGHT+IFNPqteIERuQeyx8fOJtXwMedVB6JFT7AeuGshPQDCn+zzfFh7PvOccTzqO4JtW047q2vYzycQdAe7WDgqQFSA=
X-Received: by 2002:a17:906:ca8a:b0:a5c:df23:c9c6 with SMTP id
 a640c23a62f3a-a5cdf23d59cmr1178417366b.47.1716297838602; Tue, 21 May 2024
 06:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-8-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-8-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 15:23:47 +0200
Message-ID: <CAHVXubjQr1xzKcjRgB8zA3opj6N93PGpF2=5yKkKK6R07Rpntg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] riscv: Enable memory hotplugging for RISC-V
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
> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
> RISC-V.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fe5281398543..2724dc2af29f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,8 @@ config RISCV
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>         select ARCH_DMA_DEFAULT_COHERENT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATIO=
N
> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM_VMEMMAP && 64BIT &=
& MMU

Not sure you need 64BIT && MMU here since ARCH_SPARSEMEM_ENABLE
depends on MMU and SPARSEMEM_VMEMMAP_ENABLE is only enabled on 64BIT.

> +       select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
>         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>         select ARCH_HAS_BINFMT_FLAT
> --
> 2.40.1
>

But anyway, to me that does not require a new version so you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
