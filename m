Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCA9C433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 09:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4E6060DC6;
	Tue, 11 Jan 2022 09:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpvIQ6CTaNK5; Tue, 11 Jan 2022 09:23:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E9EE60ACE;
	Tue, 11 Jan 2022 09:23:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBE03C0030;
	Tue, 11 Jan 2022 09:23:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FCC9C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E82B82D0F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:23:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t_7FJYgcrIkw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:23:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E0D382D07
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:23:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R751e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V1ZTzNx_1641892985; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1ZTzNx_1641892985) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 11 Jan 2022 17:23:05 +0800
MIME-Version: 1.0
message-id: <1641892556.7161078-1-xuanzhuo@linux.alibaba.com>
subject: Re: RE: RE: [PATCH 0/6] virtio: support advance DMA
date: Tue, 11 Jan 2022 17:15:56 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: magnus.karlsson@intel.com
in-reply-to: <MW3PR11MB460249CF61015546801FFAF4F7519@MW3PR11MB4602.namprd11.prod.outlook.com>
Cc: "Michael S.Tsirkin" <mst@redhat.com>,
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

On Tue, 11 Jan 2022 09:01:21 +0000, Karlsson, Magnus <magnus.karlsson@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, January 11, 2022 9:30 AM
> > To: Jason Wang <jasowang@redhat.com>
> > Cc: Karlsson, Magnus <magnus.karlsson@intel.com>; virtualization
> > <virtualization@lists.linux-foundation.org>; Michael S.Tsirkin
> > <mst@redhat.com>
> > Subject: Re: RE: [PATCH 0/6] virtio: support advance DMA
> >
> > On Tue, 11 Jan 2022 16:25:44 +0800, Jason Wang <jasowang@redhat.com>
> > wrote:
> > > On Tue, Jan 11, 2022 at 4:17 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > wrote:
> > > >
> > > > On Tue, 11 Jan 2022 08:04:05 +0000, Karlsson, Magnus
> > <magnus.karlsson@intel.com> wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Sent: Tuesday, January 11, 2022 7:17 AM
> > > > > > To: Jason Wang <jasowang@redhat.com>
> > > > > > Cc: virtualization <virtualization@lists.linux-foundation.org>;
> > > > > > Michael S.Tsirkin <mst@redhat.com>; Karlsson, Magnus
> > > > > > <magnus.karlsson@intel.com>
> > > > > > Subject: Re: [PATCH 0/6] virtio: support advance DMA
> > > > > >
> > > > > > On Tue, 11 Jan 2022 10:54:45 +0800, Jason Wang
> > > > > > <jasowang@redhat.com>
> > > > > > wrote:
> > > > > > > On Mon, Jan 10, 2022 at 5:59 PM Michael S. Tsirkin
> > > > > > > <mst@redhat.com>
> > > > > > wrote:
> > > > > > > >
> > > > > > > > On Fri, Jan 07, 2022 at 02:33:00PM +0800, Xuan Zhuo wrote:
> > > > > > > > > virtqueue_add() only supports virtual addresses, dma is
> > > > > > > > > completed in virtqueue_add().
> > > > > > > > >
> > > > > > > > > In some scenarios (such as the AF_XDP scenario), DMA is
> > > > > > > > > completed in advance, so it is necessary for us to support
> > > > > > > > > passing the DMA address
> > > > > > to virtqueue_add().
> > > > > > > > >
> > > > > > > > > This patch set stipulates that if sg->dma_address is not
> > > > > > > > > NULL, use this address as the DMA address. And record this
> > > > > > > > > information in
> > > > > > > > > extra->flags, which can be skipped when executing dma unmap.
> > > > > > > > >
> > > > > > > > >     extra->flags |= VRING_DESC_F_PREDMA;
> > > > > > > > >
> > > > > > > > > But the indirect desc does not have a corresponding extra,
> > > > > > > > > so the second and third patches of this patch set are to
> > > > > > > > > allocate the corresponding extra while allocating the
> > > > > > > > > indirect desc. Each desc must have a corresponding extra
> > > > > > > > > because it is possible in an sgs some are advance DMA,
> > > > > > > > > while others are virtual addresses. So we must
> > > > > > allocate an extra for each indirect desc.
> > > > > > > >
> > > > > > > >
> > > > > > > > I didn't realize AF_XDP didn't have space to stuff the header into.
> > > > > > > > Jason, is that expected?
> > > > > > >
> > > > > > > I might be wrong but it looks to me AF_XDP allows to reserve
> > > > > > > sufficient headroom via xdp_umem_reg_v1.
> > > > > > >
> > > > > >
> > > > > > I understand that there is a headroom for receiving packages,
> > > > > > which can be used to put virtio headers. But there is no
> > > > > > headroom defined in the direction of sending packages. I hope
> > > > > > Magnus Karlsson can help confirm whether there is any
> > misunderstanding.
> > > > >
> > > > > You can specify the amount of headroom you want on Tx by adjusting
> > the "addr" field in the descriptor of the Tx ring. If your chunk starts at address
> > X in the umem and you want 128 bytes of headroom, just write your packet
> > into X+128 and put that address into the Tx descriptor. Will this solve your
> > problem? If not, what would you need from AF_XDP to make it work?
> > > > >
> > > > > On Rx, there is always 256 bytes worth of headroom as specified by
> > XDP. If you need extra, you can set the headroom variable when you register
> > the umem.
> > > >
> > > > The driver of virtio net, when passing the packet to the hardware,
> > > > should add a virtnet hdr (12 bytes) in front of the packet. Both rx
> > > > and tx should add such a header. AF_XDP has a space of 256 bytes in
> > > > the rx process. We can reuse this space. The direction of AF_XDP tx has
> > no such regulation.
> > > >
> > > > The method you mentioned requires user cooperation, which is not a
> > > > good method for driver implementation.
> > >
> > > This will result in a non-portable userspace program. I wonder why TX
> > > has become a problem here actually, anyhow we can use a dedicated sg
> > > for vnet hdr? And if we packed all vnet headers in an array it will
> > > give less performance impact.
> >
> > There is no problem in implementation, there are two performance points:
> >
> > 1. vnet hdr and packet are not connected memory 2. use indirect or occupy
> > two desc.
> >
> > By the way, @Karlsson, Magnus, due to the peculiarity of virtio, the DMA
> > implementation of virtio needs to call the specialized API of virtio (see the
> > last patch of this patch set). I am thinking about how xsk can support this:
> >
> > 1. Pass callback to xsk (must pass multiple callbacks including map, unmap,
> > map sync...) 2. xsk judges that it is virtio, and specifically calls virtio's DMA api
> >
> > Which one do you think is more suitable?
>
> I think that depends on if we expect more special DMA operations to pop up in the future or not? If not, then we should go with #2 since #1 has negative performance implications for the map_sync call as it is used for every packet in the data path. Could also argue that #1 is overdoing it until we know that there will be more sets of DMA operations than these two.
>
> As for the "judging", just provide a flag that the driver can set and the core xsk code can test. If I remember correctly, you had something like this in your AF_XDP virtio-net zero-copy patch set. Preferably located in a cache line that is already being used, for performance reasons.

