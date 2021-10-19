Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F156C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 13:24:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453476137F
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 13:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 453476137F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0ED724070A;
	Tue, 19 Oct 2021 13:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NnWM5sqjZQ1g; Tue, 19 Oct 2021 13:24:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B97A240703;
	Tue, 19 Oct 2021 13:24:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77584C0011;
	Tue, 19 Oct 2021 13:24:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 996F9C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7983940503
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lAhuU_kXS7u1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:23:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 783C8404F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634649835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zFS1Bnqe23bHHtQS7UWlwMB2a4HZqb8I+OJHFqv7h0I=;
 b=bjiUUl11wn+6JwNffo7yN2ofY8H1qsizEefO6qPPi6cN0vsqI7nbSOe0SpGOTmpdR6lJr/
 G94SsNX6UlwtIRo/QopnZ0kjrbx8HBf8Mw8wlwVn7WMqHu1FHJGvrEcV9rJdOqYlezqewZ
 uZOmrNhIVYgKpNpOPFF8Q7nLZ39kN+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-18-8jJ4wPTOLSUsZ5L4J-A-1; Tue, 19 Oct 2021 09:23:54 -0400
X-MC-Unique: 18-8jJ4wPTOLSUsZ5L4J-A-1
Received: by mail-wr1-f70.google.com with SMTP id
 d13-20020adfa34d000000b00160aa1cc5f1so10144642wrb.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 06:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zFS1Bnqe23bHHtQS7UWlwMB2a4HZqb8I+OJHFqv7h0I=;
 b=i0sQFLuGAFCQpOdPaRaTgY5GlUSKJeTPNBLtQjJhf0XyhwQGlKLUFzHJCK2vjEOyLf
 9fLOcou3/pgCrNOAjpvYYOsWJ72YM192/aEW7bUsnPwAOs/PjA6rwZRUWdF83gMVPm9A
 MwxOA0TuJOeYjXIW8Ywm+kTjaVarCIEEfICWB3l8RPuAzT0YKacFUUVhG+1IUYvqvgEJ
 7Y1XHTRmoSw2N3Ri5z65ZgjU55zzxBG1MhNEiHhI9+0FL/KTrEOZiBuGVkiiYQvzTDne
 LaemV7v2F1UBW6eshZUpIAK8D92/FIJE71c09b9rNWWh1eq39v91Pja0ectgQx2eqIv2
 cawg==
X-Gm-Message-State: AOAM532c++IeQhmxAKwV8446paxIplFXGUojayr6rHxC0qAmap/GVpyN
 UrSAWk/QKD6PELaf8zZi4wQlG730s7TFDo6J9TYKKg9tqD1ShfUPS/GTSBmNag1FFndeZEuV6P3
 YSoA47GF2ciuV6/0GYh/aN7Kq8tdIhrpegarIslAL3A==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr5836344wml.177.1634649833023; 
 Tue, 19 Oct 2021 06:23:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7wuLBtdHS0norZCwXvJZUQlrM2h+ySWrmnAkkC3QncBMrGQtXaU6juzhRdUWwMdB6wz9V+A==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr5836330wml.177.1634649832839; 
 Tue, 19 Oct 2021 06:23:52 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id f18sm14915450wrg.3.2021.10.19.06.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 06:23:52 -0700 (PDT)
Date: Tue, 19 Oct 2021 09:23:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 0/2] virtio_ring: check desc == NULL when packed and
 indirect
Message-ID: <20211019092251-mutt-send-email-mst@kernel.org>
References: <20211019115235.106507-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211019115235.106507-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
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

On Tue, Oct 19, 2021 at 07:52:33PM +0800, Xuan Zhuo wrote:
> In the case of packed, use indirect desc, since desc is allocated by
> kmalloc_array(), we should check whether its return value is NULL.
> 

a better description here:

fix theoretical issues in virtio_ring (so I'm guessing - or did
you observe any null pointer dereferences?)

> v4:
>    Inside the #2 patch, virtqueue_add_indirect_packed() return -EAGAIN when
>    desc == NULL.
> 
> v3:
>     Update commit message of the #1 patch.
> 
> v2:
>     Separate the style fix into a single patch.
> 
> 
> Xuan Zhuo (2):
>   virtio_ring: fix style of virtqueue_add_indirect_packed
>   virtio_ring: check desc == NULL when using indirect with packed
> 
>  drivers/virtio/virtio_ring.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
