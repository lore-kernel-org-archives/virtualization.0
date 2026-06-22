Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C943546C9
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134667; cv=none; b=Yhg94/u0k075Iit9kwVg9v5gZZqWmn7CgbshsRN2xCj33Oz+FrO7UnC5+qkVpxxGFQrFI5/12YDjV5uuZrY6lcv2SF7Q+l8WFF3nk4hUO4Gfnnw34AjQWVGVCwMfMorDLZiJqOwWyw+eKFCyfez/2sEzc5g+aqgoKt8Ib8UaVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134667; c=relaxed/simple;
	bh=cjAXUTzNPqS4dOTkuXMbpmtFoEhnSMkBNWuo/+4MBf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SNk7bnVIYMT8osAPQ3CEmAPmU4WVV3IvDFg1PxHH3Lmz2f1VXJPIl7twv2lBhNtQMkRYAzC4DQkRK0mCH80HFKxcRqh14ps616X8y1NapxiTsvHmlG4s9s6SXcyNwtRLJge2yYs+WvpXhQpK0sb5T3M8QkDp3a10o7P3ZOkoy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+4YsLlU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+4YsLlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782134665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rfm03S2KrDPchvPaJf082C9fX5hmkhy7ZeP2RTcSj3M=;
	b=P+4YsLlUvm+UX6Ni4zWlphFoZ0oDiUe+sA9TZ31ODMmwmwIJUWWcP6X1doGZftu2QYtVJy
	fC18BSuZIlHamryH3qrw6TZ3Yl6Pz7fFh2Y9sdErPG2V0nd8pk+0gTRuhRYKqXC4WlDZe9
	j0mPJemaSXFWcpnTCevJ2phe3avUOMw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-QCW60Me_O0StgplFp6Wb7g-1; Mon, 22 Jun 2026 09:24:24 -0400
X-MC-Unique: QCW60Me_O0StgplFp6Wb7g-1
X-Mimecast-MFC-AGG-ID: QCW60Me_O0StgplFp6Wb7g_1782134663
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ab3f6e55so28540345e9.0
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 06:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134663; x=1782739463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfm03S2KrDPchvPaJf082C9fX5hmkhy7ZeP2RTcSj3M=;
        b=cG9AeQntcCYg8ebOJd0x75NS0YeOXM2H2Qv9/Y7WeImAx8sA5bhiCCWTl3H6YTPNEk
         rZn32v+P3qQyNvb6psNV5Eht/mPv+Lcy8TMpaNlh9w8fgxk8XHUBka539dxStaL+6ZXF
         cjyMzFW+DJA3ABiGj0sAowzXYpj/DTf2Vf7RiZ+ZH8QLdR9nS47XY8x3y5no8y/a+baF
         2nLIz2j4TlwIetEyNK20GTavXWmb9znat+6yHHjTsCVvi2+28OyOzZSTeoD8dgWTcDHY
         i7tsgeVIYwBl2iNL09V2BpMe6zPpxRTGJwgbZ9Y17G8V/bSWkhBiOfMa2JE3jNEEuwMJ
         m5ew==
X-Forwarded-Encrypted: i=1; AFNElJ/C3tC1x4UcSmfQtdWjirBCBxoGR1Wgi4GKwL+cyBRnrbnxDy6a6k6pbSqySftpRChffFAbUkkWgQOpt/mvwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvNrI4SRhvSqvy66pI4ikaSjNNsFxk3pJJymxoTKT67BVbZ86W
	Guz2cm1gk29i5CEQXJ1HBi1nVHc0lkTuTb/KUE4LFAoC/o6AafRO3vCjHXJHgNJ3DB+ABNLWwsF
	v3a+9G4C00Ba0+zCWovp7UrwK981JM0B3tbycf/Usic9cv80DqFwNplk8g5KTkSngDehH
X-Gm-Gg: AfdE7cnCPIyj81Q6nsnsrv6+xJKoUL+3PXikSqgv9hU2PdXKMOM209jWTYQEg9HwDAO
	9OQaAtwA7sLN+gr1qGuEj4G4aipD36Ya/usCkacyvc9M/HUj2Ze+eXDjTGTxl9b1yxIU6T7jI0/
	KRtmyfZmaJ5ZgVkO+P0wx5ppNq897qmA5Dd8/2TyyNNOXD7Mbw0WmfAAWk6s9scS6TP0E/dhrby
	eR5D4RFJ3R7ukFvFOoXp2L6GP549Slc+KgjrsPF6B5hQ3uwqTK6WfzkjH4X8Lx4IksGEV3dFmpU
	TjW+mAEDYYmcMehOl+6Ioo6Xa4vm73/Vgnvo1oABh64FYnNRjmiFVNs/DG9QGG+HgZVurvrkTqE
	ST8ohZycq4unAJe8h13dI1GBi1ntClX36
X-Received: by 2002:a05:600c:c4b7:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-49240e9cb38mr237208395e9.27.1782134663014;
        Mon, 22 Jun 2026 06:24:23 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b7:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-49240e9cb38mr237207865e9.27.1782134662470;
        Mon, 22 Jun 2026 06:24:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944faa8sm202537345e9.13.2026.06.22.06.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:24:22 -0700 (PDT)
