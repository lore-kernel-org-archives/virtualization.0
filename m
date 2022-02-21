Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F095C433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 06:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 013E0813CE;
	Mon, 21 Feb 2022 06:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hYk_I7UkomuN; Mon, 21 Feb 2022 06:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7FDA0813C3;
	Mon, 21 Feb 2022 06:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3619CC0021;
	Mon, 21 Feb 2022 06:20:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 088F7C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 06:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D87D9813C3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 06:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Dx8tv5oZZp4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 06:19:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3902B813C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 06:19:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V5.8HpS_1645424395; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5.8HpS_1645424395) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 21 Feb 2022 14:19:55 +0800
Message-ID: <1645424291.1354678-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
Date: Mon, 21 Feb 2022 14:18:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEv-rhha5WFg+ef181RR5xZmyHkNyfDdcPA=HoDFZ_-Oxg@mail.gmail.com>
 <1645414751.8578591-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEts1ZCteMtqVotdQ5uo0OKBbyxwTuiWJRHcf553_Le2jQ@mail.gmail.com>
 <1645423146.5578375-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1645423146.5578375-2-xuanzhuo@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 21 Feb 2022 13:59:06 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Mon, 21 Feb 2022 11:53:33 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Mon, Feb 21, 2022 at 11:46 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Mon, 21 Feb 2022 11:32:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Fri, Feb 18, 2022 at 5:00 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > > On Thu, 17 Feb 2022 15:19:44 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > On Thu, Feb 10, 2022 at 4:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > > > > virtqueue_add().
> > > > > > >
> > > > > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > > > > >
> > > > > > I'd suggest rename this feature as "unmanaged DMA".
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Record this predma information in extra->flags, which can be skipped when
> > > > > > > executing dma unmap.
> > > > > >
> > > > > > Question still, can we use per-virtqueue flag instead of per
> > > > > > descriptor flag? If my memory is correct, the answer is yes in the
> > > > > > discussion for the previous version.
> > > > > >
> > > > >
> > > > > Yes.
> > > > >
> > > > > per-virtqueue? I guess it should be per-submit.
> > > > >
> > > > > This patch set only adds a flag to desc_extra[head].flags, so that we can know
> > > > > if we need to unmap dma when we detach.
> > > >
> > > > I meant if we can manage to make it per virtqueue, there's no need to
> > > > maintain per buffer flag.
> > > >
> > > > So we know something that needs to be mapped by virtio core itself,
> > > > e.g the indirect page. Other than this, all the rest could be
> > > > pre-mapped.
> > > >
> > > > For vnet header, it could be mapped by virtio-net which could be still
> > > > treated as pre mapped DMA since it's not the virtio ring code.
> > > >
> > > > Anything I miss here?
> > >
> > > I guess, your understanding is that after the queue is reset, the queue is used
> > > by xsk(AF_XDP), then all commits to this vq are premapped amd address.
> > >
> > > This is ok for rx.
> > >
> > > But for tx, just like XDP TX, although vq is used by xsk, the kernel also passes
> > > skb to it at the same time. It is shared.
> >
> > Right.
> >
> > >
> > > We can guarantee that the sg of the sgs submitted at one time uses the premapped
> > > dma address or virtual address uniformly. It is not guaranteed that all the sgs
> > > to the vq are uniform
> >
> > Sorry, I don't understand here. We can let virtio-net do the mapping
> > even for TX, then from the virtio_ring point of view, it's still
> > pre-mapped?
> >
>
> Yes, we can do this. My previous thought was to keep the skb path unchanged.
>
> Then we can make it clear that in the case of xsk, after completing the queue
> reset, all the addresses submitted to virtio are the addresses of the completed
> dma, including the skb case, the dma map operation must be completed first.
>
> In this case, I feel like we can do without this patch set.

I originally thought that use_dma_api could be reused, but I found that this is
not the case. The logic of sg_phys() does not meet our ideas. We still have a
separate flag.

Thanks.

>
> Thanks.
>
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > v1:
> > > > > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > > > > >       of them are not supported to be PREDMA
> > > > > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > > > > >       together with the next time AF_XDP supports virtio dma
> > > > > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > > > > >       indirect desc
> > > > > > >
> > > > > > > Xuan Zhuo (6):
> > > > > > >   virtio: rename vring_unmap_state_packed() to
> > > > > > >     vring_unmap_extra_packed()
> > > > > > >   virtio: remove flags check for unmap split indirect desc
> > > > > > >   virtio: remove flags check for unmap packed indirect desc
> > > > > > >   virtio: virtqueue_add() support predma
> > > > > > >   virtio: split: virtqueue_add_split() support dma address
> > > > > > >   virtio: packed: virtqueue_add_packed() support dma address
> > > > > > >
> > > > > > >  drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
> > > > > > >  1 file changed, 126 insertions(+), 73 deletions(-)
> > > > > > >
> > > > > > > --
> > > > > > > 2.31.0
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
