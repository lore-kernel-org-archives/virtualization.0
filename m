Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113834252B
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459066; cv=pass; b=XXHn42zSbbVeRYF1MTeB+CUn9tKpzzE10SyLzngPOrbl88y5L3Ok4lrXYNfDTxQO0c9go2XQgEVRUo52jI2CXF3qAJi1klLecCmGdd/06BcAbTvxARhGiqu6W9XaFu8RVigIQMSFHHyhdU6kxf4wK0anGgSvp87qrjgYJSKj6fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459066; c=relaxed/simple;
	bh=j0mPX6D1udoICLrOWMnBa6G8xraJgQSDcns4hqgts1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wukv4LukgV6qdBmWBPX+Wb2eyPYpqxlsMD0ynW4IxJMjUjLA4NtWJJ3/tFtiGPsw8ZBPBgc4m8tZAeQ0kMnn8wNJ5USJcGBAqZqA4ZlyUbN1zZyT69VXZmoZ4AxX+eU7APNQRaGz7hQx0Rzu1gvNZ0P9kKkT6+Vp/wePMF3qxFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNj5IhhC; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNj5IhhC"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a1f80fd2e4so441651a12.1
        for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 07:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786459063; cv=none;
        d=google.com; s=arc-20260327;
        b=IpMyRg/XP5QjZ7+HWeuBRPP/XQXe3X1PQCoL6K6zoZg0F0qPwnyiJ4sVAiv2RDQ7ia
         l3tT605L3IECSF8uTs92chtKPN5ajBYFdI3y1DJevoQ5InstzYEe3Tuu+S9bJ/PmbvBS
         1ChSBJVFyDGmNVN3ZtWf6exrJoNo3BgSzlvsW+gql0hnhPd8mFYOHksnzkt1LevFw2hU
         MvqeUcgTpchTd300Qy61ceZkoqDmSj5ovxCrRci3foMLkS/0TJqxENBv6BBp7SSXA7HY
         CFwmtUTiNSmORjRppJEUsLlswMIMLYhs1rBk8lFicCuJx8MkhxC+LotdCaGJgd1TEsoX
         hFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n+LMSTbD4cIIlUAYX526qV1Be8813NnLBO4pSP/4pV8=;
        fh=S8s9xap7bV3bMAHH/a2TbdMVPw30jDuvKzoSbKcxbEQ=;
        b=mFDX5Niln0BkogvjYuU0tfMjvFiK6VtSyilGtc8m6EoRrTrNaLXamf8D8uvAn3EZfD
         dXAZEM9SuVEQBZwvP4vFOVX0wrUGg11U2Y1znnB8vJSDCp7K5gXQ5M9ggXjra1RJhr+c
         wCKWmnJMRzH78LUuoxl40eqsXDr/dHxfP1y8DFHB5fTp8/WPZ5BAjVHjMbOzmVeh/nF7
         jZtjpFnIx5OvHXbfmkPXOdopJBUUqc857RAS8Xk9jwFCWwIA9EC/cCudczoDkNe/wUid
         jKApajvxNEznTjpM8gBlXLRURuVo/7LAKdLLyPIjBV4MF4Vn1/ojilyYlu16LCoBa+lN
         MAhA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459063; x=1787063863; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n+LMSTbD4cIIlUAYX526qV1Be8813NnLBO4pSP/4pV8=;
        b=QNj5IhhCz2Bp4GZEPetSoXbwwbi70jBm6Ldf3z6yCYDD1R2JoIvdUd6/CEMCERuJWJ
         dGMHNg+GrNiVzazRiKYW4j8bg3DxU05VJWNsNOjkYHazlmnea6iDQSlP508sUH4hg2l0
         ppugGN7KsBT3KWNzMeGgue5/s1gSvb4XLV+ws/PZo0mvmo7HqPAVouchBWw1GzVjVaRw
         2gM4QqiFnql5l2EvYGeB+/ZxBhuCxcnskWiq/CsKZ3xNlY5o+93anF+rcLU0ssxBvQQX
         8w3gkbXxahUBRNU+iCJ+c6T0fR082xxJFMzJFNLY8/BtKRKhzj2jk9SyLw26mt3FSCHt
         xuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459063; x=1787063863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+LMSTbD4cIIlUAYX526qV1Be8813NnLBO4pSP/4pV8=;
        b=oYMTATjsXBJ5GG/2JZFqdBuSqlCRmGktUTPulrHaYr1yHqZ8qgotZiqJHpUufROil3
         NtHUcDJRXFQwXLcc1S3VqXPEwoHcJO/sOjCSbSEj1UjWCIpowK71S4wsQ4J/Gv1a3Zhf
         Ho4ZF2YCaPe+l8kBYNTfgCp7hdFXqL6O8AKrycHUtXbTcG4Gbd0WkmUtpFugdRnYN72a
         rcYRh8Gmbn8P6UcNDEM3ydN48ZxsgBRJaEJPokMwkiewlpjlkRWiRFsLbfSRhXYGoqGB
         M/WtYkFB+cUvAoHaiGz+yEw7NJlQIregTm1K0O1pGqIYwTLCu+1DCI+0sWDwRuLBaR5A
         LuVg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2hGL+UpD5xnQjrJ1vomeEiab+qCA1cBqQ5Y8w4t5rSCvnT5gHWjTkQTtuDFrUMaDMFskstf3BSXKQdAnYPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFNeoRYAKHRISWZVymuuqr+W2VHf5TYK9DpmRdRZcD6xTWz3sf
	h57ohuxSXnO9/IMXw0iuRpbFmR0aT9jA8KSpwS3QJ+IqLENy9zcoWutYzAqdpxi1KKLtLYe6IvI
	LsglAILBJdYMJ7OMqzPpToi9lFuXtQRY=
