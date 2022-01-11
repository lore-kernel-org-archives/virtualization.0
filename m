Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE9DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 06:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A3BE4062F;
	Tue, 11 Jan 2022 06:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8CaB6cPMGXoE; Tue, 11 Jan 2022 06:28:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B920C40374;
	Tue, 11 Jan 2022 06:28:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92640C0030;
	Tue, 11 Jan 2022 06:28:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8850C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8EEE829DC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G89dG5GREOCx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:28:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CED7827BB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:28:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V1YMO2R_1641882490; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1YMO2R_1641882490) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 11 Jan 2022 14:28:10 +0800
MIME-Version: 1.0
message-id: <1641881842.1001978-2-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 0/6] virtio: support advance DMA
date: Tue, 11 Jan 2022 14:17:22 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEshgEO3GBezLVo1t1hQHN00e2rZbsXhDfq4-dANc-CXEA@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
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

On Tue, 11 Jan 2022 10:54:45 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jan 10, 2022 at 5:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jan 07, 2022 at 02:33:00PM +0800, Xuan Zhuo wrote:
> > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > virtqueue_add().
> > >
> > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > >
> > > This patch set stipulates that if sg->dma_address is not NULL, use this
> > > address as the DMA address. And record this information in extra->flags,
> > > which can be skipped when executing dma unmap.
> > >
> > >     extra->flags |= VRING_DESC_F_PREDMA;
> > >
> > > But the indirect desc does not have a corresponding extra, so the second and
> > > third patches of this patch set are to allocate the corresponding extra while
> > > allocating the indirect desc. Each desc must have a corresponding extra because
> > > it is possible in an sgs some are advance DMA, while others are virtual
> > > addresses. So we must allocate an extra for each indirect desc.
> >
> >
> > I didn't realize AF_XDP didn't have space to stuff the header into.
> > Jason, is that expected?
>
> I might be wrong but it looks to me AF_XDP allows to reserve
> sufficient headroom via xdp_umem_reg_v1.
>

I understand that there is a headroom for receiving packages, which can be used
to put virtio headers. But there is no headroom defined in the direction of
sending packages. I hope Magnus Karlsson can help confirm whether there is any
misunderstanding.

It would be best if we could not use indirect.

Thanks.

> > It would be best to fix that, performance is
> > best if header is linear with the data ...
>
> This looks like a must otherwise we may meet trouble in zerocopy receive.
>
> Thanks
>
> > Or maybe we can reduce the use of indirect somewhat, at least while
> > the ring is mostly empty?
> >
> > > Xuan Zhuo (6):
> > >   virtio: rename vring_unmap_state_packed() to
> > >     vring_unmap_extra_packed()
> > >   virtio: split: alloc indirect desc with extra
> > >   virtio: packed: alloc indirect desc with extra
> > >   virtio: split: virtqueue_add_split() support dma address
> > >   virtio: packed: virtqueue_add_packed() support dma address
> > >   virtio: add api virtio_dma_map() for advance dma
> > >
> > >  drivers/virtio/virtio_ring.c | 387 ++++++++++++++++++++---------------
> > >  include/linux/virtio.h       |   9 +
> > >  2 files changed, 232 insertions(+), 164 deletions(-)
> > >
> > > --
> > > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
