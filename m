Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FBAC433EF
	for <virtualization@archiver.kernel.org>; Mon, 20 Dec 2021 15:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C32584064C;
	Mon, 20 Dec 2021 15:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9u5hBNSItjbl; Mon, 20 Dec 2021 15:35:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DE0B40643;
	Mon, 20 Dec 2021 15:35:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 056ADC001E;
	Mon, 20 Dec 2021 15:35:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F161DC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA3504156E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G5aXa9w6Ff-s
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CFD84155E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640014551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s0lGMD0pC7skWIYrRhVwKOPgTmBx4KUrBkR78qYxnqw=;
 b=aE2i3fF0gSE/adNGT206nyHGT8EhTXs7q1HrG0O79BvhT2NKrH4EPqerfl8okbrGH3O6NE
 3MEEFqvdns8wzb/MhNbNPYR4CmVPkpXjUnyifa41Vu5011cUIGTmhB0FhO5Ql5p95o5VO0
 U2JtZ+D7umP95nYjp6aaGZh/BN0bgUA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-VUKuUl2oNu-mIibAdE743A-1; Mon, 20 Dec 2021 10:35:50 -0500
X-MC-Unique: VUKuUl2oNu-mIibAdE743A-1
Received: by mail-wm1-f69.google.com with SMTP id
 b20-20020a05600c4e1400b003457da1c91eso1377111wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 07:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s0lGMD0pC7skWIYrRhVwKOPgTmBx4KUrBkR78qYxnqw=;
 b=1cypQdMpq28udBuZ260omY6g+8fhsEJPIpjz/qbmY1rME72oIcNpf6LIpLAdoxhPSP
 O5aLlWOT43uiF69YOS7QrBqI2exiO3ZcY2PF9q4ugrTOrJOoGms/iY0TXuGWveFGOwKX
 MTOEg9qv4FIEAospxWJAcwPwXKJKCRWrjT3KnKODr0hlwn4PWEWtkKVSODYVAE3rdTxL
 S2M0SPaK0fGbBfSI/dRBSoB1dAzAh2ADgQ3Au2MDCI3+59IbGWEx0fGS8eiBrXn0He9A
 0YPF6r10bsY3faikFgfHjKuKFtugfz0nNO2+SSTl+5i5FzWh/u/SOv68vrJsbftTPe40
 UU0w==
X-Gm-Message-State: AOAM531PcNpk0MkI/kEPQbIOFk1GYw9WUU5zaBVL+HiqWp+ORJui511T
 CAG188tGeZzYOLp460yka0a/RtVPrWkmBxSADRfE7HZrapVwXweab1n5X+9fSOLxm/KRbchRi4n
 IrpLHl6I7OQaRr4BSm2bvUhD2nBgw80BcGMw8e9+asQ==
X-Received: by 2002:a05:600c:1da3:: with SMTP id
 p35mr2388571wms.9.1640014549025; 
 Mon, 20 Dec 2021 07:35:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlGp7cXs8bcGDDTJ9A4ThRV7yXkHYo3y8iw5DiCoay9PJOvjvzhVsl1lQ5A8vn6i0apYrFCQ==
X-Received: by 2002:a05:600c:1da3:: with SMTP id
 p35mr2388548wms.9.1640014548781; 
 Mon, 20 Dec 2021 07:35:48 -0800 (PST)
Received: from redhat.com ([2.55.19.224])
 by smtp.gmail.com with ESMTPSA id b2sm7974828wrd.35.2021.12.20.07.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Dec 2021 07:35:48 -0800 (PST)
Date: Mon, 20 Dec 2021 10:35:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH] gpio: virtio: remove timeout
Message-ID: <20211220103537-mutt-send-email-mst@kernel.org>
References: <20211220130656.16900-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
In-Reply-To: <20211220130656.16900-1-vincent.whitchurch@axis.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-gpio@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, kernel@axis.com,
 Viresh Kumar <viresh.kumar@linaro.org>, "Enrico Weigelt,
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

On Mon, Dec 20, 2021 at 02:06:56PM +0100, Vincent Whitchurch wrote:
> The driver imposes an arbitrary one second timeout on virtio requests,
> but the specification doesn't prevent the virtio device from taking
> longer to process requests, so remove this timeout to support all
> systems and device implementations.
> 
> Fixes: 3a29355a22c0275fe86 ("gpio: Add virtio-gpio driver")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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
> -- 
> 2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
