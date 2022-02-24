Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A56C433FE
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 17:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EAE8401DF;
	Thu, 24 Feb 2022 17:26:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0V4iUeJ4mOX; Thu, 24 Feb 2022 17:26:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 591B7400E0;
	Thu, 24 Feb 2022 17:26:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC47C0021;
	Thu, 24 Feb 2022 17:26:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD11C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 17:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65C7D60B37
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 17:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1q63Mtwr0kKZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 17:26:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83EBB607A4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645723613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KOt11P3yaaZUw/7BmU9CxBeIQu22cwdFYgYDt8CuHzs=;
 b=eara7wVBtLJInpDIwMxAGroy1kuIYjKifezjKygCkD8QlgdD5hcICx1obP/Wnzsf2a+HrL
 ttoeCclkqBoP9hHe0c5VNgjyie1TnmmKjS+8YtDFwvU/Kf0ibv8rD+kts4IAYiceQ+XiAw
 EMhRGj+Re/sOsE5hN/zNQbzeO67VLBU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-BTkgepG5NxCoUVA-ycq6Ng-1; Thu, 24 Feb 2022 12:26:52 -0500
X-MC-Unique: BTkgepG5NxCoUVA-ycq6Ng-1
Received: by mail-wm1-f72.google.com with SMTP id
 r206-20020a1c44d7000000b00380e36c6d34so148121wma.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 09:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KOt11P3yaaZUw/7BmU9CxBeIQu22cwdFYgYDt8CuHzs=;
 b=b2Zf5JKZxmNNteQCRHqNnVNZ7tY3URQ6WMwrCPujXCYYfm2lSGYH1ig8rlGediAUpH
 IE7HPdmqcwP0ADU3QfBQMoYvL8Z6dS7VCmaSqQH1vrc7iXOJrO4qdVVD+1TeFT6mZh14
 odH741/YYGww76Msm0XpwFxuqnHA4DxwzsvaHTzIGHeZUb5tnXDk7CHqdkum1fZaeS9B
 cx76BJ9BhUPU/XEHYog00N3gVI0l8P4HD7XwgWVNSChLj+8+bCui2tUTSBtZmGiRAz6G
 OTZwK9H4HIa8qxRhbbjVJW7DAo759V0t8HyHTAwpv6JBn6qW5IDJdhpDIlP3LLAXNJb9
 Skig==
X-Gm-Message-State: AOAM5336dy+qKWIwx0F1H3YPI0f9S8QfnwZKjugY9hgUAgyNPegn45cg
 T7ay6OS64R31g1qPRDAnxMdiYbiPw445q3aod2DNQajF3EccpqPjNGhzPOokjGx82U1NLbKl9QR
 QQRWlpn58jLqaxSe8S55eOEjNVs5haywEo+TzYtu3pQ==
X-Received: by 2002:adf:e552:0:b0:1ef:58cc:fd3c with SMTP id
 z18-20020adfe552000000b001ef58ccfd3cmr702086wrm.264.1645723611342; 
 Thu, 24 Feb 2022 09:26:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxp6nduuBu8KKk5GwR9BSY8FWCyD58WiMZsQiFTE9p+p5m/wsAqEbG8mtV8Mp+fucekaoMpvQ==
X-Received: by 2002:adf:e552:0:b0:1ef:58cc:fd3c with SMTP id
 z18-20020adfe552000000b001ef58ccfd3cmr702070wrm.264.1645723611096; 
 Thu, 24 Feb 2022 09:26:51 -0800 (PST)
Received: from redhat.com ([2.55.145.157])
 by smtp.gmail.com with ESMTPSA id 14sm4243666wrb.34.2022.02.24.09.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Feb 2022 09:26:50 -0800 (PST)
Date: Thu, 24 Feb 2022 12:26:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
Message-ID: <20220224122533-mutt-send-email-mst@kernel.org>
References: <20211108081324.14204-1-jasowang@redhat.com>
 <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
 <20220223020452-mutt-send-email-mst@kernel.org>
 <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
 <CACGkMEuu-Q83aBm0ijGr8AhP9C0tjxzvuHKvnY4HaArL5d2eoQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuu-Q83aBm0ijGr8AhP9C0tjxzvuHKvnY4HaArL5d2eoQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Wed, Feb 23, 2022 at 03:50:07PM +0800, Jason Wang wrote:
> On Wed, Feb 23, 2022 at 3:34 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Feb 23, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> > > > On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > > > > for split virtqueue") tries to make it possible for the driver to not
> > > > > read from the descriptor ring to prevent the device from corrupting
> > > > > the descriptor ring. But it still read the descriptor flag from the
> > > > > descriptor ring during buffer detach.
> > > > >
> > > > > This patch fixes by always store the descriptor flag no matter whether
> > > > > DMA API is used and then we can avoid reading descriptor flag from the
> > > > > descriptor ring. This eliminates the possibly of unexpected next
> > > > > descriptor caused by the wrong flag (e.g the next flag).
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > Michael, any comment for this?
> > > >
> > > > Thanks
> > >
> > > I don't exactly see why we should care without DMA API, it seems
> > > cleaner not to poke at the array one extra time.
> >
> > I think the answer is that we have any special care about the DMA API
> 
> I meant "we haven't had" actually.
> 
> Thanks

I'm just asking what's better for performance. An extra write in the
first chunk has a cost. Want to test and see?

> > for all other places that are using desc_extra.
> >
> > Thanks
> >
> >
> > >
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 00f64f2f8b72..28734f4e57d3 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > >         }
> > > > >         /* Last one doesn't continue. */
> > > > >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > > > -       if (!indirect && vq->use_dma_api)
> > > > > +       if (!indirect)
> > > > >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> > > > >                         ~VRING_DESC_F_NEXT;
> > > > >
> > > > > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > > >         /* Put back on free list: unmap first-level descriptors and find end */
> > > > >         i = head;
> > > > >
> > > > > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > > > > +       while (vq->split.desc_extra[i].flags & nextflag) {
> > > > >                 vring_unmap_one_split(vq, i);
> > > > >                 i = vq->split.desc_extra[i].next;
> > > > >                 vq->vq.num_free++;
> > > > > --
> > > > > 2.25.1
> > > > >
> > >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
