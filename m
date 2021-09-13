Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2087AC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 09:19:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B096C60F8F
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 09:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B096C60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7695160594;
	Mon, 13 Sep 2021 09:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBEEAF92WlRw; Mon, 13 Sep 2021 09:19:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14B286061C;
	Mon, 13 Sep 2021 09:19:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2D21C000F;
	Mon, 13 Sep 2021 09:19:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53167C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35C8040261
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vbxkijE7H6Yg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:19:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4F0A4025D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:19:24 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id 5so5381990plo.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=/KLMhu/ohKTdcErkhutjcvNbaBuyL81b9h2OgPrIAGs=;
 b=0nRXlrxU0h72/63M9Z//j1oUioUEAaM+i5ApthV6Y6lkH/EExd7NOO9yr4vV4wgDNy
 bPRLPTKfpDYsCESaZiV2ZnTya9oO/cvVWeYUWVWCDWsqN4hgD6OhUU/+7nWrCeQACVrj
 Ng9tOjvqGrzA7ezlFKTNwqvCGL9I7gYNe6l7oGdArV3/eMLtbXxGC+8j1o1poMN3JBjm
 uSomnaR+AeYmB3bnxhpAvi9nuZ7FVpjatWQ9DdigYpQHkh1YOAzCo0x6jo1vcFUn1WFa
 xsMcSqIckKjfo3/7e6i8S6BIeDrXis8u9S6H1ZGWzHGN/RgTRu8Oa9fTXdCfIzfaw8/w
 1Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/KLMhu/ohKTdcErkhutjcvNbaBuyL81b9h2OgPrIAGs=;
 b=7JesSiT73SHkORfEGlylw87tl7+CdPh7XW4l5Bw3WHQ2cr7/+YTKO74UZTfMs31ga5
 DqdijE6ahIvuGLMa2sc0whRDPnRdUB1TI4JlYqZu7zTTHJQ9Zg5i9Q9wrFOyVHRWDhcF
 xN+qTeWUWJ2i0RLFHlWPBMc1s0KWtkQcAyUb8uRWocrNhYFgXlXRoLmFmOakU6vPpM3E
 88BIqc4gIExnbjNiLr6ZIGHb1QQ2pau7uf7gaRQopBDnmhQLtxo5nbAdrxVBRtX5idEb
 rW0hDOvNDskI8furXHIOTVdJ6a4PG9CvYeGE1zDIQQQyZ+kQqqgKecqvUv3D3XW/gHKL
 PV6g==
X-Gm-Message-State: AOAM5312pMebVsUIe5IC/ShFBDgJxX5PXxu01pV2Hxsfy852yPZcxz4s
 irgDrwg8We7p28f1XXemaBcMsA==
X-Google-Smtp-Source: ABdhPJyY3G84sKYfeqnJEQmI31QLTRG3fjL7QKVWFJ//gBCJGS4TbYjUbyn/1EcTU7tcRuRvFNJWLw==
X-Received: by 2002:a17:90b:3ecd:: with SMTP id
 rm13mr12074738pjb.4.1631524764063; 
 Mon, 13 Sep 2021 02:19:24 -0700 (PDT)
Received: from [192.168.10.23] (124-171-108-209.dyn.iinet.net.au.
 [124.171.108.209])
 by smtp.gmail.com with ESMTPSA id m1sm6457153pfc.30.2021.09.13.02.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 02:19:23 -0700 (PDT)
Message-ID: <d5f87715-5a3e-1e85-68ba-3e4d35163c68@ozlabs.ru>
Date: Mon, 13 Sep 2021 19:19:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:92.0) Gecko/20100101
 Thunderbird/92.0
Subject: Re: [PATCH V3 5/5] virtio: Bind virtio device to device-tree node
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
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



On 26/07/2021 14:51, Viresh Kumar wrote:
> Bind the virtio devices with their of_node. This will help users of the
> virtio devices to mention their dependencies on the device in the DT
> itself. Like GPIO pin users can use the phandle of the device node, or
> the node may contain more subnodes to add i2c or spi eeproms and other
> users.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/virtio/virtio.c | 57 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 4b15c00c0a0a..d001e84a5b23 100644
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
> @@ -319,6 +323,43 @@ void unregister_virtio_driver(struct virtio_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
>  
> +static int virtio_device_of_init(struct virtio_device *dev)
> +{
> +	struct device_node *np, *pnode = dev_of_node(dev->dev.parent);
> +	char compat[] = "virtio,XXXXXXXX"; /* Reserve enough space 32-bit id */
> +	int ret, count;
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
> +	BUG_ON(snprintf(compat, sizeof(compat), "virtio,%x", dev->id.device) >=
> +	       sizeof(compat));
> +
> +	if (!of_device_is_compatible(np, compat)) {


This broke powerpc/pseries as there these virtio devices are PCI so
there is no "compat" - PCI vendor id/device ids play role of "compat".
Thanks,




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
> @@ -343,6 +384,10 @@ int register_virtio_device(struct virtio_device *dev)
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
> @@ -362,10 +407,16 @@ int register_virtio_device(struct virtio_device *dev)
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
> 

-- 
Alexey
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
