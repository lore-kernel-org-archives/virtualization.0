Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E471BC433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 03:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C31E40356;
	Mon, 21 Feb 2022 03:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z4PlF3Q-dQPy; Mon, 21 Feb 2022 03:53:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08B4B40355;
	Mon, 21 Feb 2022 03:53:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCFF4C0033;
	Mon, 21 Feb 2022 03:53:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5133C001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 842FB404EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pfEGJJcTSzcJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:53:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C0CC40018
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 03:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645415627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=US1vMFhYOTrQkT8wqAtoPxHG3JSCJRVGRUhPE+hVnz4=;
 b=SozD9GIKuUxxxbVYmnNaByIyH7zI2p3MY1swAGVohszvzBYOn2axuRfNVWGoxvcoSKQulA
 xwsOQR5Q8nPwzxUfit+gFtrSTYEDibagPuQXlioHnCTOd+Uhmy791jWrnFachis467OkWr
 PxjlJaCRMUW1CXbhyyzkfkdcxZrUZCU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-mj7TORpINh2FyUh34EFuqQ-1; Sun, 20 Feb 2022 22:53:46 -0500
X-MC-Unique: mj7TORpINh2FyUh34EFuqQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 v24-20020a056512349800b0043f1c29459bso2267129lfr.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 19:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=US1vMFhYOTrQkT8wqAtoPxHG3JSCJRVGRUhPE+hVnz4=;
 b=nnZVR+4/YGM4e8Brz3m9SoXah1B2FeTzGZ020xB2id7KsHpq6SmI+WGjWMYX4vAvaq
 nDrbgPNlms7Vv1y0wJ8lMtAPXacwJEWD0k+UrzaIcawekXlCvhobeNZO2Ks5MN58dXz4
 wu6iRektn/Ev7h3SnLic57LrS6hi9YRhONGCc2WUeD9VVp2ZXeO2wcLPJ6RBUfACjb3C
 oYJM8DOr1+n8hf0KQVzuG988cu2zVOxPUvrVHjtA/mxnosCUsDziX6UEUhHPtEYKk6MF
 3c4vh1pLQrOefSlHN0Kt+jUuSupTJTrQTJhYPBYG/5xDyyvLjY0m44mcby1Ybvl1CpKg
 DD+Q==
X-Gm-Message-State: AOAM532sx4VjoY/zjBxIuCDY4ezmAwIcn6I0CsFFQWNxYWaNEmbNfXPL
 nI1UqDnPcjubXoxPQnOQJJ4Zt6n3ntqdGiTWbI0cw3uY2hoLnMrPsoS3cfa9+umVwccWhJ/ljgT
 ZUhqKWKTYKX3OHteUoB5wC8SWrw8o2bzzQb4WJb+eUfzjkB/bOsLrR2L6aA==
X-Received: by 2002:a05:6512:6c4:b0:437:9409:984c with SMTP id
 u4-20020a05651206c400b004379409984cmr12613803lff.199.1645415624583; 
 Sun, 20 Feb 2022 19:53:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgIaPl6LHgfHrq8OJQn2WkEPaLB+nKUth6tQbEYu6waFnTG0Gjaq9gS+33hHVaHqc8nV3pqoiCEWE88vqyAIo=
X-Received: by 2002:a05:6512:6c4:b0:437:9409:984c with SMTP id
 u4-20020a05651206c400b004379409984cmr12613798lff.199.1645415624399; Sun, 20
 Feb 2022 19:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
 <1645414751.8578591-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1645414751.8578591-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Feb 2022 11:53:33 +0800
Message-ID: <CACGkMEts1ZCteMtqVotdQ5uo0OKBbyxwTuiWJRHcf553_Le2jQ@mail.gmail.com>
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

On Mon, Feb 21, 2022 at 11:46 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 21 Feb 2022 11:32:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Fri, Feb 18, 2022 at 5:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Thu, 17 Feb 2022 15:19:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Thu, Feb 10, 2022 at 4:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > > virtqueue_add().
> > > > >
> > > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > > >
> > > > I'd suggest rename this feature as "unmanaged DMA".
> > >
> > > OK
> > >
> > > >
> > > > >
> > > > > Record this predma information in extra->flags, which can be skipped when
> > > > > executing dma unmap.
> > > >
> > > > Question still, can we use per-virtqueue flag instead of per
> > > > descriptor flag? If my memory is correct, the answer is yes in the
> > > > discussion for the previous version.
> > > >
> > >
> > > Yes.
> > >
> > > per-virtqueue? I guess it should be per-submit.
> > >
> > > This patch set only adds a flag to desc_extra[head].flags, so that we can know
> > > if we need to unmap dma when we detach.
> >
> > I meant if we can manage to make it per virtqueue, there's no need to
> > maintain per buffer flag.
> >
> > So we know something that needs to be mapped by virtio core itself,
> > e.g the indirect page. Other than this, all the rest could be
> > pre-mapped.
> >
> > For vnet header, it could be mapped by virtio-net which could be still
> > treated as pre mapped DMA since it's not the virtio ring code.
> >
> > Anything I miss here?
>
> I guess, your understanding is that after the queue is reset, the queue is used
> by xsk(AF_XDP), then all commits to this vq are premapped amd address.
>
> This is ok for rx.
>
> But for tx, just like XDP TX, although vq is used by xsk, the kernel also passes
> skb to it at the same time. It is shared.

Right.

>
> We can guarantee that the sg of the sgs submitted at one time uses the premapped
> dma address or virtual address uniformly. It is not guaranteed that all the sgs
> to the vq are uniform

Sorry, I don't understand here. We can let virtio-net do the mapping
even for TX, then from the virtio_ring point of view, it's still
pre-mapped?

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
> > >
> > > Thanks.
> > >
> > > > Thanks
> > > >
> > > > >
> > > > > v1:
> > > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > > >       of them are not supported to be PREDMA
> > > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > > >       together with the next time AF_XDP supports virtio dma
> > > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > > >       indirect desc
> > > > >
> > > > > Xuan Zhuo (6):
> > > > >   virtio: rename vring_unmap_state_packed() to
> > > > >     vring_unmap_extra_packed()
> > > > >   virtio: remove flags check for unmap split indirect desc
> > > > >   virtio: remove flags check for unmap packed indirect desc
> > > > >   virtio: virtqueue_add() support predma
> > > > >   virtio: split: virtqueue_add_split() support dma address
> > > > >   virtio: packed: virtqueue_add_packed() support dma address
> > > > >
> > > > >  drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
> > > > >  1 file changed, 126 insertions(+), 73 deletions(-)
> > > > >
> > > > > --
> > > > > 2.31.0
> > > > >
> > > >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
