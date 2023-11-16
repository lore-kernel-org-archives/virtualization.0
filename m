Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8DA2E654
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEFhBfNc"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B02060E8F
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:19:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B02060E8F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gEFhBfNc
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8GGn1jx8yWC
	for <virtualization@lists.linux-foundation.org>;
	Thu, 16 Nov 2023 13:19:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2D5FC60E7E
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 13:19:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D5FC60E7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2ioSvsdVC24BNs/tJ+ckjjBuQcpkPVhbaN7mfLUSmk=;
	b=gEFhBfNcCbMgIupKMmqeXxjaSPUFpcLPDVixjVMLqjV0z3sIehZ/K+KGSb65me9m+lmEyI
	Kr4RhuZia2JFhZbUgSQ6ILaahlrCQTXBl9E6gR1suQMKXtWUf5n4jl4/r8DOtFd4z0W7tH
	TMRG0UnEXLkp/wNIdVleTZEJfykAbS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-WWi-2DHoPhyYWuOdPycReQ-1; Thu, 16 Nov 2023 08:18:58 -0500
X-MC-Unique: WWi-2DHoPhyYWuOdPycReQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f68d3b788so419015f8f.3
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 05:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140738; x=1700745538;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2ioSvsdVC24BNs/tJ+ckjjBuQcpkPVhbaN7mfLUSmk=;
        b=TCHgOf4vtFw1KgoKzBTif4bAxujRjOh6qJS705d8n1TTK1TpOoH5FLMUaRtDmft6BF
         23Xp9BtmAsFNqJ9hLSo2CCHUcaLmX3a0ifHV7fAoOiwWmP+A0fi/zw5+IxcET0OVknJw
         oMPgYzwR5n/ZUnjeNfTgXJvxgs0HtCH5TS+RxIM5YdkcH3lGm+KJsNbuSksTol8vKVOU
         Fmci1vPkFYbDU5cv19xs6F225LcxloiuE3Ptqn0ybUaNaq8PqLqPInhYLiL5WtMM7hJL
         KkXSOvH7Wyc3kjsyUJjvOWCyCrPyh9fDj7a9jN2WkvaitPXQXPMbyQPro80K1hR27ZZP
         LDEw==
X-Gm-Message-State: AOJu0YxoZgp/8lq0VRQ30lxREYZEi1sZDLlGdo0+UuPpX+k0O/obStlY
	DIarrGMqdMl9/n7q75/RRYIJK2fe1sSZn2+maSV9qDYFam8ATgO5OGD8k6N7Tkq9WREpWTQbW0B
	+m2TUNEGSBYlseE+2Q33kdEj6hwJdQPKYzjh8Ncuq/A==
X-Received: by 2002:a05:6000:186b:b0:32d:9b3d:4f69 with SMTP id d11-20020a056000186b00b0032d9b3d4f69mr15354772wri.64.1700140737944;
        Thu, 16 Nov 2023 05:18:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZePSLm6805MffvvwhDpaaQKx0BMg13ekmNTxyFySFKHK0WR1spvD11gT9iZCxRQtve/mI9g==
X-Received: by 2002:a05:6000:186b:b0:32d:9b3d:4f69 with SMTP id d11-20020a056000186b00b0032d9b3d4f69mr15354743wri.64.1700140737613;
        Thu, 16 Nov 2023 05:18:57 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g26-20020adfa49a000000b0030647449730sm13748332wrb.74.2023.11.16.05.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:18:57 -0800 (PST)
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
Subject: Re: [PATCH] drm/virtio: Add suppport for non-native
In-Reply-To: <282a31154172a78165912c832a09f6502515d139.1700140178.git.geert@linux-m68k.org>
References: <282a31154172a78165912c832a09f6502515d139.1700140178.git.geert@linux-m68k.org>
Date: Thu, 16 Nov 2023 14:18:56 +0100
Message-ID: <87wmuh25vj.fsf@minerva.mail-host-address-is-not-set>
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

Hello Geert,

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

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

