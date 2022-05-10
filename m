Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A01C433EF
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 11:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0483A81402;
	Tue, 10 May 2022 11:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gGoqcZGokNo; Tue, 10 May 2022 11:32:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7202081258;
	Tue, 10 May 2022 11:32:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48351C0039;
	Tue, 10 May 2022 11:32:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F82DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AB5360F38
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DRIVbr-bMqNZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:32:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F3AC60B48
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652182362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6JGU3yCeXbwd8q2TiB3We0T+2lr2Ip1+nsoAPs6S2s=;
 b=YOifvgOohhYD3h49AFuojryzEohmk0Fu58c6erBapOPMwpSnGn3uysWyHELu3aK+RNKBN4
 ZEPuphFdTNlJcKKPFGImkpmQcO/tov3uOxtoGPyjdo2MucBCBcRoQ4IfRVTxWkwNV/8Ze9
 huH8V1+YHqQVzFYMR/nNeLvr+1g/Dig=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-9VMVZrsbMC6Lj1DSbwdyEQ-1; Tue, 10 May 2022 07:32:41 -0400
X-MC-Unique: 9VMVZrsbMC6Lj1DSbwdyEQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 o24-20020a05600c379800b003943412e81dso677716wmr.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 04:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/6JGU3yCeXbwd8q2TiB3We0T+2lr2Ip1+nsoAPs6S2s=;
 b=RMedRATgDX7GsQA8gTGK0yx9LGcQxJJxBpwSJjYGvD0lrd+XfWa5w16O55gSOmmJrS
 /4shgxwAxQnbrplSxzhgFZ2BuhLX/CyQ4UbC7qYxJdrW+57MFoPD571My5Xd8V4P+Ob2
 4p2m4zd01IpNuccNZvMX2CBCdRfBL2MhZmKa6ZdxtkCfdQzkFZDQTWPHebUCHYck289m
 5abgReBycjWJdppPs6BpnFPIgmub7FNZQt1xcl97e3i+TLZSzN9+/jMNfZs+WhuMYU67
 J8O1/FGbR7T8KcyWBS4shvDItv7OOsDNg3Wra94uSFf8a0iGVGPvPa6d/nEYN72x1CGF
 7AbA==
X-Gm-Message-State: AOAM5325Vc6kB2kpwRgoPAqjjCqB+s0TsAFLNNALrFjofeisWKDvhgIO
 vUjwOAY85bJWqDCQuGhyxNc8R74+KnSiMdT0ZDXMC9xMyprEIw08jKQHny8E4q0heSq0A/FqKfX
 4uFGkXbNItkT2VFEV/pW0I61KWMnAy3W1mw4er+0xWA==
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id
 v15-20020a056000144f00b0020c60903040mr17724132wrx.479.1652182360185; 
 Tue, 10 May 2022 04:32:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsEleGX5w1OSWKo2o5f2WSyJKHdkzs/SrI4J/pz4kEhj9uYYK5k7bkfywVoL/OsCq+T9m4og==
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id
 v15-20020a056000144f00b0020c60903040mr17724121wrx.479.1652182359954; 
 Tue, 10 May 2022 04:32:39 -0700 (PDT)
Received: from redhat.com ([2.55.130.230]) by smtp.gmail.com with ESMTPSA id
 c17-20020a056000105100b0020c5253d8ccsm13457840wrx.24.2022.05.10.04.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 04:32:39 -0700 (PDT)
Date: Tue, 10 May 2022 07:32:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
Message-ID: <20220510072833-mutt-send-email-mst@kernel.org>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-9-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220507071954.14455-9-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, paulmck@kernel.org, peterz@infradead.org, maz@kernel.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 eperezma@redhat.com, tglx@linutronix.de
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

On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
> This is a rework on the previous IRQ hardening that is done for
> virtio-pci where several drawbacks were found and were reverted:
> 
> 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
>    that is used by some device such as virtio-blk
> 2) done only for PCI transport
> 
> The vq->broken is re-used in this patch for implementing the IRQ
> hardening. The vq->broken is set to true during both initialization
> and reset. And the vq->broken is set to false in
> virtio_device_ready(). Then vring_interrupt can check and return when
> vq->broken is true. And in this case, switch to return IRQ_NONE to let
> the interrupt core aware of such invalid interrupt to prevent IRQ
> storm.
> 
> The reason of using a per queue variable instead of a per device one
> is that we may need it for per queue reset hardening in the future.
> 
> Note that the hardening is only done for vring interrupt since the
> config interrupt hardening is already done in commit 22b7050a024d7
> ("virtio: defer config changed notifications"). But the method that is
> used by config interrupt can't be reused by the vring interrupt
> handler because it uses spinlock to do the synchronization which is
> expensive.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c       | 15 ++++++++++++---
>  drivers/virtio/virtio_ring.c  | 11 +++++++----
>  include/linux/virtio_config.h | 12 ++++++++++++
>  3 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 8dde44ea044a..696f5ba4f38e 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +	/*
> +	 * The below virtio_synchronize_cbs() guarantees that any
> +	 * interrupt for this line arriving after
> +	 * virtio_synchronize_vqs() has completed is guaranteed to see
> +	 * driver_ready == false.
> +	 */
> +	virtio_break_device(dev);
> +	virtio_synchronize_cbs(dev);
> +
>  	dev->config->reset(dev);
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
> @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
>  
> +	INIT_LIST_HEAD(&dev->vqs);
> +	spin_lock_init(&dev->vqs_list_lock);
> +
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
>  	virtio_reset_device(dev);
> @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
>  	/* Acknowledge that we've seen the device. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>  
> -	INIT_LIST_HEAD(&dev->vqs);
> -	spin_lock_init(&dev->vqs_list_lock);
> -
>  	/*
>  	 * device_add() causes the bus infrastructure to look for a matching
>  	 * driver.
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5b7df7c455f0..9dfad2890d7a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1690,7 +1690,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->we_own_ring = true;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = false;
> +	vq->broken = true;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> @@ -2136,8 +2136,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  		return IRQ_NONE;
>  	}
>  
> -	if (unlikely(vq->broken))
> -		return IRQ_HANDLED;
> +	if (unlikely(vq->broken)) {
> +		dev_warn_once(&vq->vq.vdev->dev,
> +			      "virtio vring IRQ raised before DRIVER_OK");
> +		return IRQ_NONE;
> +	}
>  
>  	/* Just a hint for performance: so it's ok that this can be racy! */
>  	if (vq->event)
> @@ -2179,7 +2182,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->we_own_ring = false;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> -	vq->broken = false;
> +	vq->broken = true;
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index d8a2340f928e..23f1694cdbd5 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
>  	unsigned status = dev->config->get_status(dev);
>  
>  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> +
> +	/*
> +	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
> +	 * will see the driver specific setup if it sees vq->broken
> +	 * as false.
> +	 */
> +	virtio_synchronize_cbs(dev);

since you mention vq->broken above, maybe add
	"set vq->broken to false"

> +	__virtio_unbreak_device(dev);
> +	/*
> +	 * The transport is expected ensure the visibility of

to ensure

> +	 * vq->broken

let's add: "visibility by vq callbacks"

> before setting VIRTIO_CONFIG_S_DRIVER_OK.
> +	 */


Can I see some analysis of existing transports showing
this is actually the case for them?
And maybe add a comment near set_status to document the
requirement.

>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
