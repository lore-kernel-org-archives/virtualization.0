Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB224BD1A
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787782; cv=pass; b=JN6OfwNp0EBCSNlQs0N87O0GsJM4CNskx4MA/SKTWzzth0ODIN8N2XScHmIKJpqTkfM1SW0jcClPxHqdDbKlOP6cCLKODeUGl3Tf4/s7HU/boxVFljYenTKmiWej/QEo+ucs8Py+zy6eZIS0XcmgWN16BiI8Ws1JFqE9X7+Rg2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787782; c=relaxed/simple;
	bh=bav4IRLbYgm2lLajgHgDzg+MDRlm47GGHNmgd8nNXJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDK/wB7Pwyax2ZuOPHlC3xPgeHJ2y1b4avZYcpuc0logEbAtw5Hm77tj5nhUnRE9G4iR2aqQ2KCpAjGoTa4cY9HncSDzsmZRMtpqy6few3+iz1DIE83cO5ope0xkEPGz0QlxGGF9oWg9zkpRjwituFT4tNMl3tk6oNimu8vfpxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=zfsmf5+5; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=sEyJ3Icc; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="zfsmf5+5";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="sEyJ3Icc"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-2drr.prod.antispam.mailspamprotection.com; s=arckey; t=1766787780;
	 b=6TN2ahEumx+BgdybXAb3yUcv6XmFRoa8bhDsUbWQH33U+7fFDX2r1SwhNZSyIWm5iG2mHXFhnY
	  +QE7B7wWAaV5IT/1J7YvI5QUCmfYYUsm2ybJYMnvhA69PKG0VQtbULZidVV8WZ8wrTBJAcih2Y
	  VKfOGl6x319BH7Ux/pIz12lTnJb7s2QErn/oIpjRuDtezTmVfuqtGX43h55PE4j02ZeOj4uYuf
	  jkE9j9HLwHL41OxkyTSpEAaIv/3y2C1cqRpPsP5I4t0tyj8D61Ec/pFRPNh/eAf5hrLuAFQKj2
	  bKx0K5rJsm4EsbkGCCfB5j31LFRWHqaj/kZZAy4sv4G0XQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-2drr.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-2drr.prod.antispam.mailspamprotection.com; s=arckey; t=1766787780;
	bh=bav4IRLbYgm2lLajgHgDzg+MDRlm47GGHNmgd8nNXJk=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=ufiaE8/CGDeqW8M1+iSzvIMC0uhq/cDebgSNpPhUOnZa5JP+BZs7VQ+Mzvb01WbMrV3EQ0HKFO
	  hddYdCM7+DCVeW/8XxcerYNtGfdWVYMt+wEW1Nq98x2tG293P00ZA/cCahO9WhNjOBOdK+9xSf
	  4lSneOJmcKcJiynkzWAFtvo0ybndsTb8Y4fNSX5DGBpM2dg+Mt5Sil1+wV/syw48IZthQXa5Z4
	  pw5Lo36P3BQwoBgGVdYx4JPBhCWo3wTqxMTPAUtZL2fQOwe5aUCoujdTiQK6PFExMZDcBjwPAG
	  QUKb3ceXg9jvSAmlE4X3k4Pk5fPY+6zl58G2AtsoL+yT6A==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=uwxcfM2nIoMiJ/2Cxvig6X/YBuR8saav4O8t3bsIEzg=; b=zfsmf5+5FrxQjsej7ACl/1JXJY
	0UBo+3hnxMJ1ljTAGa/54ErgZk1BS4kqeFabPTX8wThiG60gn0sBunnzNctct00bQrNgCnjATbtVi
	Jg7sIeB/h04BjKVGtWHKmyj9nGd9MdQpz3azo2pyxR2FA5eFkUNrV126YVCGn1oPnrbc=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-2drr.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vZGD1-00000003URG-1pmp
	for virtualization@lists.linux.dev;
	Fri, 26 Dec 2025 22:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=uwxcfM2nIoMiJ/2Cxvig6X/YBuR8saav4O8t3bsIEzg=; b=sEyJ3IccJgOLjH0XhYCQHnwT9S
	ngKkeBgcBkv6Lo//RWEVtIXXHj+1OEYB3m830PyESrBXPOB3TG3SxdwbzYcAS7n4STHsJkUSn/aM0
	5c1Y/6WrURrnRiUyNCQFp8W+Ijq+ZiYtZ8wp7wg6ejKIFhoZpOqZvVUK8yUHsJp6k64w=;
Received: from [95.248.141.113] (port=64047 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vZGCm-00000000Lwd-0IpK;
	Fri, 26 Dec 2025 22:22:40 +0000
Date: Fri, 26 Dec 2025 23:22:38 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aU8Krjsv0_aC3E7A@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU71oJScQ8aC0npw@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aU71oJScQ8aC0npw@fedora>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: bc4efc9583dc2d73531cf17135db547a
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vZGD1-00000003URG-1pmp-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-2drr.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Fri, Dec 26, 2025 at 09:52:48PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > +{
> > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > +	struct net_device *dev = can_priv->dev;
> > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > +	struct net_device_stats *stats;
> > > > > +	unsigned long flags;
> > > > > +	unsigned int len;
> > > > > +	u8 result;
> > > > > +
> > > > > +	stats = &dev->stats;
> > > > > +
> > > > > +	/* Protect list and virtio queue operations */
> > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > 
> > > > The section below seems a pretty big one to protect behind a spin lock. 
> > > > 
> > > 
> > > How can I split it? 
> > > 
> > 
> > Question here is: what needs to be protected? As far as I can tell, the
> > only entity needing some kind of locking here is the queue, while both
> > ida_* and tx_inflight operations are already covered (the former by
> > design [1], the second because it's implemented using an atomic.
> > 
> > If I'm not wrong (but I might be, so please double check) this can be
> > limited to:
> > 
> > 	/* Protect queue operations */
> > 	scoped_guard(spinlock_irqsave, &priv->tx_lock)
> > 		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> > 
> > 
> > Maybe the whole locking pattern is a leftover from a previous version, 
> > where a list of TX messages was kept?
> > 
> 
> I followed this approach for the three queues. I wonder why the rx queue
> and the ctrl queue use a mutex instead of spinlock? I added a mutex for
> the operations to the rx queue.

If I interpreted correctly (but maybe Harald can shine some light on this):

- the virtio_can_send_ctrl_msg() uses a mutex because it could be
  executed in parallel by different actors (read: userspace processes
  invoking up and down operations); moreover, is the whole control
  operation that needs to be protected and not only the access to the
  virtqueue_ functions, so a mutex should make sense;
- the rx queue shouldn't actually need any locking, since it is accessed
  only by the poll function and the network framework should guarantee
  that no multiple parallel poll operations are called on a napi;
- the tx queue needs instead to be protected, since it could
  concurrently be accessed by both the start_xmit callback and the poll
  function; a spinlock there makes more sense, as accesses should be
  very short.

> 
> Matias
> 
> 

Thank you

Regards,
Francesco