X-Gm-Gg: AR+sD11u1sDdVDRvMYirfyy/O51uW0KsNtkgMd+p+DOEUGExsfvwePP+XIj0Rip9pVd
	SHzQY78Q9aWhzjG7HY7sbx0jsggzYEkk+kKFkWqgrohGRzAgC/oLReLU4R+dQeZEiStH7HmTPcP
	4qu1MQXsFNVoX23EYHx1BS/fUZUiMeVIm00/CqWpLDp6PFh0L0/qFLefWHT1tvzAlZhni4n5Dak
	ZwkiUmgwKHs1dx+0PeN/Jicji9Sz0Ws6DZeSaE3U/OvTbRV3mmUXdF6UKpB/+QPStPgVoui/QJH
	UuiPJcaejmZYxWV2COm10LJf9hkk226USRLyD6MeWCK9ghDkWlInyQN+FWpdlzVIoK4m3fbMIHA
	6f5U=
X-Received: by 2002:a05:6402:52ca:b0:6a1:f3b5:f7dc with SMTP id
 4fb4d7f45d1cf-6a36d0c5908mr362506a12.4.1786459062712; Tue, 11 Aug 2026
 07:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <am2QeS/lS+Cova+I@yokbvdiprd370.nvidia.com> <CAJSP0QVSBsg0_pCaxy8Sar3=G+sdj5Z8R5yNmUomGy+C5YrHJQ@mail.gmail.com>
 <anP0FimfttCpDMKW@yokbvdiprd370.nvidia.com>
In-Reply-To: <anP0FimfttCpDMKW@yokbvdiprd370.nvidia.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Aug 2026 10:37:28 -0400
X-Gm-Features: AUfX_mxzcGA4XPxYE1zJqZHivc7uWpGWMyYBqIqN_mUx-tx5bISwY9OA8oaCuoc
Message-ID: <CAJSP0QV1=SUYFy3XKe8tWeore3EVQEjN7EWfLZ8QLm8qY4rEtg@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: add use_irq_affinity module parameter
To: "Liu, Changcheng" <jerrliu@nvidia.com>
Cc: pbonzini@redhat.com, virtualization@lists.linux.dev, 
	changcheng.liu@aliyun.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 10:40=E2=80=AFPM Liu, Changcheng <jerrliu@nvidia.com=
