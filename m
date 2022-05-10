Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7FFC433EF
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 11:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEC16405E3;
	Tue, 10 May 2022 11:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 73CNTlxLYFPt; Tue, 10 May 2022 11:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90C20400FB;
	Tue, 10 May 2022 11:28:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 697BDC0039;
	Tue, 10 May 2022 11:28:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 146A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01A0C60E6D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:28:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s8ofkZ7-RU8E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:27:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E37660B48
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652182077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBBnb2I2NKEOa24s2priljbXubiGaWfTmbEUyqlIXqU=;
 b=ZNx5L+nrccwE1Idh8mziix+YA7ciEKSVKGmB/cYhFQyzebycpPE/eTp3djnvVppU3ZuIUD
 dPzrr07EkJb4fDlxN9XCqZ+2aKEJelPgbmGFKNIz+69r/++zfw/Sn4yTWN9BgDS3W9KvLO
 etNztflOKvFsgL5yxl4FkIqBu5yfkSE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-aI1pBedDPKmiBUF8FQrH5Q-1; Tue, 10 May 2022 07:27:57 -0400
X-MC-Unique: aI1pBedDPKmiBUF8FQrH5Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 k5-20020a05600c0b4500b003941ca130f9so5169380wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 04:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NBBnb2I2NKEOa24s2priljbXubiGaWfTmbEUyqlIXqU=;
 b=Ot86c+G3yN87Yj9Vl+8RPXWlynZXmYOmQldtkSqBJy09YBOc/SoZJRX1tlmC4A0ocP
 YIns+9/fB2rNPKJmaOGRifg8W1zhbcxKDj7reEChmCBNBoY5fUa39FL7W5jmcHSWUEOS
 Y4ZMUh1COV0uviBDqf6LkBDdfUkHetshiFnskbIUGMjSnr3cir4cJ0aIaGvLy/w34D9o
 Pu0QA/XA8jHQuBilztBlj0QvTnoMjiwLbpVCsUD7cZPcJaWmg9/sVos3VwUsJ2gp/DIL
 ABOi8bEP7QOvtNTd9WdmJGou7U+yE+1+Hqqj6+G3GrxYANX3qzqriP41BPwsAqLNN4Ub
 51Ig==
X-Gm-Message-State: AOAM530oAye6rI9ThXUoiN++wWyWMR80BVYgTFvSCSRvmROS6wea6lkM
 IXN0y+7mWXLUVyns5NpHOWW3KblvMGLqpgvHZBwTvAj8jRf3izxOZmPDxh5nlA+a7e3gFLyu5Nz
 qqIGSi0EJUn8WbSXDEbYzi4rIemtdewqgUz/lA8AyTw==
X-Received: by 2002:adf:d1e2:0:b0:20c:7012:47c3 with SMTP id
 g2-20020adfd1e2000000b0020c701247c3mr18327092wrd.631.1652182075787; 
 Tue, 10 May 2022 04:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnvYdgZfzsuO6nkuqGaiNO3U1dm9Ph0Vrt/DPepxKDYsE4pJN5El85U8fk2uFunwTZ9CLMlA==
X-Received: by 2002:adf:d1e2:0:b0:20c:7012:47c3 with SMTP id
 g2-20020adfd1e2000000b0020c701247c3mr18327073wrd.631.1652182075584; 
 Tue, 10 May 2022 04:27:55 -0700 (PDT)
Received: from redhat.com ([2.55.130.230]) by smtp.gmail.com with ESMTPSA id
 c17-20020a056000105100b0020c5253d8ccsm13448149wrx.24.2022.05.10.04.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 04:27:55 -0700 (PDT)
Date: Tue, 10 May 2022 07:27:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V4 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220510072451-mutt-send-email-mst@kernel.org>
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-7-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220507071954.14455-7-jasowang@redhat.com>
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

On Sat, May 07, 2022 at 03:19:51PM +0800, Jason Wang wrote:
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
> ---
>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index d35e7a3f7067..001e1f0e6037 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -62,6 +62,7 @@ struct virtio_ccw_device {
>  	unsigned int revision; /* Transport revision */
>  	wait_queue_head_t wait_q;
>  	spinlock_t lock;
> +	rwlock_t irq_lock;
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
> +	if (info) {
> +		/*
> +		 * Synchronize with the vring_interrupt() with airq indicator
> +		 */
> +		write_lock(&info->lock);
> +		write_unlock(&info->lock);
> +	} else {
> +		/*
> +		 * Synchronize with the vring_interrupt() called by
> +		 * virtio_ccw_int_handler().
> +		 */
> +		write_lock(&vcdev->irq_lock);
> +		write_unlock(&vcdev->irq_lock);
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
> +	read_lock_irqsave(&vcdev->irq_lock, flags);
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */

Cornelia sent a lockdep trace on this.

Basically I think this gets the irqsave/restore logic wrong.
It attempts to disable irqs in the handler (which is an interrupt
anyway).
And it does not disable irqs in the synchronize_cbs.

As a result in interrupt might try to take a read lock while
.synchronize_cbs has the writer lock, resulting in a deadlock.

I think you want regular read_lock + write_lock_irq.


> @@ -1114,6 +1139,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  		vq = virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);
>  	}
> +	read_unlock_irqrestore(&vcdev->irq_lock, flags);
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));
> @@ -1284,6 +1310,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
>  	init_waitqueue_head(&vcdev->wait_q);
>  	INIT_LIST_HEAD(&vcdev->virtqueues);
>  	spin_lock_init(&vcdev->lock);
> +	rwlock_init(&vcdev->irq_lock);
>  	mutex_init(&vcdev->io_lock);
>  
>  	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
