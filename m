Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8713148A6
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773477191; cv=pass; b=ewoeQ2+rVK+WF8kpYaLiAjMV+d+purNK9Qaho/sZkorYm9rvEk2mCTQ0kTg7Luvxw8+IA0ADkRkLlFct8W+FwULDSCCl5ic33iTjN56/qHh2SdHrUqzKnsnXzIlCdCuj6eZEpbJ0Rc/O0UBh94CPldQw+s7SxOV8UyRUbd4NVUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773477191; c=relaxed/simple;
	bh=K2m29vFYhTa8suMcX35xG4/CJ0THa7o+u/MUTTc4DN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJO/TtNVlr7qNa6gsH4lKuOOrfZVe66qq9wfMj3zEjaa4xqcu5nMmiXoa8b1zAJajTG+8YSgbxSVMpY3iXbS/DtFQZVK5AeftkWoTnNrj61G2yWzhSIHsVoepmAizfZJyt4/p78UAEaFcGMdYuPZA1QSWtMXZ2BmbgC7fwUBVr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=Fg0mj7Yb; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="Fg0mj7Yb"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso4181009a12.1
        for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 01:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773477187; cv=none;
        d=google.com; s=arc-20240605;
        b=C+BXaaZK7s1RUbJy9cPByRyIlyd4zWqY5qgVwjgILTc1PXF6JbJzgP2Ip+k/6IEWrR
         otncFYBesSggLwmRrQKKiraxJiaVVgVh0FoxNCi0Zez3/khCdyzzl3jRYkNxC1dimEbD
         VJwRmh0dGsgIZQ9G0ubU+O4x0V6VgoCczB/ePu5uCUj/Kz6hTH/xBGArZFXDpZNz9BES
         LvvkZDoDQ38ramfj/lBXr+BRY32gjEzEaIn1Hv8aIbu0VjD9VI1nYd2/Viz86lJ0qpxn
         CWhAG1PIRbg76MNvbiRJhoiGyJclzDzDMlClLo9KBBScKWh/eIvte4zs7mMVVaFixE6/
         o5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dtJDuSnv9xup9mKfpmpv48fCVeZrU/FJKeoAzNll9L8=;
        fh=NABTjXGf+/4K+Yi8fTsmPbF9if1uZ8inSEUIeMh25xA=;
        b=eaZSaGFXUVm1bzoJQ4l06lCeXwY4kzjzSS6XSHkJhBf7xuhh47pV6D2+fvmgzMGJNU
         gvEks96jfOZ2K4CZaYx6ySkgNwyCqdJ1GSfP5I7qxfiS71Y/Bc3nPbolWh91eqZ3cQlw
         ZWk2BOjPmffMp0QMlFB+jQkYxqGwVOfgcAbmBbwe0ND8U4JY4wQqdWATZ58YcuUS9x5n
         ZffgOfb1LQHPec26LE+s6FHymSqzt17JlUmZrm9S/v5deMiZ+HbTkAo6dVYIiNX/Syd9
         UKcRRRfnRkTFWrts4bfyXE9gLxbMMy6MJP+GCxHIirbA3RPni0QI1Xa4u/Lxe4vT/EHx
         ADNQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1773477187; x=1774081987; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dtJDuSnv9xup9mKfpmpv48fCVeZrU/FJKeoAzNll9L8=;
        b=Fg0mj7Yb/s4Ou//U5MrGzq7N3EUjY7RPLGDv9lm3hYqRfpDtfnMMq4CMHQYoPYC0Yc
         AO/VorYNhKeremWObAG1IBvjfuXm5t3gv9dBe+qXrhVKSQ6n0MIaMtyoh+YoqGlB7RhB
         y+eyYdS4aAnY18pVvjZViya7YwGTQK71WY1TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773477187; x=1774081987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtJDuSnv9xup9mKfpmpv48fCVeZrU/FJKeoAzNll9L8=;
        b=GmRBVil/gF+g3RTlA9xm8E6Ze7/eAwZ8QdhsFlSy2fWpGKjCpyeD3vQhjmJtM7xdwY
         yBwAwmVpPI39M0DsZKRh33I9ZfTx8sSKf3DKiusfMi7WXFa8WXhP/zYHNeT4GHGOYr9D
         BciRd08WKNhbk8wsYDmOc/XylgBq0MVIeYAfgDqyY8m+mNeP3vskXvpYC/sY5XlUcmSk
         Uup/2ApVNhTCt18TEENR8citfnS6Wk05RVEvOS8mvWmEa0GQywzWSsNt7mvK62+0LLHr
         G8AM0w8+EogV9J28/a3kHIxJXzfmQy1XLbraH53OO+6PY0DK5xeJkT2388L5S6HtaISa
         uJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8+PeqWA96koPQ6OdQ2IXJCf6zt+jIsRMhFzGYXgiu0lIh34jzlBc+XuJzI1hVz7D4ShtmSTf/sKrPtGBqYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaZstuf0Hm6ClLaYiRzDCgiZgbvsPdJjZot88QoX7hLBOgG1by
	WGNlOikSgrFSPDA1yX/g+i2QIpYcQiq7idq54t27v6bL0kINMP9BaOJc8j5vkxVezol9cFqjxXo
	PKX7uj5g7c3uFXkp5Jia5AoDNaA05O0Ha2MD6Z73PCEiJx+XIX/+T