Date: Mon, 22 Jun 2026 09:24:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Message-ID: <20260622085825-mutt-send-email-mst@kernel.org>
References: <20260616115912.513183-1-dongml2@chinatelecom.cn>
 <20260621182119-mutt-send-email-mst@kernel.org>
 <BMgCMK8nRYC94QK7N1SXpQ@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BMgCMK8nRYC94QK7N1SXpQ@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4xQryavwjPiyzLKUtI9zA6Q3rjBYHEXSYRGt4Sq8wEw_1782134663
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 22, 2026 at 08:27:12PM +0800, Menglong Dong wrote:
> On 2026/6/22 06:31 Michael S. Tsirkin <mst@redhat.com> write:
> > On Tue, Jun 16, 2026 at 07:59:12PM +0800, Menglong Dong wrote:
> [...]
> > >  
> > > +	vring_size = virtqueue_get_vring_size(sq->vq);
> > > +	need_wakeup = xsk_uses_need_wakeup(pool);
> > > +
> > > +	if (need_wakeup && vring_size == sq->vq->num_free)
> > > +		xsk_set_tx_need_wakeup(pool);
> > > +
> > 
> > why are we doing this here?
> > the check after virtnet_xsk_xmit_batch not enough?
> > I vaguely think it's some kind of race we are closing?
> > Pls add a comment to explain.
> 
> Hi, Michael. Thanks for your review.
> 
> Yeah, it's for a race condition between user space and kernel
> space. I added a comment in V2, which is too confusing, and
> I removed it 😢. I'll make it more clear and add it in the V4. The
> origin comment is:
> 
>  * If the sq->vq is empty, and the tx ring is empty, and the user
>  * submit an entry to the tx ring after virtnet_xsk_xmit_batch() and
>  * before xsk_set_tx_need_wakeup(), we will lose the chance to wake
>  * up the tx napi, so we have to set the need_wakeup flag here.
> 
> And the logic is like this:
> 
> Kernel: tx NAPI is waked up from skb_xmit_done() ->
> Kernel: sq->vq and xsk->tx_ring are both empty ->
> Kernel: call virtnet_xsk_xmit_batch()
> 
>     User: submit a entry to the xsk->tx_ring
>     User: check the wakeup flag
>     User: wakeup flag is not set, skip send()
> 
> Kernel: call xsk_set_tx_need_wakeup(), because sq->vq is empty
> 
> If we don't send more data, the data in the xsk->tx_ring will
> not be sent forever.

I'm not 100% sure I understand, but when someone fixes cross-CPU races
with no synchronization or CPU memory barriers just with extra checks,
this always gives me pause.

AI helped write this for me, for example:
  1. Kernel: xsk_set_tx_need_wakeup stores NEED_WAKEUP (sits in store buffer)
  2. Kernel: xsk_tx_peek_release_desc_batch - load, sees empty (reordered before the store is globally visible)
  3. Kernel: peek finds nothing, returns 0
  4. Userspace: stores entry + producer
  5. Userspace: loads flags - doesn't see NEED_WAKEUP yet (still in kernel's store buffer)
  6. Userspeace: skips send()
  7. Kernel: NEED_WAKEUP store finally becomes visible - too late

Seems legit?



> > 
> > >  	sent = virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > >  
> > > +	if (need_wakeup) {
> > > +		if (vring_size == sq->vq->num_free)
> > > +			/* we can't wake up by ourself, and it should be done
> > > +			 * by the user.
> > > +			 */
> > > +			xsk_set_tx_need_wakeup(pool);
> > > +		else
> > > +			/* we can wake up from skb_xmit_done() */
> > > +			xsk_clear_tx_need_wakeup(pool);
> > 
> > But what if we don't have get tx napi so no wakeup in skb_xmit_done?
> 
> Sorry that I'm not sure what "get tx napi" means here ;(
> 
> There are entry in sq->vq, so skb_xmit_done() will be called after
> the entries in the ring is consumed by the HOST, right?
> Then, the corresponding sq->napi will be scheduled, as we ensure
> that tx napi is always enabled, which means napi->weight is not
> zero, in this commit:
> 1df5116a41a8 ("virtio_net: xsk: prevent disable tx napi")

Oh I forgot we did that. But can xsk bind when tx napi has already
been disabled previously?


> Right?
> 
> Thanks!
> Menglong Dong
> 
> > 
> > 
> > > +	}
> > > +
> > >  	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > >  		check_sq_full_and_disable(vi, vi->dev, sq);
> > >  
> > > @@ -1470,9 +1488,6 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> > >  	u64_stats_add(&sq->stats.xdp_tx,  sent);
> > >  	u64_stats_update_end(&sq->stats.syncp);
> > >  
> > > -	if (xsk_uses_need_wakeup(pool))
> > > -		xsk_set_tx_need_wakeup(pool);
> > > -
> > >  	return sent;
> > >  }
> > >  
> > > -- 
> > > 2.54.0
> > 
> > 
> > 
> 
> 
> 

