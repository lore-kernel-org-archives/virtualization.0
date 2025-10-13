Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBC270576
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373020; cv=pass; b=omdggXmZqHTdutRlVz2rPKL5FFWbbtOiOwOjMgaeCtGH7ZzxWE10HbVTzMgRAgiT6NL9zptO6U7TiEF3k1JQ6PWXrBF1sAqOLFfOBWp/3jTeBXxkuuDE3wRmRZNGuVHcrtzm2DrYr6H16V899q6OpKaqP3Sh+95d4mWMLvD/dos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373020; c=relaxed/simple;
	bh=oRrhiGhbiLfqykr6MY0L/zJyzj4RWMd48cjICCb7vVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eT4YrKiiYqHb7sswfc0obo4TGCvNwTtRxaKr810b2fIeR7AEZryQLOlIx9cwR/mPbeogirKVtBPBXEokbNTe0e7mK4Z5YrPk6zmOMeXqXaaD6WhJ9yHm3RHwbOaSqAdAY+U8KJMnzI5hndxBxHLAOhY6wKryOkdqPn+MhO+nj/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=xrBTQj4Z; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=dd1EagOm; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="xrBTQj4Z";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="dd1EagOm"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-mh1q.prod.antispam.mailspamprotection.com; s=arckey; t=1760373017;
	 b=iUGHIIOP5zbvHPpoLD3vycp3ATnvtCZdDFjYlm+la2bJvxwDy1MRExS/TN2wRYnWNqyAgTGY29
	  VJW269FCXeL7pCVusMzWjtJ8JiGw/fPMqgk+UowbdKlay1AEtB8mRrnm2x5IbwwcYfHsTSppWq
	  ka1ncVVy0JVEuz1I0dIbhOmotolE/69XhvG/kFvWIV1NbejFRrPi3wl77TIUc0K8f1X4nLT/JD
	  gdsgmC4TSc0RTYcHA5sGwF31gPaKg8zKqOKFNwJxIIjNOyvPjrEw9FLDG++JD3pAqrR7ElMzui
	  6FX1GJSJB/GZGd63gGoGtIxytKT/qIdcVkEDMTFzI+7rRQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-mh1q.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-mh1q.prod.antispam.mailspamprotection.com; s=arckey; t=1760373017;
	bh=oRrhiGhbiLfqykr6MY0L/zJyzj4RWMd48cjICCb7vVA=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=WJw00f66NkuedD5G3BP/b45mFTHQoWNipEo4Qfd1XE2LRN+cn0k6acCwgsVxpTjj8thkv1KuES
	  E91RRrTANMh29VutEBuj/F9HcpYBeNiacgop9PUeUd6TvQhQVsP7s5uvzD1FHTP6dAm6umMD99
	  iM1EuLLenepgRk2xRpQyfo2c5uSMF7yR9XNMqeX6r0sc9SRC+o5aJHkWjuJbY4ZqIFFyvLlgAM
	  YlO3HRbpDkinLSZEq2BRKnAf/afJPhg4krV1BTMmZMMb149NtJwXarFyKQFXu8Yeh+7NmzCpff
	  H/sc+Kk4V4ZzMYQxfLYu2wCR4LMekeiDT5OCXt/saBAawg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=gA9uKnBWzq3tNgDYgIEYFP3EMG6Irn51dWR8gIBuhXk=; b=xrBTQj4ZCXN5GEsVPdiTlgg5Wc
	wqYwOrHYee71wOrnXsQaImxjKSXqXsenNnsWhCkqsXQUf//UnLn92vrrTEZoLbx5TtQjrpZ7VZYUo
	div7Ea4C2Z6+dbeXX9nKwo8UQngHdtPv7xJqp45OET3vsW2DNurvLR7eqN9+2lsDWF6w=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-mh1q.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8LR5-00000008jpK-40Te
	for virtualization@lists.linux.dev;
	Mon, 13 Oct 2025 16:30:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=gA9uKnBWzq3tNgDYgIEYFP3EMG6Irn51dWR8gIBuhXk=; b=dd1EagOmmgLxgaEMz6CBVPciXH
	oGdev0cOOI5RfI5PeaARazlT1BdOhaPzQRHgkp9flIZz8aDddCajdC53G3RaWVoWv5CKKk9DmD3mk
	oE8vCwXUgHwavha3xQdwwDaSgQpG3kd3UVOwWIOOOQfBYfw/26z+WQG7A0nbKXYikIf8=;
