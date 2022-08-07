Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3875BC19F2A
	for <virtualization@archiver.kernel.org>; Sun,  7 Aug 2022 22:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A914818DC;
	Sun,  7 Aug 2022 22:57:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A914818DC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTmyR3cT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39K00r3BxRAP; Sun,  7 Aug 2022 22:57:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7AFF82702;
	Sun,  7 Aug 2022 22:57:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7AFF82702
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC057C0032;
	Sun,  7 Aug 2022 22:57:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74C2FC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 22:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 492D8405A8
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 22:57:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 492D8405A8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTmyR3cT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id No2mChbFJxPI
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 22:57:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 373E340181
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 373E340181
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 22:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659913024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DRG3kxi36PNmVinjdItykZfWEJs1QIH2+MUoMsMB+M0=;
 b=LTmyR3cThuKtgkMgp9HiJdX4j0nr5jymPxJf6yy2Rpw/E2xCrE5q1LfSsaXygS5LvAwB22
 uaw58RhoizljZzALDueoT/3PRuZEBLs0DYVu8Lay7M9NexFX96lvsp5aQ10I6xOYuJ1lQv
 cWfbge9oOAjIrhICuSDLMpxDuMYyNLo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226--_EwYm-HNCaL-tj6n9y3aw-1; Sun, 07 Aug 2022 18:57:03 -0400
X-MC-Unique: -_EwYm-HNCaL-tj6n9y3aw-1
Received: by mail-wm1-f69.google.com with SMTP id
 bh18-20020a05600c3d1200b003a32044cc9fso3947880wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Aug 2022 15:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=DRG3kxi36PNmVinjdItykZfWEJs1QIH2+MUoMsMB+M0=;
 b=eOlHY1r7g8ANA8WmFIsLDVjSiD173aCQ44hgyucPvDVDz/WAqIPRWfwgp29aYu3QG4
 3bXJpgvaj2hPyLf6M3CYXdLA6KeVFOOtftsV/8Q3PLPPAJJn7tbujvvRLZJA3UHftRuq
 3KwO/QFtRuvuBnpSdtPoMDzaB8pxPOw4F4cGzX2M0IKiSvrx7AXDDAiy6TqdIBo5K3o0
 13AX7e+NTFuoj6RalEjIObsf2ARphDEUcGVP3QBCCO1r8WGKMiQgRyDHla2Htg5zdhHI
 QA16Z0qHi5BzbXBuhRSrG45+pzlm54x5zFpg7aW4pYH+oO44hRh90E9ytvEiBl+jFwYl
 SnWQ==
X-Gm-Message-State: ACgBeo1tSWpyjvPIT163ea5ECvCSuXQw3me2a+dIHt96M1uzYu6yE3G0
 KuetbTlIBh8fAxa7TA1IUZnEsfDaVwCmDqbgMHUzicyup5TGtpiXaeMr4a/v2aa4sEy/YfQDLhH
 mzNXmacCzCE3QyO12lH0hoDkBaN2dD6K5fK+mxvFBbw==
X-Received: by 2002:adf:dfca:0:b0:21f:c93:5c36 with SMTP id
 q10-20020adfdfca000000b0021f0c935c36mr9565187wrn.41.1659913021920; 
 Sun, 07 Aug 2022 15:57:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4DQBpZdhf0pAyeZfbLu4dv8LJ5Uprgoh7hJXP8hoIGau82PS3zKRDTJ/sqZNm7PtU1kq2lQA==
X-Received: by 2002:adf:dfca:0:b0:21f:c93:5c36 with SMTP id
 q10-20020adfdfca000000b0021f0c935c36mr9565176wrn.41.1659913021591; 
 Sun, 07 Aug 2022 15:57:01 -0700 (PDT)
Received: from redhat.com ([2.52.21.123]) by smtp.gmail.com with ESMTPSA id
 w11-20020a1cf60b000000b003a5260b8392sm4523962wmc.23.2022.08.07.15.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Aug 2022 15:57:01 -0700 (PDT)
