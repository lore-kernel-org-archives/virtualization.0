Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08C5C433F5
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85D7E41B6E;
	Wed, 30 Mar 2022 06:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MTpeJ63bzEvB; Wed, 30 Mar 2022 06:59:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C364541927;
	Wed, 30 Mar 2022 06:59:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 917ADC002C;
	Wed, 30 Mar 2022 06:59:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5036C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 933C0611A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lvqc6qN7Tqs6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:59:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 404356118B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:59:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V8cbEuS_1648623587; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V8cbEuS_1648623587) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 30 Mar 2022 14:59:48 +0800
Message-ID: <1648623508.9711535-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
Date: Wed, 30 Mar 2022 14:58:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
 <20220330023258-mutt-send-email-mst@kernel.org>
 <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
In-Reply-To: <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, 30 Mar 2022 14:56:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 30, 2022 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > virtqueue_add().
> > >
> > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > it is necessary for us to support passing the DMA address to virtqueue_add().
> >
> > I picked up a couple of patches. Others are waiting for some acks
> > (Jason?) and improved commit logs for documentation.
>
> I will review them.

hi, the core code of premapped, I will merge it into 'virtio pci support
VIRTIO_F_RING_RESET' because this function will be used when reusing the buffer
after resize.

Thanks.


>
> Thanks
>
> >
> > Thanks!
> >
> > > v2:
> > >     1. rename predma -> premapped
> > >     2. virtio net xdp tx use virtio dma api
> > >
> > > v1:
> > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > >       of them are not supported to be PREDMA
> > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > >       together with the next time AF_XDP supports virtio dma
> > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > >       indirect desc
> > >
> > > Xuan Zhuo (9):
> > >   virtio_ring: rename vring_unmap_state_packed() to
> > >     vring_unmap_extra_packed()
> > >   virtio_ring: remove flags check for unmap split indirect desc
> > >   virtio_ring: remove flags check for unmap packed indirect desc
> > >   virtio_ring: virtqueue_add() support premapped
> > >   virtio_ring: split: virtqueue_add_split() support premapped
> > >   virtio_ring: packed: virtqueue_add_packed() support premapped
> > >   virtio_ring: add api virtio_dma_map() for advance dma
> > >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> > >   virtio_net: xdp xmit use virtio dma api
> > >
> > >  drivers/net/virtio_net.c     |  42 +++++-
> > >  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
> > >  include/linux/virtio.h       |  12 ++
> > >  3 files changed, 254 insertions(+), 80 deletions(-)
> > >
> > > --
> > > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
