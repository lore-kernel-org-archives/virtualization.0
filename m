Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345811701
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 07:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C7F082B49
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 07:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C7F082B49
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GspBbkQZx8MW
	for <virtualization@lists.linux-foundation.org>;
	Tue, 16 Jan 2024 07:47:15 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 854A982AF5
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 07:47:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 854A982AF5
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W-lNSlX_1705391227;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-lNSlX_1705391227)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 15:47:08 +0800
Message-ID: <1705390340.4814627-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Tue, 16 Jan 2024 15:32:20 +0800
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
In-Reply-To: <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 11 Jan 2024 16:34:09 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > get buf from virtio core for premapped mode.
> >
> > If the virtio queue is premapped mode, the virtio-net send buf may
> > have many desc. Every desc dma address need to be unmap. So here we
> > introduce a new helper to collect the dma address of the buffer from
> > the virtio core.
> >
> > Because the BAD_RING is called (that may set vq->broken), so
> > the relative "const" of vq is removed.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++----------
> >  include/linux/virtio.h       |  16 ++++
> >  2 files changed, 142 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 51d8f3299c10..1374b3fd447c 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const struct v=
ring_virtqueue *vq)
> >         return vq->dma_dev;
> >  }
> >
> > +/*
> > + *     use_dma_api premapped -> do_unmap
> > + *  1. false       false        false
> > + *  2. true        false        true
> > + *  3. true        true         false
> > + *
> > + * Only #3, we should return the DMA info to the driver.
>
> Btw, I guess you meant "#3 is false" here?
>
> And could we reduce the size of these 3 * 3 matrices? It's usually a
> hint that the code is not optmized.

On the process of doing dma map, we force the (use_dma_api, premapped).

if premapped:
     virtio core skip dma map
else:
	if use_dma_api:
		do dma map
	else:
		work with the physical address.

Here we force the (premapped, do_unmap).

do_unmap is an optimization. We just check this to know should we do dma un=
map
or not.

Now, we introduced an new case, when the virtio core skip dma unmap,
we may need to return the dma info to the driver. That just occur when
the (premapped, do_unmap) is (true, false). Because that the (premmaped,
do_unmap) may be (false, false).

For the matrices, I just want to show where the do_unmap comes from.
That is a optimization, we use this many places, not to check (use_dma_api,
premapped) on the process of doing unmap. And only for the case #3, we shou=
ld
return the dma info to drivers.

Thanks.

>
> Thanks
>
>
