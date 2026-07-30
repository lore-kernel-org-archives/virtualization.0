Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA03839A3
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432302; cv=none; b=VZnvayIZfLgAZ2W4zNAPbP1NDlW3gzCSTH3hZX7REjgxIdBuZINek2XIEDH8O/IPsOqBgJw4EWQhCmQAP9ynJc6PowDshdb4LeaoeTnGFvnJXeo8ZqvbnkIFIwPUFuvZa35zTZY7YpYn1hEGcL+PcCgwVY73ut6ENpnoO2yuw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432302; c=relaxed/simple;
	bh=wJ/XalsDjBq1gNIRP+peHYZq0bXX6cTt4OaaAFBwQW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TOJxKqDY9O1hv7xzOVE+l98GoUdytJ8IhVpMQJYO9xCimZiGmHxY6UkgeZuHkcAfbXC0qsoRpMcWcDycWIzpWJTxPtDXOCuFrLWDUtJVB2l24UVcJTtC0lN5ijIbZ6F123ehotco1ilAW4AzOuEBLDaudLac54c9/cubo51pNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjyFjSea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjyFjSea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785432300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pr67HA2/51ofKU2VJ7pDYmc1/eiW023ABVDXfaJxwo=;
	b=PjyFjSeaBrdu8Wwq1RHE0c73hG++/vut+MJah6QVtdUFW332KbqywN5j49nnVeIIJmVrgb
	pVtwQHxMts4URhdokTYtykzooycBSXJg0BHJj5UaUXQcy4QP5s76dpV0uIcZNAs7x9tj4U
	lbQftohpK+dyBJzH41+6j9GbSCR08fM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-ywb6KmcoMZiPSd6whx1Wxw-1; Thu, 30 Jul 2026 13:24:58 -0400
X-MC-Unique: ywb6KmcoMZiPSd6whx1Wxw-1
X-Mimecast-MFC-AGG-ID: ywb6KmcoMZiPSd6whx1Wxw_1785432298
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso87005e9.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 10:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432297; x=1786037097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2pr67HA2/51ofKU2VJ7pDYmc1/eiW023ABVDXfaJxwo=;
        b=JOVkD6JvNXqhq2Elh84bQib8LtznjSEDhP8xitFXkhiX+76vU1skEJnpM+/bMwdyLn
         SC5l9kXrNkmqangYpF05FtWMkyRnvRQZwYeTY7D7Djx03KIrHHkN72lpxRA/QUIbh8AZ
         Il2ShnameRL+YwIVJe6bKPBRzlgUfxWbVmBUtxJ7yjl3kZeJkJIjLlD1COB5AiW3cQHG
         CljyAow1pgwg29qnYlNX3+yhrFYzPv7JgXuop5YSC9LUuXrX8A+jzwjReAy49qoCCvyl
         EUQmfkpvkApPzDquOiCXAtfo9ObjYAD85I0X9Od6zE0LtXEtS18Buh3Lqnzotj9Jyobl
         VLeg==
X-Forwarded-Encrypted: i=1; AHgh+RqyM8zHvomq00ENLdyDtr4JeOJI9y/aaVq4+ss1wEtdrlH6r+GIxCwaYK7qY5myni//w5Z8jjxSHXI6jxQsnw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+duupbVOlT3VZk+53/s2/hWp608N6WIra5FCoiBDLUCHKJBk+
	lUKx7JJed/OxsBqF5UfOydEo1+FUOo/GvK1RL2Q6gWs0ALZYXSpM2kS2Ln7P/tsm6NrFIV3Rthf
	3/7qP50CMRs55GpMS1v09KNkN4rtQY/6YlFV99+FechWw+joHl9x4VlUqXPF+tnD0AI8wckWHV1
	43Kzg=
X-Gm-Gg: AR+sD102lmzyDq3RYfjOaa+AcSEDDBZS+0qKv/14PiOpG0ec9MFZFhlDyLdPFseDtG4
	EsbkniiBLBRTVYIsa1KL1rix320QkGm7brmjDq1BWdbzEhssZp0G/Y+jgUcdcZoL9AGgrdzjSov
	Zkpg6x5EQxKu0DYgneTRgf3G6lLwAc23QKpW28c1IUkv+VHIY//BMgZ3X5YRY2NW4J7BCN9d+wo
	qW4J0Pb5/+89qLbIhURNB5xQ9Meg7Itw/UA8t1PqgZw/pvdF3MrqeH67veuv+Xt8/X1xx+pkU62
	mAqM/lNIOG1YwyH9QpgVC7SBo/7ZGbhVKybUy+h8/fRd8ieqbDslGMy4eOLOT7X3IUr/TgLYd5o
	4+tM1xt5ZZLLVOkZ7JnLpEMs=
X-Received: by 2002:a05:600c:c4ab:b0:495:4730:15b2 with SMTP id 5b1f17b1804b1-49800eb3d94mr51452255e9.31.1785432297483;
        Thu, 30 Jul 2026 10:24:57 -0700 (PDT)
X-Received: by 2002:a05:600c:c4ab:b0:495:4730:15b2 with SMTP id 5b1f17b1804b1-49800eb3d94mr51451925e9.31.1785432297015;
        Thu, 30 Jul 2026 10:24:57 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011f2b45sm74579175e9.4.2026.07.30.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 10:24:55 -0700 (PDT)
Date: Thu, 30 Jul 2026 13:24:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] virtio_console: read size from config space
 during device init
