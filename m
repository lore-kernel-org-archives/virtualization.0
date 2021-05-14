Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8CCC433ED
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 11:14:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6215C613DA
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 11:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6215C613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 192E24040A;
	Fri, 14 May 2021 11:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ASWQaVrOEUvw; Fri, 14 May 2021 11:14:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85FC5403F3;
	Fri, 14 May 2021 11:13:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FEBAC000D;
	Fri, 14 May 2021 11:13:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63E14C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 403FA60762
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9u7wdJFvuImZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:13:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73D29605FE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620990834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcyY5SRYU8znOLGxlQ+VXLYAFrni6/EsXvguEf/Rk+o=;
 b=g+34zFmFzjvf8xxJ3MDWh4h2FosQiPLrG7URKXUVh9xhH1WaEXz8dOI9Z3gP7TbJ1oYshC
 PufIO0tuwQZYQ96u9USXH3J/qG5ebAZ/ODcvII0Ykq5NSWnyX057s+istAu3/nFcCfF+a0
 jkQyBd0uMs+xJKi0nhPDEK/JjxmHStg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-TqvhhJaJNdydUAmhAb6mOQ-1; Fri, 14 May 2021 07:13:53 -0400
X-MC-Unique: TqvhhJaJNdydUAmhAb6mOQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 u5-20020adf9e050000b029010df603f280so12589672wre.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 04:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GcyY5SRYU8znOLGxlQ+VXLYAFrni6/EsXvguEf/Rk+o=;
 b=aBMFnsOTgW5DVZ8ZOfCCdn3AfmMlwUbXfIW/DH0Oj91wS9weTQ6sNtg07LIyQi280e
 H1c6IN120P8WsUGqWcTX8cPjso3c+yV2qriBhfjY911blKPx3rP8kVNFmkU/rPddM8D+
 MA5vaDJ7tG7xK+uajqwLfMfX4gi3Kpwc0ESBs/vvaFbeTFsQdzvfnv/gat9FKzI+/PNk
 qcC3gmPw/njr3NxlNQcdO6jRLZuMzPgXC227BQsS47Skc4EekvxOdAXNJsSHVniCUiDD
 DWqT4hxs0ZFSi0fY2TQZWUFvRqbpkL6K+YW9oRwHfvM6RwEanFCjtJYDRCePn+HBxFJ7
 gFZA==
X-Gm-Message-State: AOAM530XXfCVOI9NS9XM3byrjK5Ae+OisFBcBihxf4ljYw8/Cqp9fm5R
 /RMWprGbh3sEZ96XGR/WgHNOcDwzMY2muixRL5mfz7RXAU5EdzXdQTvk+u1/tfm5hoV7eJbYFQt
 5g372qn6A+yZTDumjzJbL9ZdP1z/+mam8SgLv7JET8w==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr9792477wmc.127.1620990832246; 
 Fri, 14 May 2021 04:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZNhppxBIXT6J4oHOEj05xdp5fT5MtIiU2dY4jUT95nukcwuVNGKlHAjd1LlANrcZHhqooTQ==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr9792463wmc.127.1620990832028; 
 Fri, 14 May 2021 04:13:52 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id f7sm5007823wmq.30.2021.05.14.04.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 04:13:51 -0700 (PDT)
Date: Fri, 14 May 2021 07:13:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
Message-ID: <20210514063516-mutt-send-email-mst@kernel.org>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
 <20210506041057-mutt-send-email-mst@kernel.org>
 <20210506123829.GA403858@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20210506123829.GA403858@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 stefanha@redhat.com
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

On Thu, May 06, 2021 at 01:38:29PM +0100, Christoph Hellwig wrote:
> On Thu, May 06, 2021 at 04:12:17AM -0400, Michael S. Tsirkin wrote:
> > Let's try for just a bit, won't make this window anyway:
> > 
> > I have an old idea. Add a way to find out that unmap is a nop
> > (or more exactly does not use the address/length).
> > Then in that case even with DMA API we do not need
> > the extra data. Hmm?
> 
> So we actually do have a check for that from the early days of the DMA
> API, but it only works at compile time: CONFIG_NEED_DMA_MAP_STATE.
> 
> But given how rare configs without an iommu or swiotlb are these days
> it has stopped to be very useful.  Unfortunately a runtime-version is
> not entirely trivial, but maybe if we allow for false positives we
> could do something like this
> 
> bool dma_direct_need_state(struct device *dev)
> {
> 	/* some areas could not be covered by any map at all */
> 	if (dev->dma_range_map)
> 		return false;
> 	if (force_dma_unencrypted(dev))
> 		return false;
> 	if (dma_direct_need_sync(dev))
> 		return false;
> 	return *dev->dma_mask == DMA_BIT_MASK(64);
> }
> 
> bool dma_need_state(struct device *dev)
> {
> 	const struct dma_map_ops *ops = get_dma_ops(dev);
> 
> 	if (dma_map_direct(dev, ops))
> 		return dma_direct_need_state(dev);
> 	return ops->unmap_page ||
> 		ops->sync_single_for_cpu || ops->sync_single_for_device;
> }

Yea that sounds like a good idea. We will need to document that.


Something like:

/*
 * dma_need_state - report whether unmap calls use the address and length
 * @dev: device to guery
 *
 * This is a runtime version of CONFIG_NEED_DMA_MAP_STATE.
 *
 * Return the value indicating whether dma_unmap_* and dma_sync_* calls for the device
 * use the DMA state parameters passed to them.
 * The DMA state parameters are: scatter/gather list/table, address and
 * length.
 *
 * If dma_need_state returns false then DMA state parameters are
 * ignored by all dma_unmap_* and dma_sync_* calls, so it is safe to pass 0 for
 * address and length, and DMA_UNMAP_SG_TABLE_INVALID and
 * DMA_UNMAP_SG_LIST_INVALID for s/g table and length respectively.
 * If dma_need_state returns true then DMA state might
 * be used and so the actual values are required.
 */

And we will need DMA_UNMAP_SG_TABLE_INVALID and
DMA_UNMAP_SG_LIST_INVALID as pointers to an empty global table and list
for calls such as dma_unmap_sgtable that dereference pointers before checking
they are used.


Does this look good?

The table/length variants are for consistency, virtio specifically does
not use s/g at the moment, but it seems nicer than leaving
users wonder what to do about these.

Thoughts? Jason want to try implementing?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
