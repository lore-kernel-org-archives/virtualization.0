Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A45A0F9
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709658; cv=none; b=GIKx8UDI4fZCgi4Kvojgc7k+iSpDiNXgpMvokptfX6KXcsrpyy0vVXo3aUwg00FNvagU3exoJ5KJ4f3L6N15k8YJRnMP9eoC/i5xQauHpAtSp0zOctZ2DXZKT3lXVuXiJpZ0si+omIr5EAgypadqkh+F89Lf6ogFXD1qgJEJKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709658; c=relaxed/simple;
	bh=QpLFeA2HlNqOEmnHE/cIxn51kUcvHow4/it0St+9Ios=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKjha+sZ8EjsxJJrchGXcjkeOoinOBvhiQF1WIAm1EVP5TsN6uXak9iB8eWn1YVFvLs7y7B2LveRyUllOcoexEsEnGDGOVG/MvAj6vTuaegsr0zZECKgGC+fMINBm2X246cVGSIAojU84YiSHcLTu1kIAbYw0r/UUVLV8etsqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Fi3JlqBo; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Fi3JlqBo"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA0684048A
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:00:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5ohkVncypCB for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 18:00:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9A42D4039D
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A42D4039D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Fi3JlqBo
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A42D4039D
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:00:55 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so2090676a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715709653; x=1716314453; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPFkuGbhnZyO2YuOasmxxVswDvCK0WBgSsmUFjTxFvY=;
        b=Fi3JlqBouySALG0fFObyQYnNW/Xtgs6Xoxza/oVHcZUm0pcy9MX8tlcRnQ8FDxTbjq
         +h4mIAHOXXAC5zlnMw+jzJhNNN4rDJ5Ds2fT5oHevY1Pma//AjV6B5sGP3w7+rG1FZtQ
         TWgKKqStTHIrHO/B0aQAuJAAxf1CGchzmCwwFNTm2ifdwDmH31hpzr4CVSSlMZI8hiFV
         67KqecNO8DhFc5CHbUCRzlmf2ng3TH7BZ1jOfGVZ5hslO/NhH4u7q2RNHi0L4HKQY2GB
         m8j2BJzlBK8kSwfzOX51+25DWzn3yG9Wl75+Danc8R3lDh8GVcQllTkwxNKxqmL/Yhdw
         wWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715709653; x=1716314453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPFkuGbhnZyO2YuOasmxxVswDvCK0WBgSsmUFjTxFvY=;
        b=N2fyghe6IOYyXISp3tjbMd6gLcYI6Xdy16AnafxxsXl3JIX/muGbTiv3TNmnZKnSuA
         CxGvnp1U6NeA6pesXQOLjvS3c3rOsWhjhnndyLoEywIkeI/PfJJIaSaYDZstUz7U3Hfn
         sWzjthwRG8Bq12l5k71xDnoktBSA7YI6UHIY19Emem91g8ZQFjALoKkBgYXSlALXJ/UN
         W/rpj5Ix+tKahhWyCVJ+RhshFmeOL5koP+udqleMPY5gNxhgjxHmhgbJtZ/b35bVUXh5
         dtrpkV9y9LhD5SJqOAOwBNS6nlOmP0iJ6vbe1dishQpUnCNhcLYT84YcmCVbt/YQTF1B
         SqRA==
X-Forwarded-Encrypted: i=1; AJvYcCXr+r9JDf4x0cVi/VqssA9jYvxb/EecFcMKLMPC+rRH9e10GvdVxetlJFsGAtZ/dKcF9O1okubOq6vo29J+dlz+b/5Wt6IW0TiTxg7puQitQqfitrXqTwdF0Q==
X-Gm-Message-State: AOJu0Yx430BzFrfc/rnf55pAEmgrjGy129VjJFAP85ttP9hm5OEXuGwM
	qoE0z/MCE+Gy8Q89CnEFHhVZgzCDDYIkpPIgjFhTRy5mJ2oTIIrVCI66Z6o82T74OpFnGx++DI6
	+NdL6b55rdeEOCM5H2QDWBjZ9HovZmIrsd5o0Bg==
X-Google-Smtp-Source: AGHT+IEav+Kv/bYUpFPfTWv7r39urrL/VjCf1N0diMj0Pjq5+EuaD+cN5qt0Ndddnyt68aDR99gcExBIUX9EIjG6mjI=
X-Received: by 2002:aa7:d392:0:b0:572:7014:230a with SMTP id
 4fb4d7f45d1cf-573328e4ec7mr13569756a12.14.1715709653683; Tue, 14 May 2024
 11:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-7-bjorn@kernel.org>
In-Reply-To: <20240514140446.538622-7-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 20:00:42 +0200
Message-ID: <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
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
> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
> RISC-V.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6bec1bce6586..b9398b64bb69 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,8 @@ config RISCV
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>         select ARCH_DMA_DEFAULT_COHERENT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATIO=
N
> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU

I think this should be SPARSEMEM_VMEMMAP here.

> +       select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
>         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>         select ARCH_HAS_BINFMT_FLAT
> --
> 2.40.1
>
