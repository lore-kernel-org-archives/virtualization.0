Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C080C432BE
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 06:25:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01B660F56
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 06:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D01B660F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A7A74035A;
	Tue, 31 Aug 2021 06:25:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rgIQORHO7XYR; Tue, 31 Aug 2021 06:25:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 434424037E;
	Tue, 31 Aug 2021 06:25:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 178DCC0010;
	Tue, 31 Aug 2021 06:25:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29AB5C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C51680CC9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b7Vmy7yMYbyl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:25:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24F1A80CC3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630391130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=St1rq/GRTUN1BqWP/sQOT2FcgqysJ21/+gmc2cNwpXE=;
 b=FT6ro3Ch/XH/aPlacXLgGTn1vo/YQn8ArgvlFsL9eLNUaPJ6P/FnZZgpKV80Wb2LfZJQWH
 r3V6LpM3FmN87Gi9P36O4iQcH9YclftJaEHVEfjAI+j5MDFUNAEZ6Y6neuQujUYayO28aA
 twwYjrGtFMbJ/csDxiPfSD4bxQhytZY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-WfVnXSNQNnivA9GPOIsSyg-1; Tue, 31 Aug 2021 02:25:28 -0400
X-MC-Unique: WfVnXSNQNnivA9GPOIsSyg-1
Received: by mail-ej1-f72.google.com with SMTP id
 yz13-20020a170906dc4d00b005c61ad936f0so6648086ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 23:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=St1rq/GRTUN1BqWP/sQOT2FcgqysJ21/+gmc2cNwpXE=;
 b=UBJcgYRT4Rqg5Gp5VLoPZPlGF5uo+rCSTLkEaqlGz2NKLNgcvbTjql5WcLqfhf1qLI
 mCH1VzTxFnFwg3hcPazR7zmdtvUznWLpuRgwzqnLsexzOvn0TUMnjXz6BVGFqtKjQa1+
 +6v+tBW6hCC/3WwmEPUwtEZbzVpWNquC60b+jKzQritNs7/ucwUKmkV8EGlQJ76qsIEe
 SGTeK78T3aqXLa8+EZvbP4hTghBcRWVghQlBoY1W/W2Hcfw7FNFQJTgi/a3lpCNVjI7U
 9sY7fogVUAv5gk9KZ7TNTMb6F0YVfcu5yddapW5TDdf6UCb2IeKOpBg/tsgUMRfwlMn5
 v+PQ==
X-Gm-Message-State: AOAM531BqwbsqnrnsxBffo0/n4DlxzZ1xZR1r9fobOyo2tbZ9lLdwAj7
 tbDqyVxwbgBhCMC37ivWiYdZqKbyw0EYAT38WROsBjfZWI/+8eCPT1w+K01+AZ6EXFJOOfBmmkR
 jh/XnT4Bzv9NZVclQvbGZQ3LwW/gkGcbZZPs2NXj6eQ==
X-Received: by 2002:a17:907:6289:: with SMTP id
 nd9mr29024384ejc.384.1630391127016; 
 Mon, 30 Aug 2021 23:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvRafOmY6jKU6Si2LSybhJCp5YyAxIJ+xnSN9f6usZ4gHSBOkAZ32XK3mN933PuL0lQsr2BQ==
X-Received: by 2002:a17:907:6289:: with SMTP id
 nd9mr29024373ejc.384.1630391126827; 
 Mon, 30 Aug 2021 23:25:26 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id t24sm7664370ejf.48.2021.08.30.23.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 23:25:26 -0700 (PDT)
Date: Tue, 31 Aug 2021 02:25:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] gpio: virtio: Fix sparse warnings
Message-ID: <20210831022224-mutt-send-email-mst@kernel.org>
References: <32ab7b833743449b21f529cae41f4cbb60dc863c.1630387746.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
In-Reply-To: <32ab7b833743449b21f529cae41f4cbb60dc863c.1630387746.git.viresh.kumar@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 kernel test robot <lkp@intel.com>, linux-gpio@vger.kernel.org,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

On Tue, Aug 31, 2021 at 10:59:25AM +0530, Viresh Kumar wrote:
> Fix warnings reported by sparse, related to type mismatch between u16
> and __le16.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'm not sure which tree has the above commit - can this be squashed?

Also, the driver lacks a MAINTAINERS entry - we want at least
L:      virtualization@lists.linux-foundation.org
on all virtio drivers.


