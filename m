Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352403BE64B
	for <virtualization@lists.linux.dev>; Sat, 13 Jun 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353607; cv=none; b=KwSGu6PFRNgOaiAmVD1lziRAwsSYif0GeoT6OsRjdrhORLTsVrHsj5kA9l39l7jNsCKz7l0VfOsuqvtffqPvlDCvu17vJqzeQa5vuu1PTfVNGvhYiqCPSFUDqSBMDOqPu0+9g+IHpwI8s4S8QRmTgtbiLhgscilgQan83r9+pQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353607; c=relaxed/simple;
	bh=+Utq3396aQFNMgv97jxeXtkc7/pqfXum3no/lPBQ9rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpdKTZxhsaCtPnbdNvSWpIjwR2dj9jF6tHoKx/fde2T4o3UbBpnxksepHaWYMKM56scMygW/NgKQ0eGAx+W5h71MUU8p9RSW9eKTJ/MnRxH9iwdpGVOnthkDaxi1/HMQsRI0MdlOdZoqNpb0HSEc8XHgDhDL1EpX6bpV3pv5UHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fVNFhJBH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fVNFhJBH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781353600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezZ4R5waX9NiYNreVYNEdpvd6VvEUg7nWNgpBzpChj4=;
	b=fVNFhJBHstCvbysj7S3frgErmLO4n20mCXB15L0+aV4Iqhg8aSto2Vr8WlJH0WA1SG866W
	M8onNIvAJ3GzcMDUoCACBi/5d7CI4VZD/4b4SasNfgJPN595wjpx7McwgmHxxYJsjFDVX2
	ph6KSW5rORttgaEXHl9PdtIrZhK+1WY=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
Date: Sat, 13 Jun 2026 20:26:26 +0800
Message-ID: <rHZz5_ylT4WggoZ-Ic2Q4w@linux.dev>
In-Reply-To: <41eefa1d-99bf-450d-988e-7dec67c6b61e@gmail.com>
References:
 <20260611025644.2431148-1-dongml2@chinatelecom.cn>
 <20260611025644.2431148-2-dongml2@chinatelecom.cn>
 <41eefa1d-99bf-450d-988e-7dec67c6b61e@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/12 00:24, Bui Quang Minh wrote:
> On 6/11/26 09:56, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > During packet receiving in virtio-net, the rq can be empty, which means
> > "rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
> > virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
> > can be empty too, which means we can't allocate anything from
> > xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.
> >
> > However, if the user clean all the data in rx ring and fill the
> > "fill ring" and check the XDP_RING_NEED_WAKEUP flag after
> > xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(), then the rx
> > napi will never be scheduled: the rx ring is empty, which means we will
> > never receive a packet to trigger the further recv fill. The rx ring is
> > empty now, so the user will not check the flag too.
> >
> > Fix this by set the XDP_RING_NEED_WAKEUP flag before
> > xsk_buff_alloc_batch() if both rq->vq and fill ring are empty.
> >
> > Meanwhile, set the XDP_RING_NEED_WAKEUP flag if we have any free entry in
> > rq->vq.
> >
> > Fixes: e3f8800aa243 ("virtio-net: xsk: Support wakeup on RX side")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >   drivers/net/virtio_net.c | 25 ++++++++++++++++++++++---
> >   1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..4b5b3fa62008 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
> >   				   struct xsk_buff_pool *pool, gfp_t gfp)
> >   {
> >   	struct xdp_buff **xsk_buffs;
> > +	bool need_wakeup;
> >   	dma_addr_t addr;
> >   	int err = 0;
> >   	u32 len, i;
> >   	int num;
> >   
> > +	need_wakeup = xsk_uses_need_wakeup(pool);
> >   	xsk_buffs = rq->xsk_buffs;
> >   
> > +	/* If both rq->vq and fill ring are empty, and then the user submit
> > +	 * all the chunks to the fill ring and check the wake up flag
> > +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> > +	 * we will lose the chance to wake up the rx napi, so we have to
> > +	 * set the need_wakeup flag here.
> > +	 */
> > +	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
> > +		xsk_set_rx_need_wakeup(pool);
> 

Hi, Bui Quang. Thanks for your reply. I spent some time learning
what you said.

> I think when polling the receive queue, the userspace program needs to 
> check the XDP_RING_NEED_WAKEUP flag if it does not see any packets. The 
> flag check is quite lightweight in my opinion. Here are some examples I find
> 
> - 
> https://github.com/xdp-project/xdp-tools/blob/e9469501622aa22a7e452a671000bec8685edcde/lib/util/xdpsock.c#L1206

You are right, I'm over concerned about this point. My origin
concern is that we can't wake up from the poll syscall in this case:

The chunk of the umem is 2000. In the beginning, the xsk->fill_ring
is filled with 2000 chunk, and then the user fall asleep and don't
do anything.

Kernel: the 2000th packet is received
Kernel: xsk_buff_alloc_batch return 0(xsk->fill_ring is empty and xsk->rx_ring is full)

        User: handle the xsk->rx_ring
        User: fill the xsk->fill_ring with 2000 chunks
        User: check the wake up flag
        User: no need_wakeup flag, fall asleep with poll() syscall

Kernel: call xsk_set_rx_need_wakeup()
Kernel: virio-net rx ringbuf is empty, we can't receive any packet further
Kernel: to call virtnet_add_recvbuf_xsk(), we are dead

But then, I found that we can still be wake up with the 2000th
packet from the poll syscall, which means that the case that
the NAPI and the user can't both be waked up doesn't exist.

> - 
> https://github.com/xdp-project/bpf-examples/blob/43e565901c4287efa863edca7f0e6cd6e35ed896/AF_XDP-forwarding/xsk_fwd.c#L540
> 
> Furthermore, the XDP_RING_NEED_WAKEUP flag related functions does not 
> provide any memory orderings. So even with your patch, I'm worried that 
> this case is possible
> 
> kernel userspace
> 
> xsk_buff_alloc_batch -> failed
>                                                              submit fill 
> ring
>                                                              flag != 
> XDP_RING_NEED_WAKEUP
> // reordering due to lack of memory orderings
> xsk_set_rx_need_wakeup
> 
> I'm not expert here, so correct me if I'm wrong. I think the wake up 
> flag is designed with no orderings so we cannot rely on it to reason and 
> skip further checks.
> 
> > +
> >   	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
[....]
> > +
> 
> Why do we need to set XDP_RING_NEED_WAKEUP even when 
> xsk_buff_alloc_batch succeeds?

Ah, don't mind here. I just thought that if xsk_buff_alloc_batch()
didn't allocate enough chunks as we need, we can wake up
the NAPI as soon as possible, in case that the virtio-net ringbuf
is full and cause packet dropping :)

Anyway, I'll remove the first patch, and send the second patch
only in the V3.

Thanks!
Menglong Dong

> 
> >   	return num;
> >   
> >   err:
> 
> Thanks,
> Quang Minh.
> 
> 
> 
> 




