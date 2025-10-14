Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E9289811
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424899; cv=pass; b=XPQo0gngbESZ75Juu4tkv9rqPAunAUoFB1/Qheywixvwx6vL4SIiHi9C4pCaxHXXNjP7lYVU5QxshTRWDN4HPWDb2BMrLt4eJ8pvtd02qZOC0c6VYOIJe7mUhJtGhiPNQvljBQM65WIulDUSKfZQ/qyYf2o4OkVNbxCW4ZLVJVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424899; c=relaxed/simple;
	bh=+KOCzTUQxF7tBG8tIQArtu0WukAm1yPCMNY0jgO/01A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlVSAR87V9zZKNgiS8iY/ZpazlXZwFCGvO1XM3fu4ixHdo/zW5vWhwMXqo54DoYNR+3TBAeMvOHyJx6Z/LMwh9K5bviX9EizADb8FgLQpBSrfjpktwf2tpwM2Lb/Jqtuw7yJxD6fxC7K6xN7SRsu/GR1JZ7E53oXVkML5gwz9LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=R3wFz3bX; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=cxNKIHTN; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="R3wFz3bX";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="cxNKIHTN"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-688d.prod.antispam.mailspamprotection.com; s=arckey; t=1760424896;
	 b=TlJtXO1vVByqkbe3qoB9uYZD0UUXQzgKOKqUDUKqOR68yJNIqpNLXOnJ6T8G5fZxVdDY1ysKo3
	  IDaed3R2/GIbPAtigj+gjb+b8t+WrXtPaJSChErz2g2zN78isX8XoePYCD+ZN7XxXJ05ZRACI1
	  y8m+xfVNJxtoG53KRq8Opfw7rWfk/sdsrP1lyKPaatKbgooa4jcJRwXvJzYBoy9U3gj4hVJKe7
	  t91DyNY5m3kVtRa35rk7LBg35wT33o+6WdGncSrwUPZ5MZsl6KBn/VlZswgpU27BbU8e9lGPga
	  4SYcLlLGV28CB5rLkMeDaF518EnUr7XO6QTuOAZL+ssPBg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-688d.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-688d.prod.antispam.mailspamprotection.com; s=arckey; t=1760424896;
	bh=+KOCzTUQxF7tBG8tIQArtu0WukAm1yPCMNY0jgO/01A=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=KkgjRs8lVEXUNgKqXQd8Y7bX1ZKbvSKEyicYqrJgGVPnLSNrBhylhEzcPUqCjLNuSHcNca7/AQ
	  SJoxSmGYpFe34dD84MFkkW41MD++HGX2ej0VYH0msBO0aMY1PzJDVeGbbjzT/2zIpPA4CIzu4A
	  7iOUKLRAtxz/jwQ3H+Vi/0FbyvLEppm7GZSd6BU2sQFnr+NtjriA9/k5ChGxJsvAvCXv9wn9rh
	  gYXr2LQgJW8+F1Az7UGCkSru/mwY4bKK++BfQSTcNK5Azojl2lQK5p8EWDSeXPVvpakOaPwSmO
	  JTaqQT67hAMjaYPXp1nnH7TfL998qatUgv5vP3C3Ci0rSg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=+RRcVYG+JUhl3wwxa7uQJx37j5Sku3cHAniytdo2VwQ=; b=R3wFz3bXbVA1kylgYK45hXforn
	7h+ROpL4t16k8cJMVaY3KF7U2U4Th21wIs9LlY/WHosLyCLEAp4o3qXfjPrMmi3zQ8/0DbDJCFNkE
	HPnf1aQ7OYb5L2HqW1qw+vMMS2rfye+ukNpQ6b1y+p8Q6ZMy1wZIdVOqcbTLnsxxnoM8=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-688d.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8Yvl-00000000EAk-38Vm
	for virtualization@lists.linux.dev;
	Tue, 14 Oct 2025 06:54:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=+RRcVYG+JUhl3wwxa7uQJx37j5Sku3cHAniytdo2VwQ=; b=cxNKIHTNYmuzDNfeOKfMSXI46U
	HXOanL9R91tN80jMXt+g62vZhFF46VPRinAMUPxr1ZCeUnrqsYsyLtmQPuLt/vJPwGCGUsGLbGvFu
	1tKEk4BT3+rasp2VKC1WjtVb0M9JQDmAuFt1Vp1/6BE7axLKcgmUCvGCczdUGS7ikmQ0=;
Received: from [87.16.13.60] (port=63318 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8YvQ-000000003P6-0BXm;
	Tue, 14 Oct 2025 06:54:24 +0000
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
Date: Tue, 14 Oct 2025 08:54:23 +0200
Message-ID: <2332595.vFx2qVVIhK@fedora.fritz.box>
In-Reply-To: <aO0qZ4kKcgpRmlIl@fedora>
References:
 <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box> <aO0qZ4kKcgpRmlIl@fedora>
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
X-SGantispam-id: 4c4818ce1f291eb43fbe4b373690c6de
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v8Yvl-00000000EAk-38Vm-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-688d.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Monday, 13 October 2025 at 18:35:51 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > [...]
> > 
> > > +
> > > +/* TX queue message types */
> > > +struct virtio_can_tx_out {
> > > +#define VIRTIO_CAN_TX                   0x0001
> > > +	__le16 msg_type;
> > > +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > > +	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > > +	__u8 padding;
> > > +	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > > +	__le32 flags;
> > > +	__le32 can_id;
> > > +	__u8 sdu[64];
> > > +};
> > > +
> > 
> > sdu[] here might be a flexible array, if the driver allocates
> > virtio_can_tx_out structs dyncamically (see above). This would be
> > beneficial in case of CAN-XL frames (if/when they will be supported).
> > 
> 
> If we use a flexible array for sdu[] here, then we will have a problem
> when defining the virtio_can_tx struct since it is not in the end of the
> structure. I think it is a good idea to define it as a flexible array
> but I do not know how. 

In this case, I'd move struct virtio_can_tx_out at the end of the
virtio_can_tx struct - in this way, sdu[] would be at the end:

struct virtio_can_tx {
	struct list_head list;
	unsigned int putidx;
	struct virtio_can_tx_in tx_in;
	struct virtio_can_tx_out tx_out;
};

Maybe an additional comment declaring why it is done this way would
be a good idea? Also considering that the two structures are defined
in different files.

Francesco




