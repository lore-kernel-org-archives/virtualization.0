Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63F0C433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 12:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A2024051C;
	Fri, 17 Jun 2022 12:36:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A2024051C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JLceM910
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nFHRfkjGrPPu; Fri, 17 Jun 2022 12:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9888E400E5;
	Fri, 17 Jun 2022 12:36:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9888E400E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65B6CC0032;
	Fri, 17 Jun 2022 12:36:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED242C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3D444099E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:36:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3D444099E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JLceM910
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BXvCMJNqv6cL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:36:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A04140995
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A04140995
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655469391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RNdSBmShYOKDsuGy06c+NrA70N8YaR9zjSa+aBwZad0=;
 b=JLceM910HFeTjjQtaTmOdQWsMr5INNLT5y0DrELWPbVDecWvDDT5zwBl+FKlkK/cGtIdGt
 bw/zJK0qkupuKx55cv8+ib/2+t+0OeQd6BsoN72dVbV1NhUQXKap1oOF+KZdWsBm8MgKZW
 O5Dj34tANr5hiZ5VHDZO9zcrTpK6fo0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-B7pzwDS1NoiF1zJ_omVr5w-1; Fri, 17 Jun 2022 08:36:30 -0400
X-MC-Unique: B7pzwDS1NoiF1zJ_omVr5w-1
Received: by mail-ej1-f71.google.com with SMTP id
 mb1-20020a170906eb0100b00710c3b46a9aso2003970ejb.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 05:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RNdSBmShYOKDsuGy06c+NrA70N8YaR9zjSa+aBwZad0=;
 b=hNIswmvbKn32UEbrAnP9pnjmU71PYRjyopd401z4kW/6dIL5+D8lHxSXvQ01vvwSTC
 XfhDegvOXEb3ltxAsRFNz62WjJS5dzPtgQt9NwioRjHqKy1uyapB6tDnu6mPAtpvffg2
 qwv6Nxc+ZKIhwmlvuoYjuBlJjPl+z4/0T9cflgEqTpbaPUucJ+SvHSTxflbYQnCCWphg
 6lanEO62ihMc14TXVNcQvTrh6uY0DaGXjN3BzSl9HmS8kF81V8uYp3XX7mdtRkS1m8Kn
 Z+6rBfvBSSt0MhfYg65xbraFm4PF9Z72pGmxIz4x9Yo2HQE0nVrbPE3BoC1CIJ+fgkb3
 Q0JA==
X-Gm-Message-State: AJIora+VRJqqvMAQKsORnudZSn8J82hmRhxh/HGmf+s3DSfoTrJrzMwi
 QJR4QcUR1uyheJpdje7yY1JQdOmudsjHYW7U8UmVKdg9D+UJF4izmq0w0cP/rPcw8ATHX8rm1cJ
 TYLu85c7ohnrI6F2VvOO3RQpw6sdsq/VaJLCE42/l7Q==
X-Received: by 2002:a17:906:1b19:b0:70d:6fe8:eb44 with SMTP id
 o25-20020a1709061b1900b0070d6fe8eb44mr9235503ejg.129.1655469388913; 
 Fri, 17 Jun 2022 05:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umHXhoj133SUaYQ2dFkPt30Rc7hAXn4S/0TBhCi0UQuwOhLRoLLmk8YQXjeYRRgEr50dRwPA==
X-Received: by 2002:a17:906:1b19:b0:70d:6fe8:eb44 with SMTP id
 o25-20020a1709061b1900b0070d6fe8eb44mr9235488ejg.129.1655469388662; 
 Fri, 17 Jun 2022 05:36:28 -0700 (PDT)
Received: from redhat.com ([2.54.189.19]) by smtp.gmail.com with ESMTPSA id
 g10-20020a056402424a00b00435390befe2sm2934123edb.58.2022.06.17.05.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jun 2022 05:36:28 -0700 (PDT)
Date: Fri, 17 Jun 2022 08:36:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: disable notification hardening by default
Message-ID: <20220617083420-mutt-send-email-mst@kernel.org>
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
> +          Enable to this

Enable this

> to harden the

handling of 

> device notifications and
> +          supress the ones that are illegal.

Experimental: not all drivers handle this correctly at this point.
If unsure, say N.


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
