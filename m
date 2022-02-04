Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7F7C433F5
	for <virtualization@archiver.kernel.org>; Fri,  4 Feb 2022 13:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 304AE60C15;
	Fri,  4 Feb 2022 13:24:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXJcC9wUSwey; Fri,  4 Feb 2022 13:24:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE17360BAF;
	Fri,  4 Feb 2022 13:24:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 919B6C0011;
	Fri,  4 Feb 2022 13:24:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38F8EC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 13:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12AB6404E2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 13:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhwrgNA3nTw0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 13:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92647404DD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643981082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7UKHH0LEkavlxiUm0dlyomqZecTKkmkM1AWd2rdM34w=;
 b=er9daQp5CYSJk3CPJ0EL3PyFCGa9B/cDCU3xBCDy2TM9HI53V+xVlkcMvIKCTATdJsapxK
 P3RQZJSQvzviVE6d3EPFVWmzC42ZiadL5DnupR7l66LLwZ+VE4UklocxJht7tL0RF1fIfr
 Zg7fLyZGLfc5Sp1f66qKpKS2yoqVPzI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-wSDY0lftOGOJ6EG_A-RHdw-1; Fri, 04 Feb 2022 08:24:41 -0500
X-MC-Unique: wSDY0lftOGOJ6EG_A-RHdw-1
Received: by mail-wm1-f71.google.com with SMTP id
 j18-20020a05600c1c1200b0034aeea95dacso7562317wms.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Feb 2022 05:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7UKHH0LEkavlxiUm0dlyomqZecTKkmkM1AWd2rdM34w=;
 b=WHUW7MF5rrjOLm7NYiSmOJ4xNl2IWfmCbDsCaWdYdjxycK8Z27HZ2Ar96wkdWS84DM
 Aeb12M1py1Bg16UtHjEaOZNklyEvsJjbxa85RrVaH/tWbQSB2+wR1LRLAnmYREkTJ9Mj
 V/7DFtWwc5mVrsyR8P1yZk6nJfYv2o70p1Ff0wNd6TraR+PmrJRKx37OhSLKVusbYy7z
 ElLRMOoerxFfrNnzwOJGAeYhDcjwZWE0FXjtdBNlXf+k/pA7AO9YcBQJrjB/940fBBQH
 aBBWenvoJtM8vRDGphjw/s73COQPd2KKr94b7Vk3ZaHivZTWlg3aHk+AeguOnx9iQpf+
 bSqw==
X-Gm-Message-State: AOAM530ogL1ofrGoFpjzusvg6yVKzhcy9iaB29jjyS/W3OOflZ7iUB2i
 p04xhwgKZuGOGOG1ddv1kvCain5nj+3AujxoLl2e/gFf0IqiEb5BrwvpFWA9e2e8SvTnl3zg689
 U6s8pAJeoQO9A0sGO7IfAQHNQ3P8dsJw9yEHs8jPv2g==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr2305911wmq.13.1643981080181; 
 Fri, 04 Feb 2022 05:24:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQbetRZY1dnqYN0HUwFi8p97h3dS54Ma4HeFNpc7P/IL6nCxE60R8MQ6sI+OMp4zgc3hHwlg==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr2305895wmq.13.1643981080003; 
 Fri, 04 Feb 2022 05:24:40 -0800 (PST)
Received: from redhat.com ([2a10:8005:331d:0:5c51:c095:613e:277c])
 by smtp.gmail.com with ESMTPSA id bh19sm3982968wmb.1.2022.02.04.05.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Feb 2022 05:24:37 -0800 (PST)
Date: Fri, 4 Feb 2022 08:24:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] drivers/virtio: Enable virtio mem for ARM64
Message-ID: <20220204082351-mutt-send-email-mst@kernel.org>
References: <20220119010551.181405-1-gshan@redhat.com>
 <20220119022611-mutt-send-email-mst@kernel.org>
 <d8cedad1-bbb6-b7ea-57b2-f3832776fe1e@redhat.com>
 <50422908-1917-bda9-ead5-40b02d57c545@redhat.com>
MIME-Version: 1.0
In-Reply-To: <50422908-1917-bda9-ead5-40b02d57c545@redhat.com>
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

On Wed, Jan 19, 2022 at 09:35:05AM +0100, David Hildenbrand wrote:
> On 19.01.22 08:46, Gavin Shan wrote:
> > Hi Michael,
> > 
> > On 1/19/22 3:39 PM, Michael S. Tsirkin wrote:
> >> On Wed, Jan 19, 2022 at 09:05:51AM +0800, Gavin Shan wrote:
> >>> This enables virtio-mem device support by allowing to enable the
> >>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
> >>> architecture.
> >>>
> >>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >>> Acked-by: David Hildenbrand <david@redhat.com>
> >>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>> ---
> >>> v3: Pick ack-by tags from Jonathan and Michael
> >>> ---
> >>>   drivers/virtio/Kconfig | 7 ++++---
> >>>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> >>> index 34f80b7a8a64..74c8b0c7bc33 100644
> >>> --- a/drivers/virtio/Kconfig
> >>> +++ b/drivers/virtio/Kconfig
> >>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
> >>>   config VIRTIO_MEM
> >>>   	tristate "Virtio mem driver"
> >>>   	default m
> >>> -	depends on X86_64
> >>> +	depends on X86_64 || ARM64
> >>>   	depends on VIRTIO
> >>>   	depends on MEMORY_HOTPLUG
> >>>   	depends on MEMORY_HOTREMOVE
> >>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
> >>>   	 This driver provides access to virtio-mem paravirtualized memory
> >>>   	 devices, allowing to hotplug and hotunplug memory.
> >>>   
> >>> -	 This driver was only tested under x86-64, but should theoretically
> >>> -	 work on all architectures that support memory hotplug and hotremove.
> >>> +	 This driver was only tested under x86-64 and arm64, but should
> >>> +	 theoretically work on all architectures that support memory hotplug
> >>> +	 and hotremove.
> >>>   
> >>
> >> BTW isn't there a symbol saying "memory hotplug" that we can depend on?
> >>
> 
> You mean
> 
>  	depends on MEMORY_HOTPLUG
>  	depends on MEMORY_HOTREMOVE
> 
> We still need a manual opt-in from architectures, because devil's in the
> detail. (e.g., memblock stuff we had to adjust)

Is there any chance of documenting some of this here? The current comment makes it
look like it's just a question of whitelisting an architecture.

> -- 
> Thanks,
> 
> David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
