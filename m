Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A519C433F5
	for <virtualization@archiver.kernel.org>; Mon, 20 Dec 2021 23:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8E9C60E59;
	Mon, 20 Dec 2021 23:17:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i0lhXOiaOpiP; Mon, 20 Dec 2021 23:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 845AA60E69;
	Mon, 20 Dec 2021 23:17:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A7DAC001E;
	Mon, 20 Dec 2021 23:17:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A64D9C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E20481886
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1uEuxzDCoZ0u
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:17:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19BF28184F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640042230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wnV+YCzQSRpEeUBVLFNHXe4yvle1BRcB9qMY4Oils9E=;
 b=P+lv4xiusLiX0hR1AbsErJ0tYj5bkGA7YDLGVwJY+A5GBDO6B79NN0p0TMn/EqJ4UX8yFk
 5aj8uzXe4/KMuZQ6gtY/urRHOyDsNJC77bQZxEnIA1DVOdt9Aj9i13FB9qKrw2+kcjNiAv
 UivLFvUCrte1xowXVm0re4us3n6IMIw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-n619IKnlMcWEYR6vfBF2-w-1; Mon, 20 Dec 2021 18:17:09 -0500
X-MC-Unique: n619IKnlMcWEYR6vfBF2-w-1
Received: by mail-ed1-f70.google.com with SMTP id
 h7-20020a05640250c700b003f800db4193so8836715edb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wnV+YCzQSRpEeUBVLFNHXe4yvle1BRcB9qMY4Oils9E=;
 b=4xr+OVo/gv2EsFiqYuGFKDap/fLE95r0aesZ1ZSaBfHvW+sO9K+m5k/sNpJO40pJEt
 DjW+TwHKMoqac9GteQTRmfdtl1XZdN6yd/pmTXZz/oofPvMo+s0nRoveJP7tcA4rfhyZ
 qmPcJZU7tZ4frqpJBIwauSMW97AhSvBn9W5ajfrZnnnpXpuELsyFDxMJmxGUxOBZYc+e
 1gOmsykIDigLY+E5efEepnGRI5MtaUKWhjXfuMSWwgTAjvL3KOQtq03TcJohojB7as7V
 2YEEEzdX77UaSoyHLOD89gWmLETEIcwKxat+ObU4CF3KV2dSBNJdX62q4ELVIkhQWmLl
 IWFw==
X-Gm-Message-State: AOAM533zExsiPZeFYVliT1HJhzKh2oWSYQuoj6vS40Ta6A4qovWYnPm2
 8azqsxPvDHVzBTK+IGF9ryCbGHov+3nvqbraESpfxvXqj5a1sDr0UYOwHUQoB0j3hhLgucYCznx
 2yZlI4TJkUYS/nwsI5dnTsgWQJR5JXR/h+GOkle+J3A==
X-Received: by 2002:a17:906:2788:: with SMTP id
 j8mr334101ejc.203.1640042228092; 
 Mon, 20 Dec 2021 15:17:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMxNdRvjgj2LTg3XKVDAWLJRwAaKr/+YLK80CtFoU6d5PVfTT6bEjRkKpl+aDGUkvEZbzbXQ==
X-Received: by 2002:a17:906:2788:: with SMTP id
 j8mr334085ejc.203.1640042227863; 
 Mon, 20 Dec 2021 15:17:07 -0800 (PST)
Received: from redhat.com ([2.55.141.192])
 by smtp.gmail.com with ESMTPSA id w17sm6994956edu.48.2021.12.20.15.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Dec 2021 15:17:06 -0800 (PST)
Date: Mon, 20 Dec 2021 18:17:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v8 09/11] firmware: arm_scmi: Add atomic mode support to
 virtio transport
Message-ID: <20211220181455-mutt-send-email-mst@kernel.org>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
 <20211220195646.44498-10-cristian.marussi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20211220195646.44498-10-cristian.marussi@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: f.fainelli@gmail.com, vincent.guittot@linaro.org,
 Igor Skalkin <igor.skalkin@opensynergy.com>, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Peter Hilber <peter.hilber@opensynergy.com>, james.quinlan@broadcom.com,
 Jonathan.Cameron@huawei.com, souvik.chakravarty@arm.com,
 etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Dec 20, 2021 at 07:56:44PM +0000, Cristian Marussi wrote:
