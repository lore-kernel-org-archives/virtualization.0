Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BD2C433F5
	for <virtualization@archiver.kernel.org>; Fri, 25 Feb 2022 13:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B07C540A54;
	Fri, 25 Feb 2022 13:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6uog2NCRSvWT; Fri, 25 Feb 2022 13:30:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8C4A4000B;
	Fri, 25 Feb 2022 13:30:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70450C0033;
	Fri, 25 Feb 2022 13:30:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEBEBC001A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 13:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EEFE40194
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 13:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LKUpLdu8227r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 13:30:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37A9E4000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645795838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgR1hZTpp5aLcG8iM+BJVGQ/aPOCjlXRhgyoKS95aU0=;
 b=Z3AwnS8U/yUiE4fCekIBxfpnBe3yermMwxQBudhsXsf5CDT1IyI56PpZuR89Iqw1vl4ByS
 C6Kho7MZxx72DuJI9EMCDC6q3/xdxZ+s0cHWjPVrK5hKWuOJHKgmouzy1UsTJP2zLFb3Ft
 I+q2v2MGJry8epM5i9pRiWUjkRzXBvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-_yXmxrWgNwOOLCe-at0gHw-1; Fri, 25 Feb 2022 08:30:37 -0500
X-MC-Unique: _yXmxrWgNwOOLCe-at0gHw-1
Received: by mail-wr1-f70.google.com with SMTP id
 w8-20020a5d4b48000000b001ef708e7f71so404423wrs.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 05:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=tgR1hZTpp5aLcG8iM+BJVGQ/aPOCjlXRhgyoKS95aU0=;
 b=x5K7nJuj9vdcBV84RuOub8QH5AhhtHpYv1ee3S1SwGOPKzo15/1xcGzrlJX9dOUt8w
 nBSd+oAyYrLcaJpKPhrdTOvpt5cwPpJDPyeh65F86RxPOTaFFZG66tnLVW1NyS+hQEA6
 qxxxTNnDh+Vftk8xh4MyzaKa730l+W4/7RRd6JsHglE5vHz+scrqp6EXLKOCayfD1Zcy
 FvMpzcCO+Lz3E+SkqFiK/cBvGND4U5AqhnNWvYRUZy+j57s192MDn+7rhYrh7RwHJHgi
 v5ld69LevLvgfZAQHW5BSnbOLT9q37/Fn3suC+oI3T8PtJE1Qyv6w0WrTZbqbKayJ4ms
 4FSw==
X-Gm-Message-State: AOAM531VPASV1MLK7prgIyCY5TBgw/r7oWC1v8EGR3gTKRTwGCOLYTpV
 gSXYMUFwspXUp43khdnN6/70Ilur6/J+yg0/aYqa9vLaYtkkgdEQyFpURJtLUtSTiOX6tz1ADaD
 gPn3L0Ss5qTjAYu/sZiye3TpzayMU5CKCYTptTOazRA==
X-Received: by 2002:a05:600c:5028:b0:380:e4f4:7743 with SMTP id
 n40-20020a05600c502800b00380e4f47743mr2712782wmr.114.1645795836638; 
 Fri, 25 Feb 2022 05:30:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxktPQsKtoT6b4UgB+rT37ddzU9CpROPcN405eOVwWCAiMBGmhGTic9fvRGGSeV5oOD4BtJyw==
X-Received: by 2002:a05:600c:5028:b0:380:e4f4:7743 with SMTP id
 n40-20020a05600c502800b00380e4f47743mr2712758wmr.114.1645795836321; 
 Fri, 25 Feb 2022 05:30:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:1900:f2f7:d2ad:80d9:218f?
 (p200300cbc7061900f2f7d2ad80d9218f.dip0.t-ipconnect.de.
 [2003:cb:c706:1900:f2f7:d2ad:80d9:218f])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a5d58f5000000b001ea99c3397dsm2383985wrd.21.2022.02.25.05.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Feb 2022 05:30:35 -0800 (PST)
Message-ID: <f87db49d-16f7-6607-35ce-9a2a9391c01f@redhat.com>
Date: Fri, 25 Feb 2022 14:30:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] virtio: drop default for virtio-mem
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20220225114801.47348-1-mst@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220225114801.47348-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

On 25.02.22 12:48, Michael S. Tsirkin wrote:
> There's no special reason why virtio-mem needs a default that's
> different from what kconfig provides, any more than e.g. virtio blk.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 34f80b7a8a64..492fc26f0b65 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -105,7 +105,6 @@ config VIRTIO_BALLOON
>  
>  config VIRTIO_MEM
>  	tristate "Virtio mem driver"
> -	default m
>  	depends on X86_64
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG

Yeah, why not

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
