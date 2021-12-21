Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E9EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 04:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A221740285;
	Tue, 21 Dec 2021 04:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PtdODWeglkOc; Tue, 21 Dec 2021 04:26:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3389040274;
	Tue, 21 Dec 2021 04:26:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05A1BC002F;
	Tue, 21 Dec 2021 04:26:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3944C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 04:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E71860E88
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 04:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xnp7ZLxGv4L
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 04:26:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC2A660E83
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 04:26:14 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id b22so5778026pfb.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 20:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=o5xgDMJ+wA2AyFoIMAcbqy3DgLh40+fFYdFo8qBjJE8=;
 b=fkWX4FE2fKrGc6jIjzKBmNKopUVPnx18uxX1pok12ZjhvxhROZb1GWoV7T1MvpBudt
 6LHtXXg3Dpq54L43Wbbh0IFlLECarR9vn4gzWVGlxCL+05x4ZUchsuSf3HtjEwXEchJs
 wT7cfIKPEEchrPfwStWJcDb16pM6OULVQjtxnhl1hCls1CblwwWetho8UJoQwN/7K52j
 teHRSPOW+R8nb61KTxIg/N8XuATrU4Mikrjzst6vSYHd/ixBwH27C4ih/CH+CvTDWPoi
 aCQGd31zo9gDEYXil4snjCsnNhQUDrRrTevLWe2cnYL1SEus0alZW3o1AHN+QGcuodXS
 DAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=o5xgDMJ+wA2AyFoIMAcbqy3DgLh40+fFYdFo8qBjJE8=;
 b=TaDm0NStPKk7WDaE8APUJ3GcpeWHQlESrsg/O88CJxnPrzmaORpEU7Z1pUTlfKtocq
 xh7yt/sOoE20M4HEOQ9C8cf+438gd001laBcakURqN5bWb5YknvVOhbsMRfkIOwH4FhB
 mVCm9vfS0o12aZFiHsfI/gj0B8JS/+cPm+ucx2ACdJDre2o2b7Qlm1PLqyHas9zfQTjF
 JhoL27QnplUcPO+NU+4LZ3+JhvjB22QAToS+7dTnQDVCoeEeGKOPdcaqMbjm1Kx+Ho2E
 JVA471miv9QGa1iYOVeNCbgSerVG16NaUeNVLqCXZyeg2jcHjDNlyY/9ZrZoMjlg6cBs
 //Gw==
X-Gm-Message-State: AOAM533GwOxp6ydqXE9nPe6K6TEVnbfjoG5RVgIXJK/tLDO5jY284twW
 X4uWiDEKsf+MkirfCU41kJ24xQ==
X-Google-Smtp-Source: ABdhPJztA7MLr2E6odObLfxQK6j2NDLvXaQUVbwCfwZV8inZmomln2BM1g3CwJ4xazgwkg1+6VwdeQ==
X-Received: by 2002:a05:6a00:1792:b0:4ba:c60b:a63a with SMTP id
 s18-20020a056a00179200b004bac60ba63amr1422411pfg.0.1640060774320; 
 Mon, 20 Dec 2021 20:26:14 -0800 (PST)
Received: from localhost ([106.201.42.111])
 by smtp.gmail.com with ESMTPSA id ls6sm986959pjb.33.2021.12.20.20.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Dec 2021 20:26:13 -0800 (PST)
Date: Tue, 21 Dec 2021 09:56:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] gpio: virtio: remove timeout
Message-ID: <20211221042609.zeo6ci45sxzjxgrt@vireshk-i7>
References: <20211220130656.16900-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211220130656.16900-1-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: mst@redhat.com, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, kernel@axis.com,
 linux-gpio@vger.kernel.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bartosz Golaszewski <brgl@bgdev.pl>
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

On 20-12-21, 14:06, Vincent Whitchurch wrote:
> The driver imposes an arbitrary one second timeout on virtio requests,
> but the specification doesn't prevent the virtio device from taking
> longer to process requests, so remove this timeout to support all
> systems and device implementations.
> 
> Fixes: 3a29355a22c0275fe86 ("gpio: Add virtio-gpio driver")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/gpio/gpio-virtio.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 84f96b78f32a..9f4941bc5760 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -100,11 +100,7 @@ static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
>  	virtqueue_kick(vgpio->request_vq);
>  	mutex_unlock(&vgpio->lock);
>  
> -	if (!wait_for_completion_timeout(&line->completion, HZ)) {
> -		dev_err(dev, "GPIO operation timed out\n");
> -		ret = -ETIMEDOUT;
> -		goto out;
> -	}
> +	wait_for_completion(&line->completion);
>  
>  	if (unlikely(res->status != VIRTIO_GPIO_STATUS_OK)) {
>  		dev_err(dev, "GPIO request failed: %d\n", gpio);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