In my opinion, only virtio should be special. So my choice #1.

In the previous patch set, the page was acquired and then passed to virtio, and
virtio implemented DMA. From a performance point of view, the idea of XSK's
advanced DMA is better, so I consider the idea of using advanced DMA in the next
version of the patch set.

Thanks.

>
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > > It would be best if we could not use indirect.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > > > It would be best to fix that, performance is best if header
> > > > > > > > is linear with the data ...
> > > > > > >
> > > > > > > This looks like a must otherwise we may meet trouble in zerocopy
> > receive.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > > Or maybe we can reduce the use of indirect somewhat, at
> > > > > > > > least while the ring is mostly empty?
> > > > > > > >
> > > > > > > > > Xuan Zhuo (6):
> > > > > > > > >   virtio: rename vring_unmap_state_packed() to
> > > > > > > > >     vring_unmap_extra_packed()
> > > > > > > > >   virtio: split: alloc indirect desc with extra
> > > > > > > > >   virtio: packed: alloc indirect desc with extra
> > > > > > > > >   virtio: split: virtqueue_add_split() support dma address
> > > > > > > > >   virtio: packed: virtqueue_add_packed() support dma address
> > > > > > > > >   virtio: add api virtio_dma_map() for advance dma
> > > > > > > > >
> > > > > > > > >  drivers/virtio/virtio_ring.c | 387 ++++++++++++++++++++-------
> > --------
> > > > > > > > >  include/linux/virtio.h       |   9 +
> > > > > > > > >  2 files changed, 232 insertions(+), 164 deletions(-)
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.31.0
> > > > > > > >
> > > > > > >
> > > >
> > >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
