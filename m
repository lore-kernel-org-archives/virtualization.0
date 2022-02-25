Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661C5C433FE
	for <virtualization@archiver.kernel.org>; Fri, 25 Feb 2022 02:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFFB64046B;
	Fri, 25 Feb 2022 02:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TTrmx_kDEQ_E; Fri, 25 Feb 2022 02:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33C664010C;
	Fri, 25 Feb 2022 02:36:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19F39C001A;
	Fri, 25 Feb 2022 02:36:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3496BC0011
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 02:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1337F403C4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 02:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3t1rAOvwXCO4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 02:36:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 884E14010C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 02:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645756567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yU8GS8BgzaMD7fDEtovQ458r1iAvIqdNLZPe70i9638=;
 b=GMlamDOCQxKXK+co5+WTHWpJBPxqtN9yu50BBVRSRDKnZ2MQSm81QtNMfL+kYLLe/Iwe5M
 IhqpSyI3cxOXud4T8Tv5HWRWK9YrbGQgNLHatnpees9ts7vnTuFDyzJCGzUdXXIcKsBHHm
 PILx149w7i+vH61RNqArFf5N2NYSV5E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-ddSg3sEgM0-ZKa5OgrTgyQ-1; Thu, 24 Feb 2022 21:36:05 -0500
X-MC-Unique: ddSg3sEgM0-ZKa5OgrTgyQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 20-20020a2e0914000000b0024635d136ddso1984325ljj.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 18:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yU8GS8BgzaMD7fDEtovQ458r1iAvIqdNLZPe70i9638=;
 b=uFBSKUhxKCPaX/ygvE0A3UQA2X4VABHvWf7ezk8rVEqpn7sfC9/3VhLTT7WPsPY+Wx
 TvtHa4uHGW+wKiqvpZdWr5h6leM5/VrxeXsSaL8m5VCQs/zqCgakSO+rn4AJVcHHis/H
 6xENNROdtv3lAu/PxTQDCptuNihWfHIHt5+wREG3bvtgrvM23t+LAKAAuvXidcA5EQfM
 wiUI8cZlgUXgCYiiqFV/txZ5oxpXCbHLPyxBsYXBeXDpVTehXSJpUDoEi8qKz3TCOAKd
 yRzG8I7iN67R4t7bAHdTmtAvAzwCJ1ghnt+uIARXtOFS4LiISQCAi8tbsBPgTCGDtZle
 xwQQ==
X-Gm-Message-State: AOAM531CwFalvx1QMyzYM8Vurfbj/8S8iuE3yp1ZGdFfMnSxZQ0npzti
 dxE2sEIAly6VXo5gW2tB9fSVesESofMAUlkap8M2hwG1QxLED0wDXdBc2QR+3vpo8K3EqXmykPV
 wkGMJyeAgztKgw6Reqclr5M89vqN4gQbAwClKD5bvIzHWWhaSKOAW52B1Aw==
X-Received: by 2002:a05:651c:c7:b0:244:f9d7:7c48 with SMTP id
 7-20020a05651c00c700b00244f9d77c48mr4028967ljr.300.1645756564234; 
 Thu, 24 Feb 2022 18:36:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjAhhNdJ81uWG2TggCgB0pGDHZN6gLYH0DcvEADiHYUKFvn60w4UU5WCGJu9wPo8OI5eChZ4BpTaH0LrHjkM4=
X-Received: by 2002:a05:651c:c7:b0:244:f9d7:7c48 with SMTP id
 7-20020a05651c00c700b00244f9d77c48mr4028959ljr.300.1645756563999; Thu, 24 Feb
 2022 18:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com>
 <20220224122655-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220224122655-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Feb 2022 10:35:52 +0800
Message-ID: <CACGkMEuCWE-oHQXJYfQZh2k5s8BNWRgXW4wZrHyo7Z2=k89EeA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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

On Fri, Feb 25, 2022 at 1:55 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Typo in the subject btw.
>
> minor tweaks to commit log below
>
> On Mon, Nov 08, 2021 at 04:13:24PM +0800, Jason Wang wrote:
> > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > for split virtqueue") tries to make it possible for the driver to not
> > read from the descriptor ring to prevent the device from corrupting
> > the descriptor ring. But it still read
>
> reads
>
> >the descriptor flag from the
> > descriptor ring during buffer detach.
> >
> > This patch fixes
>
> fixes this
>
> >by always store
>
> storing
>

Will fix.

> >the descriptor flag no matter whether
> > DMA API is used and then we can avoid reading descriptor flag from the
> > descriptor ring. This eliminates the possibly of unexpected next
> > descriptor caused by the wrong flag (e.g the next flag).
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> I'd also like the commit log to document what the issue is in a bit more depth.
> I think the main reason we are checking the dma API is this
>
>
> static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>                                           unsigned int i)
> {
>         struct vring_desc_extra *extra = vq->split.desc_extra;
>         u16 flags;
>
>         if (!vq->use_dma_api)
>                 goto out;
>
>         ...
> }
>
>
> so I guess with a bad flag, what will happen is num_free will become too
> big is that right?

Yes, and it may have other implications and this is not easy to answer
since with the current code, next/flag is the only one that can be
controlled by the device. From what I've seen so far, it can cause an
early unmap for the descriptors in the free list. This may cause
several issues when using DMA API (e.g IOTLB for bouncing). Indeed
software IOMMU/IOTLB has done a lot of checks for this but we can't
solely depend on IOMMU/IOTLB to handle malicious inputs.

So my understanding is that, instead of trying to figuring out what
may happens if some flag or descriptor is modified by the malicious
device/hypervisor, we can simply eliminate all those possibilities
with minimal efforts and this is why we try not read anything from
shared memory area (e.g the descriptor ring etc) if possible.

>
>
>
>
> > ---
> >  drivers/virtio/virtio_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 00f64f2f8b72..28734f4e57d3 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >       }
> >       /* Last one doesn't continue. */
> >       desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > -     if (!indirect && vq->use_dma_api)
> > +     if (!indirect)
> >               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> >                       ~VRING_DESC_F_NEXT;
> >
>
> BTW I'm a bit confused why we need the & (vq->split.vring.num - 1) logic.
> Maybe it's time we stopped writing out descriptor then overwriting it -

Right since the next can be read from the descriptor ring directly (as
you said below, this needs to be fixed as well).

> e.g. return the desc_extra pointer from virtqueue_add_desc_split
> instead of an index. Worth checking what this does to performance.

Right, let me try to do that in the next version.

Thanks

>
>
> > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >       /* Put back on free list: unmap first-level descriptors and find end */
> >       i = head;
> >
> > -     while (vq->split.vring.desc[i].flags & nextflag) {
> > +     while (vq->split.desc_extra[i].flags & nextflag) {
> >               vring_unmap_one_split(vq, i);
> >               i = vq->split.desc_extra[i].next;
> >               vq->vq.num_free++;
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
