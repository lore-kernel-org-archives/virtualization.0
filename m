Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A62C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 08:24:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDDE611EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 08:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACDDE611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74FAC81D3A;
	Wed, 20 Oct 2021 08:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aDfaKcINNX7k; Wed, 20 Oct 2021 08:24:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F2A681D21;
	Wed, 20 Oct 2021 08:24:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8D42C0011;
	Wed, 20 Oct 2021 08:24:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D446C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5759781D3A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xTwisw_lBPe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:24:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 128DF81D21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634718279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwcocHVbec3ymjxdViN7mgEpRxnZq0BOcgl8sS8Lk1Y=;
 b=XCVOVCxKQpBCcR+hyleTXBZlaRIs4OwJLRYO2g1nKMhU2OH/LCtNm5B13GRNyu4/8NJ8Gf
 szQmFdpKdf60WRm7qFfrHYDAsecqkO2mdY/n3COwIQ4JduBukbb/n1Hr0R0ZnhPvIVdC+J
 1Slj0n7cWeAYvkded5sAGGbYm1M06Fk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-lBCQn3u0PiWpfrwoNsEolQ-1; Wed, 20 Oct 2021 04:24:38 -0400
X-MC-Unique: lBCQn3u0PiWpfrwoNsEolQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 u23-20020a50a417000000b003db23c7e5e2so20263140edb.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 01:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pwcocHVbec3ymjxdViN7mgEpRxnZq0BOcgl8sS8Lk1Y=;
 b=e0zN6gys8zJOrbyPlRq8hG+xzJeOpm7qYnanJM+Nmq/Eek1TXl87wYzrG93Mjq2Pre
 3nfozHK3VSb7Yew464Ku4lNg0fGiTvCSyxUc2yhvY43pMC6OGKbPy6ORgi2QlXwYC+/A
 JnxjfM3Zzt631QxDlR4Qof3lSm+cwuMMAo+qFSTHTlpBS33PA/dcNlkbotMKaWEKGWdg
 noml2p/yEbPnQJqVlayJGwPGsAh8uqj2yhZ93gQPGC0m3x0IZxkK19vWhY8g8PypGY/m
 IzNTVm3Yzl/bjtL1/dUYnhF2vUxKJTRLnZnao42o5kCs/+ysiI0xsKD1/kOX/ULRmRSf
 b1/Q==
X-Gm-Message-State: AOAM532qtlwhBkECW1SPpaexIiOIkMjh2AlgUmGKuDMoW3SPPYUAw28w
 VgGTs8QHb3j/TEqaWuW28igXVeWesKg3MsilKDtV83lV4jjH4CjCgCumLEQF73sqo83d3lEEWP5
 GgEcb5ghUaNUKUwhAPNVmzoGwrtxplaIG7Ux5kOgk4g==
X-Received: by 2002:aa7:da51:: with SMTP id w17mr40354838eds.289.1634718277417; 
 Wed, 20 Oct 2021 01:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgeNcazKOYTobw/UP3euOcahWSlkxAQEJY4brdmYAXJVR5LXHrEaDvtGuIRlZm095HCmbsOg==
X-Received: by 2002:aa7:da51:: with SMTP id w17mr40354809eds.289.1634718277117; 
 Wed, 20 Oct 2021 01:24:37 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id v6sm817512edc.52.2021.10.20.01.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 01:24:36 -0700 (PDT)
Date: Wed, 20 Oct 2021 04:24:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 2/2] virtio_ring: check desc == NULL when using
 indirect with packed
Message-ID: <20211020042350-mutt-send-email-mst@kernel.org>
References: <20211019091947-mutt-send-email-mst@kernel.org>
 <1634696386.1682892-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1634696386.1682892-1-xuanzhuo@linux.alibaba.com>
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

On Wed, Oct 20, 2021 at 10:19:46AM +0800, Xuan Zhuo wrote:
> On Tue, 19 Oct 2021 09:21:51 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Oct 19, 2021 at 07:52:35PM +0800, Xuan Zhuo wrote:
> > > When using indirect with packed, we don't check for allocation failures.
> > > This patch checks that and fall back on direct.
> > >
> > > Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 91a46c4da87d..44a03b6e4dc4 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1065,6 +1065,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >
> > >  	head = vq->packed.next_avail_idx;
> > >  	desc = alloc_indirect_packed(total_sg, gfp);
> > > +	if (!desc)
> > > +		/* fall back on direct */
> >
> > this comment belongs in virtqueue_add_packed right after
> > return.
> >
> > > +		return -EAGAIN;
> > >
> >
> > -ENOMEM surely?
> 
> virtqueue_add_indirect_packed() will return -ENOMEM when dma mmap fails, so we
> have to choose a different error code.
> 
> Thanks.

That's exactly the point.  Why would we want to recover from allocation
failure but not DMA map failure?

> >
> > >  	if (unlikely(vq->vq.num_free < 1)) {
> > >  		pr_debug("Can't add buf len 1 - avail = 0\n");
> > > @@ -1176,6 +1179,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >  	unsigned int i, n, c, descs_used, err_idx;
> > >  	__le16 head_flags, flags;
> > >  	u16 head, id, prev, curr, avail_used_flags;
> > > +	int err;
> > >
> > >  	START_USE(vq);
> > >
> > > @@ -1191,9 +1195,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >
> > >  	BUG_ON(total_sg == 0);
> > >
> > > -	if (virtqueue_use_indirect(_vq, total_sg))
> > > -		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> > > -				out_sgs, in_sgs, data, gfp);
> > > +	if (virtqueue_use_indirect(_vq, total_sg)) {
> > > +		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> > > +						    in_sgs, data, gfp);
> > > +		if (err != -EAGAIN)
> > > +			return err;
> > > +	}
> > >
> > >  	head = vq->packed.next_avail_idx;
> > >  	avail_used_flags = vq->packed.avail_used_flags;
> > > --
> > > 2.31.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
