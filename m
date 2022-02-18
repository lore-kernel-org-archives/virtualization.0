Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A424C433F5
	for <virtualization@archiver.kernel.org>; Fri, 18 Feb 2022 09:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A94BD83F19;
	Fri, 18 Feb 2022 09:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dvlvYLAOrxM6; Fri, 18 Feb 2022 09:30:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 15F6283EFA;
	Fri, 18 Feb 2022 09:30:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB4F3C0011;
	Fri, 18 Feb 2022 09:30:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A82AC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 09:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6460B41805
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 09:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H4HujShSsCqi
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 09:30:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4C7C4176F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 09:30:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R891e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V4oXrnC_1645176606; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4oXrnC_1645176606) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 18 Feb 2022 17:30:07 +0800
Message-ID: <1645176590.2488885-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
Date: Fri, 18 Feb 2022 17:29:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
 <1645174523.8877885-1-xuanzhuo@linux.alibaba.com>
 <20220218041948-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220218041948-mutt-send-email-mst@kernel.org>
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, 18 Feb 2022 04:24:58 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Feb 18, 2022 at 04:55:23PM +0800, Xuan Zhuo wrote:
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
>
> IIUC when you say "dma is completed" you really mean "memory is mapped
> for dma". What is special is that virtio suddenly gets s/g that is
> already mapped for DMA, not in the way DMA (direct memory access) itself
> happens. right? Pls document as such.
> And this is why I'd call this flag "mapped" or "premapped", not
> "predma". "unmanaged" is also ok, though it's a bit vague wrt what
> exactly is managed.
> I'll defer to Jason on this.  Jason what do you prefer?

OK. Thanks

>
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
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
