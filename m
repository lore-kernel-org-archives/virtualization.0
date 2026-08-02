Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51672DCBEC
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785694233; cv=none; b=OD/rJJFFT+l09bQnIEH8AnHsiffNSFTmsBv1xFqfqDZTgH7uvqp7qjlSv3oz+TljLuxniobIQFnjIxD9c66jjKTDvU2OOEDN8XQ5Ss+5C2ulWJK5lP1k+Mp74U9zw7JbA0aWjifR1ZAC374IK60MAkM1zgxkT2LlnhWnayc5XsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785694233; c=relaxed/simple;
	bh=LIkuI23ru68AL7kN+JvGgQXMhZWmeZ2+PfGGzYwQ8gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TPWPsZXh6uG8SNVKpe2l6Far/Z5XFqa0sOUPe/dKqNsu4zxfrry4sdEJTP3gRmNZHkJCSrwd83+PabunnFVWy7rulO2uwxL+YwT08L14Xw0u3FUFEG4c1FB0ujBjm/HczyY3X38H9v5ttLC/I3PBHpTHlI1fs6QPh1P702J1uWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng3BEqs4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng3BEqs4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785694230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqFBg6nB/z21F6d3F0FRo0Q9T52fV8s+MEGcMWr8o18=;
	b=Ng3BEqs4Tx2LMsrk2EqCdSr5XzZsm6HLrrXOAze7ZtUP2GcBqEgYW7jDlU8tnGgzgLu5Q5
	FVvhRkR8wm8JiwLLDM1r/374ZsOlW4WD/FJwftsgZV/6TvIPpTX/70tLqiw3sF2MEZTsyo
	qxEZgJLhdvCaHDKiR3FuPsUGeiFEUYQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-E9s0lhEvPwWi9jmV-FlxuA-1; Sun, 02 Aug 2026 14:10:29 -0400
X-MC-Unique: E9s0lhEvPwWi9jmV-FlxuA-1
X-Mimecast-MFC-AGG-ID: E9s0lhEvPwWi9jmV-FlxuA_1785694228
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4957287363bso8473195e9.0
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 11:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785694228; x=1786299028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqFBg6nB/z21F6d3F0FRo0Q9T52fV8s+MEGcMWr8o18=;
        b=jSmjXlR2gEsJTzRssngej6DvgAB6kZBzPn7FtVkIl6YFvhacjs8g/7OJmsIcnNi3xd
         HMUFja6FCZeCSY3xvKr9G+B3Obx7+YMhxjnkSl2eJH3z7u2kSHzUsOEunXU/4PFz6ez9
         Or/3oN1/MwchqgVIMbdKmSTZCp35GFbVSBs9Fg9Ck9cBFbsUQbVnTufAUr/+3O75ognB
         0p94QQQcU9J35lWzitggTs/LGayNgdhq9g1nrXLnyh5Lird+tWdrq3TevEogw2Fc0aOt
         +94+Lj2rwIAeKscC6hKlfEPFHdSLmiN0aqNc+GQZJkHh7BGXz+VrO38mqp2E5hOTSrk1
         EtkA==
X-Forwarded-Encrypted: i=1; AHgh+RoJw91bkIR3GtfnuS8B114xosyirIDlhUKu9Dex7bCjDsM0Uhg/DZQ1XOGDr4bBfSmXoDaL66RGkwlXRGlMSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTXXsjclKz7Vfn3Hmy8BdLvFiJWcEB2iBmiwb1/cL+Cc5u9hpP
	1Qk8mLJSH4eACcZIXRJ1MkIyuzixw+aOQ3BWQfh+xxCc53FON5O9KX4XoiCCEicbW3UNiKkw9Hk
	/YmsreBQVaxwNUKtmgrpuc889XlFZmzK1ctW1T93wDem4dVo3yEAOZfminBR0Va9QQnek
X-Gm-Gg: AR+sD13y/B9r7tnHT4NPqBuTqDyEnsFEBMUrVyemMx8UphYGkpNnmaQbtSgCqdrwTRM
	MNkFY8nuYogKOZDYoVoHqoNndUIMaPxSSH0Yt7lNkWmAnVTkaU0p2cebQ+ayFiJSXrhdjZAwrbc
	wSWarwPP5wy0qcLvjwuuGCVDDfXxFHU/3wfhj80S57bns+F+y4u9TzWuoJ5VoWRPfszeBW5x7S0
	9B55jVGIkAJT+cl4vtpSwAvernIReAmG8vAZiK8Y2LejW83utCxLTeFd4vAKQjmReqSAps/tEpP
	NHv2CPYVQJeu3UGoMrPOwkS5Vy3C+awpB9s1VPCaQsS7t2qaxwCN+/c3oJMKfyhaVg/utLEootQ
	C8/acIrCXUlt0r/3BhoQ/yg==
