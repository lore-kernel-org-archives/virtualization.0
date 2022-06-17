Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911B1C43334
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 10:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E98C83EC9;
	Fri, 17 Jun 2022 10:02:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E98C83EC9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G82t8gEa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mE8RP7fTKlU0; Fri, 17 Jun 2022 10:02:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C100844ED;
	Fri, 17 Jun 2022 10:02:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C100844ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CC43C0039;
	Fri, 17 Jun 2022 10:02:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A409CC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D641844ED
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:01:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D641844ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ChznnmwecurV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3147983EC9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3147983EC9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655460115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TSVh7yijYlapN8vzLiNc0otlLUAAzEtnNLfWmNY1vGE=;
 b=G82t8gEaOqofqqu228Wyin2CZyc0cvVUW1lX+QJn+DT85wneTWAKxCLmna4numyoaD2fk5
 OViSn2U59lcrP0VbzABMezR2wPgLWjKqov3H+AHbQJaJvt/NqCT/dT/LoDK2Pq3IB259po
 b0GPNwcDkQsRSBW+nr91NM5gamopogc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-srjZujIwOdisY8Ob08-c-Q-1; Fri, 17 Jun 2022 06:01:52 -0400
X-MC-Unique: srjZujIwOdisY8Ob08-c-Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 l4-20020a05600c1d0400b0039c60535405so1408377wms.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 03:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TSVh7yijYlapN8vzLiNc0otlLUAAzEtnNLfWmNY1vGE=;
 b=MicWGob93SUSt2ifBrjKC+o15gdx9P9CxminxcjfsHb/VxLPpeEgm3Fw+ysloTxd9T
 QHg1Uy5WLcVZGh7G1RjsozaA73jJHgnFMGtXxPWA2YabFACbeM5uZTV7ffXdTmNXaKsc
 +S7URlTYmpJJ7cnhE4clhGJQxFlfsCOj58oFFHu7L3Xo+Z0lsjiUFuOe3owrWCwZay0w
 mXu3xdd9zd8FdthKEYY4EMHIAVdBRmX3mJFF4MV1WwjKlmXc3JK6aAL0NyMGfKkiPT7r
 vXsU0ZlsQ1c/wUuEZFeYqC/EylNaxsNbK/55SUwsTZD3h7NYBHKNUnFep0a3+YuvL5CP
 fJ7w==
X-Gm-Message-State: AJIora9C6AS+VP3ClVTvKJDGqQNXPtkH1zLs9MJC8HUU0QxyghQ+uHH5
 R3MKVpK4VWYkYLbOlQA/iA3FNFr5JOa2YRtKnKpmp2aCvPki6I8Af5vFrxhrBeockYijT3xb8An
 hygIZxWiNxdEra52eZKvjLin+ustArC9HtnbGDuhE9Q==
X-Received: by 2002:a05:6000:1111:b0:212:d9ea:8609 with SMTP id
 z17-20020a056000111100b00212d9ea8609mr8689017wrw.522.1655460110689; 
 Fri, 17 Jun 2022 03:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v8oTtQKSi5Cmw+jxp4WuOkWmcH0i3GQ/fJ95cJqHwaeCaQcWr0LlRvF1z+hNcGMxe0/fHbBw==
X-Received: by 2002:a05:6000:1111:b0:212:d9ea:8609 with SMTP id
 z17-20020a056000111100b00212d9ea8609mr8689000wrw.522.1655460110368; 
 Fri, 17 Jun 2022 03:01:50 -0700 (PDT)
Received: from redhat.com ([2.54.189.19]) by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4c48000000b0021b8213fa3bsm411504wrt.19.2022.06.17.03.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jun 2022 03:01:49 -0700 (PDT)
Date: Fri, 17 Jun 2022 06:01:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: disable notification hardening by default
Message-ID: <20220617060111-mutt-send-email-mst@kernel.org>
References: <20220617072626.30503-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220617072626.30503-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Fri, Jun 17, 2022 at 03:26:26PM +0800, Jason Wang wrote:
> We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> harden vring IRQ"). It works with the assumption that the driver or
> core can properly call virtio_device_ready() at the right
> place. Unfortunately, this seems to be not true and uncover various
> bugs of the existing drivers, mainly the issue of using
> virtio_device_ready() incorrectly.
> 
> So let's having a Kconfig option and disable it by default. It gives
> us a breath to fix the drivers and then we can consider to enable it
> by default.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Do you want to drop irq_lock lock/unlock in ccw too?

> ---
>  drivers/virtio/Kconfig        |  6 ++++++
>  drivers/virtio/virtio.c       |  2 ++
>  drivers/virtio/virtio_ring.c  | 12 ++++++++++++
>  include/linux/virtio_config.h |  2 ++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index b5adf6abd241..b059c39af3d4 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -35,6 +35,12 @@ menuconfig VIRTIO_MENU
>  
>  if VIRTIO_MENU
>  
> +config VIRTIO_HARDEN_NOTIFICATION
> +        bool "Harden virtio notification"
> +        help
> +          Enable to this to harden the device notifications and
> +          supress the ones that are illegal.
> +
>  config VIRTIO_PCI
>  	tristate "PCI driver for virtio devices"
>  	depends on PCI
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index ef04a96942bf..21dc08d2f32d 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -220,6 +220,7 @@ static int virtio_features_ok(struct virtio_device *dev)
>   * */
>  void virtio_reset_device(struct virtio_device *dev)
>  {
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	/*
>  	 * The below virtio_synchronize_cbs() guarantees that any
>  	 * interrupt for this line arriving after
> @@ -228,6 +229,7 @@ void virtio_reset_device(struct virtio_device *dev)
>  	 */
>  	virtio_break_device(dev);
>  	virtio_synchronize_cbs(dev);
> +#endif
>  
>  	dev->config->reset(dev);
>  }
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..d9d3b6e201fb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1688,7 +1688,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->we_own_ring = true;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	vq->broken = true;
> +#else
> +	vq->broken = false;
> +#endif
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> @@ -2135,9 +2139,13 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  	}
>  
>  	if (unlikely(vq->broken)) {
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  		dev_warn_once(&vq->vq.vdev->dev,
>  			      "virtio vring IRQ raised before DRIVER_OK");
>  		return IRQ_NONE;
> +#else
> +		return IRQ_HANDLED;
> +#endif
>  	}
>  
>  	/* Just a hint for performance: so it's ok that this can be racy! */
> @@ -2180,7 +2188,11 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->we_own_ring = false;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	vq->broken = true;
> +#else
> +	vq->broken = false;
> +#endif
>  	vq->last_used_idx = 0;
>  	vq->event_triggered = false;
>  	vq->num_added = 0;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 9a36051ceb76..d15c3cdda2d2 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -257,6 +257,7 @@ void virtio_device_ready(struct virtio_device *dev)
>  
>  	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	/*
>  	 * The virtio_synchronize_cbs() makes sure vring_interrupt()
>  	 * will see the driver specific setup if it sees vq->broken
> @@ -264,6 +265,7 @@ void virtio_device_ready(struct virtio_device *dev)
>  	 */
>  	virtio_synchronize_cbs(dev);
>  	__virtio_unbreak_device(dev);
> +#endif
>  	/*
>  	 * The transport should ensure the visibility of vq->broken
>  	 * before setting DRIVER_OK. See the comments for the transport
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
