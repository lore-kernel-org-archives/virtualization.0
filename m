Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B9C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 03:43:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989EA6103B
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 03:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 989EA6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51B42606CC;
	Mon, 27 Sep 2021 03:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ov2-TysuHLGS; Mon, 27 Sep 2021 03:43:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E0B1D60592;
	Mon, 27 Sep 2021 03:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1CBBC000F;
	Mon, 27 Sep 2021 03:43:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05154C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4DB06063A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HwHQ0EEwW7OE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:43:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0896F60592
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 03:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632714214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FV+S/t1IBuo2HhS3g4CJTfct8ubnx5YVk86QYs7lHbg=;
 b=Oq2HSqerIu+32Xl0uN5n2CdfTC4dSDe9zERll3KL+KWYuX4iCxHb6KGA4rDodLUX76qVxj
 RqeT2JQO7U2t+MLzxouIdSW5tB1azw64l7VuL/pnoIqUUGGRV7gJfvkWp2JYTVPMo9V5dJ
 wdibBxrfEQ1qHBHrbqxTsbTZqZpu9l4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-Q7ujFpSfMJS8hInR_1JoXg-1; Sun, 26 Sep 2021 23:43:33 -0400
X-MC-Unique: Q7ujFpSfMJS8hInR_1JoXg-1
Received: by mail-lf1-f72.google.com with SMTP id
 r14-20020ac25c0e000000b003fc149ed50eso14553342lfp.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 20:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FV+S/t1IBuo2HhS3g4CJTfct8ubnx5YVk86QYs7lHbg=;
 b=7P95JQAv+jCUdFdmpm//7A9Lo5FFhkeXj/7Z29OYdzO9jx8h75/7CJrlzqdq2eHYJj
 9u76/uX5NMBLBdv9GA2luBckUt5Ob9DfFh+fvrBYdvv0Al0vtEbaNZIkqwyTi9U9OgzM
 xQbgNb4yYCqd+na3TVGCpx3ZslPI2xgccijscLqLMJmaRUCYQepXQFxG70udAIWUukQc
 DLOI0ZidSMrYlngPNasRSSSRWzP/Ks1+0UlxNVJnLY8hIlAq5V63FUbgV+JTXgPxXizu
 AwjxydAoFP1fTH1WvTXfJf+Lj1FOoyfDIb9ObwGGer7T3QAYJuTr1Ct34ukbOWoY7QqA
 XDbA==
X-Gm-Message-State: AOAM532poKVtqSQRM/msR9y0+0qsy97QZT/WAr8swnYhR9diw9FBnn2/
 vIKWNBe6fZdVvQAVCQXiwyaknpd2hxCzY4lEvzMNdH8KEZV6VLNlyJOfuHBFNeRPiWSXgaiZJiS
 Fy7bH/GR+sEv34v8NeITO8DalxZHs26ufo77gfJr+b5HxtP32UDhyE1hSIQ==
X-Received: by 2002:a05:6512:3d0a:: with SMTP id
 d10mr22630943lfv.481.1632714211625; 
 Sun, 26 Sep 2021 20:43:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrpRYKNzDgGLqKx3Qwc1HUOcvCESyt2KpXo9a4U+bqH9wVFDNmzezaEeQ74oeJuhtioSZS0mxSjHmV693wWh8=
X-Received: by 2002:a05:6512:3d0a:: with SMTP id
 d10mr22630933lfv.481.1632714211438; 
 Sun, 26 Sep 2021 20:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEtaXD=0zPoiLxrXbqBQPZF4ZLWvm_dNkSnf6s3H+-VRgA@mail.gmail.com>
 <1632713121.4676855-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1632713121.4676855-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Sep 2021 11:43:20 +0800
Message-ID: <CACGkMEvFbPbLMLNfehx81M8Y4wS4rSHdbQk=tyh4mHUiuq=O_Q@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: check desc == NULL when packed and indirect
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Sep 27, 2021 at 11:29 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 27 Sep 2021 11:20:16 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Mon, Sep 27, 2021 at 11:06 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > In the case of packed, use indirect desc, since desc is allocated by
> > > kmalloc_array(), we should check whether its return value is NULL.
> > >
> > > Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 27 ++++++++++++++++-----------
> > >  1 file changed, 16 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index dd95dfd85e98..7dd381eae725 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1050,21 +1050,20 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> > >  }
> > >
> > >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > -                                      struct scatterlist *sgs[],
> > > -                                      unsigned int total_sg,
> > > -                                      unsigned int out_sgs,
> > > -                                      unsigned int in_sgs,
> > > -                                      void *data,
> > > -                                      gfp_t gfp)
> > > +                                        struct scatterlist *sgs[],
> > > +                                        struct vring_packed_desc *desc,
> > > +                                        unsigned int total_sg,
> > > +                                        unsigned int out_sgs,
> > > +                                        unsigned int in_sgs,
> > > +                                        void *data,
> > > +                                        gfp_t gfp)
> >
> > It looks to me the style changes are mixed with bug fix here.
>
>
> I will make a separate patch for the next version.

Please make it a patch on top of the fix to ease the backport.

>
> >
> > >  {
> > > -       struct vring_packed_desc *desc;
> > >         struct scatterlist *sg;
> > >         unsigned int i, n, err_idx;
> > >         u16 head, id;
> > >         dma_addr_t addr;
> > >
> > >         head = vq->packed.next_avail_idx;
> > > -       desc = alloc_indirect_packed(total_sg, gfp);
> > >
> > >         if (unlikely(vq->vq.num_free < 1)) {
> > >                 pr_debug("Can't add buf len 1 - avail = 0\n");
> > > @@ -1191,9 +1190,15 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > >
> > >         BUG_ON(total_sg == 0);
> > >
> > > -       if (virtqueue_use_indirect(_vq, total_sg))
> > > -               return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> > > -                               out_sgs, in_sgs, data, gfp);
> > > +       if (virtqueue_use_indirect(_vq, total_sg)) {
> > > +               desc = alloc_indirect_packed(total_sg, gfp);
> > > +               if (desc) {
> > > +                       return virtqueue_add_indirect_packed(vq, sgs, desc,
> > > +                                                            total_sg,
> > > +                                                            out_sgs, in_sgs,
> > > +                                                            data, gfp);
> > > +               }
> > > +       }
> >
> > Any reason that we can't fix virtqueue_add_indirect_packed()? It can
> > help to reduce the changeset and ease the backport.
>
> The purpose of this is to fall back to not using indirect when
> alloc_indirect_packed returns NULL.
>
> If we check the return value of alloc_indirect_packed() in
> virtqueue_add_indirect_packed(), then MUST check the error returned by
> virtqueue_add_indirect_packed() to determine whether to fall back to the mode
> that does not use indirect.

Right, this aligns the behaviour of the split path. But please
describe this in the commit log.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > >         head = vq->packed.next_avail_idx;
> > >         avail_used_flags = vq->packed.avail_used_flags;
> > > --
> > > 2.31.0
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
