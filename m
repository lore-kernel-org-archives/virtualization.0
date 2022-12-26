Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9475C4332F
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 23:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4708260BBE;
	Mon, 26 Dec 2022 23:34:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4708260BBE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZflK0ltg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86lzBkXCZ3kV; Mon, 26 Dec 2022 23:34:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B407460595;
	Mon, 26 Dec 2022 23:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B407460595
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E44EC0032;
	Mon, 26 Dec 2022 23:34:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4471C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AA2B401DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:34:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AA2B401DC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZflK0ltg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IeKk9C44dJaz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:34:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22EDF401B1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22EDF401B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672097685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ng2g0yYWgbxIEbydIqQjZjaHCJ47pT59sGYfx/xB8K8=;
 b=ZflK0ltgLxrn8+MAjKtVzXDsBcN1zBlpgsOyNtRTWMYT++D867PbbVZfleCSBJTsfca+gJ
 A++3BXoolMglZEpP8vTlc6UdEUlrdfqlBow334PgJx6T6CkUsAlv3ViPv1cG3yrmyqUIpl
 bCiPZhu0KSENzrnjnH7nCvU2k+wjJik=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-139-mXxyFFjLNT-9PAQC0wqyQg-1; Mon, 26 Dec 2022 18:34:44 -0500
X-MC-Unique: mXxyFFjLNT-9PAQC0wqyQg-1
Received: by mail-ed1-f69.google.com with SMTP id
 g14-20020a056402090e00b0046790cd9082so8284753edz.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 15:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ng2g0yYWgbxIEbydIqQjZjaHCJ47pT59sGYfx/xB8K8=;
 b=jzEjoUFNr41kLjkVd4SnH4WpP9GBG5o13ToXYgC0mdxGZMCbVMp8khVvAOsMo24N+K
 SYHGV2zBlMabi/AYUsnzekL/93Xo9AWCc+Q9N35Fr8NykCzVb4CYGXLHvoZM1wFSDZIh
 joa46BBXK9+5zzZ5SDJVjDwD0fKJHKiLLSfzQ7Vtf2mWumFnNO4vjXbCZzX1a1gMDF75
 qhP9S9c1NXxFRAsguiQn/1yPc2EyR5Bj71yNnqdZa2+GKY9XGaxnjKsQIq/NwWA+HHMu
 wrfl8icfTP3PuYvoOc0ADi/e6JYCcBBcALEZKkTecWipeNrl+leXCzuBNQsYxIei++cI
 5/Cw==
X-Gm-Message-State: AFqh2koZqOO9NYdabN5W/0/i95f46vHIDgkvpyHpqp8e2JFqH30c4G2m
 b+HmNZ0CEUQqFI4Lyklbc934uv/zor5RlnqUsoJTqfn8qir/fbnHdLIjVAPO1RlyGHOPUz4ZmJ1
 C4jXZ/EJd9kKctsA14xT81bPF56X+QjoQYDiE9a3E1g==
X-Received: by 2002:a17:906:fcc1:b0:7c0:e310:3191 with SMTP id
 qx1-20020a170906fcc100b007c0e3103191mr23119263ejb.11.1672097683425; 
 Mon, 26 Dec 2022 15:34:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsIxLGY2K01obTyBFYBUFcxFDUBn2jzDJ0KXH7WGcJg6MHOSb0Gfde2xZleQL0FFlTneSfHXQ==
X-Received: by 2002:a17:906:fcc1:b0:7c0:e310:3191 with SMTP id
 qx1-20020a170906fcc100b007c0e3103191mr23119251ejb.11.1672097683222; 
 Mon, 26 Dec 2022 15:34:43 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 d24-20020a50fb18000000b004615f7495e0sm5154391edq.8.2022.12.26.15.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 15:34:42 -0800 (PST)
Date: Mon, 26 Dec 2022 18:34:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221226183348-mutt-send-email-mst@kernel.org>
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

There's no good timeout. Let's not even go there, if device goes
bad it should set the need reset bit.


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
