Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:31:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C80E6135F
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C80E6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48DB440701;
	Tue, 19 Oct 2021 11:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KMgI6WQ9Wgbg; Tue, 19 Oct 2021 11:31:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF8B4404B8;
	Tue, 19 Oct 2021 11:31:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B87B3C0011;
	Tue, 19 Oct 2021 11:31:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82669C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7180360B2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9vjFO3ew9c7d
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15D70606B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634643107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMNgdXbqqU1J/0TCM81sBmrMSNJr+IGr4mSm5kc8Q7U=;
 b=CGh5A/6RBgZvAohy0DD8Cf5P+iKn7eZlj+PRNrguNhLq2t4dYE83TbcQlf+Y5nGIR+IaQO
 0fjMa5mWwitMeBCJKnQzb8N2buIP0LcgYLYhpNV2HvVOHgqyWwI+AjuMejrYnN6llQhIRJ
 +Jx7PPzQnEm+jjP5yE/BkRRItDhkTmo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-c5P6yGz1MimX4GGThKC3CQ-1; Tue, 19 Oct 2021 07:31:46 -0400
X-MC-Unique: c5P6yGz1MimX4GGThKC3CQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 k20-20020a7bc414000000b0030dcd454771so1032195wmi.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 04:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GMNgdXbqqU1J/0TCM81sBmrMSNJr+IGr4mSm5kc8Q7U=;
 b=LuC7p2T1jYcQf0dUT63lNPjcZIB417UvnGXAO2jz1tGp/dxJSbliecyFMi0va3h3p8
 yoYxZnvH2540rnay4MdkwvBZEthz6wQQ17Lz7H5WH8y5CtGJlEZm8x9vF7D5iXOCKpDc
 qH/PyXMVuIxtKH1rBJrF7OLLTb/0Rky4uGvTGB4S98ZXVQBmAB8hhD3TY8GCF618k6IQ
 5QtLZ06rKN9IkTDWkyTHzWF8vbPBajCsa93PCS1YcfR3zW4dy6MikdJ7oNtKBijcWXwW
 31q6Xq9idC3PtzAEnndr4hE6ILwQ0CQizmcuael/gghb5kQlwQqyl2xL7mQ8jVP2qWRT
 To5A==
X-Gm-Message-State: AOAM5312OQVY40byjzwiIklShHFJSGIQkqP+GyGud/JC0Tz28exdZYVa
 l3rMDS2CSEPwKjulMSslHlsAwhIQJLo7AQwCbiDZffIhwRGANr5N2Gi3hO9aTtj7w8XG2CBT/g0
 oZ/63P+VZ3rQtorksiADDZIQXWHzh66qy2OqQ49NKsQ==
X-Received: by 2002:a05:6000:188d:: with SMTP id
 a13mr43134193wri.243.1634643105108; 
 Tue, 19 Oct 2021 04:31:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTUGAcc2J5eY5Ov2e/ItEmTTJgI3S5GVTWMfKUKZ20qRVMSbXSgXLAitqbjz+Dy1fEQbQZYg==
X-Received: by 2002:a05:6000:188d:: with SMTP id
 a13mr43134174wri.243.1634643104896; 
 Tue, 19 Oct 2021 04:31:44 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id n7sm14750712wra.37.2021.10.19.04.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 04:31:44 -0700 (PDT)
Date: Tue, 19 Oct 2021 07:31:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 2/2] virtio_ring: check desc == NULL when packed and
 indirect
Message-ID: <20211019073134-mutt-send-email-mst@kernel.org>
References: <20211019070002-mutt-send-email-mst@kernel.org>
 <1634641946.8235457-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1634641946.8235457-1-xuanzhuo@linux.alibaba.com>
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

On Tue, Oct 19, 2021 at 07:12:26PM +0800, Xuan Zhuo wrote:
> On Tue, 19 Oct 2021 07:07:58 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Oct 19, 2021 at 06:56:57PM +0800, Xuan Zhuo wrote:
> > > In the case of packed, use indirect desc, since desc is allocated by
> > > kmalloc_array(), we should check whether its return value is NULL.
> > >
> > > This patch alloc desc inside virtqueue_add_packe(), if desc == NULL,
> >
> > Can we manage without typos in commit log please?
> 
> I'm sorry. virtqueue_add_packe => virtqueue_add_packed
> 
> >
> > > fall back to not using indirect.
> >
> >
> > It should say why is the patch created, and how it's fixed,
> > as opposed to repating what patch does.
> >
> > E.g.
> >
> > when using indirect with packed, we don't check for
> > allocation failures. Check and fall back on direct.
> 
> 
> It's better.  I know how to do it.
> 
> 
> >
> >
> >
> > > Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 91a46c4da87d..62323c27bfe4 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1051,20 +1051,19 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> > >
> > >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > >  					 struct scatterlist *sgs[],
> > > +					 struct vring_packed_desc *desc,
> > >  					 unsigned int total_sg,
> > >  					 unsigned int out_sgs,
> > >  					 unsigned int in_sgs,
> > >  					 void *data,
> > >  					 gfp_t gfp)
> >
> > So this gets desc and will free it. I don't much like this.
> 
> Under normal circumstances, this function will not release desc. It will
> actually release "desc" in detach_buf_packed(). Of course, if you encounter
> an error in this function, it will also release desc in this function.
> 
> If we call alloc_indirect_packed() in virtqueue_add_indirect_packed() it is also
> possible, we need to make virtqueue_add_indirect_packed() return a special
> return value.
> 
> Thanks.


that seems cleaner

> >
> >
> > >  {
> > > -	struct vring_packed_desc *desc;
> > >  	struct scatterlist *sg;
> > >  	unsigned int i, n, err_idx;
> > >  	u16 head, id;
> > >  	dma_addr_t addr;
> > >
> > >  	head = vq->packed.next_avail_idx;
> > > -	desc = alloc_indirect_packed(total_sg, gfp);
> > >
> > >  	if (unlikely(vq->vq.num_free < 1)) {
> > >  		pr_debug("Can't add buf len 1 - avail = 0\n");
> > > @@ -1191,9 +1190,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >
> > >  	BUG_ON(total_sg == 0);
> > >
> > > -	if (virtqueue_use_indirect(_vq, total_sg))
> > > -		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> > > -				out_sgs, in_sgs, data, gfp);
> > > +	if (virtqueue_use_indirect(_vq, total_sg)) {
> > > +		desc = alloc_indirect_packed(total_sg, gfp);
> > > +		if (desc)
> > > +			return virtqueue_add_indirect_packed(vq, sgs, desc,
> > > +							     total_sg,
> > > +							     out_sgs, in_sgs,
> > > +							     data, gfp);
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
