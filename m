Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D8C433F5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 04:15:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974BB610E9
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 04:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 974BB610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F7EB6077D;
	Mon,  8 Nov 2021 04:15:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpzkJ1NzImvr; Mon,  8 Nov 2021 04:15:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F3BA605CC;
	Mon,  8 Nov 2021 04:15:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D285FC0012;
	Mon,  8 Nov 2021 04:15:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E83BC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 04:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65CB540226
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 04:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XqvRtzIh2xhp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 04:15:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9A6040224
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 04:15:45 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id r28so14033201pga.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Nov 2021 20:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ow3kGxYLNyC9HLIHc8ZxwibYPx3dM7u/6WgOPxoycOY=;
 b=hHMIXEwywC4KIIcQTyM84LrwKvo0ZqVFVCZyZ3zsYzUh8HbqDoMcVOpiienrfq12D8
 xi0CV1k9a4sv5Q5WEj3X8+uC2l0CdHdSipai3N4MZ04/hGZKDyuIXNzCIciAOnJH17GP
 wWUqQrLxozORex1MMIfW4QO9UL4Wj2vRuSWb7jQ1OkcOwMC2YKZFg6deH2OALV1Jcmvv
 NktFVMtu6Ag4ALAeGCqLhZgl+b8yytLE8FfIfaKYbN7ham6klAxxbVDVF8Jic+75yHbM
 c4A92SQLr6n749h08SAh91JLDGPwTi8gIf7rpf65FwTM1tUK6nxS4tRP+LYsE09ZGIT+
 1LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ow3kGxYLNyC9HLIHc8ZxwibYPx3dM7u/6WgOPxoycOY=;
 b=4MWJ9VCZmfW7VSsndWQCiu6l/k0AwYjUStCt7rFlYBVslaBBBk9kXDJ2cINYI96uyP
 6WYgYeZDeFBNaWtDy0tzwfN/ytdDIXXV1C1wmPPLA2NKds8rZjmBOnidp2elmCzm+KV4
 MuP/TWjmf8ln/w0SynS9pcZYgnhq8spYUTAylLk0XRWZkO9IsyNpEj28EsCETvqichVt
 aCj6Mx3jBMuVMKCUeuQql49dKgMU5oLPj33qbfISxneK2Th9OmTwSfYrGMI+9mDvGa9i
 5XyHC9w+LJkIeJQsnftFHky9u9Nc2aX5if1Rh+9cnB4lroTdJb9uIJewfC7jmeX+2DtK
 OyvQ==
X-Gm-Message-State: AOAM530+lxLe1GhaV/M98AB+xpG4QrUPTrskk/xHvUFvlhACWgJGeEgM
 BepVKqsbYsaeRzdzK6HB1PvMaQ==
X-Google-Smtp-Source: ABdhPJw03Vh40n48feQuJ7VhZZRb8hZlAw4Q421T71CKIYSr2dlumNMItyAlVZWpDNqfvuu93XJpTQ==
X-Received: by 2002:aa7:80c5:0:b0:480:4fc5:a531 with SMTP id
 a5-20020aa780c5000000b004804fc5a531mr64855837pfn.52.1636344945089; 
 Sun, 07 Nov 2021 20:15:45 -0800 (PST)
Received: from localhost ([223.226.77.81])
 by smtp.gmail.com with ESMTPSA id e14sm4521443pfv.18.2021.11.07.20.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Nov 2021 20:15:44 -0800 (PST)
Date: Mon, 8 Nov 2021 09:45:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] gpio: virtio: remove unneeded semicolon
Message-ID: <20211108041542.vhznujep4qgm7hv3@vireshk-i7>
References: <1636344232-56537-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1636344232-56537-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: vireshk@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
 info@metux.net, brgl@bgdev.pl
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

On 08-11-21, 12:03, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/gpio/gpio-virtio.c:437:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpio/gpio-virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index aeec4bf..84f96b7 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -434,7 +434,7 @@ static void virtio_gpio_event_vq(struct virtqueue *vq)
>  		ret = generic_handle_domain_irq(vgpio->gc.irq.domain, gpio);
>  		if (ret)
>  			dev_err(dev, "failed to handle interrupt: %d\n", ret);
> -	};
> +	}
>  }
>  
>  static void virtio_gpio_request_vq(struct virtqueue *vq)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
