Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FD4C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 08:28:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA0D233FA
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA0D233FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8ABCE864D6;
	Wed,  9 Dec 2020 08:28:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yzBM5hM5Y4yc; Wed,  9 Dec 2020 08:28:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5F403864A6;
	Wed,  9 Dec 2020 08:28:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F2E7C0FA7;
	Wed,  9 Dec 2020 08:28:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0F13C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AEB58873C3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:28:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UWHX5jNtAvEk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:28:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4A337873C2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607502521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TY8/pWIgcIz+C6jRI22Ls6KSQPYFbL8dVJN418r6j6I=;
 b=jJ9I9aKbycr9nk7TkUmta00cX9/8eANrAFlgANk2JXaO6JceIS7k0kLYW0EIq5ZTU2yWmY
 bWjgPS1KX8kwr6RUSDAM2rwxhQB27alGFNwil2cwFEgGGeLj9AdwFZHJIZwPrVI6xwP2aR
 EDBoPQlUEMlCqUB6/1I6sPXux5UKz3Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-EsgKEdCdMF6szte8J1MD1g-1; Wed, 09 Dec 2020 03:28:39 -0500
X-MC-Unique: EsgKEdCdMF6szte8J1MD1g-1
Received: by mail-wr1-f70.google.com with SMTP id n13so364130wrs.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 00:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TY8/pWIgcIz+C6jRI22Ls6KSQPYFbL8dVJN418r6j6I=;
 b=KjHbLOj2eUJTfuGtLYkH1hhJC2QQi1FSA5bkLLK37XvmUpb3icpab6nEwYNNm/jwIp
 KKT4cpKVEPWHD+lwsXa039qqxZYxoOy16PXMZvmXHZH/jE7O/ok4TFrfIl6KzVksc3+D
 I53VojFrm1S6qg5xbH4VGa4bMjjVWGRWJpWq1mNuQ8XharxGqDqlx2kPWOmE0/6BXeLG
 lFzpnGUwc4inEcrQxPAnHkjYZLlMG5qfktasYGlm1oV4zHeOZaDEI7yUyhmDquSlTfFN
 f6oz3vG8+8aVUKeCvwUoP4XvFwXQszDZ2YPscoFKpTf7MDQQtMQcxiEqP2R70SI1K9wC
 xvFw==
X-Gm-Message-State: AOAM530lsehYU6wqeTL/0SMCQO5jsRSo9NHuTtMQKkIuoDfKFHay/LD8
 yUefuXOC2DUMXc/90QGAYnRCyYTcOkhjmv0OR45vl4LOjE+aVBP+otFTE1Us3/fzhYDgm3EBR6s
 yrd0Q4x4u7EO+58s2Cpb1VWGSV7Yw6VPIZoZyA7FTzg==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr1258057wro.415.1607502517428; 
 Wed, 09 Dec 2020 00:28:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxH6Do+31Svbm6gZcmCgYjugWGzqIMTR6tBXYz8WhylY3W/V+37vUvxCwZh+NfQ/MkOY6D7Mg==
X-Received: by 2002:adf:ecd0:: with SMTP id s16mr1258052wro.415.1607502517272; 
 Wed, 09 Dec 2020 00:28:37 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id u6sm2188084wrm.90.2020.12.09.00.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 00:28:36 -0800 (PST)
Date: Wed, 9 Dec 2020 03:28:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Subject: Re: [PATCH RESEND v2] virtio-input: add multi-touch support
Message-ID: <20201209030635-mutt-send-email-mst@kernel.org>
References: <20201208210150.20001-1-vasyl.vavrychuk@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20201208210150.20001-1-vasyl.vavrychuk@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Mathias Crombez <mathias.crombez@faurecia.com>, linux-input@vger.kernel.org
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

On Tue, Dec 08, 2020 at 11:01:50PM +0200, Vasyl Vavrychuk wrote:
> From: Mathias Crombez <mathias.crombez@faurecia.com>
> Cc: stable@vger.kernel.org

I don't believe this is appropriate for stable, looks like
a new feature to me.


> 
> Without multi-touch slots allocated, ABS_MT_SLOT events will be lost by
> input_handle_abs_event.
> 
> Signed-off-by: Mathias Crombez <mathias.crombez@faurecia.com>
> Signed-off-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
> Tested-by: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
> ---
> v2: fix patch corrupted by corporate email server
> 
>  drivers/virtio/Kconfig        | 11 +++++++++++
>  drivers/virtio/virtio_input.c |  8 ++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 7b41130d3f35..2cfd5b01d96d 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -111,6 +111,17 @@ config VIRTIO_INPUT
>  
>  	 If unsure, say M.
>  
> +config VIRTIO_INPUT_MULTITOUCH_SLOTS
> +	depends on VIRTIO_INPUT
> +	int "Number of multitouch slots"
> +	range 0 64
> +	default 10
> +	help
> +	 Define the number of multitouch slots used. Default to 10.
> +	 This parameter is unused if there is no multitouch capability.
> +
> +	 0 will disable the feature.
> +

Most people won't be using this config so the defaults matter. So why 10? 10 fingers?

And where does 64 come from?


>  config VIRTIO_MMIO
>  	tristate "Platform bus driver for memory mapped virtio devices"
>  	depends on HAS_IOMEM && HAS_DMA
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index f1f6208edcf5..13f3d90e6c30 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -7,6 +7,7 @@
>  
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_input.h>
> +#include <linux/input/mt.h>
>  
>  struct virtio_input {
>  	struct virtio_device       *vdev;
> @@ -205,6 +206,7 @@ static int virtinput_probe(struct virtio_device *vdev)
>  	unsigned long flags;
>  	size_t size;
>  	int abs, err;
> +	bool is_mt = false;
>  
>  	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>  		return -ENODEV;
> @@ -287,9 +289,15 @@ static int virtinput_probe(struct virtio_device *vdev)
>  		for (abs = 0; abs < ABS_CNT; abs++) {
>  			if (!test_bit(abs, vi->idev->absbit))
>  				continue;
> +			if (input_is_mt_value(abs))
> +				is_mt = true;
>  			virtinput_cfg_abs(vi, abs);
>  		}
>  	}
> +	if (is_mt)
> +		input_mt_init_slots(vi->idev,
> +				    CONFIG_VIRTIO_INPUT_MULTITOUCH_SLOTS,
> +				    INPUT_MT_DIRECT);


Do we need the number in config space maybe? And maybe with a feature
bit so host can find out whether guest supports MT?

>  
>  	virtio_device_ready(vdev);
>  	vi->ready = true;
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
