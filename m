Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794159329;
	b=qd7xXLTLMrdsVKDat8QIRqLuzFHIj0ervAp9YWRvgJkJeIhZwR23TNTDFWdj6b8OpRIu
	 2lwi8hlO8zcXbi1GJayfJfIPqpAzrROJyy2lD1jk7dCJ4kMfSB2hHT6eSjC5WtoCxqbhs
	 ND1hyIv3fDf8SpD03lmU0pj7bZ6nK8Zyzg8XJ4x2Zb3gF7FvQc8ijuajGqNZ5uxvjkCem
	 spT/EnQsbWTYYnKCqfhAZjW+svgvXIVmzraGh5tXvVxo3sLHbGtzX0aveXSUC1XOYOQvy
	 lGn+ClnSNpqCdNxnvxW/JrDAPSSQxGVCiV7UkuZz/siqpxkHfWhuOWwGwBg0akEJ0Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794159329;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:
	 X-Source-Args:X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:
	 AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:
	 CFBL-Feedback-ID;
	bh=RiPnZObIZwfdVYQ2RKHH5XMoQAlSCLMECl3j9aPVuhs=;
	b=aXF4rYm7nGwpKLb7oLX/7PMfd4ma0PmNQpIrSo+v/2rOTGgOvqkLzdcgAW2zZQv7a1tM
	 RnrFGwCs8Cof5Df6YEfAIm9TVekGVxL0ej9gb1x+N7xAIAm31ZMRuSMP7QadqHUa8oHzd
	 c3ReuXXtw8SzayNW809UFlbojFs9IMqiuuUK6OKb1R6bJANMoeAG7fVFW8VT731Thbb2E
	 cV4L4/9pci1wiI1e3WVjcUUwG5x+Ft3rSXSEo17hstpVX63+QnvGkB92+w9IGdkPhrHYZ
	 M1ciK+9unJRNobLAKme290SLA+ob2HLLfTKqSGcGHy3v3IQjo5ku+Y5UIilxRotNf8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=gSQyqi8D;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=eRUXDQ4Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.5
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B95606A320;
	Sun,  8 Nov 2026 17:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B95606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=gSQyqi8D;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=eRUXDQ4Z
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com; s=arckey; t=1794159328;
	 b=JuUJ8r1LwCqVeB9tZ+KzR/L1W33/PNjxPS3jbnfbnfm3I3IC4xSuqV7Cw2HFxVS+ekMNP5Erz3
	  T9E3+rrPGilPuodW6WGAGC3NLg75hKOxQ59PMZVgeZw/EFyEFKJzxWB5pA91nwM9yh1vt6vK9X
	  zEHgcAd7IiZO3Q3HuZFnFBHqxrw4ff7sK0yXPSqW31u4KH4GzJJ4uJuvnz0RZ06tRVo3iKWN+o
	  WfhMvRObeTSLtiTkLzZsVt27+ktF9G/x1n4B2Mo12S2D5hmKujgjXA1rHhY2tGiIZcYdE2VQgc
	  9hXZNHDSDDLrcdDtRf7IJwJ2kvu/OTRFs5GMMZkyi+BGrA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com; s=arckey; t=1794159328;
	bh=rGhndhjN4FfmHUumbNK8ICQPn2Yp54qCx33ElHMZ+bE=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=Lsmr94zIRn42UjWV76V6RFYrbRjb7NOU9hKtb13HdsYAO+WgEq16GlqAdXULq3PA/p6WQ0ZQ4T
	  Akz6oBvo4bwMWU9bosetQF+Sm8DJhvcrIOt+iaQZyClJM2sYE3fs0lFqF3PcU6GJHAZKp4QeAh
	  khcRveKnYQoG4FDB8gimg+nM7XbmF+cacKYLIf/OGTDic5k7rwtfQMGt16MXmy/4/sNjeEU6nC
	  hdPNnGiOGNDq0dqhe0A+pkeBENhGBrjFBkki33IyjOUc8nbv76od4G7rJGpajsS5lVdf3j8lhS
	  v0OKKfxJYOXyx3IXrhEUxPj+I8NogsN4y0D57/HvVjuMOg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=RiPnZObIZwfdVYQ2RKHH5XMoQAlSCLMECl3j9aPVuhs=; b=gSQyqi8Db+C4wv3G5aiblQwNGN
	u//cSd0Mkvljb6HRfZ3dbS8EBUabjVuLFvEWtmm8ChCqcTlgX5Nw/NT/YWiif1HLBo/GnJTANr3kw
	PPBo2x2coI2SgbS+8QsQ6C4t/Hd3szbZthyensP2a5+NQ93L3XWVvcByG+M6XFYzB6ZA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xQ6nX-00000005B6Q-3Gpr;
	Sun, 08 Nov 2026 17:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=RiPnZObIZwfdVYQ2RKHH5XMoQAlSCLMECl3j9aPVuhs=; b=eRUXDQ4Z96F4bvS3QmOBbh0dqH
	iDVGWqqAGR66zBgfqfnQCBEHQC5ZF2jEmo5Q8X9E5BzTLFAzusmL4x9vkRlxfqgWRs8qR11Oq+tfc
	vITefb//xtpwWgzi5Tq+c/2UElWOmhrjiCrVPK4mgSIxXNvJ3UGQLzD59S/NbaoglJvI=;
