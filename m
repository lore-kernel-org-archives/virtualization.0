Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EF5C433EF
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 03:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA6328145A;
	Mon, 21 Feb 2022 03:33:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pu9aMGiD8lx4; Mon, 21 Feb 2022 03:33:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4690781455;
	Mon, 21 Feb 2022 03:33:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB32FC0033;
	Mon, 21 Feb 2022 03:33:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F53AC001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7284360C2F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lZGMHdMeDLBT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:33:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DDD960B9B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645414387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJWH0+1pWQwWVXEaxFsFSWjtVq074vwGKdR42piA2jk=;
 b=iojQB0ym0OgxgMqvh5DWzBl/2qEoWe/iPRGf1EKcGCUukQzGCgdg0qTs8OdsWIGmkPlrzj
 k4NWucu8kqtH1c39amvr6L1idBxOjLGRSaDhT+TH6JFoB4a8bIhihVcKdYfqpTQoHN2pMT
 +p1yg9C18tVro1tEGts18o1O+jnF8Z4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-lCKmkJFjNPuCBPt3e6PBBg-1; Sun, 20 Feb 2022 22:33:06 -0500
X-MC-Unique: lCKmkJFjNPuCBPt3e6PBBg-1
Received: by mail-lf1-f72.google.com with SMTP id
 z25-20020ac25df9000000b004435ff4bf94so2249109lfq.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 19:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JJWH0+1pWQwWVXEaxFsFSWjtVq074vwGKdR42piA2jk=;
 b=59WAhGio89QaPsh9WSJZ3ZSoJtwq5S7KyWpKeXfT+uC6pZq24tpIFlWwJE1LBsAU+s
 KHZXzVE7kwy2MGFM3Mu9eOeFAVGr1KmE/hlABijY+rHkXmMAVZvlA48QPfUjQ5VYjG2U
 3o5X+mSXHELuY/EUm5+q1+7PnS8ZifzHF6DglPbAZ3sbU6clz4e4PrhNvQgTzUNYtOCd
 xR1v3DKcHE40s6/ScATA542BS1ZAfpUkyqiNICRQS5AkMnzVCJWsd/mHEQoR8IAEXNy8
 KcKYOB1vg5U+zletiX5ZB4mzwOWzGjCnqWpZKVoW2N3YnzbiMyY90MVUyOxw7UXiLQiC
 9WLA==
X-Gm-Message-State: AOAM530uE8aAWRoUPsgQ/aKLO7XdhaDyH2JFWMB0sEBzlcuXmT1g45ZW
 AVRoFc9p3JvR4beIjyJVKMrUURHtqqmhB439lwR/bzNtPD3AP+2xHo7Kz/pa1C01fAqNvZL+D7R
 uScyYPmjhUloy6ZDQ4HZyWwdL5Yl+NB0MnocMQIox11TfQAtDEx/+jwm6bQ==
X-Received: by 2002:a05:6512:6c4:b0:437:9409:984c with SMTP id
 u4-20020a05651206c400b004379409984cmr12578043lff.199.1645414384798; 
 Sun, 20 Feb 2022 19:33:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZMV0C74WWDCYmbe3nlafRqBrBYf7AXgRZwu/aL/Bw1UZ0hR7NMuJWZwhJ5rnEsNts+F4RhBe5B9KoAFsgH+4=
X-Received: by 2002:a05:6512:6c4:b0:437:9409:984c with SMTP id
 u4-20020a05651206c400b004379409984cmr12578035lff.199.1645414384590; Sun, 20
 Feb 2022 19:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Feb 2022 11:32:52 +0800
Message-ID: <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Fri, Feb 18, 2022 at 5:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Thu, 17 Feb 2022 15:19:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Feb 10, 2022 at 4:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > virtqueue_add().
> > >
> > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > it is necessary for us to support passing the DMA address to virtqueue_add().
> >
> > I'd suggest rename this feature as "unmanaged DMA".
>
> OK
>
> >
> > >
> > > Record this predma information in extra->flags, which can be skipped when
> > > executing dma unmap.
> >
> > Question still, can we use per-virtqueue flag instead of per
> > descriptor flag? If my memory is correct, the answer is yes in the
> > discussion for the previous version.
> >
>
> Yes.
>
> per-virtqueue? I guess it should be per-submit.
>
> This patch set only adds a flag to desc_extra[head].flags, so that we can know
> if we need to unmap dma when we detach.

I meant if we can manage to make it per virtqueue, there's no need to
maintain per buffer flag.

So we know something that needs to be mapped by virtio core itself,
e.g the indirect page. Other than this, all the rest could be
pre-mapped.

For vnet header, it could be mapped by virtio-net which could be still
treated as pre mapped DMA since it's not the virtio ring code.

Anything I miss here?

Thanks


>
> Thanks.
>
> > Thanks
> >
> > >
> > > v1:
> > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > >       of them are not supported to be PREDMA
> > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > >       together with the next time AF_XDP supports virtio dma
> > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > >       indirect desc
> > >
> > > Xuan Zhuo (6):
> > >   virtio: rename vring_unmap_state_packed() to
> > >     vring_unmap_extra_packed()
> > >   virtio: remove flags check for unmap split indirect desc
> > >   virtio: remove flags check for unmap packed indirect desc
> > >   virtio: virtqueue_add() support predma
> > >   virtio: split: virtqueue_add_split() support dma address
> > >   virtio: packed: virtqueue_add_packed() support dma address
> > >
> > >  drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
> > >  1 file changed, 126 insertions(+), 73 deletions(-)
> > >
> > > --
> > > 2.31.0
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