X-Gm-Gg: ATEYQzyipOZAmojLdg2qY0qww9TBwNAwqucJFU/280kqxl5bPy1YZhqJvsepUM4d5xn
	/kCpJRyjccVW4TAJprt5WjS3j90yTn1ytEN1Ele8vBCedgE/m0PRVP7aMB58s2+oVkBqDr9QSTV
	bEoFgAACMGmyCTlhm9P5TiGIesyYdyQnDS0hXmQK9CiKJQHGDnkwVGtVf1XlY/esCZm8ANCBODG
	4vaNVPLbQF6wqqUXSUQuVVnB1sTPWvF46hgrSKKHVqDaa9/A/QR6s8dBljfa8RlCKDdFD0/2ACd
	UTfDlmsErg==
X-Received: by 2002:a17:907:e107:b0:b8f:9fe5:fd62 with SMTP id
 a640c23a62f3a-b976537e2edmr272498466b.42.1773477187531; Sat, 14 Mar 2026
 01:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260314030612.1949420-1-daniel@thingy.jp> <20260314030612.1949420-3-daniel@thingy.jp>
 <32d021cc-0179-45de-b832-f122698211fb@app.fastmail.com>
In-Reply-To: <32d021cc-0179-45de-b832-f122698211fb@app.fastmail.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sat, 14 Mar 2026 17:32:54 +0900
X-Gm-Features: AaiRm51Kr1QSkycBnZgGczxruI-DGv3kmXzfjqHYQTBTWCEMvQBsjIXI_N1leE0
Message-ID: <CAFr9PXmG6=NjscnsS=DHgyiyCsNSh8kaGyO1ujPHOsFySZhjMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-mmio: Use raw io accessors to avoid arch issues
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Sat, 14 Mar 2026 at 16:42, Arnd Bergmann <arnd@kernel.org> wrote:
> I don't think this is safe to do in portable code

:(

> diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
> index 516371d5587a..c39db8798ef2 100644
> --- a/arch/m68k/include/asm/io_no.h
> +++ b/arch/m68k/include/asm/io_no.h
> @@ -96,15 +96,6 @@ static inline void writel(u32 value, volatile void __iomem *addr)
>                 __raw_writel(swab32(value), addr);
>  }
>
> -#else
> -
> -#define readb __raw_readb
> -#define readw __raw_readw
> -#define readl __raw_readl
> -#define writeb __raw_writeb
> -#define writew __raw_writew
> -#define writel __raw_writel
> -
>  #endif /* IOMEMBASE */
>
>  #if defined(CONFIG_PCI)
>
> Can you try if this works?

This builds but doesn't boot on my devicetree'd dragonball branch. I
don't think it's possible to boot the stuff that is in mainline (and
you wouldn't know if it booted or not due to the lack of a serial
driver). I think I can fix my stuff so it works with the changes in
readl() etc but I think there are a few other people that have their
own 68000 trees for weird custom boards and I guess this might break
their stuff. Not saying we should force a change onto virtio-mmio
because of weird hobby projects. Not sure what to do.

Thanks,

Daniel
