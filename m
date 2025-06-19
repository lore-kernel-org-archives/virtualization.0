Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303724293C
	for <virtualization@lists.linux.dev>; Thu, 19 Jun 2025 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315046; cv=none; b=JaJQRi9eVUkEtIwtYfQmlc5D2L/S+ej2hVr43X0WW+mDsxuSXgmjnnjIVgl4iPZpzqGDye5bGHDwlXGrpyJ8Cj6UVCTCu+sR6yqoP03pa2TiDL5SnTqLKODpDcl9LuRI4wZtWRbeY4OIlYOQbUV+CUBeIf8Ijcw8Tz9H6nHyvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315046; c=relaxed/simple;
	bh=lg3ViviuHKRtuxRr6EtVrs3PYIgqIOuqD4vH6n5ib9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTYeo/nqJdWBFtnbtisiEHiqoxL+KRo7AuxkZyNgOAWftIRhakEZOX9X19HRgy4wKwKDrMBnZEj4EFrmqEd5bnowLQ5a1lcu9hNTbGo2JgqSREQWdnIoJH1NWiW1OKRAihplkoz5YkjylrulPqOQWpMn+jgLk1FNYWqZOVb4tfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hi4nn8mR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hi4nn8mR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750315043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uNMBk0wAlkZx/rfLqOzJesJna8POdoskmu3HAnO65Y=;
	b=Hi4nn8mR2KFTHOn3CvXhad9PPJYY8M7GAoXbGcofHbSB7LMjBEHMaZh/f2+dgA+0RBCYkT
	ZHW+KG+Nno1kQH7Pt4oxf2UGP41u5iK0k7YMav3OFS8cMX+6ZUvfkcvTN+/vXfSo0r24Fs
	2NvbLQV6xqFFOK+u/FfUKkG1aC038bs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-qxVCt--FOQGE2gjINQJwQg-1; Thu, 19 Jun 2025 02:37:20 -0400
X-MC-Unique: qxVCt--FOQGE2gjINQJwQg-1
X-Mimecast-MFC-AGG-ID: qxVCt--FOQGE2gjINQJwQg_1750315039
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so510460a91.2
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 23:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750315039; x=1750919839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uNMBk0wAlkZx/rfLqOzJesJna8POdoskmu3HAnO65Y=;
        b=wTRc+n2f4ulWiNE68ISG/IqChFXvr7grR4b12f4fjx388JKemo4Xwblata0cgl9ypv
         TirW+6zuPbcQL7X16J+dOCTiyYOhlF12Cd7JzsnSUPWn3g6FEeVkYnJ50T6f2oimOv/w
         0a6gvIVbYaBSlOtOangHVmni//JyuJwyVyzFdbkKyelC+wY7QyXykaJv9hnowKZYTxC3
         GqHksCGw2GpkAdr0/DgDmIFCPeJuoL3kWOHWyAySHSYDKI9XXaKFeF5boftLvV5HfWB6
         hBdg7tdahVxVFR4HqgAsJxeY+yGgpIkdqo/dpwORNs5YgZu4L0UsvtfBBIclCjUtIEKS
         P7cw==
X-Forwarded-Encrypted: i=1; AJvYcCWXlkeEjMGewBez7k4hYJH69T72X8YgMRRNG3QXXy+X4OZxWf+HJQfn6DZDpg5fDM8ZRhTw9xdhsuDKOHBM/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrZkZ6u3yUgehEkHB/RL2leYJZ4CFeGEMeDeama/KGyAe00tU9
	nDu0jbaJ+vRORyldQwdPV3t35wbGCvjSAVHhMrHh+xe7/oyyLQKPqXRyQ5gEBLak8+fZiky9XmV
	GzMsmXAFHj4nBfRrpN6sW9gDvWH3FZoCp9xsLZoBof9RoIB2D/vOIrvrReaBu9O/2inOvK2BMFu
	VhgMrzVRHpyQ9V7gPR+nb0+vHTj+9PUjmEISZYVaOLONE=
X-Gm-Gg: ASbGncsgg3D9SHXKn8IfWl4CSwjc8SzacoHXkq1QCCCYbOL4T+tVhx422tpdESseyLj
	FGWWjWiITlMrLhRK5faXEfJNWE3bboCXeHhf5ylz2Yvl2M6BgmwKFCcYGjdLbtLc3ePDQuIAnCd
	vLk9UjDVlcSZDfhdKwM/4ggwHUiGtunBSkgRz8Gg==
