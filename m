Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC451C48
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425665; cv=none; b=BylZEid97vPZTfnb6EAv+JuRA+Tmagy/1kjEItm5C6FkUpkX3dNG0TKGNvoMK2uD7fTw5tgYNd1QoDfW4WlqNLInEp5BnCITyvQrotnDOgj2gNXGFg/4rDRdPJ4Rx/WCLsqTZkwgkGk2cBmXRs+6Z/7jtdYiku8I/fop3nj4Whk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425665; c=relaxed/simple;
	bh=LGSnJpHQQgKcur6GW4YmxJyXuKfv3XVmRlZs4XKGzio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DM6Xr9EGB5S46vaP8GTrlMp5mu7Pilv4c96VnvQe8GK7AmM2XbaMnFbiyPiTxsncFOOfxvvDHrbyxufxu99+laUcU3eSZVU0N94OLvHUBXn+/c5cRxt3BourBB28I0n5LYFc35levfJX1SaAj34HqRMPA9pP8AgWe3LvzmHsArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TP+sgRY0; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TP+sgRY0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 429B74087C
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fWnyUAK2lyLJ for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Apr 2024 07:34:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BCEBF407B7
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCEBF407B7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TP+sgRY0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BCEBF407B7
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713425660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ydywqdvl5tGhn3V8ZvUI2ohm8v6gM+3x5JsmuXE5oQo=;
	b=TP+sgRY0FkenSc8zEWlZY6TIj7ypDWufg9Bx8m0RUDU+AUt1U48G6JOQvQJnCkhBYK2AFH
	3vJSdDMxp7WzhXJC/4apt95ycBIa94lrF9vJGWax15ylQ5hOwl7OfX6PtEahGRju+Xzg4N
	evoNyarXy/bhQCwoXBSuhFWj9eXrO+E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-rwedlSU-O0m8EoOf3Gx1jQ-1; Thu, 18 Apr 2024 03:34:19 -0400
X-MC-Unique: rwedlSU-O0m8EoOf3Gx1jQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4147de378b9so3130855e9.3
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 00:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425658; x=1714030458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydywqdvl5tGhn3V8ZvUI2ohm8v6gM+3x5JsmuXE5oQo=;
        b=Zk+09iJo2WWHQ3v30y9T6cfbPrkIw6fAfRVUvSw8Aqa1Trcfy311lYn25IpdnpXDpJ
         TbIn4T1a7XBzBcOW6im83r2AsvXjo3cQqE+qoOfoCJP7OgRa4G8CuojTWkyNeOB0b1So
         9Rb+LzGg1Ft7OhS3pLM79YIHf0cX9i+Pd0NFbkcTgkEMnTUQNEvXpPN5vi+lO1UI27eS
         9kBcZYaHP4/6ode299ixe/O1EsvcwhwoB/lsY1YleRU1HjZss9mi11hJ6UT7wobnco37
         t2SlqBW2f7nW7iXc7tKBI9F95tYwb/XyRCzUgYJOa2P1cyy+MDxcWBF52gZGBzMKl2IC
         VNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrjAo/34OeKGFKUAJazQ937cmM/r6VvKtV6MV6ctf32PSt/BfwinwFnkObFzcNPJJu1NXmCMk1G5MtZ0/ANCMZdMuNh/mBPgsLpUHzdaAA7eJn0ns1O2lkqg==
X-Gm-Message-State: AOJu0YyT5DK7ey+ILpUjdG+Ex02G41uooXqht4xWRpb+F4TkTbfUzC3y
	ls2nUN97TBzUMMmtgOqE4Rl5d87Xs+O1KGb/KefmOzty1fUDopOTYaMh58HV3apPTOHLnom5S4K
	lcuTN9oeKm+P2BMQGY4S6Ks6POQOn2EhZVOiWQ4JJ3Jdo4AUTuE28LZGDwixWgXmyhMv5bCbY43
	sbefE=
