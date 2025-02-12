Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE74C202C48;
	Wed, 12 Feb 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394444; cv=none; b=nayFAdprubI3U1f8eqL1ao/BCT6gOQydoP2GU814inyH1PRwGdqiwlGkxkOPrbUBDfHsSFNp5eFT3MgMH3srHcMKxAtefwtwybQe5tmItxxc3vs1uuiuGzyravbQSZDU1La4J2pMLhxeRb3WfM3CtSOTQbJJMgU8BH//GWIynfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394444; c=relaxed/simple;
	bh=kRaMIVwqGc8Xd49sSQZRLuGh6bNy3XlVKUPtAyzoRVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNHDd89bQYl8LVdGjr5926IkOtRY8jhjJS/Nazl22WepKRusR/SD8EVct08wnHCcgctfKUe7wOs71nqCucDhDLa8TXLOIe4qMgHRmsfwNgNKz7P96dKMc4ew1xD6cNbF44gR5RKTM3F4xz9TtVLkneeuYFuLtDTN/TXtsaYJG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAnAKepO; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAnAKepO"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d149f4c64aso377635ab.0;
        Wed, 12 Feb 2025 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739394442; x=1739999242; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m2BC0PlpLZ3PvBNk1lJNnbfheS8gB4DKKdxAHYzcP4=;
        b=TAnAKepO7jdMHs0wYHl3O5BpQ+Hdyq0V2d+3hc72UqBM3cujvrO6qxDkm8KGO+wnWz
         u1vbxBnUxH7H45pgGKMYx9r9NEw7uFTeCIc+7quRyppmo1zbFYFiwJD0vTCQEuBbKzIr
         JpURfwwcgbdAdVE3nCOUZHnEem204ygdZdt2J0CuEybXZbxHkQv7dRVnMiXdx4Me/d/x
         7H0HaP4V0fzn2G0FfyP9BDZizMjUxuIAX9A1h/l8iiuaHVfK1leb0FXsvGxAdm7YsJRb
         NNG/YxMu9oVdw7wcqYVfd3rYH9SpXowmJYpJymyMFL80Y1I0WtNozDee7+1SLeCiEd7y
         p2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739394442; x=1739999242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m2BC0PlpLZ3PvBNk1lJNnbfheS8gB4DKKdxAHYzcP4=;
        b=nF4Q2cT+Bg0SDuCOVoqdXAWA7XOVvG0oqOjpj9bblJSUlFAEkqBFYwi7gGrBYIN16O
         g5AuNwqy6A5wotw6uofFkptrW2JZfFxqs9bhrs3pUmI6Jwd9XkTTLMz+iJ/Mig5XDiIx
         ZqKQxwtSJD2ApdmlD2m/qDLM52le8B3n4NHHmw6ZCK7n1OW/l0fqeJXHz0l2SExCWHY0
         2D8mxQtjMk3rRkRNAV+LxP2sVfH5XBgwnIAZrXbmWJY5otiqekUZIEo3h98iFzHcFeNB
         Yhrt2kzlr3Wx23RLHH3L7uq+hpvka1tiMo9bIQ3GrT/ypCi3vyivVSzH0LicWYUxySbO
         Rm5w==
X-Forwarded-Encrypted: i=1; AJvYcCVaj+k4h0nIUyHP0IjLNVU8OQKB8gRVm7YEg/r99Gb40in+TCXZvrMRCA86zLwYAX9Ogn55gCdy7iePcUWG/1o=@lists.linux.dev, AJvYcCWOFSBduF70nhX7o8Ju9sQlpIprpxiQ3f4i6SvjhNoAbqU2G0T1EuE+Mhbkc9dVZ/1TVU3g+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx28Org1IJoQeGePr6NWXBA+Q6mECl8g4/WyTvq6m2El6ON4i/D
	PBXxxYwWA/DhoTYzcR2OOCNHHNPds9ePbOgxTfwRqZnT4xRTfTAnwErTS+ieJ07Jqy0prtm8LhK
	W11EShK9H5kt3/EK3oOCx8/2nSQg=
X-Gm-Gg: ASbGncsJNobfUv4MRN92o096nycUbPxIn0O6E8vsPbRd5ct+P2phW67KFnG8mgNLXSe
	TqbKfb6Chw6TIK0cwaPE5+NkaqRsP5HDgrcp6yZu3f9ua5rUJxbgwMCK/osULY0WQVs3LzfBw2G
	zoIo+PDUbAwe4aWbxWiKtOu0PoOJI=