X-Received: by 2002:a17:90b:528f:b0:312:2bb:aa89 with SMTP id 98e67ed59e1d1-313f1d50e08mr28234698a91.20.1750315039369;
        Wed, 18 Jun 2025 23:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX7GnjAlVhwgCg3zE5Ch7H7SHvP9QUYPvl7kO44iyN3b8BgkXc1zdxaWZ+FGkVn/hULPc5fRFcJjWwX6646bY=
X-Received: by 2002:a17:90b:528f:b0:312:2bb:aa89 with SMTP id
 98e67ed59e1d1-313f1d50e08mr28234671a91.20.1750315038936; Wed, 18 Jun 2025
 23:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250613132023.106946-1-ryasuoka@redhat.com> <30f0ea0c-d8fb-461e-86ab-6e7677beac3c@redhat.com>
In-Reply-To: <30f0ea0c-d8fb-461e-86ab-6e7677beac3c@redhat.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Thu, 19 Jun 2025 15:37:06 +0900
X-Gm-Features: AX0GCFvSMUcq1h_W5ABI167G5MpNn8Cu_AvBDu-QBtX7eKvqtg0izjF5ovDEkb4
Message-ID: <CAHpthZqfzOXfxzv7OTaLK0x_qro1sHKOHqPeFxwNA4_5FYQrRw@mail.gmail.com>
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TLplxE_bfgj2Nwuje_yVXCVGWMICn_5gg5LxttFCkRM_1750315039
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 3:12=E2=80=AFPM Jocelyn Falempe <jfalempe@redhat.co=
m> wrote:
>
> On 13/06/2025 15:20, Ryosuke Yasuoka wrote:
> > Add drm_panic moudle for bochs drm so that panic screen can be displaye=
d
> > on panic.
>
> Thanks for the patch, it's simple and looks good to me.
>
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>
> If no objections, I will push it next Monday.
>
> Best regards,
>
> --
>
> Jocelyn

Thank you Jocelyn for reviewing my patch.
Now I found a typo in the commit message; moudle -> module.

Let me fix it in v2.

Ryosuke

> >
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >   drivers/gpu/drm/tiny/bochs.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.=
c
> > index 8706763af8fb..ed42ad5c4927 100644
> > --- a/drivers/gpu/drm/tiny/bochs.c
> > +++ b/drivers/gpu/drm/tiny/bochs.c
> > @@ -19,6 +19,7 @@
> >   #include <drm/drm_gem_shmem_helper.h>
> >   #include <drm/drm_managed.h>
> >   #include <drm/drm_module.h>
> > +#include <drm/drm_panic.h>
> >   #include <drm/drm_plane_helper.h>
> >   #include <drm/drm_probe_helper.h>
> >
> > @@ -469,10 +470,28 @@ static void bochs_primary_plane_helper_atomic_upd=
ate(struct drm_plane *plane,
> >       bochs_hw_setformat(bochs, fb->format);
> >   }
> >
> > +static int bochs_primary_plane_helper_get_scanout_buffer(struct drm_pl=
ane *plane,
> > +                                                       struct drm_scan=
out_buffer *sb)
> > +{
> > +     struct bochs_device *bochs =3D to_bochs_device(plane->dev);
> > +     struct iosys_map map =3D IOSYS_MAP_INIT_VADDR_IOMEM(bochs->fb_map=
);
> > +
> > +     if (plane->state && plane->state->fb) {
> > +             sb->format =3D plane->state->fb->format;
> > +             sb->width =3D plane->state->fb->width;
> > +             sb->height =3D plane->state->fb->height;
> > +             sb->pitch[0] =3D plane->state->fb->pitches[0];
> > +             sb->map[0] =3D map;
> > +             return 0;
> > +     }
> > +     return -ENODEV;
> > +}
> > +
> >   static const struct drm_plane_helper_funcs bochs_primary_plane_helper=
_funcs =3D {
> >       DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> >       .atomic_check =3D bochs_primary_plane_helper_atomic_check,
> >       .atomic_update =3D bochs_primary_plane_helper_atomic_update,
> > +     .get_scanout_buffer =3D bochs_primary_plane_helper_get_scanout_bu=
ffer,
> >   };
> >
> >   static const struct drm_plane_funcs bochs_primary_plane_funcs =3D {
> >
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>

