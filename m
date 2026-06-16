Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13C3290AD
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574528; cv=none; b=hsEU7vzO2i3LfmA3g3bDAfnSrmTk9fIy4Zi2tsTyHXIZ3MEde8PliM4krZVLQANqnv30kMx3T4ljOeQxC1W8fi7+0ku2uNzcMqSJFkn8lT7G4MxuVYzuZXOddp2lZ0oShPsfgENltuOaaaCSmPF4bF3ybNPBdc5LCc8er+xka6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574528; c=relaxed/simple;
	bh=7XzaTINS1hJ1Lb5cVNmfOrlVwdiU2qOLDLUP7Onxwlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NawXX+0M/TwXgj8CqPakqj/rizpVkjL/6HbN1CGhCw0AFoaRjOERiTivYyrwnoc2XYk9cWFO/7mAzIU3UzvyKJOXj20e1cXGI82ek3HYVIkVzZpgdkAB8G6ss/dXXcOsAywavd+iR3uLAQlJ0TQ6lInP1cLIXtkrtrZHJS5SODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YFK99coD; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YFK99coD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781574523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHUiwhB6MxO/dEKOjoHtoTJVpYMZ13oa1KW9nfW9n8w=;
	b=YFK99coDlLb66IZyZ/GSWrWiihMwrsMHY9bUpadDOzWix1wdKTNnEsYpchceVv/0hJ/aMm
	iIMttjX+aRPAMQoFK9aENpgrHug3nDQ4wLdjjHesS6O5PObwxapCey8U5x29rUrCfR+ZrT
	KnvTS5s9BvRilJ+xYKRChap/IiVDFPY=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 minhquangbui99@gmail.com, kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 eperezma@redhat.com
Subject: Re: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
Date: Tue, 16 Jun 2026 09:48:28 +0800
Message-ID: <y6i9tzXeQS-8Gft2xqLmIQ@linux.dev>
In-Reply-To: <1781491685.0613394-1-xuanzhuo@linux.alibaba.com>
References:
 <20260611025644.2431148-1-dongml2@chinatelecom.cn>
 <20260611025644.2431148-2-dongml2@chinatelecom.cn>
 <1781491685.0613394-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/15 10:48 Xuan Zhuo <xuanzhuo@linux.alibaba.com> write:
> On Thu, 11 Jun 2026 10:56:43 +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > During packet receiving in virtio-net, the rq can be empty, which means
> > "rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
> > virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
> > can be empty too, which means we can't allocate anything from
> > xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.
> >
[...]
> >
> > +	need_wakeup = xsk_uses_need_wakeup(pool);
> >  	xsk_buffs = rq->xsk_buffs;
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
> Is Condition A here too strict? We should trigger the wakeup under a wider range
> of scenarios.

Hi, Xuan. Thinks for your reviewing :)

The logic here is a addition logic to the origin wake up logic, which I planed
to fix a race condition. However, this race condition seems not likely to happen,
as we discussed in this thread:

https://lore.kernel.org/netdev/rHZz5_ylT4WggoZ-Ic2Q4w@linux.dev/

So this patch is not necessary, and I'll send the 2nd patch standalone.

Thanks!
Menglong Dong

> 
> > +
> >  	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> >  	if (!num) {
> > -		if (xsk_uses_need_wakeup(pool)) {
> > +		if (need_wakeup) {
> >  			xsk_set_rx_need_wakeup(pool);
> >  			/* Return 0 instead of -ENOMEM so that NAPI is
> >  			 * descheduled.
> > @@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
> >  		}
> >
> >  		return -ENOMEM;
> > -	} else {
> > -		xsk_clear_rx_need_wakeup(pool);
> >  	}
> >
> >  	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > @@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
> >  			goto err;
> >  	}
> >
> > +	if (need_wakeup) {
> > +		if (rq->vq->num_free)
> > +			/* We have free buffers, so we'd better wake up the
> > +			 * rx napi as soon as possible.
> > +			 */
> > +			xsk_set_rx_need_wakeup(pool);
> 
> Is the purpose of waking up RX NAPI to invoke try_fill_recv? However,
> virtnet_poll does not call try_fill_recv directly. it is done
> conditionally.
> 
> Thanks.
> 
> 
> > +		else
> > +			xsk_clear_rx_need_wakeup(pool);
> > +	}
> > +
> >  	return num;
> >
> >  err:
> > --
> > 2.54.0
> >
> 
> 



