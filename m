Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BF6C4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 10:33:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D9960F26
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 10:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65D9960F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 207D740215;
	Fri, 23 Jul 2021 10:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rzPg8UJUXkQB; Fri, 23 Jul 2021 10:33:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3689401E3;
	Fri, 23 Jul 2021 10:33:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72F9CC001A;
	Fri, 23 Jul 2021 10:33:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90EE2C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 10:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72FC2600CA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 10:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ipA8lwWVZC5T
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 10:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D75960AFB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627036412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWXyBqJzTfNuRmfNKIdetBtP1RNy5LmtjYqPiHgsQrU=;
 b=cp48jOk+g7Ot3kFvLXWnTfzUIP7gMls5vnN5CY7Sd0Hf4X1644+kMvHBPWQ4MULZBuxMI8
 HMuLH+hkREopDQALaylPKRX1/z2fcNWYH3HrG5oAQ2jbaSppI1CvbgObod7OEmD1/Y5mbi
 I2Ee0soSsPXLRRXPnQBeHlkpGnSmoZs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-a4NYGmOUN4auFaPEyzcdQw-1; Fri, 23 Jul 2021 06:33:31 -0400
X-MC-Unique: a4NYGmOUN4auFaPEyzcdQw-1
Received: by mail-ej1-f72.google.com with SMTP id
 hb18-20020a1709071612b029052883e9de3eso420391ejc.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 03:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IWXyBqJzTfNuRmfNKIdetBtP1RNy5LmtjYqPiHgsQrU=;
 b=s8Zp9Dc8ELBEeaII1YyMskZeqBS0bGDRRJJ2h176X7c5ONikKpypNSqbkTIxBxRrJI
 282nvkThevo2w0gzNjnk7CD5mRME4KDMtPO49IeqOIMFx8n3ig8XiqeurGYk7j6+ntaC
 n4maRZcc+Bh4UZKy5trzyUl7dhYL0zbBaUvazEY4wBMpYlq0Shc7/Q0TONBCvBjiuCvN
 rakLz2gAu2S02DXtradbECg+KB/+kBDnYdnwbmMzVfqgo3qOHeF55XEDwH8P7El+NSxZ
 HD7FYEPaNV/wuy3FVg5YNnIcSRpz2/Tw4vuyGCm+DmxNl7TFJEK9jafVOUX4pTnLZgoW
 0VOg==
X-Gm-Message-State: AOAM530l0xwaUTAXDWvVUnOOyjdUzyBkcDmhELrS0o9PuMEG5zpSY63e
 jkF5TsbVmHeKwIzIs7S40UtnCbE4icyqI/zrtb9VY4d20QL3ypHmPL5yNmeG6H9gluC4NZRGTRE
 U3JdiunCueRKGFBLHVrHG78p1kviqui3tpq3niWRlsw==
X-Received: by 2002:aa7:d84a:: with SMTP id f10mr4786526eds.45.1627036410174; 
 Fri, 23 Jul 2021 03:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRTzuSNg37MjiloriLMkgLspNTzQ30700CgwYyTWYABO4p2OU/0d1DQ2yMLQ5IlbC1/5DVhA==
X-Received: by 2002:aa7:d84a:: with SMTP id f10mr4786499eds.45.1627036409965; 
 Fri, 23 Jul 2021 03:33:29 -0700 (PDT)
Received: from redhat.com ([2.55.16.196])
 by smtp.gmail.com with ESMTPSA id cq22sm13751399edb.77.2021.07.23.03.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 03:33:29 -0700 (PDT)
Date: Fri, 23 Jul 2021 06:33:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2.1 5/5] virtio: Bind virtio device to device-tree node
Message-ID: <20210723062427-mutt-send-email-mst@kernel.org>
References: <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
 <3606cdcc637682a3eb401d617e6e247431b78ec6.1627019436.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
In-Reply-To: <3606cdcc637682a3eb401d617e6e247431b78ec6.1627019436.git.viresh.kumar@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>
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

On Fri, Jul 23, 2021 at 11:41:31AM +0530, Viresh Kumar wrote:
> Bind the virtio devices with their of_node. This will help users of the
> virtio devices to mention their dependencies on the device in the DT
> itself. Like GPIO pin users can use the phandle of the device node, or
> the node may contain more subnodes to add i2c or spi eeproms and other
> users.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2->V2.1
> - Remove list of virtio device and use of_device_is_compatible() instead.
> 
>  drivers/virtio/virtio.c | 56 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 4b15c00c0a0a..7c56b3416895 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -4,6 +4,7 @@
>  #include <linux/virtio_config.h>
>  #include <linux/module.h>
>  #include <linux/idr.h>
> +#include <linux/of.h>
>  #include <uapi/linux/virtio_ids.h>
>  
>  /* Unique numbering for virtio devices. */
> @@ -292,6 +293,9 @@ static int virtio_dev_remove(struct device *_d)
>  
>  	/* Acknowledge the device's existence again. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> +
> +	of_node_put(dev->dev.of_node);
> +
>  	return 0;
>  }
>  
> @@ -319,6 +323,42 @@ void unregister_virtio_driver(struct virtio_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
>  
> +static int virtio_device_of_init(struct virtio_device *dev)
> +{
> +	struct device_node *np, *pnode = dev->dev.parent->of_node;

dev_of_node? I think gcc will then be smart enough to
make this a nop with !IS_ENABLED(CONFIG_OF).


> +	int ret, count;
> +	char compat[12];

I think this assumes device id is 16 bits but it's defined as u32
just in case.
If it's ever extended we will then get
into need to handle snprintf errors which is currently missing.
To keep things simple we can do
	char compat[] = "virtio,XXXXXXXX";

> +
> +	if (!pnode)
> +		return 0;
> +
> +	count = of_get_available_child_count(pnode);
> +	if (!count)
> +		return 0;
> +
> +	/* There can be only 1 child node */
> +	if (WARN_ON(count > 1))
> +		return -EINVAL;
> +
> +	np = of_get_next_available_child(pnode, NULL);
> +	if (WARN_ON(!np))
> +		return -ENODEV;
> +
> +	snprintf(compat, sizeof(compat), "virtio,%x", dev->id.device);

worth checking this returns < sizeof(compat) and BUG_ON.

> +
> +	if (!of_device_is_compatible(np, compat)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	dev->dev.of_node = np;
> +	return 0;
> +
> +out:
> +	of_node_put(np);
> +	return ret;
> +}
> +



>  /**
>   * register_virtio_device - register virtio device
>   * @dev        : virtio device to be registered
> @@ -343,6 +383,10 @@ int register_virtio_device(struct virtio_device *dev)
>  	dev->index = err;
>  	dev_set_name(&dev->dev, "virtio%u", dev->index);
>  
> +	err = virtio_device_of_init(dev);
> +	if (err)
> +		goto out_ida_remove;
> +
>  	spin_lock_init(&dev->config_lock);
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
> @@ -362,10 +406,16 @@ int register_virtio_device(struct virtio_device *dev)
>  	 */
>  	err = device_add(&dev->dev);
>  	if (err)
> -		ida_simple_remove(&virtio_index_ida, dev->index);
> +		goto out_of_node_put;
> +
> +	return 0;
> +
> +out_of_node_put:
> +	of_node_put(dev->dev.of_node);
> +out_ida_remove:
> +	ida_simple_remove(&virtio_index_ida, dev->index);
>  out:
> -	if (err)
> -		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(register_virtio_device);
> -- 
> 2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
