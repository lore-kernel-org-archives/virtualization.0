Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78C3C4332F
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 23:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 673794086B;
	Mon, 26 Dec 2022 23:38:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 673794086B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d15TV1CZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oYJHEhBGYJny; Mon, 26 Dec 2022 23:38:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8751E403C7;
	Mon, 26 Dec 2022 23:38:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8751E403C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6417CC0032;
	Mon, 26 Dec 2022 23:38:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB5D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF14860BA2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:38:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF14860BA2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d15TV1CZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhA3j0l1TN6e
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:38:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 507BA60595
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 507BA60595
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672097911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezEM/TKhEZZEiA0qvJ103L6FIDKOFYr7NEo4WCCY3ZI=;
 b=d15TV1CZsQW0FLIM61cYRBQQtheP5QSmKgzF0vM5N9wa2MWJQwZD07KIyw9mYRcGowlXgx
 FxmeQ1qTr+XWhY1wCSgyhSpq8iRx/sggkuKSLZ8wz9GdnQDRuKS1WrNM7dJ2l+KddriLev
 eKQa7O7V1/2sIxKeacW05p6rmkVhMSM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-WY28arkDMJGNfnQLdNHE3g-1; Mon, 26 Dec 2022 18:38:29 -0500
X-MC-Unique: WY28arkDMJGNfnQLdNHE3g-1
Received: by mail-ej1-f72.google.com with SMTP id
 qa18-20020a170907869200b007df87611618so7954545ejc.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 15:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezEM/TKhEZZEiA0qvJ103L6FIDKOFYr7NEo4WCCY3ZI=;
 b=4B59s3qY4kr1JLltMz5TydKX/ocVyWEpSSh/TtCWmU9bi4orpVUGwbqvlihacWKL1H
 M9+dgsd6AV5pMsiopA3cuIlOK2d8LdV+XxxrtdvxfFUH0zJk4JcKT+oHlPXTg0yfm+9i
 Z2KOz7D7ed1CYNKWCXaJzlvC2ABfcwGenaGQDXeMTxulXkHXrdBnYSEp2T1cqvCB2oDu
 og/P/SShJgnjDlifzDCDkaEhM2awXrB2Cb8iSsxPGBECchmnC+LkQdprF2yv83CtphUv
 vgGBRr1GlzYx+iZzgg+ELB7lytWW+MCflrbDx5c1MZQeJrhhUnQ8j238MgQIWCorMGzb
 8SzQ==
X-Gm-Message-State: AFqh2korjdtilSaPxFWZxxipSSvvn5mpPz3DpFmxnXAjE25TKBvFYn8W
 /O9GSsWHVVcxanVnbpXp0mppiMP7xCVZYl/Jv/8PmLeaF55/nC2BBxpFKJYgsKNz3hjqKGWInxD
 QJUG9zye2OmCpUYVpgQEDtvIAOrE9b9zWy2vojY1bgQ==
X-Received: by 2002:a17:906:184a:b0:78d:f456:1ed0 with SMTP id
 w10-20020a170906184a00b0078df4561ed0mr21402797eje.33.1672097908810; 
 Mon, 26 Dec 2022 15:38:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtbl7ganWCzrQFMRWt4QOxuXB0jibHQVxPMd+xdjGiQv6CVnMTaniUeiSPcYYhXQnXClNYHAA==
X-Received: by 2002:a17:906:184a:b0:78d:f456:1ed0 with SMTP id
 w10-20020a170906184a00b0078df4561ed0mr21402774eje.33.1672097908469; 
 Mon, 26 Dec 2022 15:38:28 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 s10-20020a1709064d8a00b007815ca7ae57sm5362124eju.212.2022.12.26.15.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 15:38:28 -0800 (PST)
Date: Mon, 26 Dec 2022 18:38:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221226183705-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221226074908.8154-4-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

On Mon, Dec 26, 2022 at 03:49:07PM +0800, Jason Wang wrote:
> This patch introduces a per virtqueue waitqueue to allow driver to
> sleep and wait for more used. Two new helpers are introduced to allow
> driver to sleep and wake up.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes since V1:
> - check virtqueue_is_broken() as well
> - use more_used() instead of virtqueue_get_buf() to allow caller to
>   get buffers afterwards
> ---
>  drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  3 +++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5cfb2fa8abee..9c83eb945493 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/kmsan.h>
>  #include <linux/spinlock.h>
> +#include <linux/wait.h>
>  #include <xen/xen.h>
>  
>  #ifdef DEBUG
> @@ -60,6 +61,7 @@
>  			"%s:"fmt, (_vq)->vq.name, ##args);	\
>  		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */ \
>  		WRITE_ONCE((_vq)->broken, true);		       \
> +		wake_up_interruptible(&(_vq)->wq);		       \
>  	} while (0)
>  #define START_USE(vq)
>  #define END_USE(vq)
> @@ -203,6 +205,9 @@ struct vring_virtqueue {
>  	/* DMA, allocation, and size information */
>  	bool we_own_ring;
>  
> +	/* Wait for buffer to be used */
> +	wait_queue_head_t wq;
> +
>  #ifdef DEBUG
>  	/* They're supposed to lock for us. */
>  	unsigned int in_use;
> @@ -2024,6 +2029,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;
>  
> +	init_waitqueue_head(&vq->wq);
> +
>  	err = vring_alloc_state_extra_packed(&vring_packed);
>  	if (err)
>  		goto err_state_extra;
> @@ -2517,6 +2524,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>  		vq->weak_barriers = false;
>  
> +	init_waitqueue_head(&vq->wq);
> +
>  	err = vring_alloc_state_extra_split(vring_split);
>  	if (err) {
>  		kfree(vq);
> @@ -2654,6 +2663,8 @@ static void vring_free(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	wake_up_interruptible(&vq->wq);
> +
>  	if (vq->we_own_ring) {
>  		if (vq->packed_ring) {
>  			vring_free_queue(vq->vq.vdev,
> @@ -2863,4 +2874,22 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>  
> +int virtqueue_wait_for_used(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	/* TODO: Tweak the timeout. */
> +	return wait_event_interruptible_timeout(vq->wq,
> +	       virtqueue_is_broken(_vq) || more_used(vq), HZ);

BTW undocumented that you also make it interruptible.
So if we get an interrupt then this will fail.
But device is still going and will later use the buffers.

Same for timeout really.



> +}
> +EXPORT_SYMBOL_GPL(virtqueue_wait_for_used);
> +
> +void virtqueue_wake_up(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	wake_up_interruptible(&vq->wq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_wake_up);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index dcab9c7e8784..2eb62c774895 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -72,6 +72,9 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
>  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
>  			    void **ctx);
>  
> +int virtqueue_wait_for_used(struct virtqueue *vq);
> +void virtqueue_wake_up(struct virtqueue *vq);
> +
>  void virtqueue_disable_cb(struct virtqueue *vq);
>  
>  bool virtqueue_enable_cb(struct virtqueue *vq);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