X-Received: by 2002:a05:600c:3111:b0:418:e561:d0b5 with SMTP id g17-20020a05600c311100b00418e561d0b5mr720668wmo.37.1713425657693;
        Thu, 18 Apr 2024 00:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvhWHg0a0NuVWZRqdc4rSWNDjVnJcCbbmdis1E8SLdKf95AgXARxMzDAd6QhFNcqERmy+EJQ==
X-Received: by 2002:a05:600c:3111:b0:418:e561:d0b5 with SMTP id g17-20020a05600c311100b00418e561d0b5mr720650wmo.37.1713425657100;
        Thu, 18 Apr 2024 00:34:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fc:1e9b:54cd:34ea:3dbb:5a75])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b004186c58a9b5sm1654720wmb.44.2024.04.18.00.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:34:16 -0700 (PDT)
Date: Thu, 18 Apr 2024 03:34:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: David Stevens <stevensd@chromium.org>, Jason Wang <jasowang@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>,
	virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/1] virtio: Add support for the virtio suspend feature
Message-ID: <20240418033313-mutt-send-email-mst@kernel.org>
References: <20240417085440.4036535-1-stevensd@chromium.org>
 <20240417085440.4036535-2-stevensd@chromium.org>
 <a123f8da-a6b9-4923-95ff-7814804cdabb@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a123f8da-a6b9-4923-95ff-7814804cdabb@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 03:14:37PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 4/17/2024 4:54 PM, David Stevens wrote:
