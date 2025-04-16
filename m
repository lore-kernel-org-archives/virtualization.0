Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8A18DB37
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791391; cv=none; b=i/eWIbyNvhwCBRq9dkzBshn8ICOyWKSseVHiaKBGV6cG7CRPq3FoIXDsUehREl6+9APBKf7iWe3SaDMY+IDlTOc9OgFjFMOoXCzy06ICEWKY9NBOnWxYGoxtlt0gyFfEKLGpuu8pOA8WbiTKNawrB9ISGwPLFnugFc9MHpj+FFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791391; c=relaxed/simple;
	bh=FDlaVgjo1I9UYbKA97JlD3TeRAETH1FgPzAyGdowi3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIfcNJ8EqmAGtzToSXm7XUrlchBiqv9HicdnW0zaBAYGBok7ATSzZziuvacVNAJP608lBxUPsC4kjwCEIxdLm7fFgCgVpj6GLnDtgknpwfFG3AxsBJ7n+36nC+H2Dfc4t5Bw2mVeqK0HZEaH7d9qiLg+OxBT6ckehFfQMfIvDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVbVUICr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVbVUICr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744791388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YJf0uNGMARC6l3YgNJT5XK+qkS/6/zUZJDuy3jnfdM=;
	b=AVbVUICr8i034ZyGPo77fDc3cqwRPowjGuS7XZwAOJ3Y8mWC4RFYx7eBxOubjHQkVNnZz6
	6cvjUDcZQh1ATSIudKqOVh6awDH3T3bMW9Uuq40qY8yUnCh+AE9Znv0lViZ4rS1FNh9IW2
	OMchvEQQBq8lPLHmaySfheSff6UuTl4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-p9nhydMYNASc9nsZALJ_bw-1; Wed, 16 Apr 2025 04:16:26 -0400
X-MC-Unique: p9nhydMYNASc9nsZALJ_bw-1
X-Mimecast-MFC-AGG-ID: p9nhydMYNASc9nsZALJ_bw_1744791386
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so489624a91.1
        for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 01:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744791386; x=1745396186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YJf0uNGMARC6l3YgNJT5XK+qkS/6/zUZJDuy3jnfdM=;
        b=uHfx1riYSK4MaZpp8WM4+Fn7/uv8pS1iLBuQm878GlL6XhQIVew5qfZFfWRQ0v2fS7
         hGfC4wK86fcUcilOi4Qv0SqDx1M5HoKPijtWJVNKf3Q5xIO29MXNcJGouUPar1eNuQSi
         HJLvf+R8F2V786BkbW1kkE9ZteUepYJOO6Eh63QA8aBfgus/zxsiDE86jpkhZrG4iRgF
         wTw3l/MWJCM+QjKjyYjhC8eWaJN9bfvHmTo0zNeBodxuDozYSBpK4Bz7heficcRDmco1
         XYjYiXnIon5YQ6zo+9kGmT3U8ldYx3UmwIpRRN2T961K8Pw7Ky5dAnxmwvDftuc6mwee
         Hh0w==
X-Forwarded-Encrypted: i=1; AJvYcCVv3h/jvwoFoPNhMsrFyqvEs34l5EGYPFqloGh0uvRD7GV5pE9Stt6p6N3eRNeTybXekjq39L4Z9+HkadsRJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqq0eEwtc/acD4LyX3lC3nlcuX/NoDJkXIevz6w5k67bR2ssVx
	Cgz3pLKPa7ogVwZZ5SKsmXRwex6E8qDBnN1+a+m1uZcW8Bvaqgj1dpiqdoPM/nKsKRGhxKMl0Y2
	8WS/kTJM/uAVBp1OdSPAG2LFnpPvgAk0JnhU6AX7LKx9lShew3qL/BIbvaFiJqWwfgdX2VKjGa4
	XmMjg1OiCwf8Z8oGmQ27KH0MW3BpNI0YGzm3iT9do=
X-Gm-Gg: ASbGnct6MGVXphy+jnPLbIL1LGDYEUbkfcwUeAg+UBz2G+WCASc/08pRiS/JVg5IQJu
	7Y7nMM7/xYEhgtipde337rSsUwapY1gpozCVPMBQSzTCePAD35RgFJm/aY0J4lqH96bsskzEECR
	jDEFbNLNlNxfnQ0muSZqMLAnPW
X-Received: by 2002:a17:90b:51cf:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-30864292d23mr1402237a91.8.1744791385682;
        Wed, 16 Apr 2025 01:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzrUSVYztyhmSnVvzEX9NlBIbpp4wsLgkVASOIWRxXnBWQ/ej/hqFPgo7RNSvfvdKL9orQuHap7MNTBS1D2Mo=
X-Received: by 2002:a17:90b:51cf:b0:2fb:fe21:4841 with SMTP id
 98e67ed59e1d1-30864292d23mr1402204a91.8.1744791385351; Wed, 16 Apr 2025
 01:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412132012.291837-1-ryasuoka@redhat.com> <d36c2ba7-52b6-4688-bb2b-70b8bd4d33c0@collabora.com>
In-Reply-To: <d36c2ba7-52b6-4688-bb2b-70b8bd4d33c0@collabora.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Wed, 16 Apr 2025 17:16:12 +0900
X-Gm-Features: ATxdqUGT9jMuGYtdwMyQrqqaRquKvFEmvpodZfFuXApiY_oe8OnZKvOncC1PQXc
Message-ID: <CAHpthZqOQZuQHbTCPH4ON6bRLRkd0X8ttTnwm8Nonrg=mvsmLw@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Support drm_panic with non-vmapped shmem BO
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, tzimmermann@suse.de
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	simona@ffwll.ch, jfalempe@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aEJOGNY2j1p1pYh5ukeiwXvxcLM1I0x-MyuIopQ-OjI_1744791386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:29=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 4/12/25 16:20, Ryosuke Yasuoka wrote:
> > Pass array of pages of the scanout buffer [1] to shmem BO, allowing
> > drm_panic to work even if the BO is not vmapped.
> >
> > [1] https://lore.kernel.org/all/20250407140138.162383-3-jfalempe@redhat=
.com/
> >
> > Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_plane.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/v=
irtio/virtgpu_plane.c
> > index a6f5a78f436a..2ff57d559c86 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > @@ -500,11 +500,19 @@ static int virtio_drm_get_scanout_buffer(struct d=
rm_plane *plane,
> >
> >       bo =3D gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
> >
> > -     /* Only support mapped shmem bo */
> > -     if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach || !bo-=
>base.vaddr)
> > +     if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach)
> >               return -ENODEV;
> >
> > -     iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
> > +     if (bo->base.vaddr)
> > +             iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
> > +     else {
> > +             struct drm_gem_shmem_object *shmem =3D &bo->base;
> > +
> > +             if (!shmem->pages)
> > +                     return -ENODEV;
> > +             /* map scanout buffer later */
> > +             sb->pages =3D shmem->pages;
> > +     }
> >
> >       sb->format =3D plane->state->fb->format;
> >       sb->height =3D plane->state->fb->height;
> >
> > base-commit: e7bb7d44c3b97aea1f0e354c6499900154ac67f2
>
> Rebased on top of [1], fixed checkpatch warning about braces and applied
> to misc-next. Thanks!
>
> [1] https://lore.kernel.org/all/20250414131507.566072-1-tzimmermann@suse.=
de/

Thomas,
Thank you for your comment.

Dmitry,
Thank you for fixing it and applying my patch.

> --
> Best regards,
> Dmitry
>

Best regards,
Ryosuke

