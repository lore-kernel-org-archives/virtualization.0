Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC94EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 20:53:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8DA610F9
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 20:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F8DA610F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11628400FB;
	Mon, 13 Sep 2021 20:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BHDzIB4L--9G; Mon, 13 Sep 2021 20:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9934140082;
	Mon, 13 Sep 2021 20:53:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71238C0011;
	Mon, 13 Sep 2021 20:53:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C55FC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A29D80DB2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lLF0i5zTrziw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:53:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51C9A80DAD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 20:53:27 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 y47-20020a4a9832000000b00290fb9f6d3fso3847571ooi.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eowsm0WXQayq+f9h1wgvwR/JZtrOX+En4eFl7+WOlJs=;
 b=g5uzMEgnMFOubg6Z8h0lpgOqktkRalXsNb3Mt7L1Ph2REfEY4vab+FDFNdC6yS2cge
 K24dMT291o9tC2ixgmOZR4sFmqurRXf+uEmV3d/WwTVSpp5hx1aHRYl6LOYWoAg4DpZ8
 lJ8Vm88ntwrJjaId0AqE9wYlifbt5NvWlhw+RWYHBG2yHbbnQtrs2GEF/mwuF+SXzoIw
 hXVq27QMLtMrk8yIkVNvd0O4xD9DS0DgDAkUNIEvyELLSqsyhUdaYkqG+UEq39ZUlwXe
 XxgAFyar7gckkiu/ZFJvi/fbaV5qGM8QNCumjsH/d2TMNOTNI3OR7xX99kGaWXuEzWIz
 E0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=eowsm0WXQayq+f9h1wgvwR/JZtrOX+En4eFl7+WOlJs=;
 b=JMYBugXxnCNqayGmrbqZI5XblwuYUXWNp5C2z8Xr/hG5ZKbUV655yzkx3oDDgG2XLd
 9rnv+suZ3qNaX2zsCZKf2lxcn1kLfj36MbmnDL9ZiN1XZX/rfrCvDzBiy8tcXko1np+J
 FciH3QqAebZvtP1hQiR0YPwWu7PAU8JCdthiN8mpUVNbfbc20DWbXhtdoqhsOO/p4nOL
 3Dkdrf5fFQ++cgT8hZQpSWLQMTKA/ULlB1VVYXSWkBDwrAsLohhsYYioanGCeVADkTbJ
 4x+LhX4oFw41oehtux0ipDZ+1ZOmkKKS7eExx9pPG/+pTKXbdFPMHGNzsG57Pz0arEBr
 slOQ==
X-Gm-Message-State: AOAM5318h6gzWL3bP2qxmwXJVRRT4/1TYTJvrz9zVpX7F85tMD8/CR+l
 6Sf8eojU0twKP6bzapfCmzI=
X-Google-Smtp-Source: ABdhPJwLuPVzLTHtC96D5WTpwJctZ5+XjhCzJhzFN7Xv1kWCz8/WlSYJUBNBwuzZySkRTQGmvjsbYA==
X-Received: by 2002:a4a:800e:: with SMTP id x14mr10837623oof.80.1631566406399; 
 Mon, 13 Sep 2021 13:53:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 m2sm2120794ooa.42.2021.09.13.13.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 13:53:24 -0700 (PDT)
Date: Mon, 13 Sep 2021 13:53:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: don't fail on !of_device_is_compatible
Message-ID: <20210913205322.GA1076369@roeck-us.net>
References: <20210913104640.85839-1-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913104640.85839-1-mst@redhat.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>,
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

On Mon, Sep 13, 2021 at 06:47:46AM -0400, Michael S. Tsirkin wrote:
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

This patch also fixes a similar problem seen with sparc64.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> 
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
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
