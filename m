Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F414A4EE
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256204; cv=none; b=NCyHECS7gU2sFRKos6cN6rOuCJHYY/wOO69gtyVR9v3Eu8+l73ckpOALSNzmSEY+sUtmAbvX1NcCCUr/UrE1qsiCiujo4d1mwOY7exSsbgqPrbEQ8e6IrInXVZddd3oXxaSYx4Er27XiWqNGgAdHp2kG17CDmVYQyxuZNvlLG10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256204; c=relaxed/simple;
	bh=LFIKne37m5ppkm20OELeLYK/6qANJ1qo2vx4CvX4qZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK1f2onwv1cxCzA/L3J6aMT/UVezyVOir/A7jCr9RzH2Dm6Gu2Tm+dk8oxW8b62LQbTbwth2wIUdYur5i/WAzTKR76BogeDZ9vqdNG6+/2VdxGzKWcbOMml4XJndeOJgbwAgPc5JvDnI3hwfIbj7J5njhb5N+oD59Yeo4DfQDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2WYJ2GfG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2WYJ2GfG"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e1fa824504so11139261fa.0
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715256200; x=1715861000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgzpFX64Iw5TdA0yzKF0Gswj46pbTZj7PjEo78f2Xbs=;
        b=2WYJ2GfGYnBfAc6d1O8QQUV7uoUtVWxQdr+C2j/ZEd2wF2TRcENHdWixHqr73KY8Zw
         Z8jTSuOMxfeoeRO83odYoZd5PoHa6AZycYyinmPouPRwLX6NN8FqW2V/zoH67USoqepO
         J6hT/M1lO0SUzyuM8WEXBTp/49CuWLg7gm/Q2oDSx2l/DiGNoep5McCO8KXkVfag+gs2
         w0NzxJaJzmXrLyzCE6K4ctpqy22hU7xOK+UuPl8bBO3J5uznE/kXsHu4/okCWKEOX8AD
         vt5hzXDsgUO/0LyNEw2sTute53LTHBlqv3tSxfHub6p+SBxJbtR+6l5QkOvul2SNm2od
         6U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256200; x=1715861000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgzpFX64Iw5TdA0yzKF0Gswj46pbTZj7PjEo78f2Xbs=;
        b=DSTU5iGeRVm5ZSYKYps251fctTG04584l5kCSUo5BTHdgEZOpOwF5rzFVGPMmXVkLs
         EHOAbbcQmdUrTQ0k1CKaws7plKIbTLMUdQOJtJHqYFy/liW9udTaHOmspheY0vj8qHpK
         sKFunj59+dmldHnjDFjSKfUqkAy/lXq+sHd3bGvsji4HJLRSO+ojo/7uIm+4NuY5rKGW
         DpSnMts3VQnlXGXwrvGiolfWiQTKsFXpge5z00iiNYkZV5v40Y+ehAjostOdSlvJYcaM
         h5rg3Ke+B5j7YKRwg/om96bPM6osHVs3NYRkNczqIGK3w6ch7F6OMXuOFwIbmJg9KeTE
         Q3Qw==
X-Gm-Message-State: AOJu0YwRwEj9//SkylzyA5Dpj9t/x5xIVUHoFa32jfDV8zb2+wUcWRaB
	8UiDw+lbNGnH+VzmxA1+BhqmLYy8XxQKmmsl6iBWxjrwwsWlEM174o/uuCGEZDCytJ5oSsyQcB2
	V
X-Google-Smtp-Source: AGHT+IFVIopUjT3AvlZCeyZ6REENWGHQLFf3FOpdrdHFyz97CnZ9ur/4It8xdBC5T2YqeuVTKaz9sQ==
X-Received: by 2002:a05:651c:4d0:b0:2e1:adc4:47f6 with SMTP id 38308e7fff4ca-2e446d82b3emr42857761fa.6.1715256200095;
        Thu, 09 May 2024 05:03:20 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a777dsm1527399f8f.50.2024.05.09.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:03:19 -0700 (PDT)
Date: Thu, 9 May 2024 14:03:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [patch virtio] virtio: delete vq in vp_find_vqs_msix() when
 request_irq() fails
Message-ID: <Zjy7g0diPulvEnae@nanopsycho.orion>
References: <20240426150845.3999481-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426150845.3999481-1-jiri@resnulli.us>

Hi, I'm new in sending patches to virtio tree directly. Do I need to do
anything more in order to get this fix applied?

Thanks!

