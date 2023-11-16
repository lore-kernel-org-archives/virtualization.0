Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A552F866
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hywM5k7g"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0766041814
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 14:44:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0766041814
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hywM5k7g
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HcLpx_WpuJ25
	for <virtualization@lists.linux-foundation.org>;
	Thu, 16 Nov 2023 14:44:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C613F402F3
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 14:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C613F402F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700145896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ynICtI83lL6BctzUKR0fO96nrEaTD/YbUJ4e5TXoZG0=;
	b=hywM5k7gQIJ/BxHYg6+N78g4KcSmP9PcLniUuruaB0JDMPp/oEzDM5xiyRcZ94OYkdT/Th
	mFJaez8L+4sENRmDOpaqd+CoxuCUHrJo4f526DuofhUYyZHUKUM87OnrsQlWKx94XO4ZZ8
	gmL1XLfrS0i3w3Um/oKYudPjbzir7+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-EAGPUdrqP7CUDRW7vwL1aQ-1; Thu, 16 Nov 2023 09:44:50 -0500
X-MC-Unique: EAGPUdrqP7CUDRW7vwL1aQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CE78101A550;
	Thu, 16 Nov 2023 14:44:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DA8C41121306;
	Thu, 16 Nov 2023 14:44:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 9DF8618012D3; Thu, 16 Nov 2023 15:44:47 +0100 (CET)
Date: Thu, 16 Nov 2023 15:44:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, 
	David Airlie <airlied@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, 
	linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/virtio: Add suppport for non-native buffer formats
Message-ID: <77c6gkquzq4sdtmrlko3lkxvcnipm2zfjem3kvhgslcellkefh@man7pbbzud47>
References: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a81d2e0e47b1715718779b6978a8b595cc7c5d.1700140609.git.geert@linux-m68k.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, Nov 16, 2023 at 02:16:54PM +0100, Geert Uytterhoeven wrote:
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

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

