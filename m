Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1765EC433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 11:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B388E40928;
	Mon, 21 Feb 2022 11:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bKBC8ADv_Vhw; Mon, 21 Feb 2022 11:32:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 482234091E;
	Mon, 21 Feb 2022 11:32:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A713C001A;
	Mon, 21 Feb 2022 11:32:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C3B8C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D07F60E17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fng_IMN6-o3t
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:32:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC8DE60AEB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 11:32:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0V556M7-_1645443144; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V556M7-_1645443144) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 21 Feb 2022 19:32:24 +0800
Message-ID: <1645442604.5901623-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
Date: Mon, 21 Feb 2022 19:23:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
In-Reply-To: <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 21 Feb 2022 11:32:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Feb 18, 2022 at 5:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Thu, 17 Feb 2022 15:19:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > On Thu, Feb 10, 2022 at 4:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > virtqueue_add().
> > > >
> > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > >
> > > I'd suggest rename this feature as "unmanaged DMA".
> >
> > OK
> >
> > >
> > > >
> > > > Record this predma information in extra->flags, which can be skipped when
> > > > executing dma unmap.
> > >
> > > Question still, can we use per-virtqueue flag instead of per
> > > descriptor flag? If my memory is correct, the answer is yes in the
> > > discussion for the previous version.
> > >
> >
> > Yes.
> >
> > per-virtqueue? I guess it should be per-submit.
> >
> > This patch set only adds a flag to desc_extra[head].flags, so that we can know
> > if we need to unmap dma when we detach.
>
> I meant if we can manage to make it per virtqueue, there's no need to
> maintain per buffer flag.
>

Rethinking this question, I feel there is no essential difference between per
virtqueue and per sgs.

per virtqueue:
	1. add buf:
		a. check vq->premapped for map every sg
	2. detach:
	        a. check vq->premaped for unmap

per sgs:
	1. add buf:
	        a. check function parameter "premapped" for map every sg
		b. add flag to extra[head].flag

	2. detach:
	        a: check extra[head].flag for unmap


Thanks.


> So we know something that needs to be mapped by virtio core itself,
> e.g the indirect page. Other than this, all the rest could be
> pre-mapped.
>
> For vnet header, it could be mapped by virtio-net which could be still
> treated as pre mapped DMA since it's not the virtio ring code.
>
> Anything I miss here?
>
> Thanks
>
>
> >
> > Thanks.
> >
> > > Thanks
> > >
> > > >
> > > > v1:
> > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > >       of them are not supported to be PREDMA
> > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > >       together with the next time AF_XDP supports virtio dma
> > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > >       indirect desc
> > > >
> > > > Xuan Zhuo (6):
> > > >   virtio: rename vring_unmap_state_packed() to
> > > >     vring_unmap_extra_packed()
> > > >   virtio: remove flags check for unmap split indirect desc
> > > >   virtio: remove flags check for unmap packed indirect desc
> > > >   virtio: virtqueue_add() support predma
> > > >   virtio: split: virtqueue_add_split() support dma address
> > > >   virtio: packed: virtqueue_add_packed() support dma address
> > > >
> > > >  drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
> > > >  1 file changed, 126 insertions(+), 73 deletions(-)
> > > >
> > > > --
> > > > 2.31.0
> > > >
> > >
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
