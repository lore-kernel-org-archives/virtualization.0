Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E574C433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:34:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405BA60F6F
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 405BA60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0693D40284;
	Tue,  2 Nov 2021 03:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sOZox_AAHrBv; Tue,  2 Nov 2021 03:34:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7222E401CA;
	Tue,  2 Nov 2021 03:34:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48CB5C0012;
	Tue,  2 Nov 2021 03:34:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38683C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 273B86077C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UU2Xv2Q5wbAO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:33:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99DBA6059D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:33:56 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id p18so10559594plf.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 20:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9wL6e6Rl6omDkjcl8QpQbRrkQlAk7mdAPYBPin+CVyw=;
 b=sr9LMU/0B9YZmnps9ZwovfhG6XGReafmiDTIHlX7hKnopo1nuSLxf60/tLBQZE9nyi
 YuKBQIyUOkLtGmCthfnxaNxHUlYhvle3LEAtlIN9WRM+05Swo6BlvUiABoEHgP9Z8Gye
 ZBEDZd2Hkpo4WBpOJppuL/YEqqCjv9IjlkGpgQopb7uPsTorsXXqZbgfRct8JHjqJsxS
 8hf2j/oOaBcRj8U3p2Hc6VwFozosrefUDG8YbOyM4p44zlvZyne4axnuuoEo1iGZ9fHv
 YdSbyBGEtUM4LCrA3axNztJNJlrvB8tWOhq23mA1FootsUHnSMq0P7Griia6WSuzjynW
 rbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9wL6e6Rl6omDkjcl8QpQbRrkQlAk7mdAPYBPin+CVyw=;
 b=ELLbkCRFQ4WIMxZ+mtQZnTQ0eZUFlxV3CoCLAGxrXiN9EAuJeyU/dMgkgK3gvPnaIA
 NBJwAx9kwiulU0TXN1vIL1zrbamIDo4tZWufR5Z5R+AsfZIlAyLqWM3MQRrfg9ei/xYx
 xtdSOP8jiTz3uWjlHxA4msS/hKmHvcUyknf0HqTpVUYYkmjOy9qhWHLFLRvImPZDxoCJ
 498bI7knmIlLJgRvsk3fX9ZU4QnIs9jPIOpNuNsIouibnMcclaURqoB1FgTNdNHQE303
 AkPupnwqRpjEYPoUfMdpfpHLDfUjRBcbCf4BMEgj4zzgy3re50/DwO9qqvv3OZsUF2iR
 rCLQ==
X-Gm-Message-State: AOAM532rFfPSNRYNFTZ97ytMG8RurK/pkj/8zLmWuB5Lb710yGvlHse0
 azJccpaSpIsqBydM+oBPjU7kDA==
X-Google-Smtp-Source: ABdhPJx4N2536lXrqEoILHMVErOOpiqbnJ3ORZ+r+y1oWUc8bc0saalhkhVXA+jDAws5J37zsepRfQ==
X-Received: by 2002:a17:90a:191c:: with SMTP id
 28mr3498852pjg.121.1635824036118; 
 Mon, 01 Nov 2021 20:33:56 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id j6sm14002047pgq.0.2021.11.01.20.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 20:33:55 -0700 (PDT)
Date: Tue, 2 Nov 2021 09:03:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_gpio: drop packed attribute
Message-ID: <20211102033354.rka35agybojk65n7@vireshk-i7>
References: <20211101091122.442512-1-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211101091122.442512-1-mst@redhat.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
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

On 01-11-21, 05:11, Michael S. Tsirkin wrote:
> Declaring the struct packed here is mostly harmless,
> but gives a bad example for people to copy.
> As the struct is packed and aligned manually,
> let's just drop the attribute.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
> index 0445f905d8cc..25c95a034674 100644
> --- a/include/uapi/linux/virtio_gpio.h
> +++ b/include/uapi/linux/virtio_gpio.h
> @@ -25,7 +25,7 @@ struct virtio_gpio_config {
>  	__le16 ngpio;
>  	__u8 padding[2];
>  	__le32 gpio_names_size;
> -} __packed;
> +};

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
