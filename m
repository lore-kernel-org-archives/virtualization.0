Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7CA181306
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712134; cv=none; b=kNEVKurAjBurN18ZV67URexGC39bsVJMfp0WDGmBWAv3g/0PxVsZA52J4emvyxUczPQyGnQC2ZLWoSVNh5RHqimrzzE7gqc9RnHgDxKtIrJLmvuwhdHPPJP1b0nWMFJ0yi69U8JuL46rx0Zz6YU07129YajnYyoIcnVZFLwNtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712134; c=relaxed/simple;
	bh=hCWkqLqTv3ItUHoFzIgYNgbikvR26cFj8jMx1uex/2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7gWMc51aq3XoyxqKGMFESaaXc3tELzrLPXBCRmdiTC9JtPCJ0o3xa1mZat7cKYXiptc8Eemzbi2lVgb/gv4aDSiQXfsWTR3cUokSOmhEQSYIf8XbbiMuwoijnYDHjC8iYe5x7DfnmexXolrF88C0uRNvV4bkJWjQP+wS/BHMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=L/Jij1+I; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="L/Jij1+I"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEDC6606ED
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWn2E_BQCpJS for <virtualization@lists.linux-foundation.org>;
 Tue, 14 May 2024 18:42:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A8E58606B4
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8E58606B4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=L/Jij1+I
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8E58606B4
	for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 18:42:09 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so618976a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715712127; x=1716316927; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6ryeUi7qTJoBD/62OgqeYM1G6ocyge361mggTj3ews=;
        b=L/Jij1+IlwH4amk5MOSMWVgKY7zSDTTpMoZUvAxIWXL3bpkHCA4HoU7+qLkRgMzzmS
         7FHPQviARXKP3PMDOlsLWS+vMc8bm41PNENHTf/uWlTQBWuJAL6OCu2DE8+PEbnjLNI2
         AzcRwoAfQ+iEp0QNdBmWAwUHe+1tz/Fp2fNBYSOekMcIL++/7jL3U/vvjjxkCoGspL5e
         fiIWuvCNrKuld8wbpDNmi7Tm/UhRKcG+FRysWD36yxizdFOtisF1sB17Aa/0ExINtudr
         b1DyB2YO09Yjfc09ZLezhcpR2jukQmE+thHozx7VzN5bmX3JKGahDHbqskPtVqpIcLWU
         jXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715712127; x=1716316927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6ryeUi7qTJoBD/62OgqeYM1G6ocyge361mggTj3ews=;
        b=V9dw+c41l59co+sF3d91N9iC4LiWyC4DyfKGqsYwLXX/N0oNXuiU6joGFm6Z9gvzaV
         U9zmAOsl99Z6/j1SGruJq1u4trg+eJdxrAYVQZXOHFjtDboHcCeXqTXN4j216nxGejf2
         8orEiJ0QLP8OEmKLcroDaRZKXIXmPpsQQZz9bHUBARuIeQ8swdG0kK0+NPoPdGoZOJE+
         MB9/1cmbvBtTdHBV4u7wWl3XwRAp9Qde7wQ9g3NTq2LjIRhX5jGsrFR6h/XniWMRNM/X
         Qr+1hV6zTpqot1fLuxdZun3uBB4TRXWsMhksOXUDflU16HwnzG2+k31DMdrJs1t+whk4
         wk6A==
X-Forwarded-Encrypted: i=1; AJvYcCUUoDoBaWX9zbmEeOVIlcT6pc57KA4DRfS6w1PEy+Ea/yqxiYOspzeTJ33Rp0YJd6SG2VOBHKZsNsxs0PyGWceS4qhuKwDMi/vOXqJlyMe68yji2s3u4hHDNw==
X-Gm-Message-State: AOJu0Yz5zIX2q8ALOrzFWiMIHRMZ6f8WwEXCE9POTGssTFz9xnRJS8bO
	xpd70d8GjCNp3guywelqPmZiNUNoOMZJeCd7A0Tl2Vg4JII6IaUVulhrANDeRV2mg7ltZiE3UD+
	dwrt1wkwkjZ3r+vYKfzk+Swt+zFXEq9JuZbFa1Q==
X-Google-Smtp-Source: AGHT+IFbMwiOYUAb7e/8vZthTHtvmc7pKqYbGlejzDyPWTizt9LTFfXax18by9Z28FgBfafwz7WSCj7y4vYaV87ykNE=
X-Received: by 2002:a50:9b05:0:b0:572:47be:a81e with SMTP id
 4fb4d7f45d1cf-5734d707234mr10945519a12.40.1715712127280; Tue, 14 May 2024
 11:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-7-bjorn@kernel.org>
 <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com> <87r0e4l0m6.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87r0e4l0m6.fsf@all.your.base.are.belong.to.us>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 20:41:56 +0200
Message-ID: <CAHVXubhbckKD=z74_Y+uukf4FQodnz4-fNdB94fK9OK++xz=nQ@mail.gmail.com>
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

On Tue, May 14, 2024 at 8:17=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
>
> > On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
> >>
> >> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >>
> >> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
> >> RISC-V.
> >>
> >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> ---
> >>  arch/riscv/Kconfig | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index 6bec1bce6586..b9398b64bb69 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -16,6 +16,8 @@ config RISCV
> >>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> >>         select ARCH_DMA_DEFAULT_COHERENT
> >>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRA=
TION
> >> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU
> >
> > I think this should be SPARSEMEM_VMEMMAP here.
>
> Hmm, care to elaborate? I thought that was optional.

My bad, I thought VMEMMAP was required in your patchset. Sorry for the nois=
e!
