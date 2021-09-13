Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E6C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 20:24:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3417610F9
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 20:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3417610F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C07B607CC;
	Mon, 13 Sep 2021 20:24:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AoEyRidjtwNm; Mon, 13 Sep 2021 20:24:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D1163607AD;
	Mon, 13 Sep 2021 20:24:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A010CC0011;
	Mon, 13 Sep 2021 20:24:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82E8DC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BB984033F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BkcM0CoZD7q8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:24:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39016402F7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631564644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhPD0uUD31I/CKuX1ZppKPQ477bEoW/ZxvwAE00nVcg=;
 b=GtumtC5Y7X1IXmNlVTCC/WxDY62tfTkYFrAwe8+TnWHO40Rbt9Z/ZM4NjVQjg+PeX1CgIi
 P3IwRcGrMBq/ErZjJLLkyqZdrqQhfZ+Ld415iJJjP8+QX9wJfCRiYPzlIfF9Akces9LBbT
 8vme7MV9X2zBItQHkJBmDc4T20pbxvo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-XgFSa70NPgWtwWrAqo4t6w-1; Mon, 13 Sep 2021 16:24:03 -0400
X-MC-Unique: XgFSa70NPgWtwWrAqo4t6w-1
Received: by mail-wm1-f70.google.com with SMTP id
 z18-20020a1c7e120000b02902e69f6fa2e0so5398923wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 13:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NhPD0uUD31I/CKuX1ZppKPQ477bEoW/ZxvwAE00nVcg=;
 b=CRssmXRAwIzAOcDZMMzeijf57XxBQsbQS+Ql0jgrPcgKK/2YfcDu/ULn6jWX1f1XIw
 tpzU0ZovX2IE9oqpSZlbXTzyTB3ZybIjs4/YLTivv3sz5Y5vXz9idEZF1qOzWe3R8Gl+
 1rgihVpWxg/m6SGRpO2Hm0U8vZnFgkVi8EFDAaOqTHnE+93URFfTbqOLmj9FyuAezz9Q
 ZsIWwwv0J+gEmo07Oc9/AwZIvz95puovtJ1p1tpq7nUPZV3rWuYZRTv/E9rR8o1y1hxP
 t4698of7Ib/5VNqrnjyRTlBCLcZxsnOHbDrUvq3zyjjM0NFcupAgQk8i+QeucwZA2Xrd
 MSqQ==
X-Gm-Message-State: AOAM532KLbQxFRmCf2yFJwO8A7FW3FZ7FccFngRDcGB49TREZBrfl49P
 OWszs0x1mjWUIi/guaqZaHSPK74Bx9ST4p27LyUTApc7ARW31V5Fdl80WWNmP2SMydwcbvVaHtf
 3+Aa22vGdcRxwIG2AXZWi33y2k92a7kpMAE4vr5rJgQ==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr15678742wra.216.1631564641944; 
 Mon, 13 Sep 2021 13:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ4VPgchaH0UTtSoQXdz3pY1CJwy3IEzUFNkJqC0hstFpyRondLeVvmI4fHJvgYlZOixZWGg==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr15678716wra.216.1631564641742; 
 Mon, 13 Sep 2021 13:24:01 -0700 (PDT)
Received: from redhat.com ([2.55.151.134])
 by smtp.gmail.com with ESMTPSA id j98sm8615187wrj.88.2021.09.13.13.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 13:24:01 -0700 (PDT)
Date: Mon, 13 Sep 2021 16:23:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] virtio: don't fail on !of_device_is_compatible
Message-ID: <20210913162308-mutt-send-email-mst@kernel.org>
References: <20210913104640.85839-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210913104640.85839-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Bill Mills <bill.mills@linaro.org>, Guenter Roeck <linux@roeck-us.net>
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

On Mon, Sep 13, 2021 at 06:47:52AM -0400, Michael S. Tsirkin wrote:
> A recent change checking of_device_is_compatible on probe broke some
> powerpc/pseries setups. Apparently there virtio devices do not have a
> "compatible" property - they are matched by PCI vendor/device ids.
> 
> Let's just skip of_node setup but proceed with initialization like we
> did previously.
> 
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---


Guenter could you take a look at this patch pls? Does it help?



> Arnd could you help review this pls? Viresh is on vacation.
> 
>  drivers/virtio/virtio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c46cc1fbc7ae..19a70a2361b4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device *dev)
>  	ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
>  	BUG_ON(ret >= sizeof(compat));
>  
> +	/*
> +	 * On powerpc/pseries virtio devices are PCI devices so PCI
> +	 * vendor/device ids play the role of the "compatible" property.
> +	 * Simply don't init of_node in this case.
> +	 */
>  	if (!of_device_is_compatible(np, compat)) {
> -		ret = -EINVAL;
> +		ret = 0;
>  		goto out;
>  	}
>  
> -- 
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
