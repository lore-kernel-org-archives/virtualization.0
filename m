Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05B14C592
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727297894; cv=none; b=hfFoUcfOKZedZ6tjnUfmMyC5a7PoC/Hfkq52MOxFd5Lab0uY5ubiZckBs56i+szOzasOwaxTcSgXCitGYyyT4SmlIAClOwVPlhpqfXSnnBBcKfsgn8dAn6IO5TUCoZH/hxR0Ngeml5jmReSMFEcSI5wW85oR0b+FhhhvVJre2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727297894; c=relaxed/simple;
	bh=MI91IPsgx12hAjD1Fnd9cbpgQPG9us6szsi1UBoZ8TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOSrJvasTvZVoifeUddHj5/ATCZbjonzZlvrWnAoFBKxgMRvtSFopmKraVXc92ZEA2qZJU2rCCiYhAhKri2va7jsCfwlVxigS7mJTzorDlBxJt+JGLSktbuddval8ECzNFhTk3uZGFhEJ2PIy9kXN3XgW7a3934Cb8qhSLcwHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jVCtvQ0C; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jVCtvQ0C"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5919D403BF
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 20:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R8ZPtklA2-JM for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Sep 2024 20:58:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=dverkamp@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF650402F4
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF650402F4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jVCtvQ0C
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF650402F4
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 20:58:10 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a8a7dddd2c3so3568266b.3
        for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727297888; x=1727902688; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loEaOAwR2WyhsG3iZ5TBHhLLRL6rmxVjK+xE7rgUtM0=;
        b=jVCtvQ0CJd5tmEVVcUst0uHSOGdSUMLr/Ni/FDneUbzpsG46THBo9d/TZdH0aJQ570
         v7WNVc+3ga/ZFfCqjqe8mymyeV+1hFoc9yU7Q7CHCNQIglCbT66YtL7rw6POyfpBu49C
         ITTq1buemPP/c1Lx0ORZm5bd7BTnyzZbA/jd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727297888; x=1727902688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loEaOAwR2WyhsG3iZ5TBHhLLRL6rmxVjK+xE7rgUtM0=;
        b=SvS9A4/dUcCs8qpLxSNhXlHLr0WSxR9/wdZdVBftqiYf3NRxUexuZcnIg796lED9tT
         SAA5Haktrjr1sKtI/cFt7IlBIGjcwCurmapv3zVaKPROPOkqBoMyP5PR1hBeCO1LfsPn
         VRQrxy1uWMJLtuBh9CKB/YU6GHIo75XkVx1Equynvz5GFMLlZT+BZJb9dhyBBpYKkZOZ
         nYJKpDvCINqDU0N6HpJwvLDKx5PMjh2f0frjnrjse08zRj4v20k3yJkf1AIGU+Zi5VEl
         3YWU7tVz5lQOraiias+WgeYpZGm0UYK0xLT1cg2M6yf3N4C3UqRKpqdRjcHUGRNtkCul
         GnGg==
X-Forwarded-Encrypted: i=1; AJvYcCVSatBjq7OC/NRqOyH5Iq/bj65Q+P6xjpQvTmjP1SvRC4ypFjRlef/GRIS3LYJpOsogWkt5jj3Y1GBnifZa+g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwilkPlD0CQeOZ91MaGiMF0Mo5isnBzuqev8QuUxIbWCFwqAj6B
	rHfhNAef/5LVbQNntJfgUA6WhlcBFwusCLS1lzZ5cMzgD3pOHUdom5/Cfw8gjJS6hcU+Gh0/7Ac
	=
X-Google-Smtp-Source: AGHT+IGsUKTfrqA6DtjC8A3FGlZEc6QAea7zZ0OaGTC8pk7v69PS2UYmuCxMblxr6iSW20s8JJ1aEA==
X-Received: by 2002:a17:906:ef0e:b0:a8d:2624:1a81 with SMTP id a640c23a62f3a-a93a06cc3f3mr158854366b.12.1727297888308;
        Wed, 25 Sep 2024 13:58:08 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f54691sm259202766b.85.2024.09.25.13.58.07
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 13:58:07 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso210126a12.3
        for <virtualization@lists.linux-foundation.org>; Wed, 25 Sep 2024 13:58:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeXc395CA/3c2ZDAlzBscGkEV4gy75QWzINPavjz5mx2/6iL0va4bSaH4y1zYwcqHdgYLDF3ESKTjRZ9KXxw==@lists.linux-foundation.org
X-Received: by 2002:a17:906:caea:b0:a8d:4e24:5314 with SMTP id
 a640c23a62f3a-a93a0360465mr369987266b.24.1727297886869; Wed, 25 Sep 2024
 13:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925145228.27953-1-mgurtovoy@nvidia.com>
