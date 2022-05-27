Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5ABC433EF
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 07:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AC3A6160F;
	Fri, 27 May 2022 07:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id edUztlLNYdI8; Fri, 27 May 2022 07:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A495C61608;
	Fri, 27 May 2022 07:30:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D9B4C0039;
	Fri, 27 May 2022 07:30:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41ACBC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FBE16160F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:30:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7h-cK57ToWP8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:30:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1135161608
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:30:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=16; SR=0;
 TI=SMTPD_---0VEW9CNu_1653636650; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VEW9CNu_1653636650) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 May 2022 15:30:51 +0800
Message-ID: <1653636641.556474-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 3/9] virtio: introduce config op to synchronize vring
 callbacks
Date: Fri, 27 May 2022 15:30:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-4-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-4-jasowang@redhat.com>
Cc: linux-s390@vger.kernel.org, lulu@redhat.com, paulmck@kernel.org,
 mst@redhat.com, peterz@infradead.org, maz@kernel.org, cohuck@redhat.com,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 eperezma@redhat.com, Vineeth Vijayan <vneethv@linux.ibm.com>,
 tglx@linutronix.de, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, 27 May 2022 14:01:14 +0800, Jason Wang <jasowang@redhat.com> wrote:
> This patch introduces new virtio config op to vring
> callbacks. Transport specific method is required to make sure the
> write before this function is visible to the vring_interrupt() that is
> called after the return of this function. For the transport that
> doesn't provide synchronize_vqs(), use synchornize_rcu() which
> synchronize with IRQ implicitly as a fallback.
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
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b341dd62aa4d..25be018810a7 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -57,6 +57,11 @@ struct virtio_shm_region {
>   *		include a NULL entry for vqs unused by driver
>   *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
> + * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> + *      The function guarantees that all memory operations on the
> + *      queue before it are visible to the vring_interrupt() that is
> + *      called after it.
> + *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
>   *	Returns the first 64 feature bits (all we currently need).
> @@ -89,6 +94,7 @@ struct virtio_config_ops {
>  			const char * const names[], const bool *ctx,
>  			struct irq_affinity *desc);
>  	void (*del_vqs)(struct virtio_device *);
> +	void (*synchronize_cbs)(struct virtio_device *);
>  	u64 (*get_features)(struct virtio_device *vdev);
>  	int (*finalize_features)(struct virtio_device *vdev);
>  	const char *(*bus_name)(struct virtio_device *vdev);
> @@ -217,6 +223,25 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>  				      desc);
>  }
>
> +/**
> + * virtio_synchronize_cbs - synchronize with virtqueue callbacks
> + * @vdev: the device
> + */
> +static inline
> +void virtio_synchronize_cbs(struct virtio_device *dev)
> +{
> +	if (dev->config->synchronize_cbs) {
> +		dev->config->synchronize_cbs(dev);
> +	} else {
> +		/*
> +		 * A best effort fallback to synchronize with
> +		 * interrupts, preemption and softirq disabled
> +		 * regions. See comment above synchronize_rcu().
> +		 */
> +		synchronize_rcu();
> +	}
> +}
> +
>  /**
>   * virtio_device_ready - enable vq use in probe function
>   * @vdev: the device
> --
> 2.25.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