X-Received: by 2002:a05:600c:a47:b0:498:1371:6612 with SMTP id 5b1f17b1804b1-49813716987mr68492825e9.6.1785694228028;
        Sun, 02 Aug 2026 11:10:28 -0700 (PDT)
X-Received: by 2002:a05:600c:a47:b0:498:1371:6612 with SMTP id 5b1f17b1804b1-49813716987mr68492315e9.6.1785694227525;
        Sun, 02 Aug 2026 11:10:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498081a1910sm71056355e9.4.2026.08.02.11.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 11:10:26 -0700 (PDT)
Date: Sun, 2 Aug 2026 14:10:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Abhin Parekadan Jose <abhinjoses@gmail.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio_pci_modern_dev: warn once on invalid status
Message-ID: <20260802140707-mutt-send-email-mst@kernel.org>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
 <20260802174059.4082-2-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260802174059.4082-2-abhinjoses@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gUuRlxsTOgNF35pS8Am10FZyWTDVRsPhSG7oJppt-zc_1785694228
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 02, 2026 at 05:40:58PM +0000, Abhin Parekadan Jose wrote:
> vp_modern_get_status() returns the raw device_status byte as read
> from the common configuration structure (struct virtio_pci_common_cfg,
> mapped via the VIRTIO_PCI_CAP_COMMON_CFG capability). That byte should
> only ever contain some combination of the status bits defined by the
> virtio spec (bits 0-3, 6-7); bits 4 and 5 are reserved and a
> spec-compliant device must never set them.

Future versions of the spec are likely to use these bits,
I prefer to make the drivers future proof. In fact, things
like kexec mean that we don't know what drove the
device earlier, so we do not know that the previous
driver did not write 0xFF there.



> A value with any other bit
> set means either the device is violating the spec, or the read never
> reached real device state at all -- e.g. because a write of 0x0000 to
> the PCI_COMMAND register (config space offset 4) clears the Memory
> Space Enable bit, causing the device to stop responding to
> memory-mapped register accesses -- effectively simulating an
> unresponsive/removed device without a real hot-unplug. In that case
> the MMIO read returns the bus's synthesized all-ones response instead
> of real device state.
> 
> Add VIRTIO_STATUS_ERROR() to the uapi header to recognize such values,
> and warn once from vp_modern_get_status() when it sees one, so the
> bogus status is visible at its source rather than only showing up as
> confusing behavior in callers.
> 
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
>  include/uapi/linux/virtio_config.h     | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 413a8c353463..60dd8acf1c28 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -480,8 +480,14 @@ EXPORT_SYMBOL_GPL(vp_modern_generation);
>  u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev)
>  {
>  	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +	u8 status = vp_ioread8(&cfg->device_status);
>  
> -	return vp_ioread8(&cfg->device_status);
> +	if (VIRTIO_STATUS_ERROR(status)) {
> +		WARN_ONCE(1, "virtio: device returned error status: %#x\n",
> +			  status);
> +	}
> +
> +	return status;
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_get_status);
>  
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 2445f365bce7..6f458914c0ba 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -45,6 +45,22 @@
>  /* We've given up on this device. */
>  #define VIRTIO_CONFIG_S_FAILED		0x80
>  
> +/*
> + * Check if a status value indicates an error
> + * All device_status bits currently defined by the virtio spec (bits
> + * 0,1,2,3,6,7). Bits 4 and 5 (0x10, 0x20) are reserved/undefined -- a
> + * real device must never set them. A status byte with any bit outside
> + * this mask set cannot be a legitimate value: either the device is
> + * violating the spec, or the read never actually reached it (e.g.
> + * PCI_COMMAND memory decode is disabled and this is a synthesized
> + * all-ones bus response instead of real device state).
> + */
> +#define VIRTIO_STATUS_ERROR(val) \
> +	(((u8)(val)) & \
> +	 ~(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER | \
> +	   VIRTIO_CONFIG_S_DRIVER_OK | VIRTIO_CONFIG_S_FEATURES_OK | \
> +	   VIRTIO_CONFIG_S_NEEDS_RESET | VIRTIO_CONFIG_S_FAILED))
> +


Not clear what this does in UAPI, even if useful.

>  /*
>   * Virtio feature bits VIRTIO_TRANSPORT_F_START through
>   * VIRTIO_TRANSPORT_F_END are reserved for the transport
> -- 
> 2.51.1

