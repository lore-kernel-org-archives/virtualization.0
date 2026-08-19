Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8AD442B3F
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132352; cv=none; b=Czj6wlNQm4PGVw9Wl+TMyuyYHEdmnBwUoWqL8WyU0Du9P3Yrpam9No0CT09tpFr2LZma1Gx2oa7cvNRk0bH1quWYlyz/ZVR4J2Yf0yTDAxi6KlMi/S7pEM+/kLlD6joqu4BLCjcIq/8ujdmbBOkjqwYm8xsfznio/Kotsimq24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132352; c=relaxed/simple;
	bh=zlErMMR25SYOsUd3S/0AwpVYnof7u7gBjzWgLBfix9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdXuSCPNeQW58cJP4fZ073UW4DYaqE7Kwl6t4TlYt8JGBQcRsUwpIqiFCVHvuvD+lXG8Lje2o/a9cpwRk1lQDLHAwJiml9JmMWXx5S6C+waIgVbSj/poJc/FqSmwpiBcvrzEFz6XURLkCdzKZJHAgSAGwSMvVD0s0/OkgKx4z5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bf9506704fso333461e0c.2
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 02:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787132348; x=1787737148;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dIMgKn9ssmwMdJVgg9MfbDylpozJGdyvq0xNOf3CW1Q=;
        b=UqkMh+XnnwXtlyfnI/osdUYKZl93m/f695bbeAwmNFQbCSeS2amkPHI6J6IcYKN39e
         Skvwg3EynkT4sz2qR1Q96AVUH8uaNFAZS8OyAtwm+5mLiR5oWb14l8RzKcx/hEIwi8D7
         ibcHbdH3vjKSByod0Bwi1F9APVJwNwviEo3infxRu4WwvdG2/NnRI5E4KDXAbSZFGEtH
         9Yh7GJir8estpxfoxMbd9l5a6GMqIYgEKA2rWu5eshsFMKlmKA8LuAE2IEAy3PLbQY3g
         nXvYqXNTjzia/3kJrx6rePDGUQOwsooXE6MyT5yzIkNbGTHr7nBxyXJ3xJJyBFeqbZeH
         i7JA==
X-Forwarded-Encrypted: i=1; AHgh+RoeY5nyQJs6rioteTRspXEvfzCVI7Ng28xvvjkBpa4R1yTELQm0wF1mla1gjMYMN5kadqohkdmkMUDbCRfFHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9NwHIWoyJL980QvqXPD4ogDprSpe3euDLNP2ucBUnJDtwX0w7
	kNBhBg08bvVtlKlRyis8d8O1XfJzL9HAXgS0jObKgyYDCYZsoFZFHHM9ioKBPsoZG4o=
X-Gm-Gg: AR+sD10brrJAD75dg2t4OyvTXRNbWDCtXo8xHkY1cxe0QSgTtnT15OwaTCLSbhvNN//
	fWYd29r6LDDEwwJ547536d6/HbTVRl5+ay/Cn0psztj+9llsv08u2ZZR0Vy9z66Y97HtaetH/mW
	cjaul5PavhyO8Ptt2HSQUFFgS8NXpu0pkByh1WUHodFRXHzC8LtCxJyM4wdQfagbZ2kwKOoxwNy
	evM6qI8jOH3r0t5h9h/le0LI1FJaZKLAo7rauOy4L92wDha32HFd0J8biurpDhukig/Jj652Dv5
	ilyGBvR5ueJJNIOuBHAvdrwuM4gOO00YpNtLRalbb5xDXR3QK9FZGUtviFm4QWwnvQjESkLhLYh
	PxEV72T+jv0O0ec1viEqjUflDim+1mvvJPNbECA6l3gESwOwvcRybaw9qKuQ+lNlEj/MNqHYejN
	UM5/S5ggEkKFWxwdH4zLYV0qoP/DxHyTKobHVHTQmWyqQeTFXGvz7VkVEb+mMA1hanQAC4Y3cxm
	rVUI1DCL0eDhB61docBcCIFiQ==
X-Received: by 2002:a05:6122:2189:b0:5bd:c27a:dafd with SMTP id 71dfb90a1353d-5c5e3beaafbmr973685e0c.3.1787132348141;
        Wed, 19 Aug 2026 02:39:08 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e25e3464sm1535506e0c.2.2026.08.19.02.39.06
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 02:39:07 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-747355a8565so243487137.3
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 02:39:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqNhvcg5fy2wJyff7Iyy9dbLMnV7VU8lkkJHFnBrLHTDag19kDtbWIxTXp56RVG4iT1LvWaDBgYcQSivz4e2Q==@lists.linux.dev
X-Received: by 2002:a67:e04e:0:b0:777:ffe0:a10b with SMTP id
 ada2fe7eead31-777ffe0a6b7mr539021137.4.1787132346344; Wed, 19 Aug 2026
 02:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818125012.468092-1-tzimmermann@suse.de> <20260818125012.468092-2-tzimmermann@suse.de>
In-Reply-To: <20260818125012.468092-2-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2026 11:38:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
X-Gm-Features: AcwNN1Uwr-MWNK1wEAyEr8Z9JNVhxk4jrnSNE7dazUpWIvLo30uHHQJP967oerw
Message-ID: <CAMuHMdWYVjvGM2pOzWoDq8LUSrkFtzOQwdmosHYQuBLnSn3D-Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/panic: Allocate QR-code buffers statically
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: jfalempe@redhat.com, javierm@redhat.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Tue, 18 Aug 2026 at 15:00, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Declare qrbuf1 and qrbuf2 as static arrays so that the module loader
> allocates them for us. Avoids the kmalloc later on. Also allows for
> using sizeof() to get the number of bytes in each array. Access the
> arrays once with memset, so that the physical pages are available on
> a panic.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -628,24 +628,23 @@ MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code");
>  #define WINDOW_BITS 12
>  #define MEM_LEVEL 4
>
> -static char *qrbuf1;
> -static char *qrbuf2;
> +static u8 qrbuf1[QR_BUFFER1_SIZE];
> +static u8 qrbuf2[QR_BUFFER2_SIZE];

I am not a big fan of increasing kernel size like this.
You may run (faster) into boot loader limitations.

>  static struct z_stream_s stream;
>
>  static void __init drm_panic_qr_init(void)
>  {
> -       qrbuf1 = kmalloc(QR_BUFFER1_SIZE, GFP_KERNEL);
> -       qrbuf2 = kmalloc(QR_BUFFER2_SIZE, GFP_KERNEL);
> +       /* best-effort allocation; can be NULL */
>         stream.workspace = kmalloc(zlib_deflate_workspacesize(WINDOW_BITS, MEM_LEVEL),
>                                    GFP_KERNEL);

<ironic>Why not use a static array for this, too?</ironic>

> +
> +       /* touch memory so that pages are there in the case of a panic */
> +       memset(qrbuf1, 0, sizeof(qrbuf1));
> +       memset(qrbuf2, 0, sizeof(qrbuf2));

Please clarify "there"?
In cache? Not all systems have sufficient data cache, so it may be
evicted at any time.
In RAM? AFAIK kernel and module memory is not demand-paged.
In TLB? Like cache, it may be evicted at any time.

So IMHO this is futile.

>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