X-Google-Smtp-Source: AGHT+IEto3QwYzrpOOb39TT9wusT7oiYBviqDLiw7Xnxk0Go+s385w1whVmNsbgrd9myoMThLMp+uZwQjNnH/c18b1A=
X-Received: by 2002:a05:6e02:338a:b0:3d0:4a82:3f40 with SMTP id
 e9e14a558f8ab-3d17be2216fmr45576995ab.7.1739394441825; Wed, 12 Feb 2025
 13:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250124-virtgpu-mixed-page-size-v1-1-480403790bac@gmail.com> <a55eecdc-76cc-432e-a4b3-90e8753088ac@collabora.com>
In-Reply-To: <a55eecdc-76cc-432e-a4b3-90e8753088ac@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 12 Feb 2025 13:07:10 -0800
X-Gm-Features: AWEUYZlK-LtIBTV8i2bVwjobA09sMmKqOYCs2aSwHvvwvdiGzeqpfq-QqFvpdEU
Message-ID: <CAF6AEGuGWNj7dcC4DouWckaP9fOKgLyqw8iPBwKxrnr9GYXpPg@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/virtio: Align host mapping request to maximum
 platform page size
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: fnkl.kernel@gmail.com, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:52=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 1/25/25 01:01, Sasha Finkelstein via B4 Relay wrote:
> > From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> >
> > This allows running different page sizes between host and guest on
> > platforms that support mixed page sizes.
> >
> > Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_vram.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/vi=
rtio/virtgpu_vram.c
> > index 25df81c027837c248a746e41856b5aa7e216b8d5..8a0577c2170ec9c12cad12b=
e57f9a41c14f04660 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> > @@ -138,6 +138,12 @@ bool virtio_gpu_is_vram(struct virtio_gpu_object *=
bo)
> >       return bo->base.base.funcs =3D=3D &virtio_gpu_vram_funcs;
> >  }
> >
> > +#if defined(__powerpc64__) || defined(__aarch64__) || defined(__mips__=
) || defined(__loongarch__)
> > +#define MAX_PAGE_SIZE 65536
>
> #define MAX_PAGE_SIZE SZ_64K
>
> for improved readability
>
> > +#else
> > +#define MAX_PAGE_SIZE PAGE_SIZE
> > +#endif
> > +
> >  static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
> >  {
> >       int ret;
> > @@ -150,8 +156,8 @@ static int virtio_gpu_vram_map(struct virtio_gpu_ob=
ject *bo)
> >               return -EINVAL;
> >
> >       spin_lock(&vgdev->host_visible_lock);
> > -     ret =3D drm_mm_insert_node(&vgdev->host_visible_mm, &vram->vram_n=
ode,
> > -                              bo->base.base.size);
> > +     ret =3D drm_mm_insert_node_generic(&vgdev->host_visible_mm, &vram=
->vram_node,
> > +                                      bo->base.base.size, MAX_PAGE_SIZ=
E, 0, 0);
>
> This change only reserves extra space in the memory allocator, but
> doesn't change actual size of allocated BO. Instead, you likely need to
> replace all ALIGN(size, PAGE_SIZE) occurrences in the driver code with
> ALIGN(args->size, MAX_PAGE_SIZE)
>
> >       spin_unlock(&vgdev->host_visible_lock);
> >
> >       if (ret)
>
> Note, previously a new virtio-gpu parameter was proposed to expose
> host's page size to guest [1], if you haven't seen it.
>
> [1] https://lore.kernel.org/dri-devel/20240723114914.53677-1-slp@redhat.c=
om/
>
> Aligning GEM's size to 64K indeed could be a good enough immediate
> solution. Don't see any obvious problems with that, other than the
> potential size overhead for a small BOs.
>
> We have been running into cases where a DXVK game allocates enormous
> amounts of small BOs to the point that amount reaches max number of
> mappings on QEMU with amdgpu native context. On the other hand, it
> showed that adding internal sub-allocator to RADV might be a worthwhile
> effort. We won't change alignment on x86 with this patch and on non-x86
> likely the increased size won't be noticeable, hence the proposed change
> might be acceptable.
>
> Curious what Rob Clark thinks about it. Rob, WDYT?

I think userspace needs to know the minimum "gpu" page size (ie. the
host page size) for other reasons, such as sparse binding.  As Sergio
proposes, we should add this to the virtgpu protocol

BR,
-R


>
> --
> Best regards,
> Dmitry
>
