Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0612AAE2
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221581; cv=none; b=X4asKLh4iqjpv7ixgAXGUr/M4oo1QC2OKt9ft1/lc/s+CN7UsRZAZDqk9o73MdUyqq2uE9CqBPddD31e6VmGbGiL4tonVmdLrNZXDSHlik/kEF51YQfeS0nLkZKaN1IHY+OKmPs99F6+hx63keiJ9bsltclD80i7fRvd5Z/N7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221581; c=relaxed/simple;
	bh=xgYPXAcahwrokBgBsI1bgHqC/P6ivXlthaKEV07Du10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y235X781e/ada0WmcOahs+MEfT5mf5p0rfn+7oWhsIvLbgW0IpxI5zjUTUY/WByvg2OnD6e7II2SjMFoASRH8ayGRICeN8Qy/QcMn4Eo20z4om96fiG9W9XsFAWfNsGPDH3vfOnGNTRD0gxfWfo476SR5H+Bb9K7Tvh6FXnsEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=alXOYhS+; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="alXOYhS+"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFA9C60896
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:32:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQ3UQMfl-B9p for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jun 2024 09:32:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EE4CF60892
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE4CF60892
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=alXOYhS+
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE4CF60892
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:32:58 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so4240169a12.1
        for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719221577; x=1719826377; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSDzT24BI2p7JqoVBNan8p02CfsKp3kht22xLj1zjCQ=;
        b=alXOYhS+nMyErQW3BvWOBNBFLKqpJcfuiU8qnaTfDD6wpa239bocaUcyv08pZcx1UT
         qGoGOSizmTmWFJqPotyM5v8LVAGfYvNYCsrysLl9rTRBYe8PoFDzS1NyM/pMGRpL4OOL
         OBdLOl5HjJtxX/KIHWiHRNGP2KuPLyJwAESkx971r+5/w50Ld5n9WkDdZtTKhTELtzhy
         OAvvDBQbvdkFASQ9lRFwZugJVoh8PtRgj3SmHOzU36lkhub49m99jc4FQAfvtEnyuj+O
         ZiA9URMikQCb95xgl+Qy4YA00qmjHuw9VgBtd9E7Q8flmVI9WLAZVGothCupaAC3JVa8
         4bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221577; x=1719826377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSDzT24BI2p7JqoVBNan8p02CfsKp3kht22xLj1zjCQ=;
        b=T0j2EOZ3+c9Z1p1mb7e1e30PDTKr4pgi5LV5x0K4aNVY4GHBLXfAay27jLX/AABr6g
         wJlfXKHwxocwBT3OJcpLfPYteTL374IlqW7hcOZSwXoKHApGTUOIBm9SUrDvg8lslgJJ
         o04adFppMhCkbzYPhmW+mHIwovBpR9TPGoExgEAhgaHc/7EOZ6CLun0tGp9pxWyQtTYR
         EHCwtKMBHl+HhjrqqIGz/Lpv58KD5x+h347wnCPBvlNtShPCwd/kSUaUtt+cOlD7alVY
         Mnqzicc+zr8PhPGfcHmXrrGt+eX9IkXfOTTYk9OABppTf+n8pAUk1kRlumy1NBhfhogq
         BKLA==
X-Forwarded-Encrypted: i=1; AJvYcCW87wZyWbV2fnFEda9a8hFbMTzZ4UaxkfJsIBANNj38WE/P5TQOcp8SAKV1s1XOz41qtj2kNNU6MfNLePwu9vOTVObXeElgLvu4/d+L6d2RlNJw5xltYKj0xg==
X-Gm-Message-State: AOJu0Ywb+yfpr1l3kvu0OwEyrRP3l9iF3Sd7Jt8Eveyew8ZI6Nx0DBel
	unogJzk6CJCYOSmPHKEKXCu2EaOfCKm3EY8Bte8jCZBsnretRYLdeOLPuKbDDeAQzsUm6mGHNuC
	ZLJK83PBt/BIZNgzNy8Fxv/noo19IgukZpgFztg==
X-Google-Smtp-Source: AGHT+IHXOtFoZ5Ms1VnEXer+u/bYL40w+BzdSznB1Ran7dPtsex2PEoJ5U03ch/VSdRA5dnKWSL056SniQ6koP4dx3Y=
X-Received: by 2002:a05:6402:40c5:b0:57d:543d:e35e with SMTP id
 4fb4d7f45d1cf-57d543de513mr1968208a12.5.1719221577025; Mon, 24 Jun 2024
 02:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240605114100.315918-1-bjorn@kernel.org> <20240605114100.315918-12-bjorn@kernel.org>
In-Reply-To: <20240605114100.315918-12-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Jun 2024 11:32:46 +0200
Message-ID: <CAHVXubgBKxOh0UjbSw2J_76MvZuiwSLL7d5=wAfiRZvgiUD=Ag@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] riscv: Enable DAX VMEMMAP optimization
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

On Wed, Jun 5, 2024 at 1:42=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Now that DAX is usable, enable the DAX VMEMMAP optimization as well.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8a49b5f4c017..1631bf568158 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -73,6 +73,7 @@ config RISCV
>         select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
>         select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>         select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
> +       select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
>         select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>         select ARCH_WANTS_NO_INSTR
>         select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> --
> 2.43.0
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
