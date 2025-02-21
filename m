Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351D82046AD;
	Fri, 21 Feb 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131869; cv=none; b=kaMgKZp49SFC7NDuX1LUaUzvPbh+Sqw96SdQ/yeBSLdYbKeE4rMZWTNGkxMcQCIWSN424ilstx+r0ksWSOU87sk9Jn3KYZb0w3JtkE+uuyquQZc/XhdHG9RHIQLiXIt6zBm2YQ+jVcFoSobS3TwPvNG1P+1KNfug1s0isvEkE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131869; c=relaxed/simple;
	bh=bsAk0fKMy1E3IDw29e4DwX52DVtBpITBlP4ScSN0CWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBzUCuQNR14rK9jsDAUdotoiaNLxsPRNMgTaZaDqwpAfqSFMzu80+fM5+rAtzLUB/zT2wRgMZgP2j9qk4f9yO2eCAb3ZpvvlOXpp6l3E1RhTOWREQnoQapBU4FoevRAzbAe/nj+22SRflK1UjT/Pq6r3+ie2pC70GEr+hDH330s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4bdb423b971so584855137.2;
        Fri, 21 Feb 2025 01:57:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740131866; x=1740736666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRmDUg88sJqiPwLbbhmS638djtZJpa1TX+xwhTJhivE=;
        b=XqPl+fkqS7iIPL6bFYipNNZRjdFTM38/n6hxuwMLK1pQGh92pfkF/AolHHGOKB03tD
         AE24KRxi3g4AyyjcP7rLBPeOTa82O5zZ1F9qDURJv/W7+EV/fWIvhGtTCZOSf4lJJZzD
         7qXE2N8aRsuEeIwIkOwHYWlD7HrM8Kkp+sThI5xJ9CHy0sWS3yLQOfeClc2GlQAGLbV7
         92X9mBKU4XNc1LnjIVZfSWNd/SMgSwblqOWQk+wJY4hFP/OgjCHmiS2TofzaZDSBbnvo
         jZ/LD7whr3Ib6Be4KRABYVa0kOsC+wqDxmrczaWCZWEx3BJ4CgFYgSdo1KetizdkrkTs
         M18g==
X-Forwarded-Encrypted: i=1; AJvYcCVE9Cd/AlhVP2+aKwxtTq06EtK4f9uaFr0CpkVk/lQOZmpudogcZLyR9jTPHZnRMwktVqA=@lists.linux.dev, AJvYcCVcR2/42XoMIVmUZHi0fccPNYYEjL/qwXMGh41QWBqONt9b1PgSwbWRMekgiLUzops5YHHhIPisuRTIl73C4Ps=@lists.linux.dev
X-Gm-Message-State: AOJu0YxpJ7cUk5BzCVnM0E/wGx+0avKW1bjCsceZrN2OUibksVzLjV6e
	mQY64gLfsIP0U35di6fMQLna0KsUpzfMmu8cyBDzcsA8hpXseQ8DeF9l2dHs
X-Gm-Gg: ASbGnctZkDvFmveTwAFEWyWHoZrBRfq2nP18G8a9hVxSAmsbSJguo19cefVGr2pleqb
	Unqf8YmEyBhH0m9cjA1RZXPVrSsXqF+OoKfUTvKhEpSKBfTRLxCifonMG9F75LwB1s8a5eXK03w
	iUkTz3ueWibIcWk0QR06tFDp2rk8gxoIkxrR4i4FJ18dq0zAn/SChSfFuWjN3bKtcBJAUCuLCJg
	rVrZ8cl9xauLVspyWf6Q9DH7iDfCDa26vRMaxf5D0n2tSohG574pvhwRk2bCCvEXvAKe9RiEdSc
	l92jWZdPcxyTPObHOT7r9nZHmaDvyXLjUHaJ65h7Sqkjo1RpVET5ZkOUsV2l9YWt
