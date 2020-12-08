Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B571C433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B14222B3
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B14222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D9F8863AE;
	Tue,  8 Dec 2020 22:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzW5Faz3E7Lh; Tue,  8 Dec 2020 22:05:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D90F9863BB;
	Tue,  8 Dec 2020 22:05:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD5B5C0893;
	Tue,  8 Dec 2020 22:05:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95516C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 75464863BB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t5HS4g7gWBM1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:05:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4F33E863AE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 22:05:08 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id t6so59772plq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Tra63uwIyLsJwtX1u3hXTd1bJBVBw8bWS7b/2nj8Uis=;
 b=JQ92XDEmcQAJr26Axzo9FOro8etm0r+pxfkQFvW2d2TVOvXVe7cjUkmuKi7xE1r07v
 rd+wsEyp/7AlRoQnZTiDCzKMcNXU8z37fTGL3mgL93Na73gkHOs+gsGi77Bm4A2457QX
 nfOEfFp2QW2Qn+CcPFflymw7ePdFAc69xMav7GChPdgCy9tsEYs+EmilJNy5hMQT+5ai
 p4SQNkbR3N5FoKWEXhjtElZcOcE6OhlT1aDred22JDI8XMQoMUN0Lmuv462LgUkjSvRE
 LGAlrN+HvXvd2fqryslEhGO9Rzr+LHotuvUs8nj5/+tI3NwW/wb8pxc9o3HG/l62N0mC
 ps+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tra63uwIyLsJwtX1u3hXTd1bJBVBw8bWS7b/2nj8Uis=;
 b=pUrmIcrSfrfRdA6QhMXqVfDKPLPeC95x8FXhTIX4sxyxtwoAtzSGzm8PEO1ph9OL45
 6RDqSNu5O6fcLlU6dxlPTPSP0tUWcRlhKf2nwPpmhikv1NcV5xsXvnzhoputGfejBh53
 BRlBbRWogmR/LYMlPSyo7RMAQ9WRMhWljzEgDKBjSGBxJsdNbXvF2+DnbGQhni8Rufpt
 nU7QRpi7CGvKDDdcW9zYVcgswDMYlSutfCtl1WvG2xMB+a05Ud9KJ4izBgxs+uUsSqFJ
 yy+gHR4xHvQWJwyl/dJNHzNqO0Q7bdjM959/oulLXurydNa9yL1ch5TaMoJGqlXdZvBx
 r4xQ==
X-Gm-Message-State: AOAM533J/Ib8Gmh2NUqRTvbQHbdSeCiTJogAb6xZWUGo8uoMDedYs8Mz
 FF5PZLJpetxvao8HkD41muA=
X-Google-Smtp-Source: ABdhPJw2JQGo34OQaWVTGod6Ooa7QnINpqzAXi+d7MwBtU1Gw+7gJLjKoJcEj2mwcdJZlHSR/vvhhA==
X-Received: by 2002:a17:902:8f98:b029:da:fcfd:6e54 with SMTP id
 z24-20020a1709028f98b02900dafcfd6e54mr9740052plo.13.1607465107819; 
 Tue, 08 Dec 2020 14:05:07 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
 by smtp.gmail.com with ESMTPSA id w73sm131105pfd.203.2020.12.08.14.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 14:05:07 -0800 (PST)
Date: Tue, 8 Dec 2020 14:05:05 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Subject: Re: [PATCH RESEND v2] virtio-input: add multi-touch support
Message-ID: <X8/4kRLsr8755i01@google.com>
References: <20201208210150.20001-1-vasyl.vavrychuk@opensynergy.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208210150.20001-1-vasyl.vavrychuk@opensynergy.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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

Hi Vasyl,

On Tue, Dec 08, 2020 at 11:01:50PM +0200, Vasyl Vavrychuk wrote:
> From: Mathias Crombez <mathias.crombez@faurecia.com>
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

I believe the number of slots should be communicated to the guest by
the host, similarly to how the rest of input device capabilities is
transferred, instead of having static compile-time option.

> +
> +	 0 will disable the feature.
> +
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

Here errors need to be handled.

>  
>  	virtio_device_ready(vdev);
>  	vi->ready = true;
> -- 
> 2.23.0
> 

Thanks.

-- 
Dmitry
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
