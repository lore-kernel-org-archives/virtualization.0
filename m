Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A6367F2F
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163528; cv=none; b=h5mE9CN8+PBS1n0mITTu7G85Yn8XAq+4Jz74j4gLfJ00Sj1x+MPy6gtfT/GrB/viv1/eR1ztnCnV1YlfA/oPKqC6Sa5FPPxEfg98jvzh+0acJNoYYoHybSvjh+ovKmJOb90vPV5HkO3WBIacQBz9QGBv+15tNSqa6G9QTNyZguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163528; c=relaxed/simple;
	bh=dMsWjHb6aAJItRl535L6hOIGhAdKxck1LCp2PQr9fQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dtpE/GMw87bhVEM5Zb1j1I4rNkaaEj/dSsfwwwKFAsVozPb3JoiNC9g3lV1Ip3Bwz5iyZAyY9d9veqFTXe0CTNexPdgGKvEBIHLB+WDWrfCGvsZxrFZ50tjrEE7xIpq7yA6qo9V6GdTN5L47gVTSLYgNkipPGhAvtsp1ig9A7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aN4/iR/s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN4/iR/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781163525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kwt3xhLgRIYCqA/0pE+1oYC80jUr6ZU3WTeNTnVpM=;
	b=aN4/iR/szqEcXrDEdMPKp3v3k6fmSn58XhTRuuQBBNgM/kTDakPvWF4I7JRjboB7MyuU+n
	nYQZJk/Coa0R4oUhPzBRjaBqo5iDtXRVKY6TlLcGQtAAQLdusyL61IvOU/vMhTR8jAyAHO
	GJaF1jC1/C5mfrUzqfll7XduToq6Tk4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-5hORPKbdO26CRornHHMp9Q-1; Thu, 11 Jun 2026 03:38:43 -0400
X-MC-Unique: 5hORPKbdO26CRornHHMp9Q-1
X-Mimecast-MFC-AGG-ID: 5hORPKbdO26CRornHHMp9Q_1781163522
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b3ec3f7fso48541015e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781163522; x=1781768322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3kwt3xhLgRIYCqA/0pE+1oYC80jUr6ZU3WTeNTnVpM=;
        b=BaFPzIzK9gMWODkmDfcVqRAde/VceCzpPmOVx7d81ptMrSplc++X3MxMHtBFPumdex
         mVFXsxoWU0xfDz4E0En8KPqHDaBnlAOj/l9A63vqypxtLF8Se/xySYq1KPTDJGjTrpC1
         7uNlqTYTMxBXyWRsH0adXtHGoIAOoC9i2yGJjTT6qsaoKwI29k73lel48WhEVuiNgvVz
         85rWAW31ZJkw97V7hHkVQJhoGcUV0YA3FOWz1JEKpftCFwGxXSwC/QQT0uEB8lypeLCv
         mz79CjHSCwC6CyZkwo5IlYJ557c4OcC3sk9UQTHOJnfcPuBden/on8ggqllk5vx4rPye
         Arug==
X-Forwarded-Encrypted: i=1; AFNElJ9JAjO2/BtPSLpXhOBy1Z6wZ3JMS9tSglkicE7130Q/CJmqIT2gzsyJ/XD5WtXhMdATex0BRvPFQhx4EFuuvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUXcUX8Hpzz8jN+Ney3cz1cRl7ADvlHsM7Q4W+rI/Uncx87XS+
	W4yatEeYatjCBTFhMzkiYtaPtpRcphu8L5Eml7YvUly0O5nBv7CTPSoTNTndOJ1PMtsOcaHMZwx
	bNrlXhmLHn0NrJYo9AwWnNhqQArF2UQ5ASxLWWDj62YgbM/4FgjYpSWzexZXu8oJs3JFD
X-Gm-Gg: Acq92OHWk4ZBTilnA5t5l1ZYT8IG3QcsA1QfHDmxRVXQduVXUCKJ7WCSzgVtZU7hedU
	nLGFMRxXXCVDkqYfu0YdFW70QR4QINM8BwCNioHkGlTTD2KItoUl6iaN8txORwHrYM5O8J9CZaH
	y5LeqEclkVVHxF3s5PF5wX+EgFkAE1hXH6WedaK+kvZKgLmUp7EF7LLCyMi4+QcXFrvVxtoEbSD
	AVK+Ax5AxjxSWRffwYs4VlmdDNQ2KqCK2dXos85QEqRifZ6Q9KyftgK6q/ha0hB903zMa2HnVSm
	ifsQwTCRpz/wJGO/wTbmPGQjMytK/lxjnRAdqvs96ovMrCGcAzKoQbpy4huwhruLb85jsloJIow
	pYVQ1NCErLfAYkvQQ3atAqHOGfciwD3MFUCdbg1eQqWzFplSJ5R8iTw==
X-Received: by 2002:a05:600c:4453:b0:490:cb90:3e00 with SMTP id 5b1f17b1804b1-490e55fbd7fmr18677475e9.14.1781163522294;
        Thu, 11 Jun 2026 00:38:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4453:b0:490:cb90:3e00 with SMTP id 5b1f17b1804b1-490e55fbd7fmr18677045e9.14.1781163521767;
        Thu, 11 Jun 2026 00:38:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fb24sm84547530f8f.34.2026.06.11.00.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:38:41 -0700 (PDT)
Date: Thu, 11 Jun 2026 03:38:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] virtio_console: read size from config space
 during device init
