Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAD13AA2F
	for <virtualization@lists.linux.dev>; Sun, 14 Dec 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765722295; cv=pass; b=TymxBBhuO1JmvR73kTiPq0YrZB4hxPfqYpxVitrd+oclHPMa4bBIy0DWBrxYsdCwxHjRMlLA6dz93aEzzAK2esoLgVRip5JdeB1QK6JlarZ2QFOwBeGbZBw5wEc3HxfxKku9BoPajqb3U8+RZQ4NyeTOwNgyeiZ/eyC2VRDNznI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765722295; c=relaxed/simple;
	bh=9U/4H0u7IeO8SK9G+ka43cBTeRHALsUFMjkDklSXq3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOYJ0S+6CgFW5NW/8POZQ/KX8EgkYT6I4PIoIkcV/WL+HKd0Uh/SlrsQEMe5JyVU+N97uPsPj1+wodcFcTAL6/qEaQ7brXPc/lI8Ovu/botdZAyKA9+t51rnG3KF8I6mTteWnrtZJMYRnapgfIg3V5d5/1i6Jknt7BSguvFOVjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=qmj/Ttxz; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=LgpazSlO; arc=pass smtp.client-ip=185.56.87.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="qmj/Ttxz";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="LgpazSlO"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h9hs.prod.antispam.mailspamprotection.com; s=arckey; t=1765722292;
	 b=K0/+xIeFmJSMDyuWpDnp68M96g6evJAlVcqfQposfZYAgzO9qnnUTmt9kGj3jpxkliBUmt1/Uy
	  Eom3Ztmvkb6HZsYYu/j+SjKJpDXrp6RbCcEopYj691xQftCH7kh5VKnizxEDFXukDphUUO9gCg
	  nuLqewojvYczlJpEGrqJbCS9Z/gx8eaRgI6o0WNt1lAbyB0mei1UobYgDKfN/JNOfB4eqwdBrT
	  Rzs90Kc7V6LhOL6NIw86NOpJOL3ooxyOzCQVpB6VNzewHR4as792YmCbcbOeuSW707LC3xV3jb
	  6rCbdmbAdC8WTLjwbtTrvvDzfqU1acXnpUo/aFSZVmg8lw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h9hs.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h9hs.prod.antispam.mailspamprotection.com; s=arckey; t=1765722292;
	bh=9U/4H0u7IeO8SK9G+ka43cBTeRHALsUFMjkDklSXq3I=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=UOq0LCxkLUVCYv/Fa3LKGZKGYTdULG5b8BWFzKwvFCtLr1hYjQD0ozDiO9x8floSwP5LmbmfAJ
	  gzzUVzyRUOT4Ska283JFp9RCHgiMg435fn2nFfzbkmBv+AjhCtQSJQ9p9sjNntNmMm7lc2sZm4
	  JoVeBfWjj2nFUajUvG6vFNsodG2f6E6QfADCncfXGeMfIN5ruYevoZVx45MCBS/vXcI4/00JJv
	  jqjklcqHqUkNATduLimEd1rmkpVgVq5tiIuc92KnmFtvtRdCyG5B6xGPcZXZ6e0fnpDW/sd+Qx
	  14Q8O+X6DpePWWp6lQwxnaLdaBzVSf2c4ie6yBB0xJZUTQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=o+wKOrFZelyH+jQJOnvI/aGEta4ZGrzG5vU+orLBrOc=; b=qmj/TtxzDZID1H6lpbiMD6a0eE
	AIB3NFTurlD+CQaCCTQ8SBAdxRItaUOd+gtImc9pN4+0NyYZM7N2+i8fS9LAYG7tUcsYzN9Qgw9/T
	8qpv08q16Qy+MrT5YwI5a5S7745Wrl3nxgVR/fzsXI+Z0DUUG7h+IzuzdoZa3+e+7slc=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h9hs.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vUn1j-00000000vPg-35hW
	for virtualization@lists.linux.dev;
	Sun, 14 Dec 2025 14:24:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=o+wKOrFZelyH+jQJOnvI/aGEta4ZGrzG5vU+orLBrOc=; b=LgpazSlOYH6J/Z6Ak0/vT65R7X
	nENUiSrlgAPkiFlGYqYoZtoIoZaJcxK3E5ElOO4pwurJMRKXZO32ufNpJ9eJML8hP4K0nrzGXs8sx
	ETxYXpuoDz27BjAm8gG8YpOzLKQ8Y7Mv/892OAxuN2tMx6evxwI3Mi645dcDz58gepFE=;
Received: from [79.34.194.176] (port=60598 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vUn1U-000000006Go-1D9P;
	Sun, 14 Dec 2025 14:24:32 +0000
Date: Sun, 14 Dec 2025 15:24:30 +0100
From: Francesco Valla <francesco@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aT7InsN51RIyIeA2@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTw2LORF0QiEcgM1@fedora>
 <20251214022000-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214022000-mutt-send-email-mst@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 9325e6ad8ea0534f7035743525f4d7bf
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vUn1j-00000000vPg-35hW-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h9hs.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Sun, Dec 14, 2025 at 02:20:36AM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 12, 2025 at 04:35:08PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > > +
> > > > +	priv->can_ctr_msg.cpkt_out.msg_type = cpu_to_le16(msg_type);
> > > > +	sg_init_one(&sg_out, &priv->can_ctr_msg.cpkt_out,
> > > > +		    sizeof(priv->can_ctr_msg.cpkt_out));
> > > > +	sg_init_one(&sg_in, &priv->can_ctr_msg.cpkt_in, sizeof(priv->can_ctr_msg.cpkt_in));
> > > > +
> > > > +	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
> > > > +	if (err != 0) {
> > > > +		/* Not expected to happen */
> > > > +		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
> > > > +		mutex_unlock(&priv->ctrl_lock);
> > > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > > +	}
> > > > +
> > > > +	if (!virtqueue_kick(vq)) {
> > > > +		/* Not expected to happen */
> > > > +		dev_err(dev, "%s(): Kick failed\n", __func__);
> > > > +		mutex_unlock(&priv->ctrl_lock);
> > > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > > +	}
> > > > +
> > > > +	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
> > > > +		wait_for_completion(&priv->ctrl_done);
> > > > +
> > > 
> > > Since the call is synchronous, does can_ctr_msg really need to be part
> > > of priv? Cannot be it allocated from the stack?
> > > 
> > 
> > I tried to allocate in the stack but the guest blocks when during `ip
> > link set up can0`, any idea?
> 
> you can not DMA to/from the stack, really.
>

Right. Forgot aboud DMA, my bad.

> -- 
> MST
> 
> 

Regards,
Francesco