In-Reply-To: <20240925145228.27953-1-mgurtovoy@nvidia.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 25 Sep 2024 13:57:38 -0700
X-Gmail-Original-Message-ID: <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
Message-ID: <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:05=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidia.com>=
 wrote:
>
> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> set.
>
> The blk_size field represents the smallest addressable unit of data that
> can be read from or written to the device. It is always a power of two
> and typically ranges from 512 bytes to larger values such as 4 KB.

I agree that this is what the blk_size field probably *should* have
meant (matching other storage protocols like ATA, SCSI, NVMe, ...),
but I believe rewriting the spec like this changes the meaning of the
blk_size field in an incompatible way.

Previously, blk_size was described as the "optimal" sector size, so it
seems clear that the driver is still allowed to send requests that are
not aligned to blk_size ("awareness of the correct value can affect
performance" but no mention of correctness). A device may need to do
extra work to support this, of course, such as turning an unaligned
write into a read-modify-write sequence if the underlying storage
device doesn't support such an access directly, but such requests are
still valid. It's also perfectly fine for a driver to ignore
device-offered features like VIRTIO_BLK_F_BLK_SIZE and still operate
correctly.

> Linux/Windows systems typically use 512-byte/4-KB block sizes.

While probably true, this doesn't really have anything to do with the
change (and the logical block size is a property of the storage medium
and controller, not anything to do with the operating system).

> This description provides clarity on the constraints of the blk_size
> field.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  device-types/blk/description.tex | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 2712ada..88a7591 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -3,7 +3,10 @@ \section{Block Device}\label{sec:Device Types / Block De=
vice}
>  The virtio block device is a simple virtual block device (ie.
>  disk). Read and write requests (and other exotic requests) are
>  placed in one of its queues, and serviced (probably out of order) by the
> -device except where noted.
> +device except where noted. Each block device consists of a sequence of l=
ogical
> +blocks. A logical block represents the smallest addressable unit of data=
 that
> +can be read from or written to the device. The logical block size is alw=
ays a
> +power of two. Logical block sizes may be 512 bytes, 1KB, 2KB, 4KB, 8KB, =
etc.

Does this imply that a device may return an error for a request where
the sector or num_sectors fields are not aligned to the blk_size? If
so, it should be called out as a more explicit normative requirement,
but that would definitely be an incompatible change.

The "smallest addressable unit" wording is also more confusing than
clarifying here, since in virtio-blk, the "smallest addressable unit"
is always 512 bytes, regardless of blk_size (even if a change like
this would enforce limits on the sector values that would actually be
allowed, it would still be possible to create a request that refers to
a smaller unit than blk_size, unlike other storage protocols where
logical block size changes the multiplier of the address, making it
impossible to address smaller units).

>  \subsection{Device ID}\label{sec:Device Types / Block Device / Device ID=
}
>    2
> @@ -135,6 +138,9 @@ \subsection{Device configuration layout}\label{sec:De=
vice Types / Block Device /
>  present. The availability of the others all depend on various feature
>  bits as indicated above.
>
> +The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is set. =
This field
> +reports the logical block size of the device, expressed in bytes.

Not a new problem with this change (see another example right below),
but "set" is unclear - does that mean it is present if the device
offered the feature, or only if the driver also accepted it?

>  The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This=
 field specifies
>  the number of queues.
>
> @@ -228,7 +234,7 @@ \subsection{Device Initialization}\label{sec:Device T=
ypes / Block Device / Devic
>  \item The device size can be read from \field{capacity}.
>
>  \item If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated,
> -  \field{blk_size} can be read to determine the optimal sector size
> +  \field{blk_size} can be read to determine the logical block size
>    for the driver to use. This does not affect the units used in
>    the protocol (always 512 bytes), but awareness of the correct
>    value can affect performance.
> @@ -282,6 +288,12 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
>
> +Drivers MUST negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered b=
y the
> +device.

Why is this a MUST? This is also an incompatible change since there
was no such requirement before, and drivers are free to ignore
features they don't care about.

> +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then =
drivers
> +MAY assume that the logical block size is 512 bytes.
> +
>  Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
>  sending VIRTIO_BLK_T_FLUSH commands.
>
[...]

In my opinion, this change should probably be something more like a
non-normative comment, along the lines of "blk_size is often the
logical block size of the storage medium", without changing the
existing meaning from previous spec versions. If there is a desire to
introduce a hard requirement for logical-block-aligned I/O requests,
that seems like it would have to be a new field and/or feature bit.

Thanks,
-- Daniel
