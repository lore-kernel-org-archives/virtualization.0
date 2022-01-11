Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE8AC433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 02:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EE4E40319;
	Tue, 11 Jan 2022 02:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3E4rq-Jk0VB; Tue, 11 Jan 2022 02:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDB4040874;
	Tue, 11 Jan 2022 02:03:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96FC2C002F;
	Tue, 11 Jan 2022 02:03:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAE4DC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9698D405F0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCMAj8xsX97K
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:03:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B8F4040471
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:03:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V1Wn5Rx_1641866579; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1Wn5Rx_1641866579) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 11 Jan 2022 10:03:00 +0800
MIME-Version: 1.0
message-id: <1641866421.217453-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v3 0/3] virtio support cache indirect desc
date: Tue, 11 Jan 2022 10:00:21 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20220110084054-mutt-send-email-mst@kernel.org>
x-mailing-list: netdev@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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

On Mon, 10 Jan 2022 08:50:08 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jan 06, 2022 at 08:48:59PM +0800, Xuan Zhuo wrote:
> > On Thu, 6 Jan 2022 07:28:31 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Fri, Oct 29, 2021 at 02:28:11PM +0800, Xuan Zhuo wrote:
> > > > If the VIRTIO_RING_F_INDIRECT_DESC negotiation succeeds, and the number
> > > > of sgs used for sending packets is greater than 1. We must constantly
> > > > call __kmalloc/kfree to allocate/release desc.
> > >
> > >
> > > So where is this going? I really like the performance boost. My concern
> > > is that if guest spans NUMA nodes and when handler switches from
> > > node to another this will keep reusing the cache from
> > > the old node. A bunch of ways were suggested to address this, but
> > > even just making the cache per numa node would help.
> > >
> >
> > In fact, this is the problem I encountered in implementing virtio-net to support
> > xdp socket. With virtqueue reset[0] has been merged into virtio spec. I
> > am completing this series of work. My plan is:
> >
> > 1. virtio support advance dma
> > 2. linux kernel/qemu support virtqueue reset
> > 3. virtio-net support AF_XDP
> > 4. virtio support cache indirect desc
> >
> > [0]: https://github.com/oasis-tcs/virtio-spec/issues/124
> >
> > Thanks.
>
> OK it's up to you how to prioritize your work.
> An idea though: isn't there a way to reduce the use of indirect?
> Even with all the caching, it is surely not free.
> We made it work better in the past with:
>
> commit e7428e95a06fb516fac1308bd0e176e27c0b9287
>     ("virtio-net: put virtio-net header inline with data").
> and
> commit 6ebbc1a6383fe78be3c0961d1475043ac6cc2542
>     virtio-net: Set needed_headroom for virtio-net when VIRTIO_F_ANY_LAYOUT is true
>
> can't something similar be done for XDP?
>
>
>
> Another idea is to skip indirect even with s/g as number of outstanding
> entries is small. The difficulty with this approach is that it has
> to be tested across a large number of configurations, including
> storage to make sure we don't cause regressions, unless we
> are very conservative and only make a small % of entries direct.
> Will doing that still help? It looks attractive on paper:
> if guest starts outpacing host and ring begins to fill
> up to more than say 10% then we switch to allocating indirect
> entries which slows guest down.
>

I see what you mean, I will try to reduce the use of indirect.
And bring performance test data.

Thanks for your opinion.

>
>
> > >
> > > > In the case of extremely fast package delivery, the overhead cannot be
> > > > ignored:
> > > >
> > > >   27.46%  [kernel]  [k] virtqueue_add
> > > >   16.66%  [kernel]  [k] detach_buf_split
> > > >   16.51%  [kernel]  [k] virtnet_xsk_xmit
> > > >   14.04%  [kernel]  [k] virtqueue_add_outbuf
> > > >    5.18%  [kernel]  [k] __kmalloc
> > > >    4.08%  [kernel]  [k] kfree
> > > >    2.80%  [kernel]  [k] virtqueue_get_buf_ctx
> > > >    2.22%  [kernel]  [k] xsk_tx_peek_desc
> > > >    2.08%  [kernel]  [k] memset_erms
> > > >    0.83%  [kernel]  [k] virtqueue_kick_prepare
> > > >    0.76%  [kernel]  [k] virtnet_xsk_run
> > > >    0.62%  [kernel]  [k] __free_old_xmit_ptr
> > > >    0.60%  [kernel]  [k] vring_map_one_sg
> > > >    0.53%  [kernel]  [k] native_apic_mem_write
> > > >    0.46%  [kernel]  [k] sg_next
> > > >    0.43%  [kernel]  [k] sg_init_table
> > > >    0.41%  [kernel]  [k] kmalloc_slab
> > > >
> > > > This patch adds a cache function to virtio to cache these allocated indirect
> > > > desc instead of constantly allocating and releasing desc.
> > > >
> > > > v3:
> > > >   pre-allocate per buffer indirect descriptors array
> > > >
> > > > v2:
> > > >   use struct list_head to cache the desc
> > > >
> > > > *** BLURB HERE ***
> > > >
> > > > Xuan Zhuo (3):
> > > >   virtio: cache indirect desc for split
> > > >   virtio: cache indirect desc for packed
> > > >   virtio-net: enable virtio desc cache
> > > >
> > > >  drivers/net/virtio_net.c     |  11 +++
> > > >  drivers/virtio/virtio.c      |   6 ++
> > > >  drivers/virtio/virtio_ring.c | 131 ++++++++++++++++++++++++++++++-----
> > > >  include/linux/virtio.h       |  14 ++++
> > > >  4 files changed, 145 insertions(+), 17 deletions(-)
> > > >
> > > > --
> > > > 2.31.0
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
