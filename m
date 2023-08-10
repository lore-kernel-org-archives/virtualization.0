Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0020DC001DE
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 19:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E1A483AD9;
	Thu, 10 Aug 2023 19:45:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E1A483AD9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RUKW5ufb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIOfL_o20Jlj; Thu, 10 Aug 2023 19:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D39E282236;
	Thu, 10 Aug 2023 19:45:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D39E282236
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C80C0071;
	Thu, 10 Aug 2023 19:45:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0473C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7699183A9A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:45:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7699183A9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9cq6tZfAL1Dk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:45:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B8C782236
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:45:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B8C782236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691696705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1eDr4DPmIUm/uxGGW2mKYAd0wEheDzbeEmS3Ghlc2E=;
 b=RUKW5ufbIpSZIj1QMQaez1ZQk93uaEZA65xVwO2I7KVGF+lV48MirDLTL0juuWzieApa8y
 Z7nMYih21M7NBhaOx6pDLzUdc5oxtV5Q6V+KuM5eBp3QUVyQOYxVMcAaVvAzkrlOiR7bkh
 eKTcHHKMimhCcxAJ0vr/sYd7k/BqVXM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-_Hmsm8-gPTKYA6A6oPsZYA-1; Thu, 10 Aug 2023 15:45:01 -0400
X-MC-Unique: _Hmsm8-gPTKYA6A6oPsZYA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34e35f57so89747866b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691696700; x=1692301500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1eDr4DPmIUm/uxGGW2mKYAd0wEheDzbeEmS3Ghlc2E=;
 b=VfrP4WKwSh3HYsatvP1g9KeD427seSjpPIWpoJTwl72R9zPKB2EXyrG5a34hNYxc6t
 uhKimmhSvyqlzNfBZB+u1G2S72x6AcjZqQcfZLJVaw6j4RcAL5pJ1rLVm6OCFO1mLM9B
 mD9mSo14Gak8YJg1iuXrRTVXcIudhop7cyGpXs3firiVUp0op7+7vXsu92JHVVoomBsP
 DYlh9fV/jARJOsK/Fo5RwjUU7vbv7thZ9FSoNJxdEm01GjoA5bMAQCWzeWt4iDZwx5Tc
 aetWxPu6bi56+V0coILb7PJbVSfieH7TJBCBs8BnwYZsTY/GITVpw6KUmeyS4q/yq9a4
 Lt5Q==
X-Gm-Message-State: AOJu0Yz/zrBqthiV33LIVBzeMACgUYDqxCVFRwCp2Pu0euF1x4V2WVbW
 UcUg8YnglKlF9WMjb0ZzXPZYE2FShtly2x3f8BLvfMhjPfxDAmxQ5BxhvC2NxAbtEtG+tp0B/N6
 Yp3vqUy6Ex0UcZcF9p2oe5Sk4I/PeiBCDZC/rpbUKng==
X-Received: by 2002:a17:907:761b:b0:99b:eca2:47a8 with SMTP id
 jx27-20020a170907761b00b0099beca247a8mr3005397ejc.38.1691696700479; 
 Thu, 10 Aug 2023 12:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz/FTg2onKMWAYHjvEIScnz+vcyBXPbJMtlVoN+8/Fj4f8UXrZZW5UvjYwwj0QfZbxYTzE0w==
X-Received: by 2002:a17:907:761b:b0:99b:eca2:47a8 with SMTP id
 jx27-20020a170907761b00b0099beca247a8mr3005380ejc.38.1691696700149; 
 Thu, 10 Aug 2023 12:45:00 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 p18-20020a17090635d200b0099d0a8ccb5fsm1325255ejb.152.2023.08.10.12.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 12:44:59 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:44:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anvesh Jain P <quic_ajainp@quicinc.com>
Subject: Re: [PATCH] virtio_mmio: add suspend and resume calls for
 virtio_mmio devices
Message-ID: <20230810154334-mutt-send-email-mst@kernel.org>
References: <20230728070127.18452-1-quic_ajainp@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20230728070127.18452-1-quic_ajainp@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Venkata Rao Kakani <quic_vkakani@quicinc.com>
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

On Fri, Jul 28, 2023 at 12:31:27PM +0530, Anvesh Jain P wrote:
> Handle suspend and resume calls for virtio mmio devices from
> PM core. Expose these notifications to virtio drivers that can quiesce and
> resume vq operations. Update virtio pm ops to handle freeze& restore and
> suspend & resume callbacks separately.
> 
> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>

okey but what is the motivation? does this addition of 200 LOC
achieve something new? what is the issue fixed here?


