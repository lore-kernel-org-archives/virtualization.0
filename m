Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556902DCC13
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131323; cv=none; b=QFfNxDCzsdiqKYed44rE4AFmw0XPfaT5Z3VbhUNX0WlJiJwYjkHWe2N0ohxjNLFy8Jnzm7urAMm0jcdxTMlpquDdXTeL0viTUF1w+agMTq+nMecMCNNGe/Viciol5KjfGPYf9ZNuLOr5vMzZCcTTT/OVRrvQVegSgJ26pOlL32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131323; c=relaxed/simple;
	bh=ilMbIHxM3LO0PFkjI+Cz2/XDUU5BLHB92aMMMp0DQys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GekhrjE7YqW8vu95By+fWnaIRepdAmwJJIOHjOGGMpY8HBzvA0/X0hgLN7aBQ90vXLUJAGDBT1MpXXKYd4nMd+W62/+yC4WH0tBe54LavnPe9vRQ0dyGgsPFWBoDXDnR6CKhZMOXbKckTOnnXIKwVWHhNzZOSj8rNYeri/G/O8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iul6CYjc; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iul6CYjc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782131319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgblrmP0/YIgfsoN/hQkF4Nh8mmKPXKlUQ9nt/ej4G8=;
	b=iul6CYjc2sWR1WDrBFqVfauMJoNatGCBcGFeqCqMfDEBuhmy+i+34mndFi4W/v7M6aR04m
	hvoEZcLsid+9dtRxkDOu8ZEaAQl80dcBbbnUzF5jeoIIWJ0H9aDnRm1VKk+A65vSljroZc
	sxTJr5s/ArxevMr1Wi3DES3tkcBSdck=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, eperezma@redhat.com
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Date: Mon, 22 Jun 2026 20:28:30 +0800
Message-ID: <JKxclkQrSOi004E_FpT2eg@linux.dev>
In-Reply-To: <1782096043.3540094-1-xuanzhuo@linux.alibaba.com>
References:
 <20260616115912.513183-1-dongml2@chinatelecom.cn>
 <1782096043.3540094-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/6/22 10:40 Xuan Zhuo <xuanzhuo@linux.alibaba.com> write:
> On Tue, 16 Jun 2026 19:59:12 +0800, Menglong Dong <menglong8.dong@gmail.com> wrote:
> > For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> > in the tx path for example: we set xsk_set_tx_need_wakeup() in
> > virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> > anywhere, which means the user will call send() for every packet.
> >
> > We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> > is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> > Otherwise, we will clear the wakeup flag.
> >
> > Race condition is considered for tx path.
> >
> > Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
> 
> This is not a bug, so we do not need this.
> And you post this to net-next.

Okay, I'll remove this tag in the V4.

> 
> 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v3:
[...]
> > +
> > +	if (need_wakeup && vring_size == sq->vq->num_free)
> > +		xsk_set_tx_need_wakeup(pool);
> 
> You need to comment this.

Ack!

> 
> 
> > +
[...]
> > +
> >  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> >  		check_sq_full_and_disable(vi, vi->dev, sq);
> 
> 
> After fixed above comments, you can add:
> 
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

OK! Thanks for the review :)

> 
> Thanks.
> 
> 
> >
> > @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> >  	u64_stats_add(&sq->stats.xdp_tx,  sent);
> >  	u64_stats_update_end(&sq->stats.syncp);
> >
> > -	if (xsk_uses_need_wakeup(pool))
> > -		xsk_set_tx_need_wakeup(pool);
> > -
> >  	return sent;
> >  }
> >
> > --
> > 2.54.0
> >
> 
> 