> ---
>  drivers/gpio/gpio-virtio.c       | 41 ++++++++++++++++----------------
>  include/uapi/linux/virtio_gpio.h | 10 ++++----
>  2 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index d33eb237c0b9..d24f1c9264bc 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -32,7 +32,6 @@ struct virtio_gpio {
>  	struct virtio_device *vdev;
>  	struct mutex lock; /* Protects virtqueue operation */
>  	struct gpio_chip gc;
> -	struct virtio_gpio_config config;
>  	struct virtio_gpio_line *lines;
>  	struct virtqueue *request_vq;
>  };
> @@ -57,7 +56,7 @@ static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
>  
>  	req->type = cpu_to_le16(type);
>  	req->gpio = cpu_to_le16(gpio);
> -	req->value = txvalue;
> +	req->value = cpu_to_le32(txvalue);
>  
>  	sg_init_one(&req_sg, req, sizeof(*req));
>  	sg_init_one(&res_sg, res, rxlen);
> @@ -233,19 +232,19 @@ static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
>  	return 0;
>  }
>  
> -static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio)
> +static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
> +					  u32 gpio_names_size, u16 ngpio)
>  {
> -	struct virtio_gpio_config *config = &vgpio->config;
>  	struct virtio_gpio_response_get_names *res;
>  	struct device *dev = &vgpio->vdev->dev;
>  	u8 *gpio_names, *str;
>  	const char **names;
>  	int i, ret, len;
>  
> -	if (!config->gpio_names_size)
> +	if (!gpio_names_size)
>  		return NULL;
>  
> -	len = sizeof(*res) + config->gpio_names_size;
> +	len = sizeof(*res) + gpio_names_size;
>  	res = devm_kzalloc(dev, len, GFP_KERNEL);
>  	if (!res)
>  		return NULL;
> @@ -258,18 +257,18 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio)
>  		return NULL;
>  	}
>  
> -	names = devm_kcalloc(dev, config->ngpio, sizeof(*names), GFP_KERNEL);
> +	names = devm_kcalloc(dev, ngpio, sizeof(*names), GFP_KERNEL);
>  	if (!names)
>  		return NULL;
>  
>  	/* NULL terminate the string instead of checking it */
> -	gpio_names[config->gpio_names_size - 1] = '\0';
> +	gpio_names[gpio_names_size - 1] = '\0';
>  
> -	for (i = 0, str = gpio_names; i < config->ngpio; i++) {
> +	for (i = 0, str = gpio_names; i < ngpio; i++) {
>  		names[i] = str;
>  		str += strlen(str) + 1; /* zero-length strings are allowed */
>  
> -		if (str > gpio_names + config->gpio_names_size) {
> +		if (str > gpio_names + gpio_names_size) {
>  			dev_err(dev, "gpio_names block is too short (%d)\n", i);
>  			return NULL;
>  		}
> @@ -280,31 +279,31 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio)
>  
>  static int virtio_gpio_probe(struct virtio_device *vdev)
>  {
> -	struct virtio_gpio_config *config;
> +	struct virtio_gpio_config config;
>  	struct device *dev = &vdev->dev;
>  	struct virtio_gpio *vgpio;
> +	u32 gpio_names_size;
> +	u16 ngpio;
>  	int ret, i;
>  
>  	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
>  	if (!vgpio)
>  		return -ENOMEM;
>  
> -	config = &vgpio->config;
> -
>  	/* Read configuration */
> -	virtio_cread_bytes(vdev, 0, config, sizeof(*config));
> -	config->gpio_names_size = le32_to_cpu(config->gpio_names_size);
> -	config->ngpio = le16_to_cpu(config->ngpio);
> -	if (!config->ngpio) {
> +	virtio_cread_bytes(vdev, 0, &config, sizeof(config));
> +	gpio_names_size = le32_to_cpu(config.gpio_names_size);
> +	ngpio = le16_to_cpu(config.ngpio);
> +	if (!ngpio) {
>  		dev_err(dev, "Number of GPIOs can't be zero\n");
>  		return -EINVAL;
>  	}
>  
> -	vgpio->lines = devm_kcalloc(dev, config->ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
> +	vgpio->lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
>  	if (!vgpio->lines)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < config->ngpio; i++) {
> +	for (i = 0; i < ngpio; i++) {
>  		mutex_init(&vgpio->lines[i].lock);
>  		init_completion(&vgpio->lines[i].completion);
>  	}
> @@ -319,7 +318,7 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
>  	vgpio->gc.direction_output	= virtio_gpio_direction_output;
>  	vgpio->gc.get			= virtio_gpio_get;
>  	vgpio->gc.set			= virtio_gpio_set;
> -	vgpio->gc.ngpio			= config->ngpio;
> +	vgpio->gc.ngpio			= ngpio;
>  	vgpio->gc.base			= -1; /* Allocate base dynamically */
>  	vgpio->gc.label			= dev_name(dev);
>  	vgpio->gc.parent		= dev;
> @@ -333,7 +332,7 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
>  	/* Mark the device ready to perform operations from within probe() */
>  	virtio_device_ready(vdev);
>  
> -	vgpio->gc.names = virtio_gpio_get_names(vgpio);
> +	vgpio->gc.names = virtio_gpio_get_names(vgpio, gpio_names_size, ngpio);
>  
>  	ret = gpiochip_add_data(&vgpio->gc, vgpio);
>  	if (ret) {
> diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
> index 844574acf095..0445f905d8cc 100644
> --- a/include/uapi/linux/virtio_gpio.h
> +++ b/include/uapi/linux/virtio_gpio.h
> @@ -22,16 +22,16 @@
>  #define VIRTIO_GPIO_DIRECTION_IN		0x02
>  
>  struct virtio_gpio_config {
> -	__u16 ngpio;
> +	__le16 ngpio;
>  	__u8 padding[2];
> -	__u32 gpio_names_size;
> +	__le32 gpio_names_size;
>  } __packed;
>  
>  /* Virtio GPIO Request / Response */
>  struct virtio_gpio_request {
> -	__u16 type;
> -	__u16 gpio;
> -	__u32 value;
> +	__le16 type;
> +	__le16 gpio;
> +	__le32 value;
>  };
>  
>  struct virtio_gpio_response {
> -- 
> 2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
