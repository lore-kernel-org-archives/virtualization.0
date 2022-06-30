Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAA5C43334
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 09:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55B218458B;
	Thu, 30 Jun 2022 09:46:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55B218458B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgaEzCvY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmEo9bNf2s1c; Thu, 30 Jun 2022 09:46:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 873C88458A;
	Thu, 30 Jun 2022 09:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 873C88458A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6211DC002D;
	Thu, 30 Jun 2022 09:46:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97DBEC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6788A40232
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:46:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6788A40232
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgaEzCvY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wbPoQ-Fgcwk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:46:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6193640141
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6193640141
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656582402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QbMHU+OhzMMFuIDST1hXi+9o9ACjxg07MCvZDGIBNE=;
 b=WgaEzCvYcSoc8YoThGHBxYhgXas6vRnL9h8j8U74IFQVqk1iU++JWNnY01ojNknaNEFjpZ
 gLJsoHgRG3KqCixNvGgSv+Yny0BZ4tSAkGI02DkdZ76048fFdgIqjbO4Fu5pOw8/bLRpcB
 no4OTtBGoRkJo6fcpi9TPyFxHErNZ0w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-nQHjmvqIOcmY0N4YbhEKnw-1; Thu, 30 Jun 2022 05:46:41 -0400
X-MC-Unique: nQHjmvqIOcmY0N4YbhEKnw-1
Received: by mail-wm1-f70.google.com with SMTP id
 r4-20020a1c4404000000b003a02fa133ceso3685192wma.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2QbMHU+OhzMMFuIDST1hXi+9o9ACjxg07MCvZDGIBNE=;
 b=UXl93c/lA9IjkIOpDm29aFD3grBMbeQZOSE7K7CJ7rdmNqlhwAV/lB8GBU8lcylpXD
 n8kmhSapTiO7ghVp9cktsndwyaA6JdEgNBcKgVz7LusD8SuesWBzFnSvpxDOMBNVHPPo
 2AGD40wpJAbM5/8KgxwLZ4unHDNwfZv+i1V359eFT2S8LR0rCKnwL8TxBVL71LPxn5M4
 48EN2YBGxKE1PbCb4n1u/u5EGtsQnMb2vw5dB4HzLfPrIGJy1DdUJWid9rDC77JYDOap
 ll58krBeBxF3nakelCEXOBd0qoH6iZ7omUjbG3lcMCThfV5JTEAKBwx6LuERQbYiPH7C
 u0Kw==
X-Gm-Message-State: AJIora9awidHgxAxv75cHQpgg6TpRuWPDdbS97TWbu5CEJcmYZccZfSZ
 x/wpytiifIvCbu90QX46BVoWMBI8z7pDrKbzE7sXvinDmYklY7RZbZ6F/fvSO2QV3J8EMmPhXuc
 A+z3t5lxGZRl8SfXoDJtc7KzEq/ZTAQJFdDShtVmSyw==
X-Received: by 2002:a05:600c:35d5:b0:3a0:2f95:720b with SMTP id
 r21-20020a05600c35d500b003a02f95720bmr11318297wmq.162.1656582400413; 
 Thu, 30 Jun 2022 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u1odtLgOr7pIerZRBZjkUkO149jCT02mesrCRDdnuMsff6JWno8s5dSGdLe5NdFnFIBYkhZg==
X-Received: by 2002:a05:600c:35d5:b0:3a0:2f95:720b with SMTP id
 r21-20020a05600c35d500b003a02f95720bmr11318247wmq.162.1656582400074; 
 Thu, 30 Jun 2022 02:46:40 -0700 (PDT)
Received: from redhat.com ([2.55.3.188]) by smtp.gmail.com with ESMTPSA id
 r5-20020a05600c320500b0039db500714fsm5697297wmp.6.2022.06.30.02.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 02:46:39 -0700 (PDT)
Date: Thu, 30 Jun 2022 05:46:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v1 1/1] virtio: Restore semantics of vq->broken in
 virtqueues
Message-ID: <20220630054532-mutt-send-email-mst@kernel.org>
References: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20220630093651.25981-1-alexander.atanasov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Oberparleiter <oberpar@linux.ibm.com>,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 kernel@openvz.org, Vineeth Vijayan <vneethv@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jun 30, 2022 at 09:36:46AM +0000, Alexander Atanasov wrote:
> virtio: harden vring IRQ (8b4ec69d7e09) changed the use
> of vq->broken. As result vring_interrupt handles IRQs for
> broken drivers as IRQ_NONE and not IRQ_HANDLED and made impossible
> to initiallize vqs before the driver is ready, i.e. in probe method.
> Balloon driver does this and it can not load because it fails in
> vqs_init with -EIO.
> 
> So instead of changing the original intent ot the flag introduce
> a new flag vq->ready which servers the purpose to check of early IRQs
> and restore the behaviour of the vq->broken flag.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>


