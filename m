Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A4FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 08:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6241402F5;
	Mon, 25 Apr 2022 08:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2IngPpmGHEb; Mon, 25 Apr 2022 08:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 09EA440022;
	Mon, 25 Apr 2022 08:08:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2127C0032;
	Mon, 25 Apr 2022 08:08:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E197C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25BAF408D9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4t3yiRg4mZ04
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:08:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4596408D7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 08:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650874118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GjbwvOEeWOxXzRSzSZG07fPrd7M1g4I0kIEVzwMrJBw=;
 b=SUZPul53TZPQ0kjfojAYLremdkEqHHDBJoWxVMvjhYK6VvIUhbjBYTsk6Yu0RYGUGrz8mW
 GjGVYzWFtfhuDWGOMb7TTao0P0zr1UKjbFgNpjU0zWUYu8swbCfMP6xNP8aUmVdWxKjt0K
 fTLx2xSdO8hfZnjF7UAuvxJN1B9QGhk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-IsMcoIBKPiKMNVe8x-efOA-1; Mon, 25 Apr 2022 04:08:35 -0400
X-MC-Unique: IsMcoIBKPiKMNVe8x-efOA-1
Received: by mail-wr1-f72.google.com with SMTP id
 p18-20020adf9592000000b00207bc12decbso3059694wrp.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 01:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GjbwvOEeWOxXzRSzSZG07fPrd7M1g4I0kIEVzwMrJBw=;
 b=gC1kY5JQIXNAtw/a1dIZzk9MjkWc4eh3UOXOgVP2HkBGpoV8bFMTUHk/0bx3sT8gjI
 zg0q9IAW6b2YvwRYgXAb2eabKgsW4WW5/3Q7KteYbuZkxGHn+KSaMr2NAaTT8RlXK1Bb
 d33/LspCa+bWS5bX+t2pzKqpPFuKcSbREQhGopL19VKDPJy7t9RxwBKQAw8fnLkoCXln
 YV+TvGjDcaAgaU0h2zYTWU5hxPEiOjB4RNCRWv0nEQSrb4+s0bd6PZYpFbZnr0CHTZqp
 hS/BX69ETN5oeUpUSWkVw9+Z7ldCeYv2aFTRJ4QyXs8Fl9l9ESSDrJYkuWmHgsIJfAhv
 Qb8A==
X-Gm-Message-State: AOAM532q4aIlFxxnfmINYLUSwKjAXctonzu6+rBi1hhFwaz/2tYKHjLH
 SZtd7LGpovCdXC+D3cx4VJ2RwTpGUxBGCcb8ITE9zDw8smNP74IQNCdQNHA7YKVbISBKfjDuiNV
 SdDj+eYWbUuZfsgCTBek/Oul+9VziFB11MBfs6wIgaA==
X-Received: by 2002:a05:600c:29c3:b0:392:af6e:b500 with SMTP id
 s3-20020a05600c29c300b00392af6eb500mr21517489wmd.13.1650874114124; 
 Mon, 25 Apr 2022 01:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXGUYkNTWUWYGgOmwLXbwR8xJKoVb31vM9aHcOr7nHFi4up04xH9rsaIBf5GsTykbF9G7BSw==
X-Received: by 2002:a05:600c:29c3:b0:392:af6e:b500 with SMTP id
 s3-20020a05600c29c300b00392af6eb500mr21517469wmd.13.1650874113874; 
 Mon, 25 Apr 2022 01:08:33 -0700 (PDT)
Received: from redhat.com ([2.55.142.213]) by smtp.gmail.com with ESMTPSA id
 n10-20020a5d598a000000b0020a9493bdddsm9299870wri.40.2022.04.25.01.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 01:08:32 -0700 (PDT)
Date: Mon, 25 Apr 2022 04:08:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425040512-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220425024418.8415-7-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
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

On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
> This patch tries to implement the synchronize_cbs() for ccw. For the
> vring_interrupt() that is called via virtio_airq_handler(), the
> synchronization is simply done via the airq_info's lock. For the
> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> device spinlock for irq is introduced ans used in the synchronization
> method.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


This is the only one that is giving me pause. Halil, Cornelia,
should we be concerned about the performance impact here?
Any chance it can be tested?

> ---
>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index d35e7a3f7067..c19f07a82d62 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
>  	unsigned int revision; /* Transport revision */
>  	wait_queue_head_t wait_q;
>  	spinlock_t lock;
> +	spinlock_t irq_lock;
>  	struct mutex io_lock; /* Serializes I/O requests */
>  	struct list_head virtqueues;
>  	bool is_thinint;
> @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
>  	return dev_name(&vcdev->cdev->dev);
>  }
>  
> +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +	struct airq_info *info = vcdev->airq_info;
> +
> +	/*
> +	 * Synchronize with the vring_interrupt() called by
> +	 * virtio_ccw_int_handler().
> +	 */
> +	spin_lock(&vcdev->irq_lock);
> +	spin_unlock(&vcdev->irq_lock);
> +
> +	if (info) {
> +		/*
> +		 * Synchronize with the vring_interrupt() with airq indicator
> +		 */
> +		write_lock(&info->lock);
> +		write_unlock(&info->lock);
> +	}
> +}
> +
>  static const struct virtio_config_ops virtio_ccw_config_ops = {
>  	.get_features = virtio_ccw_get_features,
>  	.finalize_features = virtio_ccw_finalize_features,
> @@ -995,6 +1017,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
>  	.find_vqs = virtio_ccw_find_vqs,
>  	.del_vqs = virtio_ccw_del_vqs,
>  	.bus_name = virtio_ccw_bus_name,
> +	.synchronize_cbs = virtio_ccw_synchronize_cbs,
>  };
>  
>  
> @@ -1079,6 +1102,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  {
>  	__u32 activity = intparm & VIRTIO_CCW_INTPARM_MASK;
>  	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> +	unsigned long flags;
>  	int i;
>  	struct virtqueue *vq;
>  
> @@ -1106,6 +1130,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  			vcdev->err = -EIO;
>  	}
>  	virtio_ccw_check_activity(vcdev, activity);
> +	spin_lock_irqsave(&vcdev->irq_lock, flags);
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */
> @@ -1114,6 +1139,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  		vq = virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);
>  	}
> +	spin_unlock_irqrestore(&vcdev->irq_lock, flags);
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));
> @@ -1284,6 +1310,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  	init_waitqueue_head(&vcdev->wait_q);
>  	INIT_LIST_HEAD(&vcdev->virtqueues);
>  	spin_lock_init(&vcdev->lock);
> +	spin_lock_init(&vcdev->irq_lock);
>  	mutex_init(&vcdev->io_lock);
>  
>  	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
