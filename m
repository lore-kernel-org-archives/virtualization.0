Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C00C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 07:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E594410D4;
	Wed, 23 Feb 2022 07:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZE-fXspVxBjx; Wed, 23 Feb 2022 07:34:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4F80410DB;
	Wed, 23 Feb 2022 07:34:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A49CC0021;
	Wed, 23 Feb 2022 07:34:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51C62C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AAFE81CEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NH4UWzdNOK0p
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:34:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 857BC812C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 07:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645601686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=McSwbVQkHiXC8iu7T4MJhFzHcjjvF5/k+kIazZQNsRc=;
 b=NXqqOOoVewjVxm6Y4nBHoRCPIV6X2ThJApM55ZSj2Uel5BvKmnS/XJ1IoW1xh8tJ4ICBmf
 joXv2pfYZbLxTZfeRfoiofwM9axupqWuquoGRfbBj8s74gvT7mJrhFh+PcwtfkdRn26DX8
 u9HWxMy2ZzBFn7fXptc9wBoDlDrnRWU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-IVF0xBrbN8SuWwFQQGj2Kw-1; Wed, 23 Feb 2022 02:34:45 -0500
X-MC-Unique: IVF0xBrbN8SuWwFQQGj2Kw-1
Received: by mail-lf1-f70.google.com with SMTP id
 a5-20020ac25205000000b00443a34a9472so3128047lfl.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 23:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=McSwbVQkHiXC8iu7T4MJhFzHcjjvF5/k+kIazZQNsRc=;
 b=rH4/M0tisEMCtt/bT79PwF3n1VTT3hQRhnj2qjSKCCBTOwjFaOgZ8+TNECAGZTzywH
 kLBOSyZSbGPNeB8v1/vSTWqEBzgUReK+yK1Kwv8Qx8dZU9im8YXyU9eXR2Ayn/wbhkAi
 mGtQbyoSUn+KTwQ0iuJZW+pATLMJAQeCCRQATTN0b5xmA792KcK3Ig6QGggIV+sgwFoQ
 WnHww6hSjaI+9iNuhEPovFDmsox/AkBDz+aUN/GXzVTSheAJYOt0CzmD4yRzfD0EM5A+
 5jd8RdfgKq1kjd3n9Prn11rKMzbjwjlmTyrRZc+8SslsrMCzk4TJesi9/zvm9l+7aCTw
 Ecpg==
X-Gm-Message-State: AOAM530bVx/Mo5aqJUkhCMFeWNbIsU956XE5E6Xob/GLs05ei7NJMQXL
 IKGFuHgi5r63MU2oJqsN/Myp/d7w+dY3KqkbkYe8Wrt8japLGEgijRSiDuOj/aOrodQX6eorNYT
 1MqV8kaEp6eJaLE6ZBa1G+c0BTOIu8WKKABIl4+VekfAZTNpjrVr41b6UTA==
X-Received: by 2002:a05:6512:15a0:b0:443:96ac:11d with SMTP id
 bp32-20020a05651215a000b0044396ac011dmr18882995lfb.471.1645601683502; 
 Tue, 22 Feb 2022 23:34:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz46i8/q8ySRYQ6BTiY1ws+UNE6QavM6rT+wdU2ZmAtcmlZScVKO5j44ixU2NQgf2Y3Yx8osUMfzsWo/hJLY0g=
X-Received: by 2002:a05:6512:15a0:b0:443:96ac:11d with SMTP id
 bp32-20020a05651215a000b0044396ac011dmr18882988lfb.471.1645601683277; Tue, 22
 Feb 2022 23:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20211108081324.14204-1-jasowang@redhat.com>
 <CACGkMEucnZPt_dhaSXCegeFE0gs=dSDfv7CJSq4HCW_4a4XfGg@mail.gmail.com>
 <20220223020452-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220223020452-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 15:34:32 +0800
Message-ID: <CACGkMEu2UkOpGHJyKGzjJHMa3RmOoCmqD1iD_nh+pVcT63BQqA@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 23, 2022 at 11:19:03AM +0800, Jason Wang wrote:
> > On Mon, Nov 8, 2021 at 4:13 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > Commit 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra
> > > for split virtqueue") tries to make it possible for the driver to not
> > > read from the descriptor ring to prevent the device from corrupting
> > > the descriptor ring. But it still read the descriptor flag from the
> > > descriptor ring during buffer detach.
> > >
> > > This patch fixes by always store the descriptor flag no matter whether
> > > DMA API is used and then we can avoid reading descriptor flag from the
> > > descriptor ring. This eliminates the possibly of unexpected next
> > > descriptor caused by the wrong flag (e.g the next flag).
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Michael, any comment for this?
> >
> > Thanks
>
> I don't exactly see why we should care without DMA API, it seems
> cleaner not to poke at the array one extra time.

I think the answer is that we have any special care about the DMA API
for all other places that are using desc_extra.

Thanks


>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 00f64f2f8b72..28734f4e57d3 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >         }
> > >         /* Last one doesn't continue. */
> > >         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > -       if (!indirect && vq->use_dma_api)
> > > +       if (!indirect)
> > >                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> > >                         ~VRING_DESC_F_NEXT;
> > >
> > > @@ -713,7 +713,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > >         /* Put back on free list: unmap first-level descriptors and find end */
> > >         i = head;
> > >
> > > -       while (vq->split.vring.desc[i].flags & nextflag) {
> > > +       while (vq->split.desc_extra[i].flags & nextflag) {
> > >                 vring_unmap_one_split(vq, i);
> > >                 i = vq->split.desc_extra[i].next;
> > >                 vq->vq.num_free++;
> > > --
> > > 2.25.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
