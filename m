Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E436C433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 07:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B28BC60B00;
	Wed, 19 Jan 2022 07:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gp7920PMqcFx; Wed, 19 Jan 2022 07:39:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CFF260034;
	Wed, 19 Jan 2022 07:39:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20721C0031;
	Wed, 19 Jan 2022 07:39:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F48C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 07:39:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35C064014A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 07:39:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o_2J7VD0XdD6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 07:39:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFDDC404B7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 07:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642577992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pm415fzFdelJOBlcBSCGCChdw/UnK+ecr9X4JAIcA4k=;
 b=Nfs9eL5xr6HWQ/x+/vHV5EiaYsnZrNSGDoMIrix3f1yKLflx0xrF4ur2t1O+jyAp7RLEuN
 25J+KIlONy+EtPxXniKIZQDVtb3G8gJV3hCLMMGEeswbZUEIVkwE66qcwztuH72o1wWgY3
 brPTxKVxXwcMMCXVs6TCSY+L8d3iglE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-PQ6S6VeRPOKidbYt11vsgA-1; Wed, 19 Jan 2022 02:39:51 -0500
X-MC-Unique: PQ6S6VeRPOKidbYt11vsgA-1
Received: by mail-wm1-f71.google.com with SMTP id
 f7-20020a1cc907000000b0034b63f314ccso1276293wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 23:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Pm415fzFdelJOBlcBSCGCChdw/UnK+ecr9X4JAIcA4k=;
 b=lCh0km8CtRkUBaLbOzYzAgpuudQ4YP8sDjOXjBn0cpxhWMYG0llDGBjyTrD3yjonbD
 ZByaxYi7ZymsVfhz3AQVRw3VihLNG1K6YySb48eglRk/d4D3fuXq0pmwSmMMU/wSUFsm
 SexbmJayIZa/bgQWZqLUrhYhRhqZd6FsjZRqkG2Gcy+GbAQ5RVDXsYdB5khoL28h8zUe
 eqOJHWo4T3mxXNykn47zGVb/LktqWNziCFO7Mw9L5d2MzJNwxKZq6XXETTM9BYdf3MRy
 2QMxm171bVC+mt84/nwjFqWhaoWc8bqS1JQsXNHOK7vvHoVm/Ze4upBzgDa6qzWitIGv
 6ZeQ==
X-Gm-Message-State: AOAM532VEnKnpWQUCx4qTbCXx9sVS/9i9+z8FpLuK6GuCQRrKRKP9A84
 Q8AmGHkwyVokOnH5RUu98gITf8IZ5vXGPh6XGc5LxX1wadczCfd2z6e6O+KYpEbnMOsQncafAyh
 T9+h5jVG4bKZSEDwmbNMcytmfyia1aFzGaORrhQWj/w==
X-Received: by 2002:a05:6000:1843:: with SMTP id
 c3mr19264847wri.396.1642577990239; 
 Tue, 18 Jan 2022 23:39:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiKEl9fxKaEjPKZnZJ3J9IO9QNsgRqzuTCYl5LMjr6eqmOVpgr0AX4Jan/NOua8vCfHgMT9Q==
X-Received: by 2002:a05:6000:1843:: with SMTP id
 c3mr19264825wri.396.1642577990011; 
 Tue, 18 Jan 2022 23:39:50 -0800 (PST)
Received: from redhat.com ([2a10:800a:d5d2:0:e15:a8d2:6b84:b530])
 by smtp.gmail.com with ESMTPSA id l13sm1206270wry.84.2022.01.18.23.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 23:39:49 -0800 (PST)
Date: Wed, 19 Jan 2022 02:39:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3] drivers/virtio: Enable virtio mem for ARM64
Message-ID: <20220119022611-mutt-send-email-mst@kernel.org>
References: <20220119010551.181405-1-gshan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220119010551.181405-1-gshan@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jonathan.Cameron@huawei.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Jan 19, 2022 at 09:05:51AM +0800, Gavin Shan wrote:
> This enables virtio-mem device support by allowing to enable the
> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
> architecture.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v3: Pick ack-by tags from Jonathan and Michael
> ---
>  drivers/virtio/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 34f80b7a8a64..74c8b0c7bc33 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>  config VIRTIO_MEM
>  	tristate "Virtio mem driver"
>  	default m
> -	depends on X86_64
> +	depends on X86_64 || ARM64
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>  	 This driver provides access to virtio-mem paravirtualized memory
>  	 devices, allowing to hotplug and hotunplug memory.
>  
> -	 This driver was only tested under x86-64, but should theoretically
> -	 work on all architectures that support memory hotplug and hotremove.
> +	 This driver was only tested under x86-64 and arm64, but should
> +	 theoretically work on all architectures that support memory hotplug
> +	 and hotremove.
>  

BTW isn't there a symbol saying "memory hotplug" that we can depend on?


>  	 If unsure, say M.
>  
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