> Add support for .mark_txdone and .poll_done transport operations to SCMI
> VirtIO transport as pre-requisites to enable atomic operations.
> 
> Add a Kernel configuration option to enable SCMI VirtIO transport polling
> and atomic mode for selected SCMI transactions while leaving it default
> disabled.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v7 --> v8
> - removed ifdeffery
> - reviewed comments
> - simplified spinlocking aroung scmi_feed_vq_tx/rx
> - added deferred worker for TX replies to aid while polling mode is active
> V6 --> V7
> - added a few comments about virtio polling internals
> - fixed missing list_del on pending_cmds_list processing
> - shrinked spinlocked areas in virtio_poll_done
> - added proper spinlocking to scmi_vio_complete_cb while scanning list
>   of pending cmds
> ---
>  drivers/firmware/arm_scmi/Kconfig  |  15 ++
>  drivers/firmware/arm_scmi/virtio.c | 291 ++++++++++++++++++++++++++---
>  2 files changed, 280 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index d429326433d1..7794bd41eaa0 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -118,6 +118,21 @@ config ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE
>  	  the ones implemented by kvmtool) and let the core Kernel VirtIO layer
>  	  take care of the needed conversions, say N.
>  
> +config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
> +	bool "Enable atomic mode for SCMI VirtIO transport"
> +	depends on ARM_SCMI_TRANSPORT_VIRTIO
> +	help
> +	  Enable support of atomic operation for SCMI VirtIO based transport.
> +
> +	  If you want the SCMI VirtIO based transport to operate in atomic
> +	  mode, avoiding any kind of sleeping behaviour for selected
> +	  transactions on the TX path, answer Y.
> +
> +	  Enabling atomic mode operations allows any SCMI driver using this
> +	  transport to optionally ask for atomic SCMI transactions and operate
> +	  in atomic context too, at the price of using a number of busy-waiting
> +	  primitives all over instead. If unsure say N.
> +
>  endif #ARM_SCMI_PROTOCOL
>  
>  config ARM_SCMI_POWER_DOMAIN
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index fd0f6f91fc0b..f589bbcc5db9 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -3,8 +3,8 @@
>   * Virtio Transport driver for Arm System Control and Management Interface
>   * (SCMI).
>   *
> - * Copyright (C) 2020-2021 OpenSynergy.
> - * Copyright (C) 2021 ARM Ltd.
> + * Copyright (C) 2020-2022 OpenSynergy.
> + * Copyright (C) 2021-2022 ARM Ltd.
>   */
>  
>  /**
> @@ -38,6 +38,9 @@
>   * @vqueue: Associated virtqueue
>   * @cinfo: SCMI Tx or Rx channel
>   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
> + * @deferred_tx_work: Worker for TX deferred replies processing
> + * @deferred_tx_wq: Workqueue for TX deferred replies
> + * @pending_cmds_list: List of pre-fetched commands queueud for later processing
>   * @is_rx: Whether channel is an Rx channel
>   * @ready: Whether transport user is ready to hear about channel
>   * @max_msg: Maximum number of pending messages for this channel.
> @@ -49,6 +52,9 @@ struct scmi_vio_channel {
>  	struct virtqueue *vqueue;
>  	struct scmi_chan_info *cinfo;
>  	struct list_head free_list;
> +	struct list_head pending_cmds_list;
> +	struct work_struct deferred_tx_work;
> +	struct workqueue_struct *deferred_tx_wq;
>  	bool is_rx;
>  	bool ready;
>  	unsigned int max_msg;
> @@ -65,12 +71,22 @@ struct scmi_vio_channel {
>   * @input: SDU used for (delayed) responses and notifications
>   * @list: List which scmi_vio_msg may be part of
>   * @rx_len: Input SDU size in bytes, once input has been received
> + * @poll_idx: Last used index registered for polling purposes if this message
> + *	      transaction reply was configured for polling.
> + *	      Note that since virtqueue used index is an unsigned 16-bit we can
> + *	      use some out-of-scale values to signify particular conditions.
> + * @poll_lock: Protect access to @poll_idx.
>   */
>  struct scmi_vio_msg {
>  	struct scmi_msg_payld *request;
>  	struct scmi_msg_payld *input;
>  	struct list_head list;
>  	unsigned int rx_len;
> +#define VIO_MSG_NOT_POLLED	0xeeeeeeeeUL
> +#define VIO_MSG_POLL_DONE	0xffffffffUL
> +	unsigned int poll_idx;
> +	/* lock to protect access to poll_idx. */
> +	spinlock_t poll_lock;
>  };
>  
>  /* Only one SCMI VirtIO device can possibly exist */
> @@ -81,40 +97,43 @@ static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
>  	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
>  }
>  
> +/* Expect to be called with vioch->lock acquired by the caller and IRQs off */
>  static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
>  			       struct scmi_vio_msg *msg,
>  			       struct device *dev)
>  {
>  	struct scatterlist sg_in;
>  	int rc;
> -	unsigned long flags;
>  
>  	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
>  
> -	spin_lock_irqsave(&vioch->lock, flags);
> -
>  	rc = virtqueue_add_inbuf(vioch->vqueue, &sg_in, 1, msg, GFP_ATOMIC);
>  	if (rc)
>  		dev_err(dev, "failed to add to RX virtqueue (%d)\n", rc);
>  	else
>  		virtqueue_kick(vioch->vqueue);
>  
> -	spin_unlock_irqrestore(&vioch->lock, flags);
> -
>  	return rc;
>  }
>  
> +/* Expect to be called with vioch->lock acquired by the caller and IRQs off */
> +static inline void scmi_vio_feed_vq_tx(struct scmi_vio_channel *vioch,
> +				       struct scmi_vio_msg *msg)
> +{
> +	spin_lock(&msg->poll_lock);
> +	msg->poll_idx = VIO_MSG_NOT_POLLED;
> +	spin_unlock(&msg->poll_lock);
> +
> +	list_add(&msg->list, &vioch->free_list);
> +}
> +
>  static void scmi_finalize_message(struct scmi_vio_channel *vioch,
>  				  struct scmi_vio_msg *msg)
>  {
> -	if (vioch->is_rx) {
> +	if (vioch->is_rx)
>  		scmi_vio_feed_vq_rx(vioch, msg, vioch->cinfo->dev);
> -	} else {
> -		/* Here IRQs are assumed to be already disabled by the caller */
> -		spin_lock(&vioch->lock);
> -		list_add(&msg->list, &vioch->free_list);
> -		spin_unlock(&vioch->lock);
> -	}
> +	else
> +		scmi_vio_feed_vq_tx(vioch, msg);
>  }
>  
>  static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> @@ -144,6 +163,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  			virtqueue_disable_cb(vqueue);
>  			cb_enabled = false;
>  		}
> +
>  		msg = virtqueue_get_buf(vqueue, &length);
>  		if (!msg) {
>  			if (virtqueue_enable_cb(vqueue))
> @@ -157,7 +177,9 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  			scmi_rx_callback(vioch->cinfo,
>  					 msg_read_header(msg->input), msg);
>  
> +			spin_lock(&vioch->lock);
>  			scmi_finalize_message(vioch, msg);
> +			spin_unlock(&vioch->lock);
>  		}
>  
>  		/*
> @@ -176,6 +198,34 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
>  }
>  
> +static void scmi_vio_deferred_tx_worker(struct work_struct *work)
> +{
> +	unsigned long flags;
> +	struct scmi_vio_channel *vioch;
> +	struct scmi_vio_msg *msg, *tmp;
> +
> +	vioch = container_of(work, struct scmi_vio_channel, deferred_tx_work);
> +
> +	/* Process pre-fetched messages */
> +	spin_lock_irqsave(&vioch->lock, flags);
> +
> +	/* Scan the list of possibly pre-fetched messages during polling. */
> +	list_for_each_entry_safe(msg, tmp, &vioch->pending_cmds_list, list) {
> +		list_del(&msg->list);
> +
> +		scmi_rx_callback(vioch->cinfo,
> +				 msg_read_header(msg->input), msg);
> +
> +		/* Free the processed message once done */
> +		scmi_vio_feed_vq_tx(vioch, msg);
> +	}
> +
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	/* Process possibly still pending messages */
> +	scmi_vio_complete_cb(vioch->vqueue);
> +}
> +
>  static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
>  
>  static vq_callback_t *scmi_vio_complete_callbacks[] = {
> @@ -244,6 +294,19 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  
>  	vioch = &((struct scmi_vio_channel *)scmi_vdev->priv)[index];
>  
> +	/* Setup a deferred worker for polling. */
> +	if (tx && !vioch->deferred_tx_wq) {
> +		vioch->deferred_tx_wq =
> +			alloc_workqueue(dev_name(&scmi_vdev->dev),
> +					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
> +					0);
> +		if (!vioch->deferred_tx_wq)
> +			return -ENOMEM;
> +
> +		INIT_WORK(&vioch->deferred_tx_work,
> +			  scmi_vio_deferred_tx_worker);
> +	}
> +
>  	for (i = 0; i < vioch->max_msg; i++) {
>  		struct scmi_vio_msg *msg;
>  
> @@ -257,6 +320,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  						    GFP_KERNEL);
>  			if (!msg->request)
>  				return -ENOMEM;
> +			spin_lock_init(&msg->poll_lock);
>  		}
>  
>  		msg->input = devm_kzalloc(cinfo->dev, VIRTIO_SCMI_MAX_PDU_SIZE,
> @@ -264,13 +328,12 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  		if (!msg->input)
>  			return -ENOMEM;
>  
> -		if (tx) {
> -			spin_lock_irqsave(&vioch->lock, flags);
> -			list_add_tail(&msg->list, &vioch->free_list);
> -			spin_unlock_irqrestore(&vioch->lock, flags);
> -		} else {
> +		spin_lock_irqsave(&vioch->lock, flags);
> +		if (tx)
> +			scmi_vio_feed_vq_tx(vioch, msg);
> +		else
>  			scmi_vio_feed_vq_rx(vioch, msg, cinfo->dev);
> -		}
> +		spin_unlock_irqrestore(&vioch->lock, flags);
>  	}
>  
>  	spin_lock_irqsave(&vioch->lock, flags);
> @@ -296,6 +359,11 @@ static int virtio_chan_free(int id, void *p, void *data)
>  	vioch->ready = false;
>  	spin_unlock_irqrestore(&vioch->ready_lock, flags);
>  
> +	if (!vioch->is_rx && vioch->deferred_tx_wq) {
> +		destroy_workqueue(vioch->deferred_tx_wq);
> +		vioch->deferred_tx_wq = NULL;
> +	}
> +
>  	scmi_free_channel(cinfo, data, id);
>  
>  	spin_lock_irqsave(&vioch->lock, flags);
> @@ -324,7 +392,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  	}
>  
>  	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> -	list_del(&msg->list);
> +	/* Re-init element so we can discern anytime if it is still in-flight */
> +	list_del_init(&msg->list);
>  
>  	msg_tx_prepare(msg->request, xfer);
>  
> @@ -337,6 +406,19 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  		dev_err(vioch->cinfo->dev,
>  			"failed to add to TX virtqueue (%d)\n", rc);
>  	} else {
> +		/*
> +		 * If polling was requested for this transaction:
> +		 *  - retrieve last used index (will be used as polling reference)
> +		 *  - bind the polled message to the xfer via .priv
> +		 */
> +		if (xfer->hdr.poll_completion) {
> +			spin_lock(&msg->poll_lock);
> +			msg->poll_idx =
> +				virtqueue_enable_cb_prepare(vioch->vqueue);
> +			spin_unlock(&msg->poll_lock);
> +			/* Ensure initialized msg is visibly bound to xfer */
> +			smp_store_mb(xfer->priv, msg);
> +		}
>  		virtqueue_kick(vioch->vqueue);
>  	}
>  
> @@ -350,10 +432,8 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_vio_msg *msg = xfer->priv;
>  
> -	if (msg) {
> +	if (msg)
>  		msg_fetch_response(msg->input, msg->rx_len, xfer);
> -		xfer->priv = NULL;
> -	}
>  }
>  
>  static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> @@ -361,10 +441,165 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_vio_msg *msg = xfer->priv;
>  
> -	if (msg) {
> +	if (msg)
>  		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> -		xfer->priv = NULL;
> +}
> +
> +/**
> + * virtio_mark_txdone  - Mark transmission done
> + *
> + * Free only successfully completed polling transfer messages.
> + *
> + * Note that in the SCMI VirtIO transport we never explicitly release timed-out
> + * messages by forcibly re-adding them to the free-list, even on timeout, inside
> + * the TX code path; we instead let IRQ/RX callbacks eventually clean up such
> + * messages once, finally, a late reply is received and discarded (if ever).
> + *
> + * This approach was deemed preferable since those pending timed-out buffers are
> + * still effectively owned by the SCMI platform VirtIO device even after timeout
> + * expiration: forcibly freeing and reusing them before they had been returned
> + * explicitly by the SCMI platform could lead to subtle bugs due to message
> + * corruption.
> + * An SCMI platform VirtIO device which never returns message buffers is
> + * anyway broken and it will quickly lead to exhaustion of available messages.
> + *
> + * For this same reason, here, we take care to free only the successfully
> + * completed polled messages, since they won't be freed elsewhere; late replies
> + * to timed-out polled messages would be anyway freed by RX callbacks instead.
> + *
> + * @cinfo: SCMI channel info
> + * @ret: Transmission return code
> + * @xfer: Transfer descriptor
> + */
> +static void virtio_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> +			       struct scmi_xfer *xfer)
> +{
> +	unsigned long flags;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +	struct scmi_vio_msg *msg = xfer->priv;
> +
> +	if (!msg)
> +		return;
> +
> +	/* Ensure msg is unbound from xfer before pushing onto the free list  */
> +	smp_store_mb(xfer->priv, NULL);
> +
> +	/* Is a successfully completed polled message still to be finalized ? */
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	if (!ret && xfer->hdr.poll_completion && list_empty(&msg->list))
> +		scmi_vio_feed_vq_tx(vioch, msg);
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +}
> +
> +/**
> + * virtio_poll_done  - Provide polling support for VirtIO transport
> + *
> + * @cinfo: SCMI channel info
> + * @xfer: Reference to the transfer being poll for.
> + *
> + * VirtIO core provides a polling mechanism based only on last used indexes:
> + * this means that it is possible to poll the virtqueues waiting for something
> + * new to arrive from the host side but the only way to check if the freshly
> + * arrived buffer was what we were waiting for is to compare the newly arrived
> + * message descriptors with the one we are polling on.
> + *
> + * As a consequence it can happen to dequeue something different from the buffer
> + * we were poll-waiting for: if that is the case such early fetched buffers are
> + * then added to a the @pending_cmds_list list for later processing by a
> + * dedicated deferred worker.
> + *
> + * So, basically, once something new is spotted we proceed to de-queue all the
> + * freshly received used buffers until we found the one we were polling on, or,
> + * we have 'seemingly' emptied the virtqueue; if some buffers are still pending
> + * in the vqueue at the end of the polling loop (possible due to inherent races
> + * in virtqueues handling mechanisms), we similarly kick the deferred worker
> + * and let it process those, to avoid indefinitely looping in the .poll_done
> + * helper.
> + *
> + * Note that we do NOT suppress notification with VIRTQ_USED_F_NO_NOTIFY even
> + * when polling since such flag is per-virtqueues and we do not want to
> + * suppress notifications as a whole: so, if the message we are polling for is
> + * delivered via usual IRQs callbacks, on another core which are IRQs-on, it
> + * will be handled as such by scmi_rx_callback() and the polling loop in the
> + * SCMI Core TX path will be transparently terminated anyway.
> + *
> + * Return: True once polling has successfully completed.
> + */
> +static bool virtio_poll_done(struct scmi_chan_info *cinfo,
> +			     struct scmi_xfer *xfer)
> +{
> +	bool pending, ret = false;
> +	unsigned int length, any_prefetched = 0;
> +	unsigned long flags;
> +	struct scmi_vio_msg *next_msg, *msg = xfer->priv;
> +	struct scmi_vio_channel *vioch = cinfo->transport_info;
> +
> +	if (!msg)
> +		return true;
> +
> +	spin_lock_irqsave(&msg->poll_lock, flags);
> +	/* Processed already by other polling loop on another CPU ? */
> +	if (msg->poll_idx == VIO_MSG_POLL_DONE) {
> +		spin_unlock_irqrestore(&msg->poll_lock, flags);
> +		return true;
>  	}
> +
> +	/* Has cmdq index moved at all ? */
> +	pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> +	spin_unlock_irqrestore(&msg->poll_lock, flags);
> +	if (!pending)
> +		return false;
> +
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	virtqueue_disable_cb(vioch->vqueue);
> +
> +	/*
> +	 * If something arrived we cannot be sure, without dequeueing, if it
> +	 * was the reply to the xfer we are polling for, or, to other, even
> +	 * possibly non-polling, pending xfers: process all new messages
> +	 * till the polled-for message is found OR the vqueue is empty.
> +	 */
> +	while ((next_msg = virtqueue_get_buf(vioch->vqueue, &length))) {
> +		next_msg->rx_len = length;
> +		/* Is the message we were polling for ? */
> +		if (next_msg == msg) {
> +			ret = true;
> +			break;
> +		}
> +
> +		spin_lock(&next_msg->poll_lock);
> +		if (next_msg->poll_idx == VIO_MSG_NOT_POLLED) {
> +			any_prefetched++;
> +			list_add_tail(&next_msg->list,
> +				      &vioch->pending_cmds_list);
> +		} else {
> +			next_msg->poll_idx = VIO_MSG_POLL_DONE;
> +		}
> +		spin_unlock(&next_msg->poll_lock);
> +	}
> +
> +	/*
> +	 * When the polling loop has successfully terminated if something
> +	 * else was queued in the meantime, it will be served by a deferred
> +	 * worker OR by the normal IRQ/callback OR by other poll loops.
> +	 *
> +	 * If we are still looking for the polled reply, the polling index has
> +	 * to be updated to the current vqueue last used index.
> +	 */
> +	if (ret) {
> +		pending = !virtqueue_enable_cb(vioch->vqueue);
> +	} else {
> +		spin_lock(&msg->poll_lock);
> +		msg->poll_idx = virtqueue_enable_cb_prepare(vioch->vqueue);
> +		pending = virtqueue_poll(vioch->vqueue, msg->poll_idx);
> +		spin_unlock(&msg->poll_lock);
> +	}
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	if (any_prefetched || pending)
> +		queue_work(vioch->deferred_tx_wq, &vioch->deferred_tx_work);

I don't see any attempt to make sure the queued work is no longer
running on e.g. device or driver removal.


> +
> +	return ret;
>  }
>  
>  static const struct scmi_transport_ops scmi_virtio_ops = {
> @@ -376,6 +611,8 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
>  	.send_message = virtio_send_message,
>  	.fetch_response = virtio_fetch_response,
>  	.fetch_notification = virtio_fetch_notification,
> +	.mark_txdone = virtio_mark_txdone,
> +	.poll_done = virtio_poll_done,
>  };
>  
>  static int scmi_vio_probe(struct virtio_device *vdev)
> @@ -418,6 +655,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  		spin_lock_init(&channels[i].lock);
>  		spin_lock_init(&channels[i].ready_lock);
>  		INIT_LIST_HEAD(&channels[i].free_list);
> +		INIT_LIST_HEAD(&channels[i].pending_cmds_list);
>  		channels[i].vqueue = vqs[i];
>  
>  		sz = virtqueue_get_vring_size(channels[i].vqueue);
> @@ -506,4 +744,5 @@ const struct scmi_desc scmi_virtio_desc = {
>  	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
>  	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>  	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
> +	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
>  };
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
