Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0696DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 07:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A39F560F1D;
	Wed, 23 Feb 2022 07:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LG8KR1zLb2-e; Wed, 23 Feb 2022 07:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D95960F30;
	Wed, 23 Feb 2022 07:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F8D2C0021;
	Wed, 23 Feb 2022 07:08:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16D93C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4C2A80B79
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2z1eMfw2MzhR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:08:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10ACC80B73
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645600119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rm2KeOaWQm/yGgRbJdODchW0H4miVO9/iqeAXn0Nkc=;
 b=Szod/jBPdqwXIOccKlGDN68fnsJkqXhyucpufb36wsfv56D2SSJPJe3XI9nv5L455kkg9k
 GOKNGmq+jAubYqKM5WpTJcRepXhR0kG7xUOYCoKzHIYsbcISc98pcilDNiE7foP9eMpH8u
 gvnu5cHGJo3uj1kdC8WdRDtQ7ke8ezk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-gkIaBmWzNZabEtQh9YMTuQ-1; Wed, 23 Feb 2022 02:08:38 -0500
X-MC-Unique: gkIaBmWzNZabEtQh9YMTuQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 g17-20020adfa591000000b001da86c91c22so9874736wrc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 23:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4rm2KeOaWQm/yGgRbJdODchW0H4miVO9/iqeAXn0Nkc=;
 b=WudXSIH2FIm9E62E1qgpjCRkGrZEobh5dXNVn6D6FjR+6WDA187842iEdtOJ6ngxIU
 E9bBVl3DUDQT5jRKzzaCrtIiB0bs3LCKyOjAjMvN/xIPlCmo5U/NoeyRGeu3FUi/Tf25
 RT4UtMFsunaWLtvqJe28lUChIadxF6FOpDCpC8tKuUh5iHvDg112ZugY0YPP811UgaAp
 ODoxqebD8IVHCf+4xBu5dfckcIrRSr5TGwqrBN/yHaxr1UkYxQHz4+sz7kLdXMq2x/NQ
 vnmnQ+wJgw6vlEUPlNDUf3cPq7pHQ38LaLsvcxJdva/wmxE2lZDOeOt8uG1h4uannDAN
 dvBw==
X-Gm-Message-State: AOAM5338XzvLA2+mPxeHFvCx7a8T/S+bPXMW/f1K1t8MJXPkajMfP3JY
 OjOXDx0GDhftkUj36ZJxOOdiqbPtrePGFd+M4oJI5bkML7WSBZeC//GWBXuzvbJtjz72K+/IWW6
 H7Yh0PVHlBMAzArCotiSvBoulQS0wrMzkc0Omes70og==
X-Received: by 2002:a7b:c143:0:b0:37b:dacd:bf2f with SMTP id
 z3-20020a7bc143000000b0037bdacdbf2fmr6154644wmi.16.1645600117177; 
 Tue, 22 Feb 2022 23:08:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+GFh97whIOSuNZIFHT24l5YnFjkQwsxacN320vC8AIXK0xpLOYTUY/wY71XkrJ/Nn38fVQQ==
X-Received: by 2002:a7b:c143:0:b0:37b:dacd:bf2f with SMTP id
 z3-20020a7bc143000000b0037bdacdbf2fmr6154632wmi.16.1645600116974; 
 Tue, 22 Feb 2022 23:08:36 -0800 (PST)
Received: from redhat.com ([2.55.144.92]) by smtp.gmail.com with ESMTPSA id
 j26-20020a05600c1c1a00b0037bf81c237dsm4859013wms.32.2022.02.22.23.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 23:08:36 -0800 (PST)
Date: Wed, 23 Feb 2022 02:08:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: aovid reading flag from the descriptor ring
Message-ID: <20220223020452-mutt-send-email-mst@kernel.org>
References: <20211108081324.14204-1-jasowang@redhat.com>
 <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > for split virtqueue") tries to make it possible for the driver to not
> > read from the descriptor ring to prevent the device from corrupting
> > the descriptor ring. But it still read the descriptor flag from the
> > descriptor ring during buffer detach.
> >
> > This patch fixes by always store the descriptor flag no matter whether
> > DMA API is used and then we can avoid reading descriptor flag from the
> > descriptor ring. This eliminates the possibly of unexpected next
> > descriptor caused by the wrong flag (e.g the next flag).
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Michael, any comment for this?
> 
> Thanks

I don't exactly see why we should care without DMA API, it seems
cleaner not to poke at the array one extra time.

> > ---
> >  drivers/virtio/virtio_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 00f64f2f8b72..28734f4e57d3 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >         }
> >         /* Last one doesn't continue. */
> >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > -       if (!indirect && vq->use_dma_api)
> > +       if (!indirect)
> >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> >                         ~VRING_DESC_F_NEXT;
> >
> > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >         /* Put back on free list: unmap first-level descriptors and find end */
> >         i = head;
> >
> > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > +       while (vq->split.desc_extra[i].flags & nextflag) {
> >                 vring_unmap_one_split(vq, i);
> >                 i = vq->split.desc_extra[i].next;
> >                 vq->vq.num_free++;
> > --
> > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