Date: Sun, 7 Aug 2022 18:56:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Subject: Re: [PATCH] virtio-mmio: Introduce virtio_mmio hotplug
Message-ID: <20220807185612-mutt-send-email-mst@kernel.org>
References: <20220807215226.36507-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20220807215226.36507-1-Igor.Skalkin@opensynergy.com>
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

On Sun, Aug 07, 2022 at 11:52:26PM +0200, Igor Skalkin wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> While the virtio device is not yet running, the virtual machine manager
> advertises the device with device_id set to 0.
> During virtio mmio probing, the device_id is checked, and if it is 0,
> the rest of the probing function is deferred until the interrupt arrives.
> 
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>

Given this is clearly an extension to host/guest ABI, please
propose this on the virtio TC mailing list.


> ---
> In our setup, we have a Linux host running virtio devices and virtualised
> Linux/Android Guest[s] running virtio drivers.
> Situation "the guest OS calls the probe() function for the virtio driver,
> but the virtio device has not yet started in the host OS." keeps happening.
> Also, some devices need to be hot-plugged later instead of starting during
> system sturtup.
> 
> Probing of the guest virtio drivers should be deferred until the host device
> has started.
> ---
>  drivers/virtio/virtio_mmio.c | 58 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 083ff1eb743d..c2e28a8faaaa 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -91,6 +91,8 @@ struct virtio_mmio_device {
>  	/* a list of queues so we can dispatch IRQs */
>  	spinlock_t lock;
>  	struct list_head virtqueues;
> +
> +	struct work_struct hotplug_work;
>  };
>  
>  struct virtio_mmio_vq_info {
> @@ -592,6 +594,43 @@ static void virtio_mmio_release_dev(struct device *_d)
>  
>  /* Platform device */
>  
> +static irqreturn_t hotplug_interrupt(int irq, void *opaque)
> +{
> +	struct virtio_mmio_device *vm_dev = opaque;
> +
> +	if (readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID))
> +		schedule_work(&vm_dev->hotplug_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int virtio_mmio_request_irq(irq_handler_t handler,
> +				   struct virtio_mmio_device *vm_dev)
> +{
> +	int err;
> +
> +	err = request_irq(platform_get_irq(vm_dev->pdev, 0), handler,
> +			  IRQF_SHARED, dev_name(&vm_dev->pdev->dev), vm_dev);
> +	if (err)
> +		dev_err(&vm_dev->pdev->dev, "request_irq(%s) returns %d\n",
> +			dev_name(&vm_dev->pdev->dev), err);
> +
> +	return err;
> +}
> +
> +static int finish_probe(struct virtio_mmio_device *vm_dev);
> +static void virtio_mmio_hotplug_work(struct work_struct *hotplug_work)
> +{
> +	struct virtio_mmio_device *vm_dev =
> +		container_of(hotplug_work, struct virtio_mmio_device,
> +			    hotplug_work);
> +
> +	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +
> +	if (finish_probe(vm_dev))
> +		virtio_mmio_request_irq(hotplug_interrupt, vm_dev);
> +}
> +
>  static int virtio_mmio_probe(struct platform_device *pdev)
>  {
>  	struct virtio_mmio_device *vm_dev;
> @@ -628,6 +667,25 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> +	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
> +	if (!vm_dev->vdev.id.device) {
> +		rc = virtio_mmio_request_irq(hotplug_interrupt, vm_dev);
> +		if (rc)
> +			return rc;
> +
> +		INIT_WORK(&vm_dev->hotplug_work, virtio_mmio_hotplug_work);
> +
> +		return 0;
> +	}
> +
> +	return finish_probe(vm_dev);
> +}
> +
> +static int finish_probe(struct virtio_mmio_device *vm_dev)
> +{
> +	struct platform_device *pdev = vm_dev->pdev;
> +	int rc;
> +
>  	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
>  	if (vm_dev->vdev.id.device == 0) {
>  		/*
> -- 
> 2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