Fri, Apr 26, 2024 at 05:08:45PM CEST, jiri@resnulli.us wrote:
>From: Jiri Pirko <jiri@nvidia.com>
>
>When request_irq() fails, error path calls vp_del_vqs(). There, as vq is
>present in the list, free_irq() is called for the same vector. That
>causes following splat:
>
>[    0.414355] Trying to free already-free IRQ 27
>[    0.414403] WARNING: CPU: 1 PID: 1 at kernel/irq/manage.c:1899 free_irq+0x1a1/0x2d0
>[    0.414510] Modules linked in:
>[    0.414540] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc4+ #27
>[    0.414540] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
>[    0.414540] RIP: 0010:free_irq+0x1a1/0x2d0
>[    0.414540] Code: 1e 00 48 83 c4 08 48 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 8b 74 24 04 48 c7 c7 98 80 6c b1 e8 00 c9 f7 ff 90 <0f> 0b 90 90 48 89 ee 4c 89 ef e8 e0 20 b8 00 49 8b 47 40 48 8b 40
>[    0.414540] RSP: 0000:ffffb71480013ae0 EFLAGS: 00010086
>[    0.414540] RAX: 0000000000000000 RBX: ffffa099c2722000 RCX: 0000000000000000
>[    0.414540] RDX: 0000000000000000 RSI: ffffb71480013998 RDI: 0000000000000001
>[    0.414540] RBP: 0000000000000246 R08: 00000000ffffdfff R09: 0000000000000001
>[    0.414540] R10: 00000000ffffdfff R11: ffffffffb18729c0 R12: ffffa099c1c91760
>[    0.414540] R13: ffffa099c1c916a4 R14: ffffa099c1d2f200 R15: ffffa099c1c91600
>[    0.414540] FS:  0000000000000000(0000) GS:ffffa099fec40000(0000) knlGS:0000000000000000
>[    0.414540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[    0.414540] CR2: 0000000000000000 CR3: 0000000008e3e001 CR4: 0000000000370ef0
>[    0.414540] Call Trace:
>[    0.414540]  <TASK>
>[    0.414540]  ? __warn+0x80/0x120
>[    0.414540]  ? free_irq+0x1a1/0x2d0
>[    0.414540]  ? report_bug+0x164/0x190
>[    0.414540]  ? handle_bug+0x3b/0x70
>[    0.414540]  ? exc_invalid_op+0x17/0x70
>[    0.414540]  ? asm_exc_invalid_op+0x1a/0x20
>[    0.414540]  ? free_irq+0x1a1/0x2d0
>[    0.414540]  vp_del_vqs+0xc1/0x220
>[    0.414540]  vp_find_vqs_msix+0x305/0x470
>[    0.414540]  vp_find_vqs+0x3e/0x1a0
>[    0.414540]  vp_modern_find_vqs+0x1b/0x70
>[    0.414540]  init_vqs+0x387/0x600
>[    0.414540]  virtnet_probe+0x50a/0xc80
>[    0.414540]  virtio_dev_probe+0x1e0/0x2b0
>[    0.414540]  really_probe+0xc0/0x2c0
>[    0.414540]  ? __pfx___driver_attach+0x10/0x10
>[    0.414540]  __driver_probe_device+0x73/0x120
>[    0.414540]  driver_probe_device+0x1f/0xe0
>[    0.414540]  __driver_attach+0x88/0x180
>[    0.414540]  bus_for_each_dev+0x85/0xd0
>[    0.414540]  bus_add_driver+0xec/0x1f0
>[    0.414540]  driver_register+0x59/0x100
>[    0.414540]  ? __pfx_virtio_net_driver_init+0x10/0x10
>[    0.414540]  virtio_net_driver_init+0x90/0xb0
>[    0.414540]  do_one_initcall+0x58/0x230
>[    0.414540]  kernel_init_freeable+0x1a3/0x2d0
>[    0.414540]  ? __pfx_kernel_init+0x10/0x10
>[    0.414540]  kernel_init+0x1a/0x1c0
>[    0.414540]  ret_from_fork+0x31/0x50
>[    0.414540]  ? __pfx_kernel_init+0x10/0x10
>[    0.414540]  ret_from_fork_asm+0x1a/0x30
>[    0.414540]  </TASK>
>
>Fix this by calling deleting the current vq when request_irq() fails.
>
>Fixes: 0b0f9dc52ed0 ("Revert "virtio_pci: use shared interrupts for virtqueues"")
>Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>---
> drivers/virtio/virtio_pci_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>index b655fccaf773..584af7816532 100644
>--- a/drivers/virtio/virtio_pci_common.c
>+++ b/drivers/virtio/virtio_pci_common.c
>@@ -348,8 +348,10 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> 				  vring_interrupt, 0,
> 				  vp_dev->msix_names[msix_vec],
> 				  vqs[i]);
>-		if (err)
>+		if (err) {
>+			vp_del_vq(vqs[i]);
> 			goto error_find;
>+		}
> 	}
> 	return 0;
> 
>-- 
>2.44.0
>
