Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D419BD8
	for <virtualization@lists.linux-foundation.org>; Sun, 19 Nov 2023 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8632060A81
	for <virtualization@lists.linux-foundation.org>; Sun, 19 Nov 2023 18:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8632060A81
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8yRoqu5peBy8
	for <virtualization@lists.linux-foundation.org>;
	Sun, 19 Nov 2023 18:33:15 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 47035605A1
	for <virtualization@lists.linux-foundation.org>; Sun, 19 Nov 2023 18:33:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47035605A1
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a7b3d33663so41329077b3.3
        for <virtualization@lists.linux-foundation.org>; Sun, 19 Nov 2023 10:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700418794; x=1701023594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Sgxs19g9ItwMLXCwSaFSmWY+3YFGqlRFFiHfPCTZTc=;
        b=obqVrVE3r/MO6oxr3hZ7yg5kTIhCXjhJ8rkeDo9z0Os+gdjcqKIBZY1t1rVYyDkYMw
         ZqlJkF7LGsl1mj3kGDR4Wpt97ybzyqg/vvl7G07pE36fYNMl6cYTubtSvSzOqMs2hi+F
         Ar6I83xuKGu4unrDSCBziJfLlwNNQZaGvefaaF+8eWDoeACMIeFd8LZE9al+sBLYi23o
         Zn+W7J9o1os2a3p5Q1y6BaUTo2FOoPnysRXeQb5EXjD3xwjhNdXY3Qa5sE1dV5t5JrT1
         hQzaj183lWmnWjgPJl9HsSZNhwKNPP85aPekv+692HZk9OfWXHydWJeQW3evf2ojiOIG
         nKlg==
X-Gm-Message-State: AOJu0YxRM9fv+NIPOkp2Lmnj1zLB7IRhoxMoHK6BxhiHX7OHdRjZ3NRm
	LL5yqI14rcwh7mNSGsFQqUf7mwwlU6dZJA==
X-Google-Smtp-Source: AGHT+IFQWbpx9pjyIuECMKYawOAImwjdO/cL3bhajYlKFaksSONIhcOKHR7cJh3+x1Fh723BfoUaRw==
X-Received: by 2002:a0d:ea55:0:b0:5bf:5d6e:1f5e with SMTP id t82-20020a0dea55000000b005bf5d6e1f5emr6081685ywe.34.1700418793900;
        Sun, 19 Nov 2023 10:33:13 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id y200-20020a81a1d1000000b005af5ef0687bsm1867510ywg.13.2023.11.19.10.33.13
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 10:33:13 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7dd65052aso41545357b3.0
        for <virtualization@lists.linux-foundation.org>; Sun, 19 Nov 2023 10:33:13 -0800 (PST)
X-Received: by 2002:a81:cb01:0:b0:5ca:9ca4:f412 with SMTP id
 q1-20020a81cb01000000b005ca9ca4f412mr97776ywi.43.1700418793512; Sun, 19 Nov
 2023 10:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
 <77c6gkquzq4sdtmrlko3lkxvcnipm2zfjem3kvhgslcellkefh@man7pbbzud47> <a9ade305-f90e-4250-a795-49ef4e29e0ac@xenosoft.de>
In-Reply-To: <a9ade305-f90e-4250-a795-49ef4e29e0ac@xenosoft.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 19 Nov 2023 19:33:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXtUYJmEharJhBXx7D=fA3mQxg6uMP2=4Qgi==2a+kVQw@mail.gmail.com>
Message-ID: <CAMuHMdXtUYJmEharJhBXx7D=fA3mQxg6uMP2=4Qgi==2a+kVQw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Add suppport for non-native buffer formats
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Laurent Vivier <lvivier@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, linux-m68k@lists.linux-m68k.org, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>, 
	mad skateman <madskateman@gmail.com>, Darren Stevens <darren@stevens-zone.net>, 
	Christian Zigotzky <info@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Sun, Nov 19, 2023 at 5:28=E2=80=AFPM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
> On 16 November 2023 at 03:44 pm, Gerd Hoffmann wrote:
> > On Thu, Nov 16, 2023 at 02:16:54PM +0100, Geert Uytterhoeven wrote:
> >> When using virtgpu on a big-endian machine, e.g. powerpc QEMU:
> >>
> >>      virtio-pci 0000:00:02.0: [drm] *ERROR* fbdev: Failed to setup gen=
eric emulation (ret=3D-2)
> >>
> >> or m68k/virt:
> >>
> >>      virtio-mmio virtio-mmio.125: [drm] *ERROR* fbdev: Failed to setup=
 generic emulation (ret=3D-2)
> >>
> >> and the graphical display fails to come up.
> >>
> >> Before, the call to drm_mode_addfb() caused a translation from a fourc=
c
> >> format (XR24) to a bpp/depth pair (32/24) to a potentially different f=
ourcc
> >> format (BX24 on big-endian), due to the quirk processing in
> >> drm_driver_legacy_fb_format().  After, the original fourcc format (XR2=
4)
> >> is passed unmodified.
> >>
> >> However, the virtgpu DRM driver supports only a single format for its
> >> main plane: DRM_FORMAT_HOST_XRGB8888, which is XR24 on little-endian,
> >> and BX24 on big-endian.  I.e. on big-endian, virtgpu does not support
> >> XR24, which is the default DRM format, and must be supported by all
> >> drivers.  Before, this was reported, but didn't lead to a failure:
> >>
> >>      virtio-mmio virtio-mmio.125: [drm] bpp/depth value of 32/24 not s=
upported
> >>      virtio-mmio virtio-mmio.125: [drm] No compatible format found
> >>
> >> As the core virtgpu driver and device support both XR24 and BX24 on bo=
th
> >> little-endian and big-endian just fine, fix this extending the list of
> >> supported formats for main plane and cursor plane to XR24/BX24 resp.
> >> AR24/BA24.
> >>
> >> Fixes: 6ae2ff23aa43a0c4 ("drm/client: Convert drm_client_buffer_addfb(=
) to drm_mode_addfb2()")
> >> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> >> Closes: https://lore.kernel.org/r/c47fba21-3ae9-4021-9f4a-09c2670ebdbc=
@xenosoft.de
> >> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
> The new patch works but I don't see the virtio-mouse-pci pointer
> anymore. I see the pointer with -device usb-tablet. Please check the
> second patch. I will use the first patch for the RC2 of kernel 6.7.

That's probably partially explained by commit 99748ab64fcc8578 ("drm:
virtio: fix virtio_gpu_cursor_formats"), which forced BA24 for the
cursor plane on big-endian, but unfortunately linked thread doesn't
contain the full picture.

Where is the default cursor format defined?
I see virtio_gpu_mode_dumb_create() still defaults to
DRM_FORMAT_HOST_XRGB8888.  However, that can't be the cause, as the
cursor formats require an alpha channel.

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
