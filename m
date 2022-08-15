Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23F6C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4551460BF7;
	Mon, 15 Aug 2022 21:56:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4551460BF7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MTzhe1FU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7o35Lhg4qcJE; Mon, 15 Aug 2022 21:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 064CF60BE7;
	Mon, 15 Aug 2022 21:56:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 064CF60BE7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C991EC0033;
	Mon, 15 Aug 2022 21:56:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17BDFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5E1340424
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5E1340424
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MTzhe1FU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 51diHKvXo9KX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B6AE40012
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B6AE40012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Mm/CnM1h4B5dRbBk+BycTCdz0sdSVv31NtnIHgtZL8=;
 b=MTzhe1FUYh94zm8xPNOkDNX8Hexf5A1aUaskB+5xj/dAMQhsjmqWIR71xGc8ehcrGV/kBb
 7rQh/VZF9ziVh47EPCFQ4c4EChUn3EG3K0Sc7MXFqmp0EmMY1VR/2eB6gXvOPOxf4oc/wo
 scxkD6fDuQVF2DhJgWuYcHPZ7rFaFn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-4eCxDpejMaiGGJzA-ghfqQ-1; Mon, 15 Aug 2022 17:56:38 -0400
X-MC-Unique: 4eCxDpejMaiGGJzA-ghfqQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 c17-20020a7bc011000000b003a2bfaf8d3dso4080457wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=8Mm/CnM1h4B5dRbBk+BycTCdz0sdSVv31NtnIHgtZL8=;
 b=l7Sr4BKJBUWImVvYH0fq/RRdMbL5gj+Q9hnKYzD6Iis6RofUXNPHpQZuWwqD3DFKLn
 +/xCNRFQ5Rv9akf5RV8OAQz8F4nnTIHPqP1KpLlzSlr8hzFniPldW2FNmb9N/TdxbCDe
 5k01EomPEgNlWVus+uAiqJSKCMD14VoxnBfYHC1k3932Kkp+jjZaOHRNt/wSrE+1xRU7
 WHx6Epmc9SD+3ahWyEfhFuqnUa6k2ghCGHgpYDDjvwE2bGKDz0A6IqAJ3lh7L4fA9N1w
 xHZC3VJTRdxt4PpQ8Ae4HUJGwzrRV+6qVXTtjGocwjkLhIgxHvGrmA/H7ffZ5G+B7gNa
 eLxg==
X-Gm-Message-State: ACgBeo0h99IFwmVCpnVwQmqNSKPY3ZXK2xxerinSjceZ+UNoWc49GSke
 SfFN9Idwm6uParVkVkqnTQynafDnUYa/wvoqauWqiRc3RZ1pffDnVzOKQ2qI/xtHNkOf/99zLvj
 txbKk0//OSDpu+mN1yCmmYkxQS9zG2XLjV3Mfi/0+FQ==
X-Received: by 2002:a5d:4646:0:b0:220:5c35:d4f2 with SMTP id
 j6-20020a5d4646000000b002205c35d4f2mr9776327wrs.475.1660600597083; 
 Mon, 15 Aug 2022 14:56:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR446rc1SI6gJKMPP11qXiQWWOXXuovFOjed61tFUBD5H8GPlv+4YWAmEn44A+sTFWCC57gMXw==
X-Received: by 2002:a5d:4646:0:b0:220:5c35:d4f2 with SMTP id
 j6-20020a5d4646000000b002205c35d4f2mr9776312wrs.475.1660600596795; 
 Mon, 15 Aug 2022 14:56:36 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 az34-20020a05600c602200b003a5e7435190sm8296828wmb.32.2022.08.15.14.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:56:36 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:56:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] virtio: kerneldocs fixes and enhancements
Message-ID: <20220815175549-mutt-send-email-mst@kernel.org>
References: <20220815215251.154451-1-mst@redhat.com>
 <20220815215251.154451-2-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220815215251.154451-2-mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 15, 2022 at 05:53:24PM -0400, Michael S. Tsirkin wrote:
> From: Ricardo Ca=F1uelo <ricardo.canuelo@collabora.com>
> =

> Fix variable names in some kerneldocs, naming in others.
> Add kerneldocs for struct vring_desc and vring_interrupt.
> =

