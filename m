Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B5CC433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 12:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19C7640928;
	Wed,  6 Apr 2022 12:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z6hNu7Q0raIR; Wed,  6 Apr 2022 12:00:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3D46E40893;
	Wed,  6 Apr 2022 12:00:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18DA6C001D;
	Wed,  6 Apr 2022 12:00:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F46FC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BA1D610C5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uYW4pmpqkvAA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:00:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12B6F60A74
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649246420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ze2TWxpmAqqDUL49E+XcPJ1705fMWUsu9cAskjBwj0E=;
 b=Pobs6p/5uPN4TmXCP14wUUB2RMAB36irVaqnXUs0lGRT9SgBMDhtAZtBHdpJ5wx80CDO8K
 HoCY7WL36hqpQezV0QAf1JKsd6Xz9w2PyLUicwxB++PMRFV8YeAMAnwO9XY/MbBWJHWRYm
 PQsIcZ//OstxtWJgMEHPAsTUltw6UBw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-e5oTsjB4NKuVhRIZMgsZsw-1; Wed, 06 Apr 2022 08:00:19 -0400
X-MC-Unique: e5oTsjB4NKuVhRIZMgsZsw-1
Received: by mail-wr1-f70.google.com with SMTP id
 v30-20020adfa1de000000b002060d11eb63so423499wrv.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 05:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ze2TWxpmAqqDUL49E+XcPJ1705fMWUsu9cAskjBwj0E=;
 b=KSSnp3Zx6r8ANgH+T3/1lTn8YeZ5eYCNFAelZygvygpRcmAf7jzA4Nw86+y03nO8V5
 wD+8ecHz7ZVEyRonIUJo2T5o3xOaqZSbxihKj/Myj+SlDz9VWF+MRqFgCLdYypNGocNs
 +al3XjBvZKmcCuYHxv/KrcW04MwsEKNJFwETF0B1zRVIIqRtZjtqOmK7MTxXrt2XHVRf
 oxrI0fKQnD7ezokBQD14eRvvj3znaMH/C3RnKFPNweJG4kQ7gncpC3IauxHo6d0jzwFV
 FGSo2JHHK0l+j/Bi65kL9cYXQER3wPKBYvMrrwG0MTvXHVQQ0PYy7qhCFROM5VhcUMWp
 tIcw==
X-Gm-Message-State: AOAM532qTX/bqkyaGBKWiUV3M0mkWsyckyH27BuiJQp5WiopQa5F2PTj
 +uVu14Dz60lOSLDViw4FfGVhZc1RN/Udg7fJ5iP8WFbNNtCijrMhKWq+G8aod123If0gnKKPCVV
 rzyfrrz6Wg/TaEzsVT7SC1VbXdTIGGvOf144qWMCBRA==
X-Received: by 2002:adf:f10e:0:b0:206:1837:b5a9 with SMTP id
 r14-20020adff10e000000b002061837b5a9mr6235216wro.347.1649246417776; 
 Wed, 06 Apr 2022 05:00:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAufotzexY7Jj8FBhbUyN69cKdArXStk+wlr/BcYVa/P4zN5BWio7QBwNF1ollNyzQV0IO1w==
X-Received: by 2002:adf:f10e:0:b0:206:1837:b5a9 with SMTP id
 r14-20020adff10e000000b002061837b5a9mr6235196wro.347.1649246417519; 
 Wed, 06 Apr 2022 05:00:17 -0700 (PDT)
Received: from redhat.com ([2.55.179.195]) by smtp.gmail.com with ESMTPSA id
 r12-20020a5d6c6c000000b00203ec2b1255sm18278692wrz.60.2022.04.06.05.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 05:00:17 -0700 (PDT)
Date: Wed, 6 Apr 2022 08:00:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220406075952-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220406083538.16274-5-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> This patch implements PCI version of synchronize_vqs().
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Please add implementations at least for ccw and mmio.

> ---
>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>  drivers/virtio/virtio_pci_common.h |  2 ++
>  drivers/virtio/virtio_pci_legacy.c |  1 +
>  drivers/virtio/virtio_pci_modern.c |  2 ++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d724f676608b..b78c8bc93a97 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>  }
>  
> +void vp_synchronize_vqs(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	int i;
> +
> +	if (vp_dev->intx_enabled) {
> +		synchronize_irq(vp_dev->pci_dev->irq);
> +		return;
> +	}
> +
> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> +}
> +
>  /* the notify function used when creating a virt queue */
>  bool vp_notify(struct virtqueue *vq)
>  {
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index eb17a29fc7ef..2b84d5c1b5bc 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -105,6 +105,8 @@ static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
>  void vp_synchronize_vectors(struct virtio_device *vdev);
>  /* the notify function used when creating a virt queue */
>  bool vp_notify(struct virtqueue *vq);
> +/* synchronize with callbacks */
> +void vp_synchronize_vqs(struct virtio_device *vdev);
>  /* the config->del_vqs() implementation */
>  void vp_del_vqs(struct virtio_device *vdev);
>  /* the config->find_vqs() implementation */
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 6f4e34ce96b8..5a9e62320edc 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -192,6 +192,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_vqs = vp_synchronize_vqs,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index a2671a20ef77..584850389855 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -394,6 +394,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_modern_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_vqs = vp_synchronize_vqs,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> @@ -411,6 +412,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.reset		= vp_reset,
>  	.find_vqs	= vp_modern_find_vqs,
>  	.del_vqs	= vp_del_vqs,
> +	.synchronize_vqs = vp_synchronize_vqs,
>  	.get_features	= vp_get_features,
>  	.finalize_features = vp_finalize_features,
>  	.bus_name	= vp_bus_name,
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
