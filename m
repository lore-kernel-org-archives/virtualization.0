Return-Path: <SRS0=x/cL=HV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC7C433DB
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 15:38:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3520764D73
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 15:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3520764D73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D1724870EC;
	Fri, 19 Feb 2021 15:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n8T-SDfH7Fng; Fri, 19 Feb 2021 15:38:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 860C186A7C;
	Fri, 19 Feb 2021 15:38:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AE24C000F;
	Fri, 19 Feb 2021 15:38:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E66CDC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 15:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2D0D60672
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 15:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRHol1lc09E1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 15:38:31 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id EB2B0606E5; Fri, 19 Feb 2021 15:38:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69B9060672
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 15:38:30 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id b8so5415909oti.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 07:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ihPA8hy6GvVU9f6zLgqzz3UOeoNDLbARu/XCfCJjyE=;
 b=NVMCAunpJMFHzOKfnav/QtH44HhbKEhBVE5pNiUdXmyTtF06iIssusgGbV++isqMRX
 EsmQgwsG130rfYiKtAIS7R16OGktrxuijCB4IPHdb9E62qRRWi7zyqPQC0OsTFV3QN0W
 dGA5Ve9iTGy5X/Ak6Kba0ymhH1WuzL943LQ07DPDQiWL+U50m6HLFX+n2aFHs15MijG6
 c0kl84660aqgM7iwX4NuBspu0fMFBLbPdhuKA0e7ZTjAs4gnXeHzMaLYIWX9Z3N8WaZM
 TV+aZsSnsnToncn8L9hb0zC2bS3UPUGxPzgMsx+YgnOIL/lH34MnhhdyyP7zlD2xU7RN
 alUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3ihPA8hy6GvVU9f6zLgqzz3UOeoNDLbARu/XCfCJjyE=;
 b=CNOhOAznttyy6lRvguKCckHD4+lbiCxngl0wepLQ7jLH6BJJHdoxfIAGjmKeYm4ODc
 cXD3yR+tt9RwQm5KZV/EtQzFzxcNs1z1/fpBoL1cVqSLkStQs9aKwbSsiiBO16Bu5sko
 b5TRFEMnL4ipYkEnRvZWJELppM+4N0BZ5XFVj1dzNQTU5xYf5PfjWnxRJasfHMlvi/4v
 9E7BNERpjmcDFBgC1nIK3LYSq9cXI9JiIE8rCUjaPebbp68JmK9nEt/501a0jGQ4vm6E
 uz18DS1eWhLt2cacBqivYoCI4YUxZsEQ65ZjkvtpjXPWVHGddBd3GTm32GhW5xC5V8Mq
 qH3Q==
X-Gm-Message-State: AOAM533MvSqfBdFV+d/s3L4mVwdJbvD1lbZpWumkgbaEJ6kfXh/SqozZ
 SXa+NntozUDQ3BEzn3Kkui4=
X-Google-Smtp-Source: ABdhPJyMFvtYgFBdKCHUxhbhM55j1T2Hl/4pzxqA9kR7fx3a4gpD/ee4cTg6c6u2VgFBpy7rUh3Gxg==
X-Received: by 2002:a05:6830:119:: with SMTP id
 i25mr7254443otp.107.1613749109467; 
 Fri, 19 Feb 2021 07:38:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 w127sm1889177oie.29.2021.02.19.07.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Feb 2021 07:38:28 -0800 (PST)
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
References: <20210219084509.48269-1-jasowang@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4b2378d8-0061-c6ed-f377-492649869581@roeck-us.net>
Date: Fri, 19 Feb 2021 07:38:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210219084509.48269-1-jasowang@redhat.com>
Content-Language: en-US
Cc: Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
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

On 2/19/21 12:45 AM, Jason Wang wrote:
> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> lot of confusion. E.g it may break various default configs which want
> virtio devices.
> 
> So this patch fixes this by hide the prompot and document the

... by hiding the prompt and documenting ...

> dependency.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/virtio/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 6b9b81f4b8c2..be7df369bc2b 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -13,12 +13,12 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>  	  VIRTIO_F_ACCESS_PLATFORM
>  
>  config VIRTIO_PCI_MODERN
> -	tristate "Modern Virtio PCI Device"
> -	depends on PCI
> +	tristate
>  	help
>  	  Modern PCI device implementation. This module implements the
>  	  basic probe and control for devices which are based on modern
> -	  PCI device with possible vendor specific extensions.
> +	  PCI device with possible vendor specific extensions. Any
> +	  module that selects this module must depend on PCI.
>  
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
> @@ -28,7 +28,8 @@ if VIRTIO_MENU
>  
>  config VIRTIO_PCI
>  	tristate "PCI driver for virtio devices"
> -	depends on VIRTIO_PCI_MODERN
> +	depends on PCI
> +	select VIRTIO_PCI_MODERN
>  	select VIRTIO
>  	help
>  	  This driver provides support for virtio based paravirtual device
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