Received: from [87.16.13.60] (port=64309 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8LQf-000000001Ys-3v9v;
	Mon, 13 Oct 2025 16:29:45 +0000
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
Date: Mon, 13 Oct 2025 18:29:44 +0200
Message-ID: <5719046.rdbgypaU67@fedora.fritz.box>
In-Reply-To: <aOzL8f4C27z361P2@fedora>
References:
 <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2318164.vFx2qVVIhK@fedora.fritz.box> <aOzL8f4C27z361P2@fedora>
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
X-SGantispam-id: 4a99e63028b7ad7a84a05dad0108a3e5
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v8LR5-00000008jpK-40Te-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-mh1q.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello Matias,

On Monday, 13 October 2025 at 11:52:49 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> On Fri, Oct 10, 2025 at 11:20:22PM +0200, Francesco Valla wrote:
> > On Friday, 10 October 2025 at 17:46:25 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > Hello Mikhail, Harald,
> > > > 
> > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > 
> > > 
> > > I am working on the v6 by addressing the comments in this thread.
> > > 
> > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > +
> > > > > +/* virtio_can private data structure */
> > > > > +struct virtio_can_priv {
> > > > > +	struct can_priv can;	/* must be the first member */
> > > > > +	/* NAPI for RX messages */
> > > > > +	struct napi_struct napi;
> > > > > +	/* NAPI for TX messages */
> > > > > +	struct napi_struct napi_tx;
> > > > > +	/* The network device we're associated with */
> > > > > +	struct net_device *dev;
> > > > > +	/* The virtio device we're associated with */
> > > > > +	struct virtio_device *vdev;
> > > > > +	/* The virtqueues */
> > > > > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > > > > +	/* I/O callback function pointers for the virtqueues */
> > > > > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > > > > +	/* Lock for TX operations */
> > > > > +	spinlock_t tx_lock;
> > > > > +	/* Control queue lock. Defensive programming, may be not needed */
> > > > > +	struct mutex ctrl_lock;
> > > > > +	/* Wait for control queue processing without polling */
> > > > > +	struct completion ctrl_done;
> > > > > +	/* List of virtio CAN TX message */
> > > > > +	struct list_head tx_list;
> > > > > +	/* Array of receive queue messages */
> > > > > +	struct virtio_can_rx rpkt[128];
> > > > 
> > > > This array should probably be allocated dynamically at probe - maybe
> > > > using a module parameter instead of a hardcoded value as length? 
> > > > 
> > > 
> > > If I allocate this array in probe(), I would not know sdu[] in advance
> > > if I defined it as a flexible array. That made me wonder: can sdu[] be
> > > defined as flexible array for rx? 
> > > 
> > > Thanks.
> > > 
> > 
> > One thing that can be done is to define struct virtio_can_rx as:
> > 
> > struct virtio_can_rx {
> > #define VIRTIO_CAN_RX                   0x0101
> > 	__le16 msg_type;
> > 	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > 	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > 	__u8 padding;
> > 	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > 	__le32 flags;
> > 	__le32 can_id;
> > 	__u8 sdu[] __counted_by(length);
> > };
> > 
> > and then allocate the rpkt[] array using the maximum length for SDU:
> > 
> > priv->rpkt = kcalloc(num_rx_buffers,
> > 		sizeof(struct virtio_can_rx) + VIRTIO_CAN_MAX_DLEN,
> > 		GFP_KERNEL);
> > 
> > In this way, the size of each member of rpkt[] is known and is thus
> > suitable for virtio_can_populate_vqs().
> > 
> > 
> 
> Thanks for your answer. What is the value of VIRTIO_CAN_MAX_DLEN? I
> can't find it nor in the code or in the spec. I guess is 64 bytes? Also,
> IIUC, using __counted_by() would not end up saving space but adding an
> extra check for the compiler. Am I right? In that case, can't I just use
> a fixed array of VIRTIO_CAN_MAX_DLEN bytes?

My bad, I forgot to say that VIRTIO_CAN_MAX_DLEN has to be defined, but:
given some more thoughts, maybe this can be a dynamic value based on
the features received from the virtio framework, to avoid wasting memory?

E.g.:

if (virtio_has_feature(VIRTIO_CAN_F_CAN_FD))
	sdu_len = CANFD_MAX_DLEN;
else
	sdu_len = CAN_MAX_DLEN;

priv->rpkt = kcalloc(num_rx_buffers, sizeof(struct virtio_can_rx) + sdu_len,
		GFP_KERNEL);


My understanding of __counted_by() is the same: additional checks but nothing
more.


CAN-XL appears to be not supported by the virtio specs v1.4 [1], but if/when
it will be, the addition of an additional case would be simple.

[1] https://github.com/oasis-tcs/virtio-spec/blob/virtio-1.4/device-types/can/description.tex#L33


> 
> Thanks, Matias.
> 
>

Many thanks to you for your effort!

Regards,
Francesco



