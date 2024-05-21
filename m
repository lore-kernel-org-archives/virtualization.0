Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB882757F7
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294193; cv=none; b=WlAMEKBIOuIk7spLl1YbMX4xy90x4COZlILozP4K5H5Qe1ujjXFo5wmb8CWDKqGFPJqSpsq5tTinZHTArcj2CDU8dIYu68gL0lkaG4raAZ8QpUC5KrawN/IcSyKeKNZNKxuWzAI78tXGtaN1+U2d0jkldt/xNNo+Vi55tTd1djQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294193; c=relaxed/simple;
	bh=lpYRt3wjuJ09ym0V4qH+KDYDfx6LZFwlM7l+U6NDPZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+SCNatB/GYD6B7qb8Ko9nhmCkwb25lnK/eDKWddguoG5D2d06T+6L4HmKhwtOBtLYUhAuWfwvH12yw7XNwZInxlD6dq+BeoHUFigq81IqHehLATjD5uxEGo/AURPg+jcOZ1z8PjyDSHAEMNN55WZomrbMZxHn0TUM7LeBfByII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=frtI+MtB; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="frtI+MtB"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 489FF4043A
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 12:23:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JjCXcrOP7qW for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 12:23:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=alexghiti@rivosinc.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B29EE402F4
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B29EE402F4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=frtI+MtB
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B29EE402F4
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 12:23:10 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-573061776e8so8742692a12.1
        for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716294188; x=1716898988; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwv4UfeFB/qhGfzo1UPvxGLOjaOyyNNjAF75j9o1V88=;
        b=frtI+MtB4VqaaBAFXOvTRZkLOYOjUxEB+vhGrscaYyp506Xp4HdVzGjHxus7kKlmDV
         SPvOEmYtOFzWERYtxAXi8CJSRThDioy8W54tXWJpeR5RMY0BQPmuJzvb7vhsST5mDebE
         tcvlaRFLcgv6yTn3rKTFUvoS7zIxYtR++n7WADD7tuY1SuPO6lqXCoc8eYuGq6xIbVKp
         8FtogkU3l7JrxfBtZwSs6L/UGGx1E8okpYdPdfdYd4+3kL38Tb2zYceTbjodCEqMLJA8
         TTG1oG9khGmUSG/HglOfD967jUnCxaG8P6vV61HGklEvoSH8Td0cujn0Gm9hrbJBYqK6
         GDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294188; x=1716898988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwv4UfeFB/qhGfzo1UPvxGLOjaOyyNNjAF75j9o1V88=;
        b=VyRPe/No9lHcQmb3G+I7I3Dbptij7EbUnlUCOFdkmWksQ/wqDhCJ58Gci/t+7/OcOP
         4hW/o2ar4MqIfdEwRHVrqQHGG8Oy+130DgaaADfacwxjvaORStKoqUY7i5BE5WPuGNBG
         aQUi97JjLBciNKnibJUVrEhyJ9eoNquuaurkAO2zUUvuOnEwT/JIv+im7l6Z6pZ4412C
         24zbAB1ieaIMYUahIg/X/FNusvLP3Rf0yuCq2N0eUTgW6/pZA1/hmkolDbOgICQXGTT+
         lidJf7Sz6cTGH9hBeSK03FTpk3u0lJEP/m16+Mfbb72QsMxZqXMEJEkIK8TW7kuBOA0z
         aT9g==
X-Forwarded-Encrypted: i=1; AJvYcCUgQvNmG/J/E809WWCJnLM1gNg8Mcn8v2BupW1d72w+z//LMdm+41W3lAQmRpxxcJR+mmrtgExRAbIpXToMabmX4A3iI32OTG4jIm9IAyvQ6WT4NQ4PkuL94A==
X-Gm-Message-State: AOJu0Yzb+MJ1FGrLrrTG66xZYQl9zyyjo/bbM924ANuEgrYMyLvj8JKl
	/g47Oh+YN8jNZbsOXyj06YO9OjOK3MWQQbCpHAkvpmcdOsbGjOPeU0bEyvpKVOrROO7+h0kn8Li
	gZggxd2sWU7HMuyvsblOxm84WBliIlbJ8ccYYUQ==
X-Google-Smtp-Source: AGHT+IHX4jtW/r/4JyHv1bYM+G3dQXmDZlMIxpf7dQJZDLPBpeUHYdAiwTVGvcK2C7L80+t1dhIgiRP4aMhzpvkO6DY=
X-Received: by 2002:a17:906:5655:b0:a59:8786:3850 with SMTP id
 a640c23a62f3a-a5a2d681266mr2140690066b.72.1716294188405; Tue, 21 May 2024
 05:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-2-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-2-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 14:22:57 +0200
Message-ID: <CAHVXubhFesiBKL0iF=Xu6J7O2m2i4d903m6o6Anq8JLdwmnz1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] riscv: mm: Properly forward vmemmap_populate()
 altmap parameter
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

Hi Bj=C3=B6rn,

On Tue, May 21, 2024 at 1:48=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Make sure that the altmap parameter is properly passed on to
> vmemmap_populate_hugepages().
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2574f6a3b0e7..b66f846e7634 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1434,7 +1434,7 @@ int __meminit vmemmap_populate(unsigned long start,=
 unsigned long end, int node,
>          * memory hotplug, we are not able to update all the page tables =
with
>          * the new PMDs.
>          */
> -       return vmemmap_populate_hugepages(start, end, node, NULL);
> +       return vmemmap_populate_hugepages(start, end, node, altmap);
>  }
>  #endif
>
> --
> 2.40.1
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
