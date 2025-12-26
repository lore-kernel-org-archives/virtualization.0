Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3F3093AE
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766782383; cv=none; b=LIQKCo8/c915g/eeQq7WiNSVvXrM0wLBWoKJxCL7xUwRKs+j8/ZUrqJo3uALBzTMsihbIrUICynwfbV79w40TMcLdbsqEcj4QMZlUVl0uwz4eq+ZadNkVzKgLRiXWdm4FXIQdUKym9UCOvZQSD4KVAB7IQebGDhLP+xePUDdfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766782383; c=relaxed/simple;
	bh=cQBlcaWGY3fQE/osFSFcd47vyjxZ0/GtU7ALTs+T5o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MNIbLFUfGIz0f+7+dly7jTLopbR4H1k4oETEGBIufeNnVB+cvZfJXdHx3rL14iubVQqC8jwvo2YbpEwjvrwVtS98Jg9g74NZXHoCYKW4bNjUsCfeWvVnUMB0gITcRbP2gM8nFG8U2Gg2zmL8laNZFszz/ZgxzoUsjw8ur5cHjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqJwD/N5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqJwD/N5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766782380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=06/0GOfuLECGxOgF+sjTq5KDrdjOZge5WvhzbJu0tt8=;
	b=AqJwD/N5nKXrJtz82IJSYUakd5eiUtnLh9WVwm71OEIcdATQRzAglvn1uw9E0HxNJvvDuY
	85J/X7GBSclOcFrRtH9MD1TxwcbZrKVdhiJY+vtCMkxtJ2U3/NILC8sCAM1Am02Grl9Q6R
	nn/mTAZCM9pe2gLwnlXpLBxIUYutDtI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-E2GW0HOWOP-hqn31o_hfnA-1; Fri, 26 Dec 2025 15:52:57 -0500
X-MC-Unique: E2GW0HOWOP-hqn31o_hfnA-1
X-Mimecast-MFC-AGG-ID: E2GW0HOWOP-hqn31o_hfnA_1766782376
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c0bead25feeso6336889a12.0
        for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 12:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766782376; x=1767387176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06/0GOfuLECGxOgF+sjTq5KDrdjOZge5WvhzbJu0tt8=;
        b=joN2Sii7bqHm/LLmJ+dMJaCUiL5JSaKQqnBoP51vyLkv8eyft2bjzM7jiqtOH6H1rc
         pM924e0frNpsMcSztjL9LRm8R2rvv28hfGEy0xrk09zan3OpcaiagsTvL6u1jD3tnAaJ
         hlW53WiptZ+XeQmA+nMEwOs/WrqXNgQu6hlKUQaWcIH4PskPRB1gPRUe0B6QVpFX/Iv2
         mF4sh+wSX002/rFKL+fWAg6NrJWQMcVjn7k0Dp2lPyIxab8ndb2qSPof/6g5zXYjtZok
         pjWrAMFe0G1nTs2Ffdx0ehLH6Dt0OIUgQs0GMMum6xaikcAIXRb3s2lGRRQqZJgfoAoS
         OHqA==
X-Forwarded-Encrypted: i=1; AJvYcCXQkfRNk9fAEuTw77V5obHzAvHLDMOdYIy60t0osXb2prQx9/kLrEm8mKuRd1O8I8r/3q6gGAMO1Y76zUwOqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWrnDLSVbpx7miGB4KUQP1G/c+2Iumj6DH1M0DurJmCzJCQSKp
	qtGMWXoLuBPx5ofQfg5nq2bYzJCvLjdLRCoGLFGf4qp8oTnxAS9TlLXObM4TujMpabE8ZF3rYed
	xzJEtFY1DDWw0te3jg/lmHpX146alXN8nAteq47rQIToHqYxfauMhhYj1mpBxUwFqtMEI
X-Gm-Gg: AY/fxX5aKBkN9ogP1bVTofFZbLgBNuE0Eu+Q2+q8nS7Ki7Un6ETLHVN/qAPowU/e3Z/
	j6wOkfqPFsUGQdckrgo5xpcbkkcARftYtVHwzH4/Jm1fjVCr9GLBMgzh55gSIROeVvh18YatO20
	VG1H4aYVPrWV72AIrNjVEfu7G33tJHnUDudiT44E6Wl0sY188EO/+IPpMbCRIa89Ie2H/0SWefw
	kXhrcKpwogCrk38Zqv70+qVpB9D1kJbYJgWBi5fPCY8V3PIyb2NjlmVwAHPsB8AiIovBV8RDSXR
	Gnbasfe6jqXVKWCvX03nJq8AoYKB9wJVx6lN4zUFklVv0jhgUamyBkuN0Yi8V+SuzvJFOe17f19
	7kDiZo8sGg9L90F9ZLG9kX/ik1Y4kx1Zmzek+QK2Wsk1+zPk=
