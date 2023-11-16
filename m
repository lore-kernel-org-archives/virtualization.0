Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8B28E16
	for <virtualization@lists.linux.dev>; Thu, 16 Nov 2023 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a90d6ab962so8368267b3.2
        for <virtualization@lists.linux.dev>; Thu, 16 Nov 2023 05:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140426; x=1700745226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIlzYfO2Ms3adHoFgSONl5i8POJ8DPO0QqHqcNpaY0s=;
        b=Gb5wdQecv1eJBWM99SyX7lc1dkH0+dXULS8/p7R7h69y4biGIvNh8I2gQGoGAce9o5
         FLL1JpYSEn1qvSdlULTDXhXGOSAspZj4FlqrIbSkuOVAd8SzUSqL4wXpVcG/mlPYvlCt
         SO0ZQu+tM/ofN8iT3g6ELNx3VLatrDcq1xuKFxAoHdWgMIvMAE+qwdyi2USWC9cN1QLi
         gqTrN+oB066poJ/p+aMwV2sxoyqGBL18MPiRmcasKNZlI+s3G5OeSEA9boPFTl12YlrG
         8iDBLxdNWUdpSgT8Hd4vRGcX7h29UUzfax8HxXNStKmmdm9iNC4lYf48bBoI9V21KAEe
         fXOQ==
X-Gm-Message-State: AOJu0YySkl0pYbdmEdAEDsjtvJKxYHow3F6LKoOTS4dyPBqr8ZGKpanN
	alyO1D4aU6G10kujctzmU2A5YN1ubk9/eQ==
X-Google-Smtp-Source: AGHT+IFHotbT8G/Zpp/xEk+a2z3eaVtRo+VugHSmaPyXhV9VHX4+UXRhr0Zj/QB3ZF8RIdjvDBbD0w==
X-Received: by 2002:a0d:f201:0:b0:59f:4bc3:3e9 with SMTP id b1-20020a0df201000000b0059f4bc303e9mr16096568ywf.46.1700140425631;
        Thu, 16 Nov 2023 05:13:45 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id w207-20020a8149d8000000b0059be6a5fcffsm987232ywa.44.2023.11.16.05.13.44
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 05:13:45 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso737550276.2
        for <virtualization@lists.linux.dev>; Thu, 16 Nov 2023 05:13:44 -0800 (PST)
X-Received: by 2002:a25:b21f:0:b0:db0:3962:fce4 with SMTP id
 i31-20020a25b21f000000b00db03962fce4mr5009733ybj.20.1700140424481; Thu, 16
 Nov 2023 05:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a1d9e09b-f533-5e2c-7a13-af96647e1a71@embeddedor.com>
 <10D1983F-33EF-46C3-976E-463D1CB5A6E9@xenosoft.de> <9bb5fcbd-daf5-1669-b3e7-b8624b3c36f9@xenosoft.de>
 <c47fba21-3ae9-4021-9f4a-09c2670ebdbc@xenosoft.de> <0d89bcd0-9b68-4c0a-acd8-2c7532e62f6d@xenosoft.de>
 <6530cea3-4507-454e-bc36-a6970c8e7578@xenosoft.de> <CAMuHMdU-8Fu55C2zu_XxmG8n5paOQYfqNA84JNvXo4c87D-kFw@mail.gmail.com>
 <fee4eb69-97ea-4b02-9e36-0962ebe3faa9@xenosoft.de> <CAMuHMdWu6Q3ew0m4xugjF_hgSt0RFFr+ccoBrSzt0FGLgtxJtA@mail.gmail.com>
 <uxr4sf6kirv32tfbd6qjzxqd53zpoknjfa4ucr4zs5ktkks2re@spgj4j64raaa>
In-Reply-To: <uxr4sf6kirv32tfbd6qjzxqd53zpoknjfa4ucr4zs5ktkks2re@spgj4j64raaa>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Nov 2023 14:13:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_3riPCSf_WDnUQWZENtDjaQmGf6cQn2-Dfsgf2HKHfA@mail.gmail.com>
Message-ID: <CAMuHMdU_3riPCSf_WDnUQWZENtDjaQmGf6cQn2-Dfsgf2HKHfA@mail.gmail.com>
Subject: Re: Fbdev issue after the drm updates 'drm-next-2023-10-31-1'
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, 
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, 
	airlied@gmail.com, deller@gmx.de, Darren Stevens <darren@stevens-zone.net>, 
	mad skateman <madskateman@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Christian Zigotzky <info@xenosoft.de>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gerd,

On Wed, Nov 15, 2023 at 10:22=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> =
wrote:
> On Wed, Nov 15, 2023 at 09:33:28AM +0100, Geert Uytterhoeven wrote:
> > On Tue, Nov 14, 2023 at 10:45=E2=80=AFAM Christian Zigotzky
> > <chzigotzky@xenosoft.de> wrote:
> > > On 13 November 2023 at 01:48 pm, Geert Uytterhoeven wrote:
> > > > I can confirm there is no graphics output with m68k/virt, and
> >
> > Before the error message you reported:
> >
> >     virtio-mmio virtio-mmio.125: [drm] *ERROR* fbdev: Failed to setup
> > generic emulation (ret=3D-2)
> >
> > it also prints:
> >
> >     virtio-mmio virtio-mmio.125: [drm] bpp/depth value of 32/24 not sup=
ported
> >     virtio-mmio virtio-mmio.125: [drm] No compatible format found
> >
> > Upon closer look, it turns out virtgpu is special in that its main
> > plane supports only a single format: DRM_FORMAT_HOST_XRGB8888, which
> > is XR24 on little-endian, and BX24 on big-endian.  I.e. on big-endian,
> > virtgpu does not support XR24.
>
> Driver and device support both XR24 and BX24 on both little endian and
> big endian just fine.

OK.

> Problem is both fbdev interfaces and the ADDFB ioctl specify the format
> using bpp instead of fourcc, and advertising only one framebuffer format
> -- in native byte order -- used to worked best, especially on bigendian
> machines.
>
> That was years ago though, IIRC predating the generic fbdev emulation,
> so maybe it's time to revisit that.  Changing it should be as simple as
> updating the format arrays:
>
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -30,11 +30,13 @@
>  #include "virtgpu_drv.h"
>
>  static const uint32_t virtio_gpu_formats[] =3D {
> -       DRM_FORMAT_HOST_XRGB8888,
> +       DRM_FORMAT_XRGB8888,
> +       DRM_FORMAT_BGRX8888,
>  };
>
>  static const uint32_t virtio_gpu_cursor_formats[] =3D {
> -       DRM_FORMAT_HOST_ARGB8888,
> +       DRM_FORMAT_ARGB8888,
> +       DRM_FORMAT_BGRA8888,
>  };
>
>  uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)

Thanks!
Almost there, the check in virtio_gpu_user_framebuffer_create()
must be extended, too.

I have submitted a patch
https://lore.kernel.org/r/282a31154172a78165912c832a09f6502515d139.17001401=
78.git.geert@linux-m68k.org/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