> ---
>  drivers/virtio/virtio.c      | 112 +++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_mmio.c |  50 +++++++++++++++-
>  include/linux/virtio.h       |  12 ++++
>  3 files changed, 173 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 3893dc29eb26..c6f25a267600 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -551,6 +551,118 @@ int virtio_device_restore(struct virtio_device *dev)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(virtio_device_restore);
> +
> +int virtio_device_suspend(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	virtio_config_disable(dev);
> +
> +	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
> +
> +	if (drv && drv->suspend)
> +		return drv->suspend(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_suspend);
> +
> +int virtio_device_resume(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +	int ret;
> +
> +	if (drv && drv->resume) {
> +		ret = drv->resume(dev);
> +		if (ret)
> +			goto err;
> +
> +		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +			virtio_device_ready(dev);
> +
> +		virtio_config_enable(dev);
> +	}
> +
> +	return 0;
> +err:
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_resume);
> +
> +int virtio_device_suspend_late(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	virtio_config_disable(dev);
> +
> +	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
> +
> +	if (drv && drv->suspend_late)
> +		return drv->suspend_late(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_suspend_late);
> +
> +int virtio_device_resume_early(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +	int ret;
> +
> +	if (drv && drv->resume_early) {
> +		ret = drv->resume_early(dev);
> +		if (ret)
> +			goto err;
> +		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +			virtio_device_ready(dev);
> +
> +		virtio_config_enable(dev);
> +	}
> +
> +	return 0;
> +err:
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_resume_early);
> +
> +int virtio_device_suspend_noirq(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	virtio_config_disable(dev);
> +
> +	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
> +
> +	if (drv && drv->suspend_noirq)
> +		return drv->suspend_noirq(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_suspend_noirq);
> +
> +int virtio_device_resume_noirq(struct virtio_device *dev)
> +{
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +	int ret;
> +
> +	if (drv && drv->resume_noirq) {
> +		ret = drv->resume_noirq(dev);
> +		if (ret)
> +			goto err;
> +		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> +			virtio_device_ready(dev);
> +
> +		virtio_config_enable(dev);
> +	}
> +
> +	return 0;
> +err:
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(virtio_device_resume_noirq);
>  #endif
>  
>  static int virtio_init(void)
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index a46a4a29e929..9385c7e65da9 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -596,9 +596,57 @@ static int virtio_mmio_restore(struct device *dev)
>  
>  	return virtio_device_restore(&vm_dev->vdev);
>  }
> +static int virtio_mmio_suspend(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_suspend(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_resume(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_resume(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_suspend_late(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_suspend_late(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_resume_early(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_resume_early(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_suspend_noirq(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_suspend_noirq(&vm_dev->vdev);
> +}
> +
> +static int virtio_mmio_resume_noirq(struct device *dev)
> +{
> +       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
> +
> +       return virtio_device_resume_noirq(&vm_dev->vdev);
> +}
>  
>  static const struct dev_pm_ops virtio_mmio_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze, virtio_mmio_restore)
> +       .freeze         = virtio_mmio_freeze,
> +       .restore        = virtio_mmio_restore,
> +       .suspend        = virtio_mmio_suspend,
> +       .resume         = virtio_mmio_resume,
> +       .suspend_late   = virtio_mmio_suspend_late,
> +       .resume_early   = virtio_mmio_resume_early,
> +       .suspend_noirq  = virtio_mmio_suspend_noirq,
> +       .resume_noirq   = virtio_mmio_resume_noirq,
>  };
>  #endif
>  
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index de6041deee37..e88b321408e9 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -145,6 +145,12 @@ void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
>  int virtio_device_freeze(struct virtio_device *dev);
>  int virtio_device_restore(struct virtio_device *dev);
> +int virtio_device_suspend(struct virtio_device *dev);
> +int virtio_device_resume(struct virtio_device *dev);
> +int virtio_device_suspend_late(struct virtio_device *dev);
> +int virtio_device_resume_early(struct virtio_device *dev);
> +int virtio_device_suspend_noirq(struct virtio_device *dev);
> +int virtio_device_resume_noirq(struct virtio_device *dev);
>  #endif
>  void virtio_reset_device(struct virtio_device *dev);
>  
> @@ -187,6 +193,12 @@ struct virtio_driver {
>  #ifdef CONFIG_PM
>  	int (*freeze)(struct virtio_device *dev);
>  	int (*restore)(struct virtio_device *dev);
> +	int (*suspend)(struct virtio_device *dev);
> +	int (*resume)(struct virtio_device *dev);
> +	int (*suspend_late)(struct virtio_device *dev);
> +	int (*resume_early)(struct virtio_device *dev);
> +	int (*suspend_noirq)(struct virtio_device *dev);
> +	int (*resume_noirq)(struct virtio_device *dev);
>  #endif
>  };
>  
> 
> base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