Message-ID: <20260730132121-mutt-send-email-mst@kernel.org>
References: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
 <20260610030318-mutt-send-email-mst@kernel.org>
 <dce7a3af2e8fd674d842efe7e21abb4644248155.camel@gmail.com>
 <20260611033747-mutt-send-email-mst@kernel.org>
 <831dca185e55f56a14c0c580ab33ce84361eb67b.camel@gmail.com>
 <20260611044443-mutt-send-email-mst@kernel.org>
 <13ed71f8e2bc22476fb0dd48eb17af4917f4f03b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <13ed71f8e2bc22476fb0dd48eb17af4917f4f03b.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 555Tqet2D_x-aA4VbxUErvfzyOKJZJyPMVIR2kza1po_1785432298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 11:09:30AM +0200, Filip Hejsek wrote:
> On Thu, 2026-06-11 at 05:01 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 11, 2026 at 10:29:50AM +0200, Filip Hejsek wrote:
> > > On Thu, 2026-06-11 at 03:38 -0400, Michael S. Tsirkin wrote:
> > > > [...]
> > > > > > 
> > > > > > Wait a second. Why is there this rproc test here?
> > > > > > Was not in the original code and commit log says nothing about it.
> > > > > > 
> > > > > 
> > > > > Previously, this code was in config_work_handler(), which was never
> > > > > called for rproc_serial (it's scheduled from config_intr(), which is
> > > > > the config_changed handler only for virtio_console).
> > > > > 
> > > > > Now update_size_from_config() is called unconditionally from
> > > > > virtcons_probe(), so it will be called for rproc_serial too, which
> > > > > doesn't have the F_SIZE feature.
> > > > 
> > > > So why not test it? 
> > > 
> > > The virtio_console driver implements two similar but distinct virtio
> > > devices: VIRTIO_ID_CONSOLE and VIRTIO_ID_RPROC_SERIAL. Although some of
> > > the implementation code is shared, the devices are different. In
> > > particular, rproc_serial doesn't support multiport nor any of the tty
> > > specific features. This means that the relevant feature bits are not
> > > valid for this device and must not be tested.
> > 
> > 
> > 
> > > I have to admit though that I don't quite understand what the
> > > RPROC_SERIAL device is supposed to be used for. It was added by commit
> > > 1b6370463e88b0c1c317de16d7b962acc1dab4f2, which describes it as "a
> > > simple serial connection driver called VIRTIO_ID_RPROC_SERIAL (11) for
> > > communicating with a remote processor in an asymmetric multi-processing
> > > configuration". It seems that it was never standardized, as the virtio
> > > spec only says that its ID is reserved.
> > > 
> > > > What does "not a valid feature" mean?
> > > 
> > > I copied the "not a valid feature" comment form other instances in the
> > > same file where a feature is tested, e.g. in resize_console():
> > > 
> > > 	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> > > 	if (!is_rproc_serial(vdev) &&
> > > 	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > > 	  hvc_resize(port->cons.hvc, port->cons.ws);
> > > 
> > > 
> > > Best regards,
> > > Filip Hejsek
> > 
> > I get it, it's existing code.  It still makes no sense.
> > 
> > rproc has:
> > 
> > static const unsigned int rproc_serial_features[] = {
> > };      
> > 
> > No features.
> > So testing any feature bit at all always returns 0.
> 
> virtio_has_feature() will BUG() if called with a feature that hasn't
> been offered by the driver (see virtio_check_driver_offered_feature).
> 
> (Maybe that was why __virtio_test_bit was used? But that seems pretty
> hacky to me.)


Ah. Yes exactly. That's exactly what __virtio_test_bit is for
in use_multiport.
Want to try reworking the patch below using this?

> > 
> > there's no reason to special case anything.
> > 
> > So I'm testing this, but I'm only compiling rproc, so pls holler if it seems wrong:
> > 
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 198b97314168..2261862d4b4c 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -340,7 +340,7 @@ static inline bool use_multiport(struct ports_device *portdev)
> >  	 */
> >  	if (!portdev->vdev)
> >  		return false;
> > -	return __virtio_test_bit(portdev->vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> > +	return virtio_has_feature(portdev->vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> >  }
> >  
> >  static DEFINE_SPINLOCK(dma_bufs_lock);
> > @@ -1156,9 +1156,7 @@ static void resize_console(struct port *port)
> >  
> >  	vdev = port->portdev->vdev;
> >  
> > -	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> > -	if (!is_rproc_serial(vdev) &&
> > -	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > +	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> >  		hvc_resize(port->cons.hvc, port->cons.ws);
> >  }
> >  
> > @@ -1783,11 +1781,8 @@ static void update_size_from_config(struct ports_device *portdev)
> >  	 * We'll use this way of resizing only for legacy support.
> >  	 * For multiport devices, use control messages to indicate
> >  	 * console size changes so that it can be done per-port.
> > -	 *
> > -	 * Don't test F_SIZE at all if we're rproc: not a valid feature.
> >  	 */
> > -	if (is_rproc_serial(vdev) ||
> > -	    use_multiport(portdev) ||
> > +	if (use_multiport(portdev) ||
> >  	    !virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> >  		return;
> >  
> > @@ -1994,9 +1989,7 @@ static int virtcons_probe(struct virtio_device *vdev)
> >  	multiport = false;
> >  	portdev->max_nr_ports = 1;
> >  
> > -	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
> > -	if (!is_rproc_serial(vdev) &&
> > -	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> > +	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> >  				 struct virtio_console_config, max_nr_ports,
> >  				 &portdev->max_nr_ports) == 0) {
> >  		if (portdev->max_nr_ports == 0 ||
> > 
> > 
> > 
> > 