> > Add support for the VIRTIO_F_SUSPEND feature. When this feature is
> > negotiated, power management can use it to suspend virtio devices
> > instead of resorting to resetting the devices entirely.
> > 
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >   drivers/virtio/virtio.c            | 32 ++++++++++++++++++++++++++++++
> >   drivers/virtio/virtio_pci_common.c | 29 +++++++++++----------------
> >   drivers/virtio/virtio_pci_modern.c | 19 ++++++++++++++++++
> >   include/linux/virtio.h             |  2 ++
> >   include/uapi/linux/virtio_config.h | 10 +++++++++-
> >   5 files changed, 74 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index f4080692b351..cd11495a5098 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -1,5 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   #include <linux/virtio.h>
> > +#include <linux/delay.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/virtio_config.h>
> >   #include <linux/virtio_anchor.h>
> > @@ -580,6 +581,37 @@ int virtio_device_restore(struct virtio_device *dev)
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL_GPL(virtio_device_restore);
> > +
> > +static int virtio_device_set_suspend_bit(struct virtio_device *dev, bool enabled)
> > +{
> > +	u8 status, target;
> > +
> > +	status = dev->config->get_status(dev);
> > +	if (enabled)
> > +		target = status | VIRTIO_CONFIG_S_SUSPEND;
> > +	else
> > +		target = status & ~VIRTIO_CONFIG_S_SUSPEND;
> > +	dev->config->set_status(dev, target);
> I think it is better to verify whether the device SUSPEND bit is
> already set or clear, we can just return if status == target.
> 
> Thanks
> Zhu Lingshan
> > +
> > +	while ((status = dev->config->get_status(dev)) != target) {
> > +		if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
> > +			return -EIO;
> > +		mdelay(10);

Bad device state (set by surprise removal) should also
be handled here I think.


> > +	}
> > +	return 0;
> > +}
> > +
> > +int virtio_device_suspend(struct virtio_device *dev)
> > +{
> > +	return virtio_device_set_suspend_bit(dev, true);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_suspend);
> > +
> > +int virtio_device_resume(struct virtio_device *dev)
> > +{
> > +	return virtio_device_set_suspend_bit(dev, false);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_resume);
> >   #endif
> >   static int virtio_init(void)
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index b655fccaf773..4d542de05970 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -495,31 +495,26 @@ static int virtio_pci_restore(struct device *dev)
> >   	return virtio_device_restore(&vp_dev->vdev);
> >   }
> > -static bool vp_supports_pm_no_reset(struct device *dev)
> > +static int virtio_pci_suspend(struct device *dev)
> >   {
> >   	struct pci_dev *pci_dev = to_pci_dev(dev);
> > -	u16 pmcsr;
> > -
> > -	if (!pci_dev->pm_cap)
> > -		return false;
> > -
> > -	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > -	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > -		dev_err(dev, "Unable to query pmcsr");
> > -		return false;
> > -	}
> > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > -	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > -}
> > +	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
> > +		return virtio_device_suspend(&vp_dev->vdev);
> > -static int virtio_pci_suspend(struct device *dev)
> > -{
> > -	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> > +	return virtio_pci_freeze(dev);
> >   }
> >   static int virtio_pci_resume(struct device *dev)
> >   {
> > -	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > +
> > +	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
> > +		return virtio_device_resume(&vp_dev->vdev);
> > +
> > +	return virtio_pci_restore(dev);
> >   }
> >   static const struct dev_pm_ops virtio_pci_pm_ops = {
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index f62b530aa3b5..ac8734526b8d 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -209,6 +209,22 @@ static void vp_modern_avq_deactivate(struct virtio_device *vdev)
> >   	__virtqueue_break(admin_vq->info.vq);
> >   }
> > +static bool vp_supports_pm_no_reset(struct pci_dev *pci_dev)
> > +{
> > +	u16 pmcsr;
> > +
> > +	if (!pci_dev->pm_cap)
> > +		return false;
> > +
> > +	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > +	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > +		dev_err(&pci_dev->dev, "Unable to query pmcsr");
> > +		return false;
> > +	}
> > +
> > +	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > +}
> > +
> >   static void vp_transport_features(struct virtio_device *vdev, u64 features)
> >   {
> >   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > @@ -223,6 +239,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
> >   	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
> >   		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
> > +
> > +	if (features & BIT_ULL(VIRTIO_F_SUSPEND) && vp_supports_pm_no_reset(pci_dev))
> > +		__virtio_set_bit(vdev, VIRTIO_F_SUSPEND);
> >   }
> >   static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index b0201747a263..8e456b04114e 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -160,6 +160,8 @@ void virtio_config_changed(struct virtio_device *dev);
> >   #ifdef CONFIG_PM_SLEEP
> >   int virtio_device_freeze(struct virtio_device *dev);
> >   int virtio_device_restore(struct virtio_device *dev);
> > +int virtio_device_suspend(struct virtio_device *dev);
> > +int virtio_device_resume(struct virtio_device *dev);
> >   #endif
> >   void virtio_reset_device(struct virtio_device *dev);
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 2445f365bce7..4a6e2c28ea76 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -40,6 +40,8 @@
> >   #define VIRTIO_CONFIG_S_DRIVER_OK	4
> >   /* Driver has finished configuring features */
> >   #define VIRTIO_CONFIG_S_FEATURES_OK	8
> > +/* Driver has suspended the device */
> > +#define VIRTIO_CONFIG_S_SUSPEND		0x10
> >   /* Device entered invalid state, driver must reset it */
> >   #define VIRTIO_CONFIG_S_NEEDS_RESET	0x40
> >   /* We've given up on this device. */
> > @@ -52,7 +54,7 @@
> >    * rest are per-device feature bits.
> >    */
> >   #define VIRTIO_TRANSPORT_F_START	28
> > -#define VIRTIO_TRANSPORT_F_END		42
> > +#define VIRTIO_TRANSPORT_F_END		43
> >   #ifndef VIRTIO_CONFIG_NO_LEGACY
> >   /* Do we get callbacks when the ring is completely used, even if we've
> > @@ -120,4 +122,10 @@
> >    */
> >   #define VIRTIO_F_ADMIN_VQ		41
> > +/*
> > + * This feature indicates that the driver can suspend the device via the
> > + * suspend bit in the device status byte.
> > + */
> > +#define VIRTIO_F_SUSPEND		42
> > +
> >   #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */

