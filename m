Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BAF2080D6
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663164; cv=none; b=VEp+VR4YJtGdwXqXCH870qHcAaGFOzH4mWCGFkVb+a4dIRnK3gIyX2qeNTUkd8ArpAf31i5u2PWLAjRp2eaSibgk1MRQG9Unq5DrF4IDveblOt676sJ5SZR/WDrcLAe+T8A1xE8+7TUO4OvPnzdhPeMEV2cZPZBfhH4I4nErLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663164; c=relaxed/simple;
	bh=GHHnPYOL+gRUE/196eOq/gj7fZDZsKf1B63nUWSuP1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfwXIyHJ+hC2i7LdDH1jdz3i+wkO4BWIZZpLq8dj4vX4QXd5igXk9BQIdqW5BZE8WDrBYtzspIYbIYqp7jBb4PRUERGOlqAjOHDkd/iUxC4PYkJ7XZsw0pchzI9ZorqZJiYzsfkBWOJQiRmPPpLN8q6Lpk5FbYxtWP0sokT+vGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hefdWeL3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hefdWeL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738663161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wGv2FsoKufVcLbYy1/87/ZPdb2v6fo4T2VRc/m1Duk=;
	b=hefdWeL3EWD7nwa6+cS96ZK5loSQw6cBI+DaUHmbuuBYvAUoUAPp/ZgSPF87xSdYgv4c5r
	m+1X06hpc56uGd6VThIQWwupbe69ow+d43qYNck01XYqqjYLNjRE9b/esiRPkLqfC7r8QF
	WPqgmsHVd0ofQmPWtbsB7rQUOmRwCGc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-vQjhPUA7OgOawPaHtbV2fQ-1; Tue, 04 Feb 2025 04:59:20 -0500
X-MC-Unique: vQjhPUA7OgOawPaHtbV2fQ-1
X-Mimecast-MFC-AGG-ID: vQjhPUA7OgOawPaHtbV2fQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab2b300e5daso621733566b.1
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 01:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738663159; x=1739267959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wGv2FsoKufVcLbYy1/87/ZPdb2v6fo4T2VRc/m1Duk=;
        b=wZLw+bkfFae5gz46ka3BL5sBSyi5sEJC1aoOe+3rC+YLkXZE7RUFEQaTE88EWaVrDY
         gw8I/ymh8YWNyjLVB9Otq2u8bWfNa3HuLiVdPUTrwAURKYjCX7GkEU+7wDmMvSPevHi9
         hamMcKcYeSRLhiuL1WNDwR8FLRX0zlkTdAole6VlJSTkljQqSDyKRs2d9nF1BAAsZ0m5
         Ppo8sCouGs73qrzqgCgm2YuDSmTMNMJjrhDwNxLeidK7KbU4q2WIlC5Z7IWLxmOWAx4X
         /mzCGfiLb84VxyWTELRk+7djNN2gEM6BD9Yhm30D/kD9VRytGHG+q41vGwuSCarOAOLx
         aJvw==
X-Forwarded-Encrypted: i=1; AJvYcCW7TBFX9am1IfLU0qhm7nLTfbJO7ggcBMvki55Gx4HLNY9mZr1Wdih808+5mWCxwCePupHU6Xg/Vvl1Y/271A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1HQnEhXaZDSUygxldSTekkB/FQnJi1s+MxuT0rkBb83vXrw6E
	0Sx4tmcD7Q3QXNjzbz4fW3A+YR/s2rOwEBRbsYFLCzZOFOECBIaryLMNNil8OBSZxIOu28sHqW4
	xjuMnheW/cnIa81f3UlTJW2LeLaSYA4vAehtKZRZgaqZXgynOECK/CsYD53CtVn+XckBj3m+Cl0
	EzQ6+DHZb+wrHGrBbC9chpEusGpzCIXoK1e3CR9dPu/8IqBsQmQt94
X-Gm-Gg: ASbGncsFiODExz0xdVi7X4+4TzjKtZ979EYuFNYJnAnAXY3crQ9RzgbWa5nlmpZLn/h
	4x/a1KTWx5pf22G/u/tGxMKqxfZ3NAhccSl1/lcaYjpYbPyy1GBLc9x0VCrbgQbDVkfSy/R0nQr
	9x8e7UEi/apqGp7qz56Q==
X-Received: by 2002:a17:907:6d26:b0:aac:4324:977e with SMTP id a640c23a62f3a-ab6cfd076admr3317236766b.27.1738663159044;
        Tue, 04 Feb 2025 01:59:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXtRcEnuU6oA06Z0ReFSRWzAHGLOtGcVBMkSs7QVLQN14Wwp3N7kI/IyVUADKD48QX2iJ3nCKN8Er+Pj17+XI=
X-Received: by 2002:a17:907:6d26:b0:aac:4324:977e with SMTP id
 a640c23a62f3a-ab6cfd076admr3317235066b.27.1738663158657; Tue, 04 Feb 2025
 01:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250130090517.201356-1-ryasuoka@redhat.com> <75cf3adc-400e-44a6-b653-bee1f0cb43ec@collabora.com>
In-Reply-To: <75cf3adc-400e-44a6-b653-bee1f0cb43ec@collabora.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Tue, 4 Feb 2025 18:59:07 +0900
X-Gm-Features: AWEUYZl1gCs8i_nghDi3JecpQ0sWd8PMYpAqhqfVffZeODkRQxTx-IAv0cYMK8k
Message-ID: <CAHpthZo=R=Csru2P8NVY8YKaasb2RTyrMYni-=8ri4K=xd8abA@mail.gmail.com>
Subject: Re: [PATCH v6] drm/virtio: Add drm_panic support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, daniel@ffwll.ch, jfalempe@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AeE8SmxcXCT32oN89oOOKxRszcm6EvaZGx_9wWib1O4_1738663159
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 3, 2025 at 2:18=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi,
>
> On 1/30/25 12:05, Ryosuke Yasuoka wrote:
> ...
> > +static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
> > +                                      struct drm_scanout_buffer *sb)
> > +{
> > +     struct virtio_gpu_object *bo;
> > +
> > +     if (!plane->state || !plane->state->fb || !plane->state->visible)
> > +             return -ENODEV;
> > +
> > +     bo =3D gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
> > +     if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach)
> > +             return -ENODEV;
> > +
> > +     /* try to vmap it if possible */
> > +     if (!bo->base.vaddr) {
> > +             int ret;
> > +
> > +             ret =3D drm_gem_shmem_vmap(&bo->base, &sb->map[0]);
>
> drm_gem_shmem_vmap() requires BO resv to be locked, it also may invoke
> drm_gem_shmem_get_pages() that sleeps. This function can't be used in
> atomic context.
>
> For the starter, let's reject !bo->base.vaddr BOs. Normally, shmem FB
> BOs are always vmapped.

OK. I'll reject !bo->base.vaddr BO in the next patch. I think this panic
feature won't work when I call panic in GUI environment (I test in Gnome)
without vmap(). It is OK as the first version but I think I should mention
it somewhere. Where should I mention, in a commit message or in code like b=
elow?

~~~
static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
struct drm_scanout_buffer *sb)
{
struct virtio_gpu_object *bo;

if (!plane->state || !plane->state->fb || !plane->state->visible)
return -ENODEV;

bo =3D gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);

/* Only support mapped shmem bo */
if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach || !bo->base.vadd=
r)
return -ENODEV;
~~~

> --
> Best regards,
> Dmitry
>

Thank you for your comment.
Ryosuke