> wrote:
>
> On Wed, Aug 05, 2026 at 01:45:58PM -0400, Stefan Hajnoczi wrote:
> >
> > On Sat, Aug 1, 2026 at 2:21=E2=80=AFAM Liu, Changcheng <jerrliu@nvidia.=
com> wrote:
> > >
> > > When creating many virtio-blk devices, probe starts failing with
> > > -ENOSPC (-28) because the system runs out of interrupt vectors:
> > >
> > >   virtio_blk virtioNNN: probe with driver virtio_blk failed with erro=
r -28
> > >
> > > By default virtio-blk uses managed IRQ affinity, which reserves an
> > > interrupt vector on every CPU for each device (about nr_cpus vectors =
per
> > > device). On a host with many CPUs and many devices this exhausts the
> > > vectors long before all devices are probed.
> > >
> > > Add use_irq_affinity (default true, no behaviour change). Set it to 0=
 to
> > > use unmanaged interrupts, so each device only uses a couple of vector=
s
> > > instead of one per CPU, allowing far more devices to probe.
> > >
> > > Signed-off-by: Liu, Changcheng <jerrliu@nvidia.com>
> >
> > There is already a num_request_queues module parameter for cases where
> > the user wishes to reduce the number of virtqueues. Did you benchmark
> > that and decide the performance of many queues sharing a single irq
> > makes it worth adding another module parameter?
> >
> > Stefan
>
> num_request_queues does not address this case because each virtio-blk dev=
ice
> already has only one request virtqueue when the failure occurs, so the qu=
eue
> count cannot be reduced further.

Okay.

> The issue is reproduced after probing approximately 800 virtio-blk device=
s on
> a 64-core bare-metal host. With managed IRQ affinity, the IRQ-vector rese=
rvations
> are eventually exhausted and probing additional devices fails with -ENOSP=
C.
> Disabling managed IRQ affinity avoids these per-CPU vector reservations a=
nd
> allows more devices to be probed successfully.

I don't follow. My understanding was that non-managed IRQ vectors are
allocated by request_irq(), which is called during virtio_find_vqs().
Probing 800 devices would still require 800 * (1 virtqueue irq + 1
config change irq) =3D 1,600 vectors. How come non-managed IRQs do not
hit the limit here?

Thanks,
Stefan

> This patch does not cause multiple virtqueues to share a single IRQ. Pass=
ing a
> NULL affinity descriptor only disables managed IRQ affinity. Regardless o=
f the
> number of virtqueues, virtio-pci still first attempts to allocate a separ=
ate
> interrupt vector for each interrupt-driven virtqueue. Only if per-VQ vect=
or
> allocation fails does the existing virtio-pci fallback share a vector amo=
ng
> the virtqueues, and that fallback is independent of this patch.
>
> The new parameter defaults to enabled, so the existing driver behavior re=
mains
> unchanged unless the option is explicitly disabled. The option is intende=
d for
> environments with a very large number of devices, particularly for functi=
onal
> device testing.
>
> - Changcheng
>
> >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 32bf3ba07a9d..184f1c1f4485 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -41,6 +41,11 @@ static unsigned int poll_queues;
> > >  module_param(poll_queues, uint, 0644);
> > >  MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues fo=
r polling I/O");
> > >
> > > +static bool use_irq_affinity =3D true;
> > > +module_param(use_irq_affinity, bool, 0644);
> > > +MODULE_PARM_DESC(use_irq_affinity,
> > > +                "Use managed IRQ affinity for virtqueues (default: t=
rue)");
> > > +
> > >  static int major;
> > >  static DEFINE_IDA(vd_index_ida);
> > >
> > > @@ -1016,7 +1021,8 @@ static int init_vq(struct virtio_blk *vblk)
> > >         }
> > >
> > >         /* Discover virtqueues and write information to configuration=
.  */
> > > -       err =3D virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
> > > +       err =3D virtio_find_vqs(vdev, num_vqs, vqs, vqs_info,
> > > +                             use_irq_affinity ? &desc : NULL);
> > >         if (err)
> > >                 goto out;
> > >
> > > --
> > > 2.43.7
> > >
> > >