Message-ID: <20260611033747-mutt-send-email-mst@kernel.org>
References: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
 <20260610030318-mutt-send-email-mst@kernel.org>
 <dce7a3af2e8fd674d842efe7e21abb4644248155.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <dce7a3af2e8fd674d842efe7e21abb4644248155.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jWOBsVJYP-ZMhBuN00AAZc16ZoqMBcxt1dvz0J6fcCE_1781163522
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 08:57:57AM +0200, Filip Hejsek wrote:
> On Wed, 2026-06-10 at 03:04 -0400, Michael S. Tsirkin wrote:
> > On Mon, Feb 23, 2026 at 06:37:02PM +0100, Filip Hejsek wrote:
> > > Previously, the size was only read upon receiving the config interrupt.
> > > This interrupt is sent when the size changes. However, we also need to
> > > read the initial size.
> > > 
> > > Also make sure to only read the size from config if F_SIZE is enabled.
> > > 
> > > Fixes: 9778829cffd4 ("virtio: console: Store each console's size in the console structure")
> > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > ---
> > > This is a resend of [1], which hasn't received any response.
> > > 
> > > I found this bug while developing patches for QEMU that add virtio
> > > console resize support. If you want to test this, you can get my QEMU
> > > patches from [2]. You will need to disable multiport
> > > using `-device virtio-serial,max_ports=1`.
> > > 
> > > [1]: https://lore.kernel.org/all/20251224-virtio-console-fix-v1-1-69d0349692dc@gmail.com/
> > > [2]: https://lore.kernel.org/all/20250921-console-resize-v5-0-89e3c6727060@gmail.com/
> > > 
> > > I'll also repeat my questions from the previous submission here. These are
> > > things that confused me when I was trying to understand the surrounding code,
> > > but should in no way prevent merging this patch.
> > > 
> > >   - Why does use_multiport use __virtio_test_bit instead of
> > >     virtio_has_feature?
> > > 
> > >   - The VIRTIO_CONSOLE_RESIZE handler sets irq_requested to 1, which I
> > >     think makes no sense?
> > > ---
> > >  drivers/char/virtio_console.c | 52 ++++++++++++++++++++++++++-----------------
> > >  1 file changed, 31 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index 088182e54d..c355f6d392 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -1771,32 +1771,40 @@ static void config_intr(struct virtio_device *vdev)
> > >  		schedule_work(&portdev->config_work);
> > >  }
> > >  
> > > -static void config_work_handler(struct work_struct *work)
> > > +static void update_size_from_config(struct ports_device *portdev)
> > >  {
> > > -	struct ports_device *portdev;
> > > +	struct virtio_device *vdev;
> > > +	struct port *port;
> > > +	u16 rows, cols;
> > >  
> > > -	portdev = container_of(work, struct ports_device, config_work);
> > > -	if (!use_multiport(portdev)) {
> > > -		struct virtio_device *vdev;
> > > -		struct port *port;
> > > -		u16 rows, cols;
> > > +	vdev = portdev->vdev;
> > >  
> > > -		vdev = portdev->vdev;
> > > -		virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> > > -		virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> > > +	/*
> > > +	 * We'll use this way of resizing only for legacy support.
> > > +	 * For multiport devices, use control messages to indicate
> > > +	 * console size changes so that it can be done per-port.
> > > +	 *
> > > +	 * Don't test F_SIZE at all if we're rproc: not a valid feature.
> > > +	 */
> > > +	if (is_rproc_serial(vdev) ||
> > 
> > Wait a second. Why is there this rproc test here?
> > Was not in the original code and commit log says nothing about it.
> > 
> 
> Previously, this code was in config_work_handler(), which was never
> called for rproc_serial (it's scheduled from config_intr(), which is
> the config_changed handler only for virtio_console).
> 
> Now update_size_from_config() is called unconditionally from
> virtcons_probe(), so it will be called for rproc_serial too, which
> doesn't have the F_SIZE feature.

So why not test it? What does "not a valid feature" mean?
I dislike transport code leaking into devices.


> > 
> > > +	    use_multiport(portdev) ||
> > > +	    !virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > > +		return;
> > >  
> > > -		port = find_port_by_id(portdev, 0);
> > > -		set_console_size(port, rows, cols);
> > > +	virtio_cread(vdev, struct virtio_console_config, cols, &cols);
> > > +	virtio_cread(vdev, struct virtio_console_config, rows, &rows);
> > >  
> > > -		/*
> > > -		 * We'll use this way of resizing only for legacy
> > > -		 * support.  For newer userspace
> > > -		 * (VIRTIO_CONSOLE_F_MULTPORT+), use control messages
> > > -		 * to indicate console size changes so that it can be
> > > -		 * done per-port.
> > > -		 */
> > > -		resize_console(port);
> > > -	}
> > > +	port = find_port_by_id(portdev, 0);
> > > +	set_console_size(port, rows, cols);
> > > +	resize_console(port);
> > > +}
> > > +
> > > +static void config_work_handler(struct work_struct *work)
> > > +{
> > > +	struct ports_device *portdev;
> > > +
> > > +	portdev = container_of(work, struct ports_device, config_work);
> > > +	update_size_from_config(portdev);
> > >  }
> > >  
> > >  static int init_vqs(struct ports_device *portdev)
> > > @@ -2054,6 +2062,8 @@ static int virtcons_probe(struct virtio_device *vdev)
> > >  	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
> > >  			   VIRTIO_CONSOLE_DEVICE_READY, 1);
> > >  
> > > +	update_size_from_config(portdev);
> > > +
> > >  	return 0;
> > >  
> > >  free_chrdev:
> > > 
> > > ---
> > > base-commit: b927546677c876e26eba308550207c2ddf812a43
> > > change-id: 20251224-virtio-console-fix-3d46980ef569
> > > 
> > > Best regards,
> > > -- 
> > > Filip Hejsek <filip.hejsek@gmail.com>

