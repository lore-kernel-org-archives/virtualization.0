Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C05381B0C
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075105; cv=none; b=FPcerId6cYpRq7w6WNWlAaRTdZ8lnphqLrGhtssUBZQvfpL42FcU6okU1Lf8pvSfo+m7GrOXgzbDEtGCgpaCpHeeLAkOl82P2WvcxQnHr1OyqUF25i4gunOi2yBJw+B0Dlp+lpP4IujEKofg/PbJZPphfxI41nLvXc28bmn7PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075105; c=relaxed/simple;
	bh=ge4IbTXF7lJt7meGHPQpdprqP2LXCoO+5g49xZWAU6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PT2gSqCaILbrYU1zcDwmyz5H7sXxTMJ0BtitsLiGybMW16aIEm0TtRF7aMoAA4DWi+G7fSS9vDVqxwMuGscrc7Gv9gAVT/cjbtMQafiXQu0lebFXMsZYMQmnZBLMpKdXdnofQPjA0aIHpFIjEMDj5Fz9Ne2iKbr68wRVhQyIdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxCX7Hn8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxCX7Hn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781075103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TzZZUYoa0+tHSBbViTShLqw2qniezPA5sWOCkhRUcwk=;
	b=OxCX7Hn8nfdDfOvYmT8wBQvoHI0izuWG7udA7KhU6aUTZnqS0qqJZ6Ie7CdJOL65sj6JGK
	VUcWklqAy/nlUAvw3C4Q92WGDCED+gnm0sgLMb+zu6RK4gpM4BBer1HIXahGV48nqM158A
	9W9LYEVpJfV1N6kj3/JYquJaK30M3Cc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-BGiSiEhSOZu1R5iJPFpDBg-1; Wed, 10 Jun 2026 03:05:01 -0400
X-MC-Unique: BGiSiEhSOZu1R5iJPFpDBg-1
X-Mimecast-MFC-AGG-ID: BGiSiEhSOZu1R5iJPFpDBg_1781075100
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef9f0af71so4724378f8f.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 00:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075100; x=1781679900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzZZUYoa0+tHSBbViTShLqw2qniezPA5sWOCkhRUcwk=;
        b=bXWr9x/IzMsCKR1rFIDfclFocnypGYcmrliuzcdiTJQDt3vu6Yezn5cagrLr5s82/S
         6KWzBfjOB8h8EOSNA23smgH9iVFyFKT5+26NVlKX7KR9zqeQ80EmBGElsfp739M2WgFk
         E0QqMnaKJP3Gp0K3D9Q7FSaY0Si/Qyx3t9MsxEyb/yRbyBoVVGmu4fq005LLCpmp0WQN
         gPSTT5LMjYdfTaCZuUWIh8B6W5e+UwkzvlutS+WmzxEQdmUBzQZQ6zXfPnmLro0GwxnD
         aipSLfQDFqNhac/dNwNF/5TCn/2dtjq+BW1LzwtKUXAjv/KFSDFD2Y02jN816c6CzAHz
         lGBw==
X-Forwarded-Encrypted: i=1; AFNElJ/mDAVwQBuc0yr2P580hJQyoxtcva6WDmOf4QGZe+lVv8wqLjWeMNZTT5IM7PJQ1I+oyr90+YkjFPaoZLyQhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YznY/fkyv1NSkp13pS3HtZ9KvD7J7rYP43N6qqZ9f1U/nMsu9/J
	N0T9NXAFDUAv7oBDHBQV2FXi2JZVjQUP37jUs93yho0OiUe6BcKBgtoSp+x7GmDiDTrHHGsgU2J
	U0CS65AfABRpkXzHKaKYGyrnDcH1vVv27tu5DLRzCPCMft0qaGDFWeYJO/JqmWkExEKJE
X-Gm-Gg: Acq92OGzY2aGfn9gu9oMM0ExVoTL26RB/1hb8KvS/oRxSXZ4L7ZNN/Z59HSAuhLrykV
	GKLhFcabnyd1v7P7mKcj2kLuT/MgY+981oz7NEffFGnC9eTswmD1c4Rn1Etn/GFRwcB+KmdwBCw
	R0t3jJiaUKZjoTl10nuKXJ3IGQsMcgTThELKSHClMUA4WLXKjF5wbgstB8CTQshYHzoeIX5PECc
	8sUJx6MCdvMxvPno21TAng/Eys1nGPrQpOw02k5ONfKUHqKvCBtpyglagtH6aO4OYk0v2ig+Rpz
	lj7pOrL5+K3Uq4uLwIgyM+A7dUCECdNTth2t+NcFDcET20ufklKb2xx1iaVj6SzLFcDJON6PLDK
	p6Z2jPMQeQaDdzzGDLWgxnu2u2kRuZRmUl53xHiUZbYgu9mAztf0F2g==