X-Google-Smtp-Source: AGHT+IG+FsqOQS4J9njEotc82GNMPKl+iO//4bj0Dit+rNPZaWuJsmaYjV89DfPTUcGHG9F6HoGUcA==
X-Received: by 2002:a05:6102:5125:b0:4bb:bf49:9088 with SMTP id ada2fe7eead31-4bfc02231f9mr1120598137.16.1740131866115;
        Fri, 21 Feb 2025 01:57:46 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4be3310c768sm2627416137.18.2025.02.21.01.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:57:45 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8641bc78952so482053241.0;
        Fri, 21 Feb 2025 01:57:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFYRgvR0Cp6VEQ6XhKzdIPD6ywQ/gnnvQv6eSO1CUcgeuChz2co8MEUsEAfsvi7px1q9BwnWIhBpx7xeopZ/c=@lists.linux.dev, AJvYcCVotFdL7NT/bkiduI5kPTlM4E9RaHM5hpCDrx7+Nnc9ooTg2F1QHeE2Cm598LkcyehmgFk=@lists.linux.dev
X-Received: by 2002:a05:6102:441c:b0:4b1:1eb5:8ee3 with SMTP id
 ada2fe7eead31-4bfc0277734mr1360564137.22.1740131865660; Fri, 21 Feb 2025
 01:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250218142542.438557-1-tzimmermann@suse.de> <20250218142542.438557-3-tzimmermann@suse.de>
 <dcd59a75-7945-4a2e-99f9-3abbb3e9de14@ideasonboard.com> <355ed315-61fa-4a9d-b72b-8d5bc7b5a16c@suse.de>
 <596b960e-71f8-4c2c-9abe-058206df1dfb@ideasonboard.com> <87ca2b81-a67a-468b-ae2b-30d02a3a64bc@suse.de>
In-Reply-To: <87ca2b81-a67a-468b-ae2b-30d02a3a64bc@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Feb 2025 10:57:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnZTj-8bqsbbZdhp0H7Bwib8GkEuXPcKNZjdo_jRRXgg@mail.gmail.com>
X-Gm-Features: AWEUYZnV-ULUCYHgs2rYqHTa6wPlfKvTAAqMyxRQ0em_d1IVN8Mw0n8NQD9eWqI
Message-ID: <CAMuHMdVnZTj-8bqsbbZdhp0H7Bwib8GkEuXPcKNZjdo_jRRXgg@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] drm/dumb-buffers: Provide helper to set pitch
 and size
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	imx@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 21 Feb 2025 at 10:19, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 20.02.25 um 11:53 schrieb Tomi Valkeinen:
> > This change also first calls the drm_driver_color_mode_format(), which
> > could change the behavior even more, but afaics at the moment does not.
>
> Because currently each driver does its own thing, it can be hard to
> write user space that reliably allocates on all drivers. That's why it's
> important that parameters are not just raw numbers, but have
> well-defined semantics. The raw bpp is meaningless; it's also important
> to know which formats are associated with each value. Otherwise, you
> might get a dumb buffer with a bpp of 15, but it will be displayed
> incorrectly. This patch series finally implements this and clearly
> documents the assumptions behind the interfaces. The assumptions
> themselves have always existed.
>
> The color modes in drm_driver_color_mode_format() are set in stone and
> will not change incompatibly. It's already a user interface. I've taken
> care that the results do not change incompatibly compared to what the
> dumb-buffer ioctl currently assumes. (C1-C4 are special, see below.)
>
> > Although, maybe some platform does width * DIV_ROUND_UP(bpp, 8) even
> > for bpp < 8, and then this series changes it for 1, 2 and 4 bpps (but
> > not for 3, 5, 6, 7, if I'm not mistaken).
>
> True. 1, 2 and 4 would currently over-allocate significantly on some
> drivers and the series will reduce this to actual requirements. Yet our
> most common memory managers, gem-dma and gem-shmem, compute the sizes
> correctly.
>
> But there are currently no drivers that support C4, C2 or C1 formats;
> hence there's likely no user space either. I know that Geert is
> interested in making a driver that uses these formats on very low-end
> hardware (something Atari or Amiga IIRC). Over-allocating on such
> hardware is likely not an option.

Note that the gud and ssd130x drivers do support R1, and I believe
work is underway to add grayscale formats to ssd130x.

> The other values (3, 5, 6, 7) have no meaning I know of. 6 could be
> XRGB2222, but I not aware of anything using that. We don't even have a
> format constant for this.

Yeah, e.g. Amiga supports 3, 5, 6, and 7 bpp, but that is using
bitplanes.  There is already some sort of consensus to not expose
bitplanes to userspace in DRM, so limiting to 1, 2, 4, and 8 bpp
(which can be converted from C[1248]) is fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