Does

commit c346dae4f3fbce51bbd4f2ec5e8c6f9b91e93163
Author: Jason Wang <jasowang@redhat.com>
Date:   Wed Jun 22 09:29:40 2022 +0800

    virtio: disable notification hardening by default


solve the problem for you?

> ---
>  drivers/virtio/virtio_ring.c  | 20 ++++++++++++++------
>  include/linux/virtio.h        |  2 +-
>  include/linux/virtio_config.h | 10 +++++-----
>  3 files changed, 20 insertions(+), 12 deletions(-)
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..dca3cc774584 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -100,6 +100,9 @@ struct vring_virtqueue {
>  	/* Other side has made a mess, don't try any more. */
>  	bool broken;
>  
> +	/* the queue is ready to handle interrupts  */
> +	bool ready;
> +
>  	/* Host supports indirect buffers */
>  	bool indirect;
>  
> @@ -1688,7 +1691,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->we_own_ring = true;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = true;
> +	vq->broken = false;
> +	vq->ready = false;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> @@ -2134,7 +2138,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  		return IRQ_NONE;
>  	}
>  
> -	if (unlikely(vq->broken)) {
> +	if (unlikely(vq->broken))
> +		return IRQ_HANDLED;
> +
> +	if (unlikely(!vq->ready)) {
>  		dev_warn_once(&vq->vq.vdev->dev,
>  			      "virtio vring IRQ raised before DRIVER_OK");
>  		return IRQ_NONE;
> @@ -2180,7 +2187,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->we_own_ring = false;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = true;
> +	vq->broken = false;
> +	vq->ready = false;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> @@ -2405,7 +2413,7 @@ EXPORT_SYMBOL_GPL(virtio_break_device);
>   * (probing and restoring). This function should only be called by the
>   * core, not directly by the driver.
>   */
> -void __virtio_unbreak_device(struct virtio_device *dev)
> +void __virtio_device_ready(struct virtio_device *dev)
>  {
>  	struct virtqueue *_vq;
>  
> @@ -2414,11 +2422,11 @@ void __virtio_unbreak_device(struct virtio_device *dev)
>  		struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> -		WRITE_ONCE(vq->broken, false);
> +		WRITE_ONCE(vq->ready, true);
>  	}
>  	spin_unlock(&dev->vqs_list_lock);
>  }
> -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> +EXPORT_SYMBOL_GPL(__virtio_device_ready);
>  
>  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>  {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index d8fdf170637c..538c5959949a 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -131,7 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
>  bool is_virtio_device(struct device *dev);
>  
>  void virtio_break_device(struct virtio_device *dev);
> -void __virtio_unbreak_device(struct virtio_device *dev);
> +void __virtio_device_ready(struct virtio_device *dev);
>  
>  void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 49c7c32815f1..35cf1b26e05a 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -259,21 +259,21 @@ void virtio_device_ready(struct virtio_device *dev)
>  
>  	/*
>  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> -	 * will see the driver specific setup if it sees vq->broken
> +	 * will see the driver specific setup if it sees vq->ready
>  	 * as false (even if the notifications come before DRIVER_OK).
>  	 */
>  	virtio_synchronize_cbs(dev);
> -	__virtio_unbreak_device(dev);
> +	__virtio_device_ready(dev);
>  	/*
> -	 * The transport should ensure the visibility of vq->broken
> +	 * The transport should ensure the visibility of vq->ready
>  	 * before setting DRIVER_OK. See the comments for the transport
>  	 * specific set_status() method.
>  	 *
>  	 * A well behaved device will only notify a virtqueue after
>  	 * DRIVER_OK, this means the device should "see" the coherenct
> -	 * memory write that set vq->broken as false which is done by
> +	 * memory write that set vq->ready as true which is done by
>  	 * the driver when it sees DRIVER_OK, then the following
> -	 * driver's vring_interrupt() will see vq->broken as false so
> +	 * driver's vring_interrupt() will see vq->true as true so
>  	 * we won't lose any notification.
>  	 */
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
