Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B865672
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903942; cv=none; b=knNdrlBPYs3vesLTWsR5wwNaK3gbGtHScRTo1odUuq6sHlkdY3VjQcAHR/UlX7XxgHiq42eXVc9hynCrT5OVA+Cuhq/sGUrMTsLZutP9zRj763yKdZqMnNeN0x9yKR/yaz3nihURMDg2rU8pkFTueH3d9OH1U4s+jWsUKa0V1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903942; c=relaxed/simple;
	bh=ZuxfKqos1iB9Had5ORFMI/UkY5m/YWXWSgmx7Txplas=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=u9vqXrzq/ajIZTlPUW/W3lz24qVhV/q7dZ7m2LKY2C/rSf9Ew2ja8GHyFR00OIdacdQ6g3OF/4FUf+raoQbO2pi+BAFAlii6V62PnMytWFbVShqB4M4PyoMlBCX1WFaXzGjsaTRtMQwGVZxuAwoWuLCqFkch04aJtIw1MyxaaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6687582062
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 06:12:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6687582062
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhe8_k9ybLW6
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 06:12:18 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6EE2E82234
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 06:12:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6EE2E82234
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.1fZgZ_1705903929;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.1fZgZ_1705903929)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 14:12:10 +0800
Message-ID: <1705903444.5368986-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Mon, 22 Jan 2024 14:04:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
 <20231229073108.57778-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
 <1705390340.4814627-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEuo7m82cTxFSeryyYemMP8AgeKgE6kKYqoFGChTZ7KNWA@mail.gmail.com>
In-Reply-To: <CACGkMEuo7m82cTxFSeryyYemMP8AgeKgE6kKYqoFGChTZ7KNWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 22 Jan 2024 12:18:51 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 16, 2024 at 3:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 11 Jan 2024 16:34:09 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > > > get buf from virtio core for premapped mode.
> > > >
> > > > If the virtio queue is premapped mode, the virtio-net send buf may
> > > > have many desc. Every desc dma address need to be unmap. So here we
> > > > introduce a new helper to collect the dma address of the buffer from
> > > > the virtio core.
> > > >
> > > > Because the BAD_RING is called (that may set vq->broken), so
> > > > the relative "const" of vq is removed.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++------=
----
> > > >  include/linux/virtio.h       |  16 ++++
> > > >  2 files changed, 142 insertions(+), 48 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 51d8f3299c10..1374b3fd447c 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const stru=
ct vring_virtqueue *vq)
> > > >         return vq->dma_dev;
> > > >  }
> > > >
> > > > +/*
> > > > + *     use_dma_api premapped -> do_unmap
> > > > + *  1. false       false        false
> > > > + *  2. true        false        true
> > > > + *  3. true        true         false
> > > > + *
> > > > + * Only #3, we should return the DMA info to the driver.
> > >
> > > Btw, I guess you meant "#3 is false" here?
> > >
> > > And could we reduce the size of these 3 * 3 matrices? It's usually a
> > > hint that the code is not optmized.
> >
> > On the process of doing dma map, we force the (use_dma_api, premapped).
> >
> > if premapped:
> >      virtio core skip dma map
> > else:
> >         if use_dma_api:
> >                 do dma map
> >         else:
> >                 work with the physical address.
> >
> > Here we force the (premapped, do_unmap).
> >
> > do_unmap is an optimization. We just check this to know should we do dm=
a unmap
> > or not.
> >
> > Now, we introduced an new case, when the virtio core skip dma unmap,
> > we may need to return the dma info to the driver. That just occur when
> > the (premapped, do_unmap) is (true, false). Because that the (premmaped,
> > do_unmap) may be (false, false).
> >
> > For the matrices, I just want to show where the do_unmap comes from.
> > That is a optimization, we use this many places, not to check (use_dma_=
api,
> > premapped) on the process of doing unmap. And only for the case #3, we =
should
> > return the dma info to drivers.
>
> Ok, it tries to ease the life of the readers.
>
> I wonder if something like
>
> bool virtqueue_needs_unmap() can help, it can judge based on the value
> of use_dma_api and premapped.


I think not too much.

Because do_unmap is for this.



+static bool vring_need_unmap(struct vring_virtqueue *vq,
+			     struct virtio_dma_head *dma,
+			     dma_addr_t addr, unsigned int length)
+{
+	if (vq->do_unmap)
+		return true;

Before this, we is to judge whether we should do unmap or not.
After this, we is to judge whehter we should return dma info to driver or n=
ot.

If you want to simplify this function, I will say no.

If you want to replace "do_unmap" with virtqueue_needs_unmap(), I will say =
ok.
But I think we donot need to do that.

+
+	if (!vq->premapped)
+		return false;
+
+	if (!dma)
+		return false;
+
+	if (unlikely(dma->next >=3D dma->num)) {
+		BAD_RING(vq, "premapped vq: collect dma overflow: %pad %u\n",
+			 &addr, length);
+		return false;
+	}
+
+	dma->items[dma->next].addr =3D addr;
+	dma->items[dma->next].length =3D length;
+
+	++dma->next;
+
+	return false;
+}


Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > >
> >
>
