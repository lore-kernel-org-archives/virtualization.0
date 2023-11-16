Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2CEB65F
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJF3O7/x"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3500340223
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3500340223
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WJF3O7/x
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SD98iO9azB_6
	for <virtualization@lists.linux-foundation.org>;
	Thu, 16 Nov 2023 13:22:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39A39401A1
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39A39401A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7+iNGSwtyGLrsX7CmnTv6eFqLzHKXVfMpm2hsnu83o=;
	b=WJF3O7/xiZHLdSGUaRf3hh/c/iLJbH1O01cWVixX3AlFMNoC8ZWlC0FJDj+mHsyKdn0IMc
	t4X1kT7cv/0Rft6ktqe9qFvZ/x7YQA2A85nPCOLBxSPvBxH5jh8Cta4efg8OntqS9C3fh2
	YVbl0wcoKmtIwZrSiH6t+AjLDVubnZ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-X0VIWa_9Op-NAwi6cQQ-CQ-1; Thu, 16 Nov 2023 08:22:23 -0500
X-MC-Unique: X0VIWa_9Op-NAwi6cQQ-CQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f798bc811so434877f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 05:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140942; x=1700745742;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7+iNGSwtyGLrsX7CmnTv6eFqLzHKXVfMpm2hsnu83o=;
        b=fhE2Ja4UR4wgXx9DWIDzrV/yn9UtW5oyA50zYCTGe8gxxPnd1otLwELmrGFL08GnI0
         SKLy57JVfiPVitndyfNJojx/Cu2qVIBriD/sVmAsZXplMKgYU2fYoXTRs64olzkmr0bJ
         eCuF73hCqygsBubLeZQLAiksSCBTkDOHRrAxVMZZLIylJ18VbH8NAg/aL6t5wNYCdpif
         24axKoyk2NTmv9x4ZFywvi9vNlZ1jxRkSCwAANb6Oah/9Fq3587lZJTwJtzWRwpUzBN8
         SYbpPUSFABQQVmh4B7HJN5Zad04QslxRgnhUVF/IRDwP2WBSEHaQE/zMLeJjuIX3dhCR
         Gb6w==
X-Gm-Message-State: AOJu0YwkV/AB8OkrzzO1yMImWSv+lV3a0yrLGKkb3NMPsS3ZsxhHGwLP
	QWoZImQnf/h0wb7amX9mHzmqoRuYS7E1V+IoAwIgHA/D/4Nm6x3RfOq4n+b8itfOgmsfIRy7H5z
	vJIFrmsSm4MSi4tm0Fapu54tUN9zVxliHQ+o3K5vGrA==
X-Received: by 2002:a5d:5741:0:b0:32f:7db1:22f0 with SMTP id q1-20020a5d5741000000b0032f7db122f0mr10520056wrw.20.1700140941860;
        Thu, 16 Nov 2023 05:22:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFuK+UpxCjYuUwCxoI9MkGHUTPUyNvLFpUtkuAQkHfNvTxAFlBt0TzLY1alrl726JtxtyLtA==
X-Received: by 2002:a5d:5741:0:b0:32f:7db1:22f0 with SMTP id q1-20020a5d5741000000b0032f7db122f0mr10520027wrw.20.1700140941220;
        Thu, 16 Nov 2023 05:22:21 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q4-20020a056000136400b003233b554e6esm13556933wrz.85.2023.11.16.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:22:21 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christian Zigotzky
 <chzigotzky@xenosoft.de>, David Airlie <airlied@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I
 Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>, Laurent Vivier <lvivier@redhat.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, linux-m68k@lists.linux-m68k.org
Cc: dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] drm/virtio: Add suppport for non-native buffer formats
In-Reply-To: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
References: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
Date: Thu, 16 Nov 2023 14:22:20 +0100
Message-ID: <87ttpl25pv.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> When using virtgpu on a big-endian machine, e.g. powerpc QEMU:
>
>     virtio-pci 0000:00:02.0: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-2)
>
> or m68k/virt:
>
>     virtio-mmio virtio-mmio.125: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-2)
>
> and the graphical display fails to come up.
>
> Before, the call to drm_mode_addfb() caused a translation from a fourcc
> format (XR24) to a bpp/depth pair (32/24) to a potentially different fourcc
> format (BX24 on big-endian), due to the quirk processing in
> drm_driver_legacy_fb_format().  After, the original fourcc format (XR24)
> is passed unmodified.
>
> However, the virtgpu DRM driver supports only a single format for its
> main plane: DRM_FORMAT_HOST_XRGB8888, which is XR24 on little-endian,
> and BX24 on big-endian.  I.e. on big-endian, virtgpu does not support
> XR24, which is the default DRM format, and must be supported by all
> drivers.  Before, this was reported, but didn't lead to a failure:
>
>     virtio-mmio virtio-mmio.125: [drm] bpp/depth value of 32/24 not supported
>     virtio-mmio virtio-mmio.125: [drm] No compatible format found
>
> As the core virtgpu driver and device support both XR24 and BX24 on both
> little-endian and big-endian just fine, fix this extending the list of
> supported formats for main plane and cursor plane to XR24/BX24 resp.
> AR24/BA24.
>
> Fixes: 6ae2ff23aa43a0c4 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/r/c47fba21-3ae9-4021-9f4a-09c2670ebdbc@xenosoft.de
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Fix truncated one-line summary.
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

