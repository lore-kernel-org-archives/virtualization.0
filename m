Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50446C433FE
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 09:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E327084060;
	Wed, 18 May 2022 09:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W3MgBheW7v1Y; Wed, 18 May 2022 09:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 502FA8406B;
	Wed, 18 May 2022 09:32:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 211B7C0039;
	Wed, 18 May 2022 09:32:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3CE7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 09:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 829258406B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 09:32:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lL9f9_Ptbxxk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 09:32:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 344C284060
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652866360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7J31Q2VN0OgQuZCLhh0JlKV/aqwl61ASdmry7dAHvIs=;
 b=Go9tbbKhpfpfrpUJXASw/XFOF8Ugm5VBnzNnL2/dR7S9IL4adAgF+lUmoe3/+v4hPVfMBr
 /lmSGURAqwE4jJZxwYhe+PT9hXAk4012cSsrh6jwsQlhZbnIoulH95fAAYVsQ+dTGC6JPJ
 UGDEMny8qBdpSUKk5mrvzadIyEL2GwQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-SjHa4HwlNGmAnBzPSKmHsA-1; Wed, 18 May 2022 05:32:36 -0400
X-MC-Unique: SjHa4HwlNGmAnBzPSKmHsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0D2829DD9AA;
 Wed, 18 May 2022 09:32:35 +0000 (UTC)
Received: from localhost (dhcp-192-194.str.redhat.com [10.33.192.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD6101410DD5;
 Wed, 18 May 2022 09:32:35 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <20220518035951.94220-7-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-7-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Wed, 18 May 2022 11:32:33 +0200
Message-ID: <87tu9nfaoe.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: lulu@redhat.com, paulmck@kernel.org, linux-s390@vger.kernel.org,
 peterz@infradead.org, maz@kernel.org,
 Peter Oberparleiter <oberpar@linux.ibm.com>, pasic@linux.ibm.com,
 eperezma@redhat.com, Vineeth Vijayan <vneethv@linux.ibm.com>,
 tglx@linutronix.de
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

On Wed, May 18 2022, Jason Wang <jasowang@redhat.com> wrote:

> This patch tries to implement the synchronize_cbs() for ccw. For the
> vring_interrupt() that is called via virtio_airq_handler(), the
> synchronization is simply done via the airq_info's lock. For the
> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> device rwlock is introduced ans used in the synchronization method.

s/ans/and/

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
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index d35e7a3f7067..22d36594bcdd 100644
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

Maybe

/*
 * This device uses adapter interrupts: synchronize with
 * vring_interrupt() called by virtio_airq_handler() via the indicator
 * area lock.
 */

> +		 */
> +		write_lock_irq(&info->lock);
> +		write_unlock_irq(&info->lock);
> +	} else {
> +		/*
> +		 * Synchronize with the vring_interrupt() called by
> +		 * virtio_ccw_int_handler().

/*
 * This device uses classic interrupts: synchronize with
 * vring_interrupt() called by virtio_ccw_int_handler() via the
 * per-device irq_lock.
 */

> +		 */
> +		write_lock_irq(&vcdev->irq_lock);
> +		write_unlock_irq(&vcdev->irq_lock);
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
> @@ -1106,6 +1129,8 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  			vcdev->err = -EIO;
>  	}
>  	virtio_ccw_check_activity(vcdev, activity);
> +	/* Local interrupt should be disabled at this time */

/* Interrupts are disabled here. */

?

Interrupts enabled here would surely be a bug.

> +	read_lock(&vcdev->irq_lock);
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
