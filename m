Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BB3002D1
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119492; cv=pass; b=nxq9jYk4wmsNUs5Twh1z2DGGa98Ze3ttUtUxrNVvuJ6w6JCZfI+P6OmZto21DGtn9XE4pjoyZ4V9Bp9vx+F9o45m1MRDLF48N8J8uQHftb7J54Mv51cMHrVK/hR9OlILLaz9UYQREHAXAfoxkbCNnjOchBo4y6Jh2QhQIYTQwIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119492; c=relaxed/simple;
	bh=qbTt32WGAbdq7IT9RU6ZMgw6KxRGPTvwquBOZ8oW/vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9MPDYIuHZFx2Z+9krKbkU5hkhA1XVTqCxx7D/nvCPvPOB9f3zxPeuQCFKwh/qXV1b3kMzjXkJHSxHK8LjYSv0u2Ug/8PgbmHd1SETQz1rllw5A7A1Mbsa9tZ7XO4nlVPStmGQeUh0ALzf4tqUx/r8Oqk0jSN2fMKOWjHPzfJs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK1Rlt8T; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK1Rlt8T"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-486118ecd5dso4575295b6e.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 12:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781119490; cv=none;
        d=google.com; s=arc-20240605;
        b=RsxZ+mmEMo+c8lxrazetOKmUN/GlvgtnHW9fH9wiOxKOC9y++DVHTFsqs+sxl4xWJ0
         1aIv/wXj5KIw3boZUonJHXFJh1CvguDFWk9KDMPANkU0Ke4cLm8tdxHFNDGk5wFd/hmX
         AP8ZpfeZPI20wU2uTLgxEQtjiBHMs3NLfErkTRksIw3Nxuxm9PhNVjGKH7yCcyaX/JUu
         1JzejAjW/Pqc76uCdfJCeoxDHywXuq4hcPr6LPMP+3CEMu+hekg5XwqSty8KL+KC6c2F
         CM0Xv9yd2vdjSBNARBeNFFHgQOtldE1q8XtssFzaQxjLVtEzxRrtqnQvBaNuS88dCLxa
         PlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HNLzCUY/JUPdriX7y3qzf1B2NTJnJURHUue9QDnGves=;
        fh=JXeTG0jhp1ThwFi/LKfBOnbIl9kE/GjsMl6DLobhwSo=;
        b=CNrBJHyjb6iPnRUWY3IkKk/PgwLYu8uFcq3D2KBtIb/1nq9aWClof/zPe14Ag1iR7L
         tsUijMiLzODmvFsq1xieY6809ITsN+hsn10ZUjg3+rttWurB+1tbR5XWAYMHN4n7J/UR
         U1po6cy/C9Tzz0rME73bvR5SbamNSR4a4Yntol7wERballOVJ9lIpJCFLsXxwa/PVzeg
         1LL1YLB4JMYHln8IL+v9h+o9HOKRhPQ+L/rwOa5fTLaViT3NZMVosMLxGsVTdvvfpyvF
         xsruDW2/9KycXcP8Xy3r75v8CbE3xYV6pgG3qFZLfNuGG15E0dvasn2m33aOwclcco+W
         DrDQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781119490; x=1781724290; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNLzCUY/JUPdriX7y3qzf1B2NTJnJURHUue9QDnGves=;
        b=QK1Rlt8TR1jQzdqCK+z4EBzp0HY266rRW29SONw9HXATwAwwf2L++3eWI4oHx0FclF
         ZsNx7djhqbjqwdTrVcQJq8Oz8O2qRt862qKAKkQDVcq8CI6yf4k6DPK3VvE4JqnFyF0X
         i73jChdqxwidXpi4q8+2vuKqg2aOQjmZDb7bbCb6xUxUhC1rFm5Jj4m3lqn6qesRvI0S
         0EspCmiUzchFkAJtmiAfn4WcKxyBBoTAwxtS/sBlCjKl/M76meGCD9FPQKyhT17ZtYYo
         NTWgjHS19I/Ajm+/CKJxHKtVZ0cfEUWcRD2//Ro7k0WfbqXbP0r0Vh+oJVTRj37GiWlP
         pdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119490; x=1781724290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HNLzCUY/JUPdriX7y3qzf1B2NTJnJURHUue9QDnGves=;
        b=TnugIPURvB3M3okDfXAWzzangvvb8NejGnl85EUb1Mobsb2EYtSEbq5VYYiKe62t5H
         jkgTno3CvQ5roNvD4IFOXnoEYXF4cC+1w1T76m5BXyz0YWvSg5AkUn0CsyF5sI6pEbIj
         kmOxqu15LTVPvBmxSoh4Y6Bezu6wrbvZGXYIqA1wBOpwT1ul1JgPOESlQv3yDV0JY8Xl
         CItcon3wm5+gFlPqI810GirwQlcaGc56jVUwQeGaQ0/3Xv+Y+xKi5XlcdcXglWbBNRZu
         v8Apl5252+FuT3hX4uVtfYzsG0JZxCga2ypAzqMb/iCkyWkfcZ1VobAZt3gYgkQqN74r
         rULg==