> Signed-off-by: Ricardo Ca=F1uelo <ricardo.canuelo@collabora.com>
> Message-Id: <20220810094004.1250-2-ricardo.canuelo@collabora.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>


Ouch this got here by mistake. Just ignore this patch pls -
it's already in my tree but does not belong in the patchset.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d66c8e6d0ef3..4620e9d79dde 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2426,6 +2426,14 @@ static inline bool more_used(const struct vring_vi=
rtqueue *vq)
>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>  }
>  =

> +/**
> + * vring_interrupt - notify a virtqueue on an interrupt
> + * @irq: the IRQ number (ignored)
> + * @_vq: the struct virtqueue to notify
> + *
> + * Calls the callback function of @_vq to process the virtqueue
> + * notification.
> + */
>  irqreturn_t vring_interrupt(int irq, void *_vq)
>  {
>  	struct vring_virtqueue *vq =3D to_vvq(_vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index a3f73bb6733e..dcab9c7e8784 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -11,7 +11,7 @@
>  #include <linux/gfp.h>
>  =

>  /**
> - * virtqueue - a queue to register buffers for sending or receiving.
> + * struct virtqueue - a queue to register buffers for sending or receivi=
ng.
>   * @list: the chain of virtqueues for this device
>   * @callback: the function to call when buffers are consumed (can be NUL=
L).
>   * @name: the name of this virtqueue (mainly for debugging)
> @@ -97,7 +97,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>  		     void (*recycle)(struct virtqueue *vq, void *buf));
>  =

>  /**
> - * virtio_device - representation of a device using virtio
> + * struct virtio_device - representation of a device using virtio
>   * @index: unique position on the virtio bus
>   * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
>   * @config_enabled: configuration change reporting enabled
> @@ -156,7 +156,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev=
);
>  	list_for_each_entry(vq, &vdev->vqs, list)
>  =

>  /**
> - * virtio_driver - operations for a virtio I/O driver
> + * struct virtio_driver - operations for a virtio I/O driver
>   * @driver: underlying device driver (populate name and owner).
>   * @id_table: the ids serviced by this driver.
>   * @feature_table: an array of feature numbers supported by this driver.
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 36ec7be1f480..4b517649cfe8 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -239,7 +239,7 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, u=
nsigned nvqs,
>  =

>  /**
>   * virtio_synchronize_cbs - synchronize with virtqueue callbacks
> - * @vdev: the device
> + * @dev: the virtio device
>   */
>  static inline
>  void virtio_synchronize_cbs(struct virtio_device *dev)
> @@ -258,7 +258,7 @@ void virtio_synchronize_cbs(struct virtio_device *dev)
>  =

>  /**
>   * virtio_device_ready - enable vq use in probe function
> - * @vdev: the device
> + * @dev: the virtio device
>   *
>   * Driver must call this to use vqs in the probe function.
>   *
> @@ -306,7 +306,7 @@ const char *virtio_bus_name(struct virtio_device *vde=
v)
>  /**
>   * virtqueue_set_affinity - setting affinity for a virtqueue
>   * @vq: the virtqueue
> - * @cpu: the cpu no.
> + * @cpu_mask: the cpu mask
>   *
>   * Pay attention the function are best-effort: the affinity hint may not=
 be set
>   * due to config support, irq type and sharing.
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio=
_ring.h
> index 476d3e5c0fe7..f8c20d3de8da 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -93,15 +93,21 @@
>  #define VRING_USED_ALIGN_SIZE 4
>  #define VRING_DESC_ALIGN_SIZE 16
>  =

> -/* Virtio ring descriptors: 16 bytes.  These can chain together via "nex=
t". */
> +/**
> + * struct vring_desc - Virtio ring descriptors,
> + * 16 bytes long. These can chain together via @next.
> + *
> + * @addr: buffer address (guest-physical)
> + * @len: buffer length
> + * @flags: descriptor flags
> + * @next: index of the next descriptor in the chain,
> + *        if the VRING_DESC_F_NEXT flag is set. We chain unused
> + *        descriptors via this, too.
> + */
>  struct vring_desc {
> -	/* Address (guest-physical). */
>  	__virtio64 addr;
> -	/* Length. */
>  	__virtio32 len;
> -	/* The flags as indicated above. */
>  	__virtio16 flags;
> -	/* We chain unused descriptors via this, too */
>  	__virtio16 next;
>  };
>  =

> -- =

> MST
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