Received: from [79.17.15.196] (port=61146 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xQ6nT-00000000Acm-1iIP;
	Sun, 08 Nov 2026 17:35:15 +0000
Date: Sun, 8 Nov 2026 18:35:14 +0100
From: Francesco Valla <francesco@valla.it>
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH] virtio: check for driver remove callback before calling
 it
Message-ID: <avCx4TSx-Zk4hfoO@bywater>
References: <20261108-virtio_drv_remove_fix-v1-1-23da1a7c3900@valla.it>
 <sashiko-outbox-203883@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-203883@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 849019556c64230bf6d25ffd39747dee
X-AntiAbuse: ID - 849019556c64230bf6d25ffd39747dee
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xQ6nX-00000005B6Q-3Gpr-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Sun, Nov 08, 2026 at 04:50:38PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] virtio: unreset device in virtio_dev_remove() when
>   drv->remove is NULL
> It also noticed 1 related pre-existing issue this patch does not
> introduce:
> - [Critical] virtio: use-after-free in virtio_dev_remove() [1]
> --
> 
> commit ccd4078efa3bba738fda1cc44e8e8955495a84fa
> Author: Francesco Valla <francesco@valla.it>
> 
> virtio: check for driver remove callback before calling it
> 
> This commit checks whether drv->remove is non-NULL before calling it in
> virtio_dev_remove().
> 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index a8588d7ad109f..067d32c67b44f 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -374,7 +374,8 @@ static void virtio_dev_remove(struct device *_d)
> >  
> >  	virtio_config_core_disable(dev);
> >  
> > -	drv->remove(dev);
> > +	if (drv->remove)
> > +		drv->remove(dev);
> >  
> >  	/* Driver should have reset device. */
> >  	WARN_ON_ONCE(dev->config->get_status(dev));
> 
> [Severity: Medium]
> When drv->remove is NULL, will WARN_ON_ONCE(dev->config->get_status(dev))
> always fire on unbind or module unload?
> 
> __device_release_driver() calls device_remove() (which runs
> virtio_dev_remove()) before device_unbind_cleanup() runs
> devres_release_all().  Even when a driver such as spi-virtio registers a
> devm callback to reset the device and delete its virtqueues, that cleanup
> has not run yet when virtio_dev_remove() checks get_status() and sets
> VIRTIO_CONFIG_S_ACKNOWLEDGE.  The subsequent devm reset then wipes out
> VIRTIO_CONFIG_S_ACKNOWLEDGE, or if a driver has no devm reset action at
> all, the device is never reset and remains active with live virtqueues and
> DMA after its devm resources are freed.
>

Yes, but that's (IMO) better than a NULL dereference. The spi-virtio
driver will be fixed in a different series, as stated.

> [Severity: Critical]
> This problem wasn't introduced by this patch, but calling
> of_node_put(dev->dev.of_node) at the end of virtio_dev_remove() causes a
> refcount underflow and use-after-free [1].
> 
> virtio_device_of_init() acquires the dev->dev.of_node reference during
> register_virtio_device(), not during driver probe, and virtio_dev_remove()
> drops that reference on driver unbind without clearing dev->dev.of_node.
> Unbinding and rebinding a driver drops the reference multiple times on the
> same pointer, while unregistering a device that never bound to a driver
> leaks the reference.
> 
> [1] https://sashiko.dev/#/bug/linux-cf8a6c4a-49fb-4827-8f82-d189cf36ccdd
> 

That's... interesting. I'll add it to my backlog if no one is already
working on it.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261108-virtio_drv_remove_fix-v1-1-23da1a7c3900@valla.it?part=1

Regards,
Francesco

