Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425EFC433F5
	for <virtualization@archiver.kernel.org>; Fri,  4 Feb 2022 14:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D81C18186E;
	Fri,  4 Feb 2022 14:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8msE-HWgLjRN; Fri,  4 Feb 2022 14:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 844D48176A;
	Fri,  4 Feb 2022 14:04:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E9B8C0011;
	Fri,  4 Feb 2022 14:04:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F215CC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 14:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AFDA60D73
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 14:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o3VA-ucPk-2I
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 14:04:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CB6C60BAF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643983481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dhHL34Psp0pwbYF7exZZG4Gqg9pCmgThVyy3J5qSHYY=;
 b=IFog//yxG09vm11BpVdbuFo62E4/rxNPQyj1ziYddFnhGuKtYuMs/xhSodc5MRmpkkoH8L
 8/+0ULt0K+PlV6uDUxqA2mQ1y2VjpbBOi+7dzCpi2n1BLrJnTJxHgAr6FO00XKgkmOXfVu
 7+LIk6Mq6FSKR75bqKqVK12/KIaIJGo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-LbtdeoQrPSO6QDXoTyqyGQ-1; Fri, 04 Feb 2022 09:04:35 -0500
X-MC-Unique: LbtdeoQrPSO6QDXoTyqyGQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 g17-20020adfa591000000b001da86c91c22so2072213wrc.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Feb 2022 06:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dhHL34Psp0pwbYF7exZZG4Gqg9pCmgThVyy3J5qSHYY=;
 b=jQbIYWSlrtFXIqzXD/88Krjf3Vl1zLxYYewIcggayld9gWt34nHF2ocdJ1zeI/bbcK
 87zz7RZfYi3Kx8U6kjVGyhg3IHGU0ZjT1oFwU2cVT8bkeahKUv3rlUA3CC55c4Gv2uE+
 fPjkzGP3IRlEMa0ykjwOEp7wIftIbUlePsHmxixHfv3mIZLPoAAgAR3gQ8WTIKrrBi5t
 7+1F3Y+8oOyqLI8tBWLIvDW5zPtvMsxUQvFmPNEgyv+vhwL4cBpLaGKPJyYSG+HGwj84
 dnfPdo03xZ9k4tbl+I5sArUB6i7cctKhXhHZn27ifgv0XHVMkI6M77FcbgSq8b59JXr6
 Sucw==
X-Gm-Message-State: AOAM531viNkH5e1RTs6j0CDO9Hjb2PtlikzKOEAs8IhciknCujq1jh0Y
 vPGEnxZ+iwHHlUry1aVfK/swYWyP3lEzfDZV6bYurFEJxKQ92lI2lI8xCskTCNpMz4I8AGF4QAG
 9uS1kjA+NbtRt/jTCmbj+lxyT4B7F9Cu/7FMHjPxUSw==
X-Received: by 2002:a5d:53cf:: with SMTP id a15mr2522142wrw.677.1643983473772; 
 Fri, 04 Feb 2022 06:04:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcadfoic5rdfUrWllQhWy1oV/C9mCx3TDk+A6bCRYswI3m6CDaCKAd7jHrFWOa8CGe6Ce4fw==
X-Received: by 2002:a5d:53cf:: with SMTP id a15mr2522122wrw.677.1643983473509; 
 Fri, 04 Feb 2022 06:04:33 -0800 (PST)
Received: from redhat.com ([2a10:8005:331d:0:5c51:c095:613e:277c])
 by smtp.gmail.com with ESMTPSA id e15sm2308872wrg.6.2022.02.04.06.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Feb 2022 06:04:29 -0800 (PST)
Date: Fri, 4 Feb 2022 09:04:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] drivers/virtio: Enable virtio mem for ARM64
Message-ID: <20220204090403-mutt-send-email-mst@kernel.org>
References: <20220119010551.181405-1-gshan@redhat.com>
 <20220119022611-mutt-send-email-mst@kernel.org>
 <d8cedad1-bbb6-b7ea-57b2-f3832776fe1e@redhat.com>
 <50422908-1917-bda9-ead5-40b02d57c545@redhat.com>
 <20220204082351-mutt-send-email-mst@kernel.org>
 <45a4987f-3a87-8c04-73a9-3ae68fafffcd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <45a4987f-3a87-8c04-73a9-3ae68fafffcd@redhat.com>
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

On Fri, Feb 04, 2022 at 02:29:39PM +0100, David Hildenbrand wrote:
> On 04.02.22 14:24, Michael S. Tsirkin wrote:
> > On Wed, Jan 19, 2022 at 09:35:05AM +0100, David Hildenbrand wrote:
> >> On 19.01.22 08:46, Gavin Shan wrote:
> >>> Hi Michael,
> >>>
> >>> On 1/19/22 3:39 PM, Michael S. Tsirkin wrote:
> >>>> On Wed, Jan 19, 2022 at 09:05:51AM +0800, Gavin Shan wrote:
> >>>>> This enables virtio-mem device support by allowing to enable the
> >>>>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
> >>>>> architecture.
> >>>>>
> >>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >>>>> Acked-by: David Hildenbrand <david@redhat.com>
> >>>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>> ---
> >>>>> v3: Pick ack-by tags from Jonathan and Michael
> >>>>> ---
> >>>>>   drivers/virtio/Kconfig | 7 ++++---
> >>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> >>>>> index 34f80b7a8a64..74c8b0c7bc33 100644
> >>>>> --- a/drivers/virtio/Kconfig
> >>>>> +++ b/drivers/virtio/Kconfig
> >>>>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
> >>>>>   config VIRTIO_MEM
> >>>>>   	tristate "Virtio mem driver"
> >>>>>   	default m
> >>>>> -	depends on X86_64
> >>>>> +	depends on X86_64 || ARM64
> >>>>>   	depends on VIRTIO
> >>>>>   	depends on MEMORY_HOTPLUG
> >>>>>   	depends on MEMORY_HOTREMOVE
> >>>>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
> >>>>>   	 This driver provides access to virtio-mem paravirtualized memory
> >>>>>   	 devices, allowing to hotplug and hotunplug memory.
> >>>>>   
> >>>>> -	 This driver was only tested under x86-64, but should theoretically
> >>>>> -	 work on all architectures that support memory hotplug and hotremove.
> >>>>> +	 This driver was only tested under x86-64 and arm64, but should
> >>>>> +	 theoretically work on all architectures that support memory hotplug
> >>>>> +	 and hotremove.
> >>>>>   
> >>>>
> >>>> BTW isn't there a symbol saying "memory hotplug" that we can depend on?
> >>>>
> >>
> >> You mean
> >>
> >>  	depends on MEMORY_HOTPLUG
> >>  	depends on MEMORY_HOTREMOVE
> >>
> >> We still need a manual opt-in from architectures, because devil's in the
> >> detail. (e.g., memblock stuff we had to adjust)
> > 
> > Is there any chance of documenting some of this here? The current comment makes it
> > look like it's just a question of whitelisting an architecture.
> 
> I can send a patch to add more details.

oks so that will be a patch on top?

> -- 
> Thanks,
> 
> David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
