Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E1C433EF
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 07:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C783A8494F;
	Fri, 27 May 2022 07:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Je1iLMux41y; Fri, 27 May 2022 07:34:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7286584950;
	Fri, 27 May 2022 07:34:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45105C0039;
	Fri, 27 May 2022 07:34:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC11AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA714412F7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cvxv4VY_305Y
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:34:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAD08412F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 07:33:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=16; SR=0;
 TI=SMTPD_---0VEW7k5j_1653636835; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VEW7k5j_1653636835) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 27 May 2022 15:33:55 +0800
Message-ID: <1653636827.6549792-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 7/9] virtio: allow to unbreak virtqueue
Date: Fri, 27 May 2022 15:33:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-8-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-8-jasowang@redhat.com>
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

On Fri, 27 May 2022 14:01:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> This patch allows the new introduced __virtio_break_device() to
> unbreak the virtqueue.
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

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++++++++
>  include/linux/virtio.h       |  1 +
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 9d0bae4293be..9c231e1fded7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2395,6 +2395,28 @@ void virtio_break_device(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(virtio_break_device);
>
> +/*
> + * This should allow the device to be used by the driver. You may
> + * need to grab appropriate locks to flush the write to
> + * vq->broken. This should only be used in some specific case e.g
> + * (probing and restoring). This function should only be called by the
> + * core, not directly by the driver.
> + */
> +void __virtio_unbreak_device(struct virtio_device *dev)
> +{
> +	struct virtqueue *_vq;
> +
> +	spin_lock(&dev->vqs_list_lock);
> +	list_for_each_entry(_vq, &dev->vqs, list) {
> +		struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +		WRITE_ONCE(vq->broken, false);
> +	}
> +	spin_unlock(&dev->vqs_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> +
>  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 5464f398912a..d8fdf170637c 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -131,6 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
>  bool is_virtio_device(struct device *dev);
>
>  void virtio_break_device(struct virtio_device *dev);
> +void __virtio_unbreak_device(struct virtio_device *dev);
>
>  void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.25.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
