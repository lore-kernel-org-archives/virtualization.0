Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398212AAE2
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221524; cv=none; b=GF9jiKudNIqLpEwM/X5/GPo8kAHbriZqdIlGzt6ZuBkf/J3uRh3P70XgxH9Kr0D3nag5Ff71dHZljC+vjtnrDDAkEqcxfmsjw6wU6wNRKUhWIylCJpyTAGdztgns0eKUVkzdykh3dn7qXhdL2YS+hzvAam3Yn6wXG2EuyTUtm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221524; c=relaxed/simple;
	bh=i6GsoA4U85wFLMJhxJ2uKt9+SS1Lm1mh24yo44FYz9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skWOonVW6J6+7epm8bDCSiEfqlMPK3sh+X9f+7A28BmqfOlHxH5HZueCJRSzTTH/Yu63/+G5Y0/1ngG77PbRvMmapENsIQ40OGm/Gok/+G4SpUNWvfxdByBIdD6aFjC36qIPTQUVLJRnKQ0SPwIENyJbX7MhDg8zXBBfu6/TspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=A4X/Vdh8; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="A4X/Vdh8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 241B440722
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDdXQ2m5Ljip for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jun 2024 09:32:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C3ED8405E1
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3ED8405E1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=A4X/Vdh8
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3ED8405E1
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 09:32:01 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a6fe81a5838so154012866b.3
        for <virtualization@lists.linux-foundation.org>; Mon, 24 Jun 2024 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719221520; x=1719826320; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtSoSxfjq8aHhF6gq2sk0dwqY29zGCyMkL+T3Rh2MIE=;
        b=A4X/Vdh8d66BEFzXLG8rAIJl7bZf6rS7RHf7k1IQPHrQETYOp1KxLA7tqOJ3ThtdKM
         qpxtJG7nFYa3J1/91LuCGzPJTy/8IAFLcUFSHO4rwer72CPfuv0SfxruGC8/kccXpRHR
         sIrSYNOCBqadWxiCVy0pWgO+bJF4xUl4T1RGHkRLvxqndW/nsQZSclsX6OE8lRcw7oag
         dkripR1k/IElZcgwhzmMWP0515eu4nASB8oM32khg6kmZTuWbTuqKJRevwI31b2SMm3U
         AeaOWXAw1KVNK19PPFmER74vTJWfAqTCWSXlITkjzKjmAcKK5pHgPRYFSqRiLvbw+c4Z
         H2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221520; x=1719826320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtSoSxfjq8aHhF6gq2sk0dwqY29zGCyMkL+T3Rh2MIE=;
        b=BAku+2hQtFzhBVFUk9XO4ra96nHbpU/fP321qysKRrjM/7YG2vRE4pZfgXHE2ottDl
         iPnqHNRf243YSDC+9Cq+q31HjS5rjpuH3hSSNlC6LCUUq4WOCkoyS5qkBq61u4kTYCxj
         jp8uNQYNUtxM8lc/G02E8CpeHL9r8NK9Yv0TOk3Fhxr9nsbA3GHTzsm6OMD4IzHOQP4P
         +2lSfCwlKbSR7Wu+XkToA32/ZIraAbdyO8DY0G1I5xMuAY/wBa2kAaT2Vzek5b9E1RPB
         604c37fx7WRQntarmmcs9TWI63T3ahkdJ6vMJ8eWokPdWhG2S58aoKN86nQKjzfsiV0r
         QDhg==
X-Forwarded-Encrypted: i=1; AJvYcCUTiKs2JdPoGpYnZxHyK55UYSR7spBL3jykezOv1Oul1qN0ZIzUWFnoacLrSP9Pxc/vhE8DjsV6UxdiMIqh2L6BLeTnYFvzCpx0Mive7gccH+B6hM6lsIx8Bg==
X-Gm-Message-State: AOJu0YxOVjNFeefBXiLkP11Rj/zlan50fFJeM9peOMw66y5f4/3muj47
	x391pUvd+tj4sgbps5TXNgpBQnSeUjV2Bs/B8dkGukgQAlE+T5Cvd0yjCXdaeIk+IFrvE/NI63m
	I+LV7KTykC1Nb3IQtXBuMYD9Vedo1MKX6AU8csw==
X-Google-Smtp-Source: AGHT+IFVeOm41TPJdia3V+ypKDs5ua30MsXI4dF3qYEF70GUNjAd+SwTuXPVZZMhmO/B5Tw3/mwInQAqPilUcV0OMrk=
X-Received: by 2002:a17:906:7c2:b0:a71:94ce:9b03 with SMTP id
 a640c23a62f3a-a7245b6251amr241286166b.20.1719221519773; Mon, 24 Jun 2024
 02:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240605114100.315918-1-bjorn@kernel.org> <20240605114100.315918-6-bjorn@kernel.org>
In-Reply-To: <20240605114100.315918-6-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Jun 2024 11:31:48 +0200
Message-ID: <CAHVXubhx6VxB3JCXQo_eo-6J27i620ALTBHCnnVif6RG7hpXww@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] riscv: mm: Add pfn_to_kaddr() implementation
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

(resending as gmail client turned to html)


On Wed, Jun 5, 2024 at 1:41=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The pfn_to_kaddr() function is used by KASAN's memory hotplugging
> path. Add the missing function to the RISC-V port, so that it can be
> built with MHP and CONFIG_KASAN.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/include/asm/page.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.=
h
> index 115ac98b8d72..235fd45d998d 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -188,6 +188,11 @@ extern phys_addr_t __phys_addr_symbol(unsigned long =
x);
>
>  unsigned long kaslr_offset(void);
>
> +static __always_inline void *pfn_to_kaddr(unsigned long pfn)
> +{
> +       return __va(pfn << PAGE_SHIFT);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>
>  #define virt_addr_valid(vaddr) ({                                       =
       \
> --
> 2.43.0
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
