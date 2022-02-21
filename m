Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004A1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 06:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4B8B40242;
	Mon, 21 Feb 2022 06:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvhBLo_mPVDW; Mon, 21 Feb 2022 06:56:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2694404D7;
	Mon, 21 Feb 2022 06:56:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90982C0021;
	Mon, 21 Feb 2022 06:56:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1F5CC0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 06:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CD5E404D7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 06:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bFFEE3NAil-n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 06:56:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 182E040242
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645426612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=istccTXEr8h9AE8JpOdSZc00K68i7NmuR75sax4uQWg=;
 b=b/4FiPXfIk0I1uB9TooiWeS62ag2hDEFc0aaRM+sVvDiI7ex/6YEGJd8ERQbzltvENP3tT
 nFCudz2Bng9qG5PEHwdx+63LNSlX0usnx3xKTacs15ulX4vmzLoVkyfpQEj9g6M5OfC0bD
 eoNDiFQ4ugev/hooNnoRLGzhe2CHJiM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-sbiwLmKKNJinQebE-0XNlQ-1; Mon, 21 Feb 2022 01:56:50 -0500
X-MC-Unique: sbiwLmKKNJinQebE-0XNlQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 r27-20020a2e575b000000b002463f43ca0aso933123ljd.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 22:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=istccTXEr8h9AE8JpOdSZc00K68i7NmuR75sax4uQWg=;
 b=kryDbrUNycYglk6ga5kuKS+1Y1tHJ4wzNOGQBwiIppww8IrRGSx/ScjgU1Vgm5x80N
 D4/StUdxMLKZc3r+CZG4ERY0DDmn+x0ByD8RPq4nuup3rxYfvDrAU0u6lTHjDm7ayq9K
 HVztXuBNhDW88fbWsL0ZiS8XIlV64fi4x6ARsxyx80qcIRjGBjZM9bWY6Bo8FXSkye6d
 /qdKoceG3icDed3kgadynqttK/LRG42gOZCNuihQ8tkVWSlDXddpJA28pGV2fU9gKyN7
 dw8GQO00ymctc+ENzFAxI2BearYv0qTkcqy+BMc2JwSbNqktNTmbKBr0f5wAnmumDxOZ
 c3SQ==
X-Gm-Message-State: AOAM532SLsnlfgw11G/RGbPRFonlaspVAjRlqrkFSA+hc7GcCpEdwpZv
 niu984AEfVkRJgF7KgSkntkAhYwavxeH4Wd0xlSV16f8SMMLK+9vQJ0NuVhfBmjSvwPYIkvencU
 kqye+cMCy2BIvGPXv828hABdKViIQrddXE4VgT5OZYqk2ZT4dFrdM9d56LA==
X-Received: by 2002:a2e:a5c2:0:b0:246:1f60:4f4d with SMTP id
 n2-20020a2ea5c2000000b002461f604f4dmr11339899ljp.362.1645426608632; 
 Sun, 20 Feb 2022 22:56:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSsFG3MiCsPfuc8uHYAMShBgqUCA5/91Y8cPeoJwCN2mTX60R0rugwzTQQHgDVfNeGwJFErwa2PnhMETwuhFI=
X-Received: by 2002:a2e:a5c2:0:b0:246:1f60:4f4d with SMTP id
 n2-20020a2ea5c2000000b002461f604f4dmr11339889ljp.362.1645426608359; Sun, 20
 Feb 2022 22:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
 <1645414751.8578591-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEts1ZCteMtqVotdQ5uo0OKBbyxwTuiWJRHcf553_Le2jQ@mail.gmail.com>
 <1645423146.5578375-2-xuanzhuo@linux.alibaba.com>
 <1645424291.1354678-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvsEVgGi4JXXVxm2jTGcmJwPu5EAVXtsJGCuv3f-b5U3w@mail.gmail.com>
 <1645426008.0806975-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1645426008.0806975-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Feb 2022 14:56:36 +0800
