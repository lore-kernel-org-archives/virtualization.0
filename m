Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517C7E
	for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a92782615dso76213427b3.2
        for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 00:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700037221; x=1700642021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loUWrR6eECAA+uv6HMt8OKh14KvU7DOewoh9g24/Sfw=;
        b=TrKEeIs/UMWfTYUApLNESW4oxw6mKo9khsifvd6KysaFj3MrEqceW8tk/0uxrUobrI
         Us0lkLqa5EaBJXFs1H4HfqzfsSTG5XD8k+c39HuzIsPOmsh7Oixq/zhpHMVSbepZldEA
         FbelQTmsM4V5BVPXCZt2wjMdk92nFmcCs5udRmlOdzHdmF7EDzmku6oatBx1KervvBRL
         xiQj/9TcSrxn+j2RycUiCok0vRV+2IG45+RTvALtA3BpIozQ3zDwtSAbx+hiG6rZXX7Q
         p+hxOo/oGHNLmslJxt+BEdNogZPD9On2z9yb7V1f5+n+pVEDU2RIDKyXjOkA1tPbmwlH
         R6Jw==
X-Gm-Message-State: AOJu0YztZQwl2g3pdvORI6aiuSWmcvf2qBf08cDdRcNu3vtJcFvkFfBL
	XXlo+w6Cee+aQcbaP/wM8swzfnZ2JmC23w==
X-Google-Smtp-Source: AGHT+IHpz7ptmu+bbH2ln86GRdNkifeceVf/A2v7nQ/hVltYavwbD2sJnMmnR91zsMDtHkczJc3otA==
X-Received: by 2002:a0d:cc96:0:b0:5af:73cd:ba30 with SMTP id o144-20020a0dcc96000000b005af73cdba30mr13129635ywd.39.1700037221618;
        Wed, 15 Nov 2023 00:33:41 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id n4-20020a0de404000000b0057736c436f1sm244372ywe.141.2023.11.15.00.33.40
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 00:33:40 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a7b3d33663so76090297b3.3
        for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 00:33:40 -0800 (PST)
X-Received: by 2002:a81:8408:0:b0:5a7:a81d:e410 with SMTP id
 u8-20020a818408000000b005a7a81de410mr13654199ywf.18.1700037220389; Wed, 15
 Nov 2023 00:33:40 -0800 (PST)
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
 <fee4eb69-97ea-4b02-9e36-0962ebe3faa9@xenosoft.de>
In-Reply-To: <fee4eb69-97ea-4b02-9e36-0962ebe3faa9@xenosoft.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Nov 2023 09:33:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWu6Q3ew0m4xugjF_hgSt0RFFr+ccoBrSzt0FGLgtxJtA@mail.gmail.com>
Message-ID: <CAMuHMdWu6Q3ew0m4xugjF_hgSt0RFFr+ccoBrSzt0FGLgtxJtA@mail.gmail.com>
Subject: Re: Fbdev issue after the drm updates 'drm-next-2023-10-31-1'
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, 
	airlied@gmail.com, deller@gmx.de, Darren Stevens <darren@stevens-zone.net>, 
	mad skateman <madskateman@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Christian Zigotzky <info@xenosoft.de>, Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

CC virtgpu

On Tue, Nov 14, 2023 at 10:45=E2=80=AFAM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
> On 13 November 2023 at 01:48 pm, Geert Uytterhoeven wrote:
> > I can confirm there is no graphics output with m68k/virt, and

Before the error message you reported:

    virtio-mmio virtio-mmio.125: [drm] *ERROR* fbdev: Failed to setup
generic emulation (ret=3D-2)

it also prints:

    virtio-mmio virtio-mmio.125: [drm] bpp/depth value of 32/24 not support=
ed
    virtio-mmio virtio-mmio.125: [drm] No compatible format found

Upon closer look, it turns out virtgpu is special in that its main
plane supports only a single format: DRM_FORMAT_HOST_XRGB8888, which
is XR24 on little-endian, and BX24 on big-endian.  I.e. on big-endian,
virtgpu does not support XR24.  Isn't this a violation of the DRM
rule that every driver must implement support for XR24?

> > bisected this to my own commit 6ae2ff23aa43a0c4 ("drm/client: Convert
> > drm_client_buffer_addfb() to drm_mode_addfb2()"), ouch...
> >
> > It turns out the old call to drm_mode_addfb() caused a translation
> > from a fourcc to a bpp/depth pair to a _different_ fourcc, due to the
> > quirk processing in drm_driver_legacy_fb_format().
> > I.e. on m68k/virt, the original requested format was XR24, which was
> > translated to BX24. The former doesn't work, the latter works.
> >
> > The following (gmail-whitespace-damaged) patch fixed the issue for me:
> >
> > --- a/drivers/gpu/drm/drm_client.c
> > +++ b/drivers/gpu/drm/drm_client.c
> > @@ -400,6 +400,16 @@ static int drm_client_buffer_addfb(struct
> > drm_client_buffer *buffer,
> >
> >         fb_req.width =3D width;
> >         fb_req.height =3D height;
> > +       if (client->dev->mode_config.quirk_addfb_prefer_host_byte_order=
) {
> > +               if (format =3D=3D DRM_FORMAT_XRGB8888)
> > +                       format =3D DRM_FORMAT_HOST_XRGB8888;
> > +               if (format =3D=3D DRM_FORMAT_ARGB8888)
> > +                       format =3D DRM_FORMAT_HOST_ARGB8888;
> > +               if (format =3D=3D DRM_FORMAT_RGB565)
> > +                       format =3D DRM_FORMAT_HOST_RGB565;
> > +               if (format =3D=3D DRM_FORMAT_XRGB1555)
> > +                       format =3D DRM_FORMAT_HOST_XRGB1555;
> > +       }
> >         fb_req.pixel_format =3D format;
> >         fb_req.handles[0] =3D handle;
> >         fb_req.pitches[0] =3D buffer->pitch;
> >
> > However, I don't think we want to sprinkle more of these
> > translations around... So perhaps we should (re)add a call to
> > drm_driver_legacy_fb_format() to drm_client_buffer_addfb()?
> >
> > Second, as I doubt you are using a big-endian system, you are probably
> > running into a slightly different issue.
> >
> > Oh wait, you did CC linuxppc-dev, so perhaps you are running on a
> > big-endian machine?
>
> Your patch works! :-) Thanks a lot!
>
> I tested it with the virtio-vga and with the virtio-gpu-pci device in a v=
irtual ppce500 QEMU/KVM HV machine with an e5500 CPU today.
>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

Thanks for testing!

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
