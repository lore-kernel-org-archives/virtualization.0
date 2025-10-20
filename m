Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599F3346A3
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995494; cv=pass; b=LzXJjW399nzOHjGpWbDO9JL1NSdh24cA2kMX2OQ7ZN7CGQ/TBD38+pUfwvAxfCUnFAZ0RA36VCleAurFPnmkyd1rOKYQ9pjAURLlLnW5jKgmH9mwCtQ26stnW9zSIq+vptxpNpsvKOog4Y5MfkpyaJdJLI9OC+8lxgjlSjoIQZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995494; c=relaxed/simple;
	bh=2ouFT+alOTtWn5rhfE5oAisrrN6mYTQD5/35TSdIxvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMb2c5cvhaSDgusYrJKJq4mP90A/4hI9qkquGPzXWOZfr/zZX60Hnn2xTF+/oxwDqqnPwarD9Vc7iBhgZJB95MfGsL2q83esj1y9jI6m09eGfDEdWktumlxJhBqLr41u+XJthwUTtn03/7t5oQlgDp8XZCWwlz1xywvA7dtjGPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=epxF7aLx; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=m0JvxP3Y; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="epxF7aLx";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="m0JvxP3Y"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-20pg.prod.antispam.mailspamprotection.com; s=arckey; t=1760995492;
	 b=Bb+/DGNBVvr+aCVRBOvD3E55Tc0tGjrmDVvUe8m3TzLgsfU3UsNc7Fst+q0hQbTMOItXmlsO3y
	  R9mnDM9jE2ub1DMM1ZGQAY7vvozDCa0SxFQ/0aHP5Dq9Psqck/PVBSdBeobipfDeaxF8I0AYad
	  IqWJQUVYjsd2TUO6u7hktVsMvcgU9337i9X73q5TR+EkXOPhR3f8rdH713ApspYO5aRZM8dets
	  yUI9XmWd8e/dlZajeFHt1kPiOE048wtvI9g7LlwfWTXuFWRQfdxx3ym7FioGA1xHgyIqoXkuQr
	  opg567mUPehlm4mSAlILnenyyEMQHPTJvIzVJru/w5jUrw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-20pg.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-20pg.prod.antispam.mailspamprotection.com; s=arckey; t=1760995492;
	bh=2ouFT+alOTtWn5rhfE5oAisrrN6mYTQD5/35TSdIxvc=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=ZhoL6Ruc4cxJ/pK11jNgJfQuW5AvJCt9TpkZNoaptcQZ/WdMzmac5u2QzQuKYsis8jar1besIs
	  7RZnPIq2BSv1Rgn2MNhdYOEaL5ZXOelAMTkeIlCYBSgsIOlX33RasnkIlVaGgQDgz5qBhPkUuA
	  fyUjgm8A+uykaY+9AG/DNWIsNJU2NVpnT4Me1h7kN89ch5yAMVhcv4u7wQwmLoTmoZahgenxMQ
	  LVLqwxnDrbfUBj1XAiBYVy7ZaZipfpC9G7/MC/ZNhiehdc11AoC0d+ou2ZcXydLx9/yTA2vQhm
	  XUMrp5pU2NJ1VqUIG+myZFbJuPRScHl2eUfNP3R+ZEqlvQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=SnX1nQdEuaGWMQh+pLSXIZd/hCY6zPBWbspwRBykrrs=; b=epxF7aLxQynHk051S8/lutn+Mk
	v5A4kyv1UGTZcTUP+3LaNzGBPMVSR/bp+U+U0s4/CrgA5+cpHnI2ewYJA1T90e4bRlYOZjyOxNrG+
	SN8oMSwLTYUSocfppcC8yh2RJxCTpgp7PB7JZfnjdKdzu4PHKOeicoUatTTIcX77yKIA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-20pg.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vAxMv-00000002cBJ-4BBV
	for virtualization@lists.linux.dev;
	Mon, 20 Oct 2025 21:24:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=SnX1nQdEuaGWMQh+pLSXIZd/hCY6zPBWbspwRBykrrs=; b=m0JvxP3YhlvEKT+SYapQA6y1pK
	eudCWGk+b4z4DhlFO1FxlCzqd/gZaM/JRU625IW4OLptCIRO1GYpgeK/uUo502GJD+P+nDJKL0IEy
	QvKyUxlpoY3EpzPsNxIJ5yc/koZL4MqoObUZXsMP5F9z1jKIqmUG766341xbyDv+T6xM=;
Received: from [87.16.13.60] (port=60132 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vAxMX-00000000AIj-08n4;
	Mon, 20 Oct 2025 21:24:17 +0000
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Harald Mommer <harald.mommer@opensynergy.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Date: Mon, 20 Oct 2025 23:24:15 +0200
Message-ID: <27327622.1r3eYUQgxm@fedora.fritz.box>
In-Reply-To: <aPZNiD1SN16K7hmT@fedora>
References:
 <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <1997333.7Z3S40VBb9@fedora.fritz.box> <aPZNiD1SN16K7hmT@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: cf0ffe42679580eb43cde25a659e616e
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vAxMv-00000002cBJ-4BBV-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-20pg.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > Hello Mikhail, Harald,
> > > > 
> > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > 
> > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > 
> > > > [...]
> > > > > +
> > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
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
> > > > > +
> > > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > > +	if (!can_tx_msg) {
> > > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > > +		return 0; /* No more data */
> > > > > +	}
> > > > > +
> > > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > > +	} else {
> > > > > +		result = can_tx_msg->tx_in.result;
> > > > > +	}
> > > > > +
> > > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > > +		 * layer to an end.
> > > > > +		 * TODO: Any better means to indicate a problem here?
> > > > > +		 */
> > > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > > 
> > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > > 
> > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > > a problem in the rx path and this is the tx path. I think the comment
> > > refers to improving the way the driver informs this error to the user
> > > but I may be wrong.
> > > 
> > 
> > Since we have no detail of what went wrong here, I suggested
> > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> > controller error with id CAN_ERR_CRTL; however, a different error might be
> > more appropriate.
> > 
> > For sure, at least in my experience, having a warn printed to kmsg is *not*
> > enough, as the application sending the message(s) would not be able to detect
> > the error.
> > 
> > 
> > > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > > is misleading.
> > > > 
> > > 
> > > I'll remove the counters below.
> > > 
> > 
> > We don't really know what's wrong here - the packet might have been sent and
> > and then not ACK'ed, as well as any other error condition (as it happens in the
> > reference implementation from the original authors [1]). Echoing the packet
> > only "to bring a waiting process in an upper layer to an end" and incrementing
> > counters feels wrong, but maybe someone more expert than me can advise better
> > here.
> > 
> > 
> 
> I agree. IIUC, in case there has been a problem during transmission, I
> should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
> netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
> stats. Is this correct?
> 
> Matias
> 
> 

That's my understanding too! stats->tx_dropped should be the right value to
increment (see for example [1]).

[1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L1035

Regards,
Francesco