X-Received: by 2002:a05:7022:6887:b0:11b:ca88:c50f with SMTP id a92af1059eb24-121722e9d56mr26505058c88.40.1766782375751;
        Fri, 26 Dec 2025 12:52:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhwIUt9pEQyngSRuvJZmbkbfSZHfZftAvl4xfxhsycFUKwbQ7pcv5VQNK2Q3IpgtQB1QhjFg==
X-Received: by 2002:a05:7022:6887:b0:11b:ca88:c50f with SMTP id a92af1059eb24-121722e9d56mr26505034c88.40.1766782375164;
        Fri, 26 Dec 2025 12:52:55 -0800 (PST)
Received: from fedora (pinamar-179-51-86-121.users.telpin.com.ar. [179.51.86.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm88131913c88.1.2025.12.26.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 12:52:54 -0800 (PST)
Date: Fri, 26 Dec 2025 21:52:48 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
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
Message-ID: <aU71oJScQ8aC0npw@fedora>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aT7XAsTWr0_yyfx_@bywater>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i7xY-e2OVZTOaETZZO9kobkJ8_GtT7NWIrx8nj_M6Hc_1766782376
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> Hi Matias,
> 
> On Thu, Dec 11, 2025 at 06:52:21PM +0100, Matias Ezequiel Vara Larsen wrote:
> > Thanks for your comments, I took most of them. I have some questions
> > though. 
> > 
> 
> (snip)
> 
> > > > + */
> > > > +static int virtio_can_add_inbuf(struct virtqueue *vq, void *buf,
> > > > +				unsigned int size)
> > > > +{
> > > > +	struct scatterlist sg[1];
> > > > +	int ret;
> > > > +
> > > > +	sg_init_one(sg, buf, size);
> > > > +
> > > > +	ret = virtqueue_add_inbuf(vq, sg, 1, buf, GFP_ATOMIC);
> > > > +	virtqueue_kick(vq);
> > > > +	if (ret == 0)
> > > > +		ret = vq->num_free;
> > > 
> > > The returned value in case of success (i.e.: vq->num_free) is not used.
> > > 
> > 
> > I removed it this but something is not working anymore so I need to
> > investigate.
> >
> 
> That should't happen, since vq->num_free is defined as an unsigned int
> and no caller is reacting on return values >= 0.
> 
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +/* Send a control message with message type either
> > > > + *
> > > > + * - VIRTIO_CAN_SET_CTRL_MODE_START or
> > > > + * - VIRTIO_CAN_SET_CTRL_MODE_STOP.
> > > > + *
> > > > + * Unlike AUTOSAR CAN Driver Can_SetControllerMode() there is no requirement
> > > > + * for this Linux driver to have an asynchronous implementation of the mode
> > > > + * setting function so in order to keep things simple the function is
> > > > + * implemented as synchronous function. Design pattern is
> > > > + * virtio_console.c/__send_control_msg() & virtio_net.c/virtnet_send_command().
> > > > + */
> > > 
> > > Comment is not really helpful nor informative, at least for me. I'd drop
> > > the AUTOSAR part at least.
> > > 
> > 
> > I removed it.
> > 
> > > > +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> > > > +{
> > > > +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > > > +	struct virtio_can_priv *priv = netdev_priv(ndev);
> > > > +	struct device *dev = &priv->vdev->dev;
> > > > +	struct virtqueue *vq;
> > > > +	unsigned int len;
> > > > +	int err;
> > > > +
> > > > +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > > > +
> > > > +	/* The function may be serialized by rtnl lock. Not sure.
> > > > +	 * Better safe than sorry.
> > > > +	 */
> > > > +	mutex_lock(&priv->ctrl_lock);
> > > 
> > > Consider the newer guard() syntax:
> > > 
> > >     guard(mutex)(&priv->ctrl_lock)
> > > 
> > 
> > IIUC this adds the unlock automatically, right?
> >
> 
> Yes, as soon as the function returnsi, and even in case of early
> returns.
> 
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
> > I moved it to the stack.
> > 
> 
> This was a bad suggestion, as Michael S. Tsirkin suggested in another
> branch of this thread [0]. Sorry.
> 
> > > > +	mutex_unlock(&priv->ctrl_lock);
> > > > +
> > > > +	return priv->can_ctr_msg.cpkt_in.result;
> > > > +}
> > > > +
> > > > +static void virtio_can_start(struct net_device *ndev)
> > > > +{
> > > > +	struct virtio_can_priv *priv = netdev_priv(ndev);
> > > > +	u8 result;
> > > > +
> > > > +	result = virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_START);
> > > > +	if (result != VIRTIO_CAN_RESULT_OK) {
> > > > +		/* Not expected to happen */
> > > > +		netdev_err(ndev, "CAN controller start failed\n");
> > > > +	}
> > > > +
> > > > +	priv->busoff_pending = false;
> > > > +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
> > > > +
> > > > +	/* Switch carrier on if device was not connected to the bus */
> > > > +	if (!netif_carrier_ok(ndev))
> > > > +		netif_carrier_on(ndev);
> > > > +}
> > > > +
> > > > +/* See also m_can.c/m_can_set_mode()
> > > > + *
> > > > + * It is interesting that not only the M-CAN implementation but also all other
> > > > + * implementations I looked into only support CAN_MODE_START.
> > > > + * That CAN_MODE_SLEEP is frequently not found to be supported anywhere did not
> > > > + * come not as surprise but that CAN_MODE_STOP is also never supported was one.
> > > > + * The function is accessible via the method pointer do_set_mode in
> > > > + * struct can_priv. As usual no documentation there.
> > > > + * May not play any role as grepping through the code did not reveal any place
> > > > + * from where the method is actually called.
> > > > + */
> > > 
> > > The do_set_mode method is used e.g. to restart the CAN after a bus-off event.
> > > 
> > 
> > Do you think we need to support CAN_MODE_STOP?
> >
> 
> No, I don't think so, but the comment is somewhat misleading and feels
> more like some private notes.
> 
> > > > +static int virtio_can_set_mode(struct net_device *dev, enum can_mode mode)
> > > > +{
> > > > +	switch (mode) {
> > > > +	case CAN_MODE_START:
> > > > +		virtio_can_start(dev);
> > > > +		netif_wake_queue(dev);
> > > > +		break;
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> 
> (snip)
> 
> > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > +{
> > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > +	struct net_device *dev = can_priv->dev;
> > > > +	struct virtio_can_tx *can_tx_msg;
> > > > +	struct net_device_stats *stats;
> > > > +	unsigned long flags;
> > > > +	unsigned int len;
> > > > +	u8 result;
> > > > +
> > > > +	stats = &dev->stats;
> > > > +
> > > > +	/* Protect list and virtio queue operations */
> > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > 
> > > The section below seems a pretty big one to protect behind a spin lock. 
> > > 
> > 
> > How can I split it? 
> > 
> 
> Question here is: what needs to be protected? As far as I can tell, the
> only entity needing some kind of locking here is the queue, while both
> ida_* and tx_inflight operations are already covered (the former by
> design [1], the second because it's implemented using an atomic.
> 
> If I'm not wrong (but I might be, so please double check) this can be
> limited to:
> 
> 	/* Protect queue operations */
> 	scoped_guard(spinlock_irqsave, &priv->tx_lock)
> 		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> 
> 
> Maybe the whole locking pattern is a leftover from a previous version, 
> where a list of TX messages was kept?
> 

I followed this approach for the three queues. I wonder why the rx queue
and the ctrl queue use a mutex instead of spinlock? I added a mutex for
the operations to the rx queue.

Matias

> > > > +
> > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > +	if (!can_tx_msg) {
> > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > +		return 0; /* No more data */
> > > > +	}
> > > > +
> > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > +	} else {
> > > > +		result = can_tx_msg->tx_in.result;
> > > > +	}
> > > > +
> 
> (snip)
> 
> > > > +static int virtio_can_probe(struct virtio_device *vdev)
> > > > +{
> > > > +	struct virtio_can_priv *priv;
> > > > +	struct net_device *dev;
> > > > +	int err;
> > > > +
> > > > +	dev = alloc_candev(sizeof(struct virtio_can_priv),
> > > > +			   VIRTIO_CAN_ECHO_SKB_MAX);
> > > > +	if (!dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	priv = netdev_priv(dev);
> > > > +
> > > > +	ida_init(&priv->tx_putidx_ida);
> > > > +
> > > > +	netif_napi_add(dev, &priv->napi, virtio_can_rx_poll);
> > > > +	netif_napi_add(dev, &priv->napi_tx, virtio_can_tx_poll);
> > > > +
> > > > +	SET_NETDEV_DEV(dev, &vdev->dev);
> > > > +
> > > > +	priv->dev = dev;
> > > > +	priv->vdev = vdev;
> > > > +	vdev->priv = priv;
> > > > +
> > > > +	priv->can.do_set_mode = virtio_can_set_mode;
> > > > +	/* Set Virtio CAN supported operations */
> > > > +	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
> > > > +	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
> > > > +		err = can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD);
> > > > +		if (err != 0)
> > > > +			goto on_failure;
> > > > +	}
> > > > +
> > > > +	/* Initialize virtqueues */
> > > > +	err = virtio_can_find_vqs(priv);
> > > > +	if (err != 0)
> > > > +		goto on_failure;
> > > > +
> > > > +	spin_lock_init(&priv->tx_lock);
> > > > +	mutex_init(&priv->ctrl_lock);
> > > > +
> > > > +	init_completion(&priv->ctrl_done);
> > > > +
> > > > +	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD))
> > > > +		priv->sdu_len = CANFD_MAX_DLEN;
> > > > +	else
> > > > +		priv->sdu_len = CAN_MAX_DLEN;
> > > 
> > > Consider replacing sdu_len with something like rpkt_len, which is
> > > directly related to priv->rpkt and can make code more readable, here and
> > > in other locations. E.g.:
> > 
> > I replaced it with rpkt_len.
> > 
> > > 
> > > 	priv->rpkt_len = sizeof(struct virtio_can_rx);
> > > 	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD))
> > >     		priv->rpkt_len += CANFD_MAX_DLEN;
> > > 	else
> > > 		priv->rpkt_len += CAN_MAX_DLEN;
> > > 
> > > 	priv->rpkt = kzalloc(priv->rpkt_len * ...
> > > 
> > > > +
> > > > +	priv->rpkt = kzalloc((sizeof(struct virtio_can_rx) + priv->sdu_len) *
> > > > +						priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
> > > > +						GFP_KERNEL);
> > > 
> > > If I'm not mistaken, priv->rpkt is never freed. Consider moving to
> > > devm_kzalloc().
> > > 
> > 
> > Done.
> > 
> > > > +	if (!priv->rpkt) {
> > > > +		virtio_can_del_vq(vdev);
> > > > +		goto on_failure;
> > > > +	}
> > > > +	virtio_can_populate_rx_vq(vdev);
> > > > +
> > > > +	err = register_virtio_can_dev(dev);
> > > > +	if (err) {
> > > > +		virtio_can_del_vq(vdev);
> > > > +		goto on_failure;
> > > > +	}
> > > > +
> > > > +	napi_enable(&priv->napi);
> > > > +	napi_enable(&priv->napi_tx);
> > > 
> > > Most of the existing drivers enable the napi(s) during the open() phase,
> > > IIUC to avoid scheduling napi operations for devices that might never
> > > get used. But here maybe there is a specific reason to do it this way?
> > > 
> > 
> > I do not have idea. I moved to open() and something stopped to work. I
> > am investigating it.
> >
> 
> On a second thought, it may be wiser to have the napis enabled on probe,
> to drop the incoming messages even when the interface is brought down.
> 
> (last snip)
> 
> 
> While stress testing this, I noticed that flooding the virtio-can
> interface with packets leads to an hang of the interface itself.
> I am seeing this issuing, at host side:
> 
> 	while true; do cansend can0 123#00; done
> 
> with:
> 
>  - QEMU: the tip of the master branch plus [2]
>  - vhost-device: the tip of the main branch
> 
> and the following QEMU invocation:
> 
> qemu-system-x86_64 -serial mon:stdio \
>     -m 2G -smp 2 \
>     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
>     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
>     -append "loglevel=7 console=ttyS0" \
>     -machine memory-backend=pc.ram \
>     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
>     -chardev socket,id=can0,path=/tmp/sock-can0 \
>     -device vhost-user-can-pci,chardev=can0
> 
> 
> Restarting the interface (i.e.: ip link set down and the up) does not
> fix the situation.
> 
> I'll try to do some more testing during the next days.
> 
> 
> > Thanks for reviewing it!
> > 
> > Matias
> > 
> >
> 
> Regards,
> Francesco
> 
> 
> [0] https://lore.kernel.org/linux-can/20251214022000-mutt-send-email-mst@kernel.org/
> [1] https://elixir.bootlin.com/linux/v6.18.1/source/lib/idr.c#L323
> [2] https://lore.kernel.org/qemu-devel/20251031155617.1223248-1-mvaralar@redhat.com/
> 
> 