X-Forwarded-Encrypted: i=1; AFNElJ/w6DqrxPcb09spqZGwaHf1aQe1f0+pEqgjw74DrhOIOM90WVXrrLZ3jwF7++JXiFpVQyMq7yUkTatJbZE6hA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx49CHznkCS2A6N7hhaHuByyO/ih/vuJBOrPSfJE8hTK2Yv5O/t
	WCrggy1nTVufiC9qvq3mqolIW6YChzQzN0ZSnxsJdFq0WeMO9Nso9T03SX7bLIc8baGFb5zVpSX
	eoBhJirlj/ERDz4BUXWKPps1Z3WNucm0=
X-Gm-Gg: Acq92OF85kQPGK6LqkZvqk05e0n6jnXcwieK/UddwbA08fAEiq7AY7yBJDcmEga0/qq
	BXDCa/HPg3jOHV0zWCWc9l2OAHALJxr3LiHMRDjY3sX4wCVmazJInLp1ePiY+s3yW566VvkM0nm
	vbFdYZ98Hvi2cEV5FEF/GPKyjIy0H2Oi5PJRnZCGaJq1gRe13YrAKTBv1P0fV1w6qvSrwwcZhkx
	0pBZHtb2cVzP53evxTwUTjJ/97SjrqcPadWcYUvub+///KYJBhgWm0wey1seIbo/4H60REyhkwj
	1UX79FmOKWqRX1ccbw==
X-Received: by 2002:a05:6820:221b:b0:69e:3c64:7f61 with SMTP id
 006d021491bc7-69e68c06118mr2868355eaf.31.1781119489522; Wed, 10 Jun 2026
 12:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 10 Jun 2026 21:24:38 +0200
X-Gm-Features: AVVi8Cf3u6Xv3TtQDxSRMDkc9Nu5lMT9FCK2mtYagN7OZm9Yts7qmkNi0JB-0eI
Message-ID: <CAMeQTsbqm=pxgjreZcmH39x2ELkipXFzxW0OHG2g+09De2yHYg@mail.gmail.com>
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named initializers
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Gerd Hoffmann <kraxel@redhat.com>, Markus Schneider-Pargmann <msp@baylibre.com>, Jianmin Lv <lvjianmin@loongson.cn>, 
	Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>, Dave Airlie <airlied@redhat.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 5:05=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable H=
ub)
<u.kleine-koenig@baylibre.com> wrote:
>
> The .driver_data member of the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using the PCI_DEVICE macro and named initializers is more
> explicit and thus easier to parse. Also skip explicit assignments of 0
> (which the compiler then takes care of).
>
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

Since it touches multiple drivers, perhaps a drm-misc maintainer can take t=
his?

-Patrik