Message-ID: <CACGkMEvu3vWPTfjuWBG8232QtwXshNvxtgP5U9+MjFEUG1Gi5w@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Feb 21, 2022 at 2:48 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 21 Feb 2022 14:37:49 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Mon, Feb 21, 2022 at 2:20 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Mon, 21 Feb 2022 13:59:06 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > On Mon, 21 Feb 2022 11:53:33 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > On Mon, Feb 21, 2022 at 11:46 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > >
> > > > > > On Mon, 21 Feb 2022 11:32:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > On Fri, Feb 18, 2022 at 5:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, 17 Feb 2022 15:19:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > On Thu, Feb 10, 2022 at 4:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > > > > > > > virtqueue_add().
> > > > > > > > > >
> > > > > > > > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > > > > > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > > > > > > > >
> > > > > > > > > I'd suggest rename this feature as "unmanaged DMA".
> > > > > > > >
> > > > > > > > OK
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Record this predma information in extra->flags, which can be skipped when
> > > > > > > > > > executing dma unmap.
> > > > > > > > >
> > > > > > > > > Question still, can we use per-virtqueue flag instead of per
> > > > > > > > > descriptor flag? If my memory is correct, the answer is yes in the
> > > > > > > > > discussion for the previous version.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes.
> > > > > > > >
> > > > > > > > per-virtqueue? I guess it should be per-submit.
> > > > > > > >
> > > > > > > > This patch set only adds a flag to desc_extra[head].flags, so that we can know
> > > > > > > > if we need to unmap dma when we detach.
> > > > > > >
> > > > > > > I meant if we can manage to make it per virtqueue, there's no need to
> > > > > > > maintain per buffer flag.
> > > > > > >
> > > > > > > So we know something that needs to be mapped by virtio core itself,
> > > > > > > e.g the indirect page. Other than this, all the rest could be
> > > > > > > pre-mapped.
> > > > > > >
> > > > > > > For vnet header, it could be mapped by virtio-net which could be still
> > > > > > > treated as pre mapped DMA since it's not the virtio ring code.
> > > > > > >
> > > > > > > Anything I miss here?
> > > > > >
> > > > > > I guess, your understanding is that after the queue is reset, the queue is used
> > > > > > by xsk(AF_XDP), then all commits to this vq are premapped amd address.
> > > > > >
> > > > > > This is ok for rx.
> > > > > >
> > > > > > But for tx, just like XDP TX, although vq is used by xsk, the kernel also passes
> > > > > > skb to it at the same time. It is shared.
> > > > >
> > > > > Right.
> > > > >
> > > > > >
> > > > > > We can guarantee that the sg of the sgs submitted at one time uses the premapped
> > > > > > dma address or virtual address uniformly. It is not guaranteed that all the sgs
> > > > > > to the vq are uniform
> > > > >
> > > > > Sorry, I don't understand here. We can let virtio-net do the mapping
> > > > > even for TX, then from the virtio_ring point of view, it's still
> > > > > pre-mapped?
> > > > >
> > > >
> > > > Yes, we can do this. My previous thought was to keep the skb path unchanged.
> >
> > We can listen from Michael and others but I think it would be simpler.
> >
> > And we can even make the pre-mapped per driver. E.g for virtio-net we
> > just let the virtio-net driver do the DMA mapping. This allows us to
> > do a lot of optimizations (e.g page flip) as what other networking
> > drivers did.
> >
> > > >
> > > > Then we can make it clear that in the case of xsk, after completing the queue
> > > > reset, all the addresses submitted to virtio are the addresses of the completed
> > > > dma, including the skb case, the dma map operation must be completed first.
> > > >
> > > > In this case, I feel like we can do without this patch set.
> > >
> > > I originally thought that use_dma_api could be reused, but I found that this is
> > > not the case. The logic of sg_phys() does not meet our ideas. We still have a
> > > separate flag.
> >
> > Just to make sure I understand here, for this flag you mean
> >
> > 1) per buffer
> > 2) per virtqueue
> > or
> > 3) per device?
>
>
> As far as this question is concerned, I personally prefer per virtqueue. Because
> this will be more flexible. It is also very simple to implement per device based
> on this, as long as each vq is set to premapped mode.

It should be fine I think.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks.
> > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > v1:
> > > > > > > > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > > > > > > > >       of them are not supported to be PREDMA
> > > > > > > > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > > > > > > > >       together with the next time AF_XDP supports virtio dma
> > > > > > > > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > > > > > > > >       indirect desc
> > > > > > > > > >
> > > > > > > > > > Xuan Zhuo (6):
> > > > > > > > > >   virtio: rename vring_unmap_state_packed() to
> > > > > > > > > >     vring_unmap_extra_packed()
> > > > > > > > > >   virtio: remove flags check for unmap split indirect desc
> > > > > > > > > >   virtio: remove flags check for unmap packed indirect desc
> > > > > > > > > >   virtio: virtqueue_add() support predma
> > > > > > > > > >   virtio: split: virtqueue_add_split() support dma address
> > > > > > > > > >   virtio: packed: virtqueue_add_packed() support dma address
> > > > > > > > > >
> > > > > > > > > >  drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
> > > > > > > > > >  1 file changed, 126 insertions(+), 73 deletions(-)
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.31.0
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
