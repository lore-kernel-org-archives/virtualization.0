Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61049D2E5
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644511; cv=none; b=uZa6BW5+fNzXoHGU2+X4CBgS0tc/cc4ZOjM7KRJOPOguHpFJtTYN/KPsDMLr0pmeAnnWM4KgJ6VZHLzgrhY4g/kLN8IMWUo64hskCqsbZOX/UucyggxmLhPmr6TOtOCMjZnKiyeqw35KM5tX2maODzKAY6OB7SxFDSdUsXWXyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644511; c=relaxed/simple;
	bh=bgVAcuwY1SKXG3vjyzdqlv2nugV2OGyQixNnAyg2jA8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=GuBdw21dxjAM9CHNH400NNubho3mpOQR5V7LwhbEZfD1q1PlGAHJD1N0nGq92v3V9b+N8ZjYd65kx9k7VLOJKiwC/tjXbCXBpow7xt258mHDNdtVqfQnz/ZCIAtLfsDf34w0EvJ1PmjOwcsT5tchS/wy4/Oxl4gAuOx4WfCRGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D3LBOZwR; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D3LBOZwR"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE007403A2
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 03:28:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -17.499
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xp2bGw0o_gaz for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 03:28:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=xuanzhuo@linux.alibaba.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 811A9400BA
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 811A9400BA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D3LBOZwR
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 811A9400BA
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 03:27:51 +0000 (UTC)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717644456; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=OFu44R6J/QcE53wYRSjB6IeSCEeSV0oNByx8BtNCsr4=;
	b=D3LBOZwR9Q5ILxAq+Ri7cnJ5SG9jUb8gRWhB77uylIyq2Ka/G+DCJLNuKFuC9iDXSb5VCgvdNk4WWumKQ1sPKuTG/kBmIwHdiPHRbT9REnktfzOaxD1r4SDtnGNIHJaoU/6WzFnsWrkZo0sd/GN2m62O6pUuwbcMd5TMxDDZWYc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7wj7E1_1717644453;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7wj7E1_1717644453)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 11:27:34 +0800
Message-ID: <1717644183.6895547-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
Date: Thu, 6 Jun 2024 11:23:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John  Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Alexander  Potapenko <glider@google.com>,
 virtualization@lists.linux-foundation.org
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com>
 <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
In-Reply-To: <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 04 Jun 2024 18:07:44 +0200, Ilya Leoshkevich <iii@linux.ibm.com> wr=
ote:
> On Thu, 2023-08-10 at 20:30 +0800, Xuan Zhuo wrote:
> > If the vq is the premapped mode, use the sg_dma_address() directly.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> > =C2=A0drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
> > =C2=A01 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c
> > b/drivers/virtio/virtio_ring.c
> > index 8e81b01e0735..f9f772e85a38 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct
> > vring_virtqueue *vq)
> > =C2=A0static int vring_map_one_sg(const struct vring_virtqueue *vq, str=
uct
> > scatterlist *sg,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 enum dma_data_direction direction,
> > dma_addr_t *addr)
> > =C2=A0{
> > +	if (vq->premapped) {
> > +		*addr =3D sg_dma_address(sg);
> > +		return 0;
> > +	}
> > +
>
> I wonder if something needs to be done for KMSAN here, like it's done
> by the next block in this function? I'm looking into what seems to be a
> KMSAN false positive on s390x:
>
> BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
>  receive_buf+0x45ca/0x6990
>  virtnet_poll+0x17e0/0x3130
>  net_rx_action+0x832/0x26e0
>  handle_softirqs+0x330/0x10f0
>  [...]
>
> Uninit was created at:
>  __alloc_pages_noprof+0x62a/0xe60
>  alloc_pages_noprof+0x392/0x830
>  skb_page_frag_refill+0x21a/0x5c0
>  virtnet_rq_alloc+0x50/0x1500
>  try_fill_recv+0x372/0x54c0
>  virtnet_open+0x210/0xbe0
>  __dev_open+0x56e/0x920
>  __dev_change_flags+0x39c/0x2000
>  dev_change_flags+0xaa/0x200
>  do_setlink+0x197a/0x7420
>  rtnl_setlink+0x77c/0x860
>  [...]
>
> My understanding is that virtnet_rq_alloc() allocates a page for
> receiving data from a virtio device, which is then wrapped in struct
> scatterlist by virtnet_rq_init_one_sg(), which is in turn associated
> with a virtqueue through the virtqueue_add_inbuf_ctx() ->
> virtqueue_add() -> virtqueue_add_split() -> vring_map_one_sg()
> call chain.
>
> Someone should unpoison this page (since KMSAN doesn't know that the
> hypervisor writes to it), and today for the non-premapped case this is
> vring_map_one_sg(). So I tried the following naive fix:
>
>         if (vq->premapped) {
>                 *addr =3D sg_dma_address(sg);
> +               if (!vq->use_dma_api) {
> +                       kmsan_handle_dma(phys_to_page(*addr), sg-
> >offset, sg->length, direction);
> +               }
>
> but it didn't help. I plan to investigate this further, but any hints
> are much appreciated.
>
> > =C2=A0	if (!vq->use_dma_api) {
> > =C2=A0		/*
> > =C2=A0		 * If DMA is not used, KMSAN doesn't know that the
> > scatterlist


Could you try this?

Thanks.

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 37c9c5b55864..cb280b66c7a2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3119,8 +3119,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct vir=
tqueue *_vq, void *ptr,
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       if (!vq->use_dma_api)
+       if (!vq->use_dma_api) {
+               kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), si=
ze, dir);
                return (dma_addr_t)virt_to_phys(ptr);
+       }

        return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attr=
s);
 }
@@ -3171,8 +3173,10 @@ dma_addr_t virtqueue_dma_map_page_attrs(struct virtq=
ueue *_vq, struct page *page
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       if (!vq->use_dma_api)
+       if (!vq->use_dma_api) {
+               kmsan_handle_dma(page, offset, size, dir);
                return page_to_phys(page) + offset;
+       }

        return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, di=
r, attrs);
 }