> ---
> Hello,
>
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre=
.com/)
> and that requires named initializers. But IMHO it's also a nice cleanup
> on its own.
>
> The anonymous union will allow changes like the following:
>
> -       { PCI_DEVICE(0x8086, 0x8108), .driver_data =3D (long) &psb_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x8108), .driver_data_ptr =3D &psb_chip_ops =
},
>
> (together with the respective change in the code when the value is
> used). This gets rid of a bunch of casts and thus slightly improves
> type safety.
>
> Best regards
> Uwe
>
>  drivers/gpu/drm/gma500/psb_drv.c      | 56 +++++++++++++--------------
>  drivers/gpu/drm/loongson/lsdc_drv.c   |  4 +-
>  drivers/gpu/drm/mgag200/mgag200_drv.c | 24 ++++++------
>  drivers/gpu/drm/qxl/qxl_drv.c         | 15 ++++---
>  4 files changed, 52 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/ps=
b_drv.c
> index 005ab7f5355f..039da26ef24d 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -56,36 +56,36 @@ static int psb_pci_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent);
>   */
>  static const struct pci_device_id pciidlist[] =3D {
>         /* Poulsbo */
> -       { 0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_=
ops },
> -       { 0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_=
ops },
> +       { PCI_DEVICE(0x8086, 0x8108), .driver_data =3D (long) &psb_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x8109), .driver_data =3D (long) &psb_chip_o=
ps },
>         /* Oak Trail */
> -       { 0x8086, 0x4100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4101, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4103, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4107, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> -       { 0x8086, 0x4108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_=
chip_ops },
> +       { PCI_DEVICE(0x8086, 0x4100), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4101), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4102), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4103), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4104), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4105), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4106), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4107), .driver_data =3D (long) &oaktrail_c=
hip_ops },
> +       { PCI_DEVICE(0x8086, 0x4108), .driver_data =3D (long) &oaktrail_c=
hip_ops },
>         /* Cedar Trail */
> -       { 0x8086, 0x0be0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0be9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0beb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bec, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bed, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bee, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0x8086, 0x0bef, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_=
ops },
> -       { 0, }
> +       { PCI_DEVICE(0x8086, 0x0be0), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be1), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be2), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be3), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be4), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be5), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be6), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be7), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be8), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0be9), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bea), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0beb), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bec), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bed), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bee), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { PCI_DEVICE(0x8086, 0x0bef), .driver_data =3D (long) &cdv_chip_o=
ps },
> +       { }
>  };
>  MODULE_DEVICE_TABLE(pci, pciidlist);
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index 1ece1ea42f78..f9f7271ddbff 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -444,8 +444,8 @@ static const struct dev_pm_ops lsdc_pm_ops =3D {
>  };
>
>  static const struct pci_device_id lsdc_pciid_list[] =3D {
> -       {PCI_VDEVICE(LOONGSON, 0x7a06), CHIP_LS7A1000},
> -       {PCI_VDEVICE(LOONGSON, 0x7a36), CHIP_LS7A2000},
> +       { PCI_VDEVICE(LOONGSON, 0x7a06), .driver_data =3D CHIP_LS7A1000 }=
,
> +       { PCI_VDEVICE(LOONGSON, 0x7a36), .driver_data =3D CHIP_LS7A2000 }=
,
>         { }
>  };
>
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag=
200/mgag200_drv.c
> index a32be27c39e8..8ad4ddb60ee6 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -205,18 +205,18 @@ int mgag200_device_init(struct mga_device *mdev,
>   */
>
>  static const struct pci_device_id mgag200_pciidlist[] =3D {
> -       { PCI_VENDOR_ID_MATROX, 0x520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_PCI },
> -       { PCI_VENDOR_ID_MATROX, 0x521, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_AGP },
> -       { PCI_VENDOR_ID_MATROX, 0x522, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_SE_A },
> -       { PCI_VENDOR_ID_MATROX, 0x524, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_SE_B },
> -       { PCI_VENDOR_ID_MATROX, 0x530, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EV },
> -       { PCI_VENDOR_ID_MATROX, 0x532, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_WB },
> -       { PCI_VENDOR_ID_MATROX, 0x533, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EH },
> -       { PCI_VENDOR_ID_MATROX, 0x534, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_ER },
> -       { PCI_VENDOR_ID_MATROX, 0x536, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EW3 },
> -       { PCI_VENDOR_ID_MATROX, 0x538, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EH3 },
> -       { PCI_VENDOR_ID_MATROX, 0x53a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200=
_EH5 },
> -       {0,}
> +       { PCI_VDEVICE(MATROX, 0x0520), .driver_data =3D G200_PCI },
> +       { PCI_VDEVICE(MATROX, 0x0521), .driver_data =3D G200_AGP },
> +       { PCI_VDEVICE(MATROX, 0x0522), .driver_data =3D G200_SE_A },
> +       { PCI_VDEVICE(MATROX, 0x0524), .driver_data =3D G200_SE_B },
> +       { PCI_VDEVICE(MATROX, 0x0530), .driver_data =3D G200_EV },
> +       { PCI_VDEVICE(MATROX, 0x0532), .driver_data =3D G200_WB },
> +       { PCI_VDEVICE(MATROX, 0x0533), .driver_data =3D G200_EH },
> +       { PCI_VDEVICE(MATROX, 0x0534), .driver_data =3D G200_ER },
> +       { PCI_VDEVICE(MATROX, 0x0536), .driver_data =3D G200_EW3 },
> +       { PCI_VDEVICE(MATROX, 0x0538), .driver_data =3D G200_EH3 },
> +       { PCI_VDEVICE(MATROX, 0x053a), .driver_data =3D G200_EH5 },
> +       { }
>  };
>
>  MODULE_DEVICE_TABLE(pci, mgag200_pciidlist);
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.=
c
> index 2bbb1168a3ff..6c3c309b8e4d 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -50,11 +50,16 @@
>  #include "qxl_object.h"
>
>  static const struct pci_device_id pciidlist[] =3D {
> -       { 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA <<=
 8,
> -         0xffff00, 0 },
> -       { 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_OTHER =
<< 8,
> -         0xffff00, 0 },
> -       { 0, 0, 0 },
> +       {
> +               PCI_DEVICE(0x1b36, 0x0100),
> +               .class =3D PCI_CLASS_DISPLAY_VGA << 8,
> +               .class_mask =3D 0xffff00
> +       }, {
> +               PCI_DEVICE(0x1b36, 0x0100),
> +               .class =3D PCI_CLASS_DISPLAY_OTHER << 8,
> +               .class_mask =3D 0xffff00
> +       },
> +       { },
>  };
>  MODULE_DEVICE_TABLE(pci, pciidlist);
>
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> --
> 2.47.3
>