X-Received: by 2002:a05:6000:4b07:b0:460:11a7:f818 with SMTP id ffacd0b85a97d-46032b81463mr29422301f8f.9.1781075100480;
        Wed, 10 Jun 2026 00:05:00 -0700 (PDT)
X-Received: by 2002:a05:6000:4b07:b0:460:11a7:f818 with SMTP id ffacd0b85a97d-46032b81463mr29422251f8f.9.1781075099941;
        Wed, 10 Jun 2026 00:04:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm68805871f8f.0.2026.06.10.00.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 00:04:59 -0700 (PDT)
Date: Wed, 10 Jun 2026 03:04:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] virtio_console: read size from config space
 during device init
Message-ID: <20260610030318-mutt-send-email-mst@kernel.org>
References: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QRBgwjkS-cbJISOntfU1uuBswmJQNQ3map-Qrjg0-XI_1781075100
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 23, 2026 at 06:37:02PM +0100, Filip Hejsek wrote:
> Previously, the size was only read upon receiving the config interrupt.
> This interrupt is sent when the size changes. However, we also need to
> read the initial size.
> 
> Also make sure to only read the size from config if F_SIZE is enabled.
> 
> Fixes: 9778829cffd4 ("virtio: console: Store each console's size in the console structure")
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
> This is a resend of [1], which hasn't received any response.
> 
> I found this bug while developing patches for QEMU that add virtio
> console resize support. If you want to test this, you can get my QEMU
> patches from [2]. You will need to disable multiport
> using `-device virtio-serial,max_ports=1`.
> 
> [1]: https://lore.kernel.org/all/20251224-virtio-console-fix-v1-1-69d0349692dc@gmail.com/
> [2]: https://lore.kernel.org/all/20250921-console-resize-v5-0-89e3c6727060@gmail.com/
> 
> I'll also repeat my questions from the previous submission here. These are
> things that confused me when I was trying to understand the surrounding code,
> but should in no way prevent merging this patch.
> 
>   - Why does use_multiport use __virtio_test_bit instead of
>     virtio_has_feature?
> 
>   - The VIRTIO_CONSOLE_RESIZE handler sets irq_requested to 1, which I
>     think makes no sense?
> ---
>  drivers/char/virtio_console.c | 52 ++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 088182e54d..c355f6d392 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1771,32 +1771,40 @@ static void config_intr(struct virtio_device *vdev)
>  		schedule_work(&portdev->config_work);
>  }
>  
> -static void config_work_handler(struct work_struct *work)
> +static void update_size_from_config(struct ports_device *portdev)
>  {
> -	struct ports_device *portdev;
> +	struct virtio_device *vdev;
> +	struct port *port;
> +	u16 rows, cols;
>  
> -	portdev = container_of(work, struct ports_device, config_work);
> -	if (!use_multiport(portdev)) {
> -		struct virtio_device *vdev;
> -		struct port *port;
> -		u16 rows, cols;
> +	vdev = portdev->vdev;
>  
> -		vdev = portdev->vdev;
> -		virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> -		virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> +	/*
> +	 * We'll use this way of resizing only for legacy support.
> +	 * For multiport devices, use control messages to indicate
> +	 * console size changes so that it can be done per-port.
> +	 *
> +	 * Don't test F_SIZE at all if we're rproc: not a valid feature.
> +	 */
> +	if (is_rproc_serial(vdev) ||

Wait a second. Why is there this rproc test here?
Was not in the original code and commit log says nothing about it.


> +	    use_multiport(portdev) ||
> +	    !virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> +		return;
>  
> -		port = find_port_by_id(portdev, 0);
> -		set_console_size(port, rows, cols);
> +	virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> +	virtio_cread(vdev, struct virtio_console_config, rows, &rows);
>  
> -		/*
> -		 * We'll use this way of resizing only for legacy
> -		 * support.  For newer userspace
> -		 * (VIRTIO_CONSOLE_F_MULTPORT+), use control messages
> -		 * to indicate console size changes so that it can be
> -		 * done per-port.
> -		 */
> -		resize_console(port);
> -	}
> +	port = find_port_by_id(portdev, 0);
> +	set_console_size(port, rows, cols);
> +	resize_console(port);
> +}
> +
> +static void config_work_handler(struct work_struct *work)
> +{
> +	struct ports_device *portdev;
> +
> +	portdev = container_of(work, struct ports_device, config_work);
> +	update_size_from_config(portdev);
>  }
>  
>  static int init_vqs(struct ports_device *portdev)
> @@ -2054,6 +2062,8 @@ static int virtcons_probe(struct virtio_device *vdev)
>  	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
>  			   VIRTIO_CONSOLE_DEVICE_READY, 1);
>  
> +	update_size_from_config(portdev);
> +
>  	return 0;
>  
>  free_chrdev:
> 
> ---
> base-commit: b927546677c876e26eba308550207c2ddf812a43
> change-id: 20251224-virtio-console-fix-3d46980ef569
> 
> Best regards,
> -- 
> Filip Hejsek <filip.hejsek@gmail.com>

